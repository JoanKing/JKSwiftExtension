//
//  Timer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/28.
//

import UIKit

// MARK: - 一、基本的扩展
public extension Timer {
    
    // MARK: 1.1、构造器创建定时器
    /// 构造器创建定时器
    /// - Parameters:
    ///   - timeInterval: 时间间隔
    ///   - repeats: 是否重复执行
    ///   - block: 执行代码的block
    convenience init(safeTimerWithTimeInterval timeInterval: TimeInterval, repeats: Bool, block: @escaping ((Timer) -> Void)) {
        if #available(iOS 10.0, *) {
            self.init(timeInterval: timeInterval, repeats: repeats, block: block)
            RunLoop.current.add(self, forMode: .default)
            return
        }
        self.init(timeInterval: timeInterval, target: Timer.self, selector: #selector(Timer.timerCB(timer:)), userInfo: block, repeats: repeats)
        RunLoop.current.add(self, forMode: .default)
    }
    
    // MARK: 1.2、类方法创建定时器
    ///  创建定时器
    /// - Parameters:
    ///   - timeInterval: 时间间隔
    ///   - repeats: 是否重复执行
    ///   - block: 执行代码的block
    /// - Returns: 返回 Timer
    @discardableResult
    static func scheduledTimer(timeInterval: TimeInterval, repeats: Bool, block: @escaping ((Timer) -> Void)) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: block)
        }
        return Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerCB(timer:)), userInfo: block, repeats: repeats)
    }
    
    // MARK: 1.3、C语言的形式创建定时器(创建后立即执行一次)
    /// C语言的形式创建定时器
    /// - Parameters:
    ///   - timeInterval: 时间间隔
    ///   - handler: 定时器的回调
    /// - Returns: 返回 Timer
    @discardableResult
    static func runThisEvery(timeInterval: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer? {
        let fireDate = CFAbsoluteTimeGetCurrent()
        guard let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, timeInterval, 0, 0, handler) else {
            return nil
        }
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
}

// MARK: - 私有的方法
public extension Timer {
    @objc fileprivate class func timerCB(timer: Timer) {
        guard let cb = timer.userInfo as? ((Timer) -> Void) else {
            timer.invalidate()
            return
        }
        cb(timer)
    }
}

