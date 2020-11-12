//
//  UIViewController+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

// MARK:- 一、基本的扩展
public extension UIViewController {
    
    // MARK: 1.1、pop回上一个界面
    /// pop回上一个界面
    func popToPreviousVC() {
        guard let nav = self.navigationController else { return }
        if let index = nav.viewControllers.firstIndex(of: self), index > 0 {
            let vc = nav.viewControllers[index - 1]
            nav.popToViewController(vc, animated: true)
        }
    }
    
    // MARK: 1.2、获取push进来的 VC
    /// 获取push进来的 VC
    /// - Returns: push进来的 VC
    func getPreviousNavVC() -> UIViewController? {
        guard let nav = self.navigationController else { return nil }
        if nav.viewControllers.count <= 1 {
            return nil
        }
        if let index = nav.viewControllers.firstIndex(of: self), index > 0 {
            let vc = nav.viewControllers[index - 1]
            return vc
        }
        return nil
    }
    
    // MARK: 1.3、获取顶部控制器
    /// 获取顶部控制器
    /// - Returns: VC
    static func top() -> UIViewController? {
        var rootVC: UIViewController?
        if let window = UIApplication.shared.delegate?.window {
            rootVC = window?.rootViewController
        } else {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        return top(rootVC: rootVC)
    }
    
    // MARK: 1.4、获取顶部控制器
    /// 获取顶部控制器
    /// - Returns: VC
    func top() -> UIViewController? {
        var rootVC: UIViewController?
        if let window = UIApplication.shared.delegate?.window {
            rootVC = window?.rootViewController
        } else {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        return Self.top(rootVC: rootVC)
    }
    
    static func top(rootVC: UIViewController?) -> UIViewController? {
        if let presentedVC = rootVC?.presentedViewController {
            return top(rootVC: presentedVC)
        }
        if let nav = rootVC as? UINavigationController,
            let lastVC = nav.viewControllers.last {
            return top(rootVC: lastVC)
        }
        if let tab = rootVC as? UITabBarController,
            let selectedVC = tab.selectedViewController {
            return top(rootVC: selectedVC)
        }
        return rootVC
    }
}
