//
//  UIViewController+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

// MARK:- 公开的方法
extension UIViewController {
    // MARK: 获取当前VC
    /// 获取当前VC
    /// - Returns: VC
    public class final func getCurrentVC() -> UIViewController {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        let curVC = getCurrentVCFrom(rootVC!)
        return curVC
    }
    
}

// MARK:- 私有的方法
extension UIViewController {
    fileprivate class final func getCurrentVCFrom(_ rootVC:UIViewController) -> UIViewController {
        
        var curVC:UIViewController?
        var rootTempVC = rootVC
        
        if let presentVc = rootTempVC.presentedViewController {
            // 视图是被presented出来的
            rootTempVC = presentVc
        }
        
        if rootTempVC is UITabBarController {
            // 根视图为UITabBarController
            let vc = rootTempVC as? UITabBarController
            curVC = getCurrentVCFrom((vc?.selectedViewController)!)
        } else if rootTempVC is UINavigationController {
            // 根视图为UINavigationController
            let vc = rootTempVC as? UINavigationController
            if let visibleViewController = vc?.visibleViewController {
                curVC = getCurrentVCFrom(visibleViewController)
            } else {
                curVC = rootTempVC
            }
        } else {
            curVC = rootTempVC
        }
        return curVC ?? (UIApplication.shared.keyWindow?.rootViewController)!
    }
}
