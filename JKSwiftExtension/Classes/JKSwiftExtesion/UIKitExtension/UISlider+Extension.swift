//
//  UISlider+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/5.
//

import UIKit

//MARK:- 一、基本的扩展
public extension JKPOP where Base: UISlider {
    
    // MARK: 1.1、UISlider的 闭包事件
    /// UISlider的 闭包事件
    /// - Parameters:
    ///   - controlEvents: 事件类型，默认是 valueChanged
    ///   - sliderCallBack: 闭包
    /// - Returns: 闭包内容
    func setHandle(controlEvents: UIControl.Event = .valueChanged, sliderCallBack: ((Float?) -> ())?) {
        base.swiftCallBack = sliderCallBack
        base.addTarget(base, action: #selector(base.sliderSwitchAction), for: controlEvents)
    }
}

private var sliderCallBackKey: Void?
extension UISlider: JKSwiftPropertyCompatible {
    internal typealias T = Float
    internal var swiftCallBack: SwiftCallBack? {
        get { return jk_getAssociatedObject(self, &sliderCallBackKey) }
        set { jk_setRetainedAssociatedObject(self, &sliderCallBackKey, newValue) }
    }
    
    @objc internal func sliderSwitchAction(_ event: UISlider) {
        self.swiftCallBack?(event.value)
    }
}
