//
//  WeakTimer.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/29.
//

import UIKit

// MARK:- 定时器 Timer 的封装
public class JKWeakTimer {
    
    public enum State: Int {
        case none = 100
        // 初始化
        case initialization
        // 执行中
        case executing
        // 暂停
        case pause
        // 销毁
        case invalidate
    }
    
    // MARK: - 公开属性
    public var tolerance: TimeInterval? {
        didSet {
            if tolerance != oldValue {
                resetTimerProperties()
            }
        }
    }
    public var userInfo: Any?
    public var fireDate: Date? {
        return _fireDate
    }
    public var state: State {
        return _state
    }
    
    // MARK: - 私有属性
    private var _state: State = .none
    private var _fireDate: Date?
    private var isRepeats = false
    private var timeInterval: TimeInterval = 1.0
    private weak var target: NSObjectProtocol?
    private var selector: Selector?
    private var timerCallBack: ((JKWeakTimer) -> Void)?
    private var timer: DispatchSourceTimer?
    
    init() {}
    deinit {
        invalidate()
    }
    
    // MARK: - 初始化定时器方法
    // MARK: 便利初始化器：初始化定时器
    /// 便利初始化器：初始化定时器
    /// - Parameters:
    ///   - ti: 定时器间隔 默认 1s
    ///   - aTarget: 调用者
    ///   - aSelector: 调用方法
    ///   - userInfo: 调用附加信息 默认 nil
    ///   - yesOrNo: 是否重复 默认  false
    public convenience init(timeInterval ti: TimeInterval = 1.0, target aTarget: NSObjectProtocol, selector aSelector: Selector, userInfo: Any? = nil, repeats yesOrNo: Bool = false) {
        self.init()
        timeInterval = ti
        target = aTarget
        selector = aSelector
        self.userInfo = userInfo
        isRepeats = yesOrNo
        initTimer()
    }
    
    // MARK: 类方法初始化定时器
    /// 类方法初始化定时器
    /// - Parameters:
    ///   - ti: 定时器间隔 默认 1s
    ///   - aTarget: 调用者
    ///   - aSelector: 调用方法
    ///   - userInfo: 调用附加信息 默认 nil
    ///   - yesOrNo: 是否重复 默认 false
    /// - Returns: 已启动的timer
    public class func scheduledTimer(timeInterval ti: TimeInterval = 1.0, target aTarget: NSObjectProtocol, selector aSelector: Selector, userInfo: Any? = nil, repeats yesOrNo: Bool = false) -> JKWeakTimer {
        let timer = JKWeakTimer.init()
        timer.timeInterval = ti
        timer.target = aTarget
        timer.selector = aSelector
        timer.userInfo = userInfo
        timer.isRepeats = yesOrNo
        timer.initTimer()
        timer.fire()
        return timer
    }
    
    // MARK: 便利初始化定时器（有队列）
    /// - Parameters:
    ///   - interval: 定时器间隔 默认 1s
    ///   - repeats: 是否重复 默认 false
    ///   - queue: 调用队列 默认 nil 全局队列
    ///   - block: 回调
    public convenience init(timeInterval interval: TimeInterval = 1.0, repeats: Bool = false, queue: DispatchQueue? = nil, block: @escaping (JKWeakTimer) -> Void) {
        self.init()
        timeInterval = interval
        self.timerCallBack = block
        isRepeats = repeats
        initTimer(queue)
    }
    
    // MARK: 类方法初始化定时器（有队列）
    /// 类方法初始化定时器（有队列）
    /// - Parameters:
    ///   - interval: 定时器间隔 默认 1s
    ///   - repeats: 是否重复 默认 false
    ///   - queue: 调用队列 默认 nil 全局队列
    ///   - block: 回调
    /// - Returns: 已启动的timer
    public class func scheduledTimer(timeInterval interval: TimeInterval = 1.0, repeats: Bool = false, queue: DispatchQueue? = nil, block: @escaping (JKWeakTimer) -> Void) -> JKWeakTimer {
        let timer = JKWeakTimer.init()
        timer.timeInterval = interval
        timer.timerCallBack = block
        timer.isRepeats = repeats
        timer.initTimer(queue)
        timer.fire()
        return timer
    }
    
    // MARK: 便利初始化定时器
    /// 初始化定时器
    /// - Parameters:
    ///   - date: 启动时间
    ///   - interval: 定时器间隔 默认 1s
    ///   - repeats: 是否重复 默认 false
    ///   - queue: 调用队列 默认 nil 全局队列
    ///   - block: 回调
    public convenience init(fire date: Date, interval: TimeInterval = 1.0, repeats: Bool, queue: DispatchQueue? = nil, block: @escaping (JKWeakTimer) -> Void) {
        self.init()
        _fireDate = date
        timeInterval = interval
        isRepeats = repeats
        self.timerCallBack = block
        initTimer(queue)
    }
    
    // MARK: 便利初始化定时器
    /// 初始化
    /// - Parameters:
    ///   - date: 启动时间
    ///   - ti: 定时器间隔 默认 1S
    ///   - t: 调用者
    ///   - s: 调用方法
    ///   - ui: 调用其他信息 默认 nil
    ///   - rep: 是否重复 默认 false
    public convenience init(fireAt date: Date, interval ti: TimeInterval = 1.0, target t: NSObjectProtocol, selector s: Selector, userInfo ui: Any? = nil, repeats rep: Bool = false) {
        self.init()
        _fireDate = date
        timeInterval = ti
        isRepeats = rep
        self.target = t
        self.selector = s
        initTimer()
    }
    
    // MARK: - 公开方法
    // MARK: 启动定时器
    /// 启动定时器
    public func fire() {
        if let _ = timer, (_state == .initialization || _state == .pause) {
            _fireDate = Date()
            print(_fireDate ?? "")
            timer?.resume()
            _state = .executing
        }
    }
    
    // MARK: 暂停定时器
    /// 暂停定时器
    public func pause() {
        if let _ = timer, _state == .executing {
            _state = .pause
        }
    }
    private let pointer = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
    
    // MARK: 销毁定时器
    /// 销毁定时器
    public func invalidate() {
        // 如果它已经失效，原子操作检查。防止dispatch_sync死锁。
        if !OSAtomicTestAndSetBarrier(7, pointer) {
            if let t = timer, _state != .invalidate {
                t.cancel()
                timer = nil
                timerCallBack = nil
                _state = .invalidate
            }
            timerCall()
        }
    }
    
    /// 当前的定时器的状态
    public var isValid: Bool { return _state == .executing }
    
    // MARK: - 私有方法
    // MARK: 初始化定时器
    /// 初始化定时器
    /// - Parameter queue: 执行队列
    private func initTimer(_ queue: DispatchQueue? = nil) {
        timer = DispatchSource.makeTimerSource(queue: queue )
        _state = .initialization
        resetTimerProperties()
        timer?.setEventHandler(handler: {[weak self] in
            self?.timerCall()
        })
        if let f = fireDate {
            (queue ?? DispatchQueue.global()).asyncAfter(deadline: .now() + f.timeIntervalSinceNow) {
                self.fire()
            }
        }
    }
    
    fileprivate func resetTimerProperties() {
        timer?.schedule(deadline: .now(), repeating: (isRepeats ? .milliseconds(Int(timeInterval * 1000)) : .never), leeway: .milliseconds(Int(tolerance ?? (timeInterval / 2) * 1000)))
    }
    
    /// 定时器回调
    private func timerCall() {
        // 检查定时器是否已经失效。
        if  OSAtomicAnd32OrigBarrier(1, pointer) != 0 {
            return
        }
        if _state == .pause {
            return
        }
        if timerCallBack != nil {
            timerCallBack?(self)
        } else if let t = target, let s = selector {
            if let u = userInfo {
                DispatchQueue.main.async {
                    t.perform(s, with: u)
                }
            } else {
                DispatchQueue.main.async {
                    t.perform(s)
                }
            }
        }
    }
}

