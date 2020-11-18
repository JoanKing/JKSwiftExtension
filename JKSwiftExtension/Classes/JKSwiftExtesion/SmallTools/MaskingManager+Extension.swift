//
//  MaskingManager+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/25.
//

import UIKit

// MARK:- 一、UIView 直接调用吐司
public extension UIView {
    
    // MARK: 1.1、展示Loading
    /// 展示Loading
    func showHUD() {
        MaskingManager.shareManager.showloading(inView: self)
    }
    
    // MARK: 1.2、隐藏Loading
    /// 隐藏Loading
    func hideHUD() {
        MaskingManager.shareManager.dismissloading(inView: self)
    }
    
    // MARK: 1.3、是否在展示 Loading
    /// 是否在展示 Loading
    var isShowHUD: Bool {
        return MaskingManager.shareManager.isShow(inView: self)
    }
}

// MARK:- 二、UIViewController 直接调用吐司
public extension UIViewController {
    
    // MARK: 2.1、展示Loading
    /// 展示Loading
    func showHUD() {
        MaskingManager.shareManager.showloading(inView: view)
    }

    // MARK: 2.2、隐藏Loading
    /// 隐藏Loading
    func hideHUD() {
        MaskingManager.shareManager.dismissloading(inView: view)
    }
    
    // MARK: 2.3、是否在展示 Loading
    /// 是否在展示 Loading
    var isShowHUD: Bool {
        return MaskingManager.shareManager.isShow(inView: view)
    }
}

// MARK:- 三、String 直接调用吐司
public extension String {
    func toast(duration: TimeInterval = 2, in view: UIView? = UIApplication.shared.keyWindow) {
        if !isEmpty {
            MaskingManager.shareManager.showToast(text: self, duration: duration, in: view)
        }
    }
}
