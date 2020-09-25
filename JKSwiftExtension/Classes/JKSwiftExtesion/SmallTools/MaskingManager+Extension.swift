//
//  MaskingManager+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/25.
//

import UIKit

// MARK:- UIView 直接调用吐司
public extension UIView {
    func showHUD() {
        MaskingManager.shareManager.showloading(inView: self)
    }

    func hideHUD() {
        MaskingManager.shareManager.dismissloading(inView: self)
    }
    var isShowHUD: Bool {
        return MaskingManager.shareManager.isShow(inView: self)
    }
}

// MARK:- UIViewController 直接调用吐司
public extension UIViewController {
    var isShowHUD: Bool {
        return MaskingManager.shareManager.isShow(inView: view)
    }
    func showHUD() {
        MaskingManager.shareManager.showloading(inView: view)
    }

    func hideHUD() {
        MaskingManager.shareManager.dismissloading(inView: view)
    }
}

// MARK:- String 直接调用吐司
public extension String {
    func toast(duration: TimeInterval = 2, in view: UIView? = UIApplication.shared.keyWindow) {
        if !isEmpty {
            MaskingManager.shareManager.showToast(text: self, duration: duration, in: view)
        }
    }
    
}
