//
//  UIGestureRecognizer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/12.
//

import Foundation
import UIKit

@objc public extension UIGestureRecognizer {
    
    private struct AssociateKeys {
        static var funcName = UnsafeRawPointer("UIGestureRecognizerFuncName".withCString { $0 })
        static var closure = UnsafeRawPointer("UIGestureRecognizerClosure".withCString { $0 })
    }
    
    /// 方法名称(用于自定义)
    var funcName: String {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.funcName) as? String {
                return obj
            }
            let string = String(describing: self.classForCoder)
            objc_setAssociatedObject(self, &AssociateKeys.funcName, string, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return string
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.funcName, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 闭包回调
    func addAction(_ closure: @escaping (UIGestureRecognizer) -> Void) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        addTarget(self, action: #selector(p_invoke))
    }
    
    private func p_invoke() {
        if let closure = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIGestureRecognizer) -> Void) {
            closure(self)
        }
    }
}
