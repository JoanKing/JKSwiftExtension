//
//  JKVerticalCarousel.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/29.
//

import UIKit

// MARK:- 垂直翻页轮播的控件
//  初始化要指定使用什么View，并实现初始化view的closure
//  另外还需要实现itemCount和configItem两个closure来处理数据
//  通过start开始轮播，中间可直接更数据，自动适应新的数据不用重新start，
//  但是当更换数据源为0或1个时，需要重新start，因为0或1个数据源会invalidate timer
public class JKVerticalCarousel<T: UIView>: UIView {
    
    /// 动画的类型
    public enum AnimationType {
        // 正常翻页 clipsBounds == true
        case normal
        // 渐隐 clipsBounds == false
        case fade
    }
    /// item的count
    public var itemCount: (() -> Int)?
    /// 对将要展示的item进行config
    public var configItem: ((Int, T) -> Void)?
    /// 轮播的间隔
    public var timeInterval: TimeInterval = 3
    /// 轮播动画时间
    public var animationTime: TimeInterval = 0.66
    /// 轮播动画的类型
    public var animationType = AnimationType.normal {
        didSet {
            clipsToBounds = animationType == .normal
        }
    }
    /// 创建 item 的closure
    private let createItem: (() -> T)
    private var index: Int = 0
    private lazy var currentItem: T = self.createItem()
    private lazy var reuseItemsPool: [T] = {
        [T]()
    }()
    private var timer: Timer?
    public init(frame: CGRect = .zero, createItemClosure: @escaping (() -> T)) {
        createItem = createItemClosure
        super.init(frame: frame)
        clipsToBounds = true
    }
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func reset() {
        subviews.forEach { view in
            guard let item = view as? T else { return }
            item.snp.removeConstraints()
            item.removeFromSuperview()
            self.reuseItemsPool.append(item)
        }
        timer?.invalidate()
        timer = nil
    }

    // MARK: 开始滚动
    /// 开始
    public func start() {
        if let _ = timer { return }

        let count = itemCount?() ?? 0
        if count < 1 { return }
        ready()
        if count < 2 {
            return
        }
        index = 0
        timer = Timer.scheduledSafeTimer(timeInterval: timeInterval, repeats: true, block: { [weak self] _ in
            self?.scroll()
        })
    }

    // MARK: 停止滚动
    /// 停止滚动
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 滚动事件
    @objc private func scroll() {
        index += 1
        let count = itemCount?() ?? 0
        if count == 0 {
            reset()
            return
        }
        if index >= count {
            index = 0
        }
        let item = dequeue()
        configItem?(index, item)
        item.addTo(self).snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom)
            make.left.right.height.equalToSuperview()
        }
        layoutIfNeeded()
        item.snp.remakeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.right.height.equalToSuperview()
        }
        currentItem.snp.remakeConstraints { make in
            make.bottom.equalTo(self.snp.top)
            make.left.right.height.equalToSuperview()
        }
        if animationType == .fade {
            item.alpha = 0
        }
        UIView.animate(withDuration: animationTime, animations: {
            if self.animationType == .fade {
                item.alpha = 1
                self.currentItem.alpha = 0
            }
            self.layoutIfNeeded()
        }) { [weak self] _ in
            guard let weakSelf = self else { return }
            let current = weakSelf.currentItem
            current.snp.removeConstraints()
            current.removeFromSuperview()
            weakSelf.reuseItemsPool.append(current)
            weakSelf.currentItem = item
            if count == 1 {
                // 临时换数据后，如果只有1个，则只显示这个，不走 timer
                weakSelf.timer?.invalidate()
                weakSelf.timer = nil
            }
        }
    }

    private func ready() {
        let count = itemCount?() ?? 0
        if count < 1 { return }
        reset()
        let item = dequeue()
        item.addTo(self).snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        currentItem = item
        configItem?(0, item)
    }
    
    private func dequeue() -> T {
        if let item = reuseItemsPool.first {
            item.alpha = 1
            reuseItemsPool.removeFirst()
            return item
        }
        return createItem()
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }
}

