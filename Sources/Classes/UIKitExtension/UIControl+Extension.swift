//
//  UIControl+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/28.
//

import UIKit

// MARK: - 一、基本的链式编程 扩展
public extension UIControl {
    
    // MARK: 1.1、设置控件是否可用
    /// 设置控件是否可用
    /// - Parameter isEnabled: 是否可用
    /// - Returns: 返回自身
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
    // MARK: 1.2、设置 点击状态
    /// 设置是否可点击
    /// - Parameter isSelected: 点击状态
    /// - Returns: 返回自身
    @discardableResult
    func isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }
    
    // MARK: 1.3、是否高亮状态
    /// 是否高亮状态
    /// - Parameter isSelected: 高亮状态
    /// - Returns: 返回自身
    @discardableResult
    func isHighlighted(_ isSelected: Bool) -> Self {
        self.isHighlighted = isSelected
        return self
    }
    
    // MARK: 1.4、设置垂直方向对齐方式
    /// 设置垂直方向
    /// - Parameter contentVerticalAlignment: 对齐方式
    /// - Returns: 返回自身
    @discardableResult
    func contentVerticalAlignment(_ contentVerticalAlignment: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = contentVerticalAlignment
        return self
    }
    
    // MARK: 1.5、设置水平方向对齐方式
    /// 设置水平方向
    /// - Parameter contentHorizontalAlignment: 对齐方式
    /// - Returns: 返回自身
    @discardableResult
    func contentHorizontalAlignment(_ contentHorizontalAlignment: UIControl.ContentHorizontalAlignment) -> Self {
        self.contentHorizontalAlignment = contentHorizontalAlignment
        return self
    }
    
    // MARK: 1.6、添加事件（默认添加 点击事件：touchUpInside）
    /// 添加事件（默认点击事件：touchUpInside）
    /// - Parameters:
    ///   - target: 被监听的对象
    ///   - action: 事件
    ///   - events: 事件的类型
    /// - Returns: 返回自身
    @discardableResult
    func add(_ target: Any?, action: Selector, events: UIControl.Event = .touchUpInside) -> Self {
        self.addTarget(target, action: action, for: events)
        return self
    }
    
    // MARK: 1.7、移除事件（默认移除 点击事件：touchUpInside）
    /// 移除事件（默认移除 点击事件：touchUpInside）
    /// - Parameters:
    ///   - target: 被监听的对象
    ///   - action: 事件
    ///   - events: 事件的类型
    /// - Returns: 返回自身
    @discardableResult
    func remove(_ target: Any?, action: Selector, events: UIControl.Event = .touchUpInside) -> Self {
        self.removeTarget(target, action: action, for: events)
        return self
    }
}

//MARK:- 二、基本的扩展
private struct AssociateKeys {
    // 使用 ptr 进行操作
    static var closure = UnsafeRawPointer("UIControlclosure".withCString { $0 })
}

public extension JKPOP where Base: UIControl {
    
    // MARK: 2.1、多少秒内不可重复点击
    // 多少秒内不可重复点击
    func preventDoubleHit(_ hitTime: Double = 1) {
        base.preventDoubleHit(hitTime)
    }
    
    /// UIControl 添加回调方式
    func addActionHandler(_ action: @escaping ControlClosure, for controlEvents: UIControl.Event = .touchUpInside) {
        self.base.addTarget(self, action: #selector(base.handleAction), for: controlEvents)
        objc_setAssociatedObject(self.base, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}

private var hitTimerKey: Void?
fileprivate extension UIControl  {
    
    private var hitTime: Double? {
        get { return jk_getAssociatedObject(self, &hitTimerKey) }
        set { jk_setRetainedAssociatedObject(self, &hitTimerKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    func preventDoubleHit(_ hitTime: Double) {
        self.hitTime = hitTime
        addTarget(self, action: #selector(c_preventDoubleHit), for: .touchUpInside)
    }
    
    @objc func c_preventDoubleHit(_ base: UIControl)  {
        base.isUserInteractionEnabled = false
        JKAsyncs.asyncDelay(hitTime ?? 1.0) {
        } _: {
            base.isUserInteractionEnabled = true
        }
    }
    
    /// 点击回调
    @objc func handleAction(_ sender: UIControl) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ControlClosure {
            block(sender)
        }
    }
}
