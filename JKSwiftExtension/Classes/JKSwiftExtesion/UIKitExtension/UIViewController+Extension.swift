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
    
    // MARK: 获取某个控制器present出来的控制器
    /// 获取某个控制器present出来的控制器
    /// - Returns: description
    public func getPresentedViewController() -> UIViewController? {
        var controller: UIViewController? = self
        while controller?.presentedViewController != nil {
            controller = controller?.presentedViewController
        }
        return controller
    }
}

public extension UIViewController {
    func popToPreviousVC() {
        guard let nav = self.navigationController else { return }
        if let index = nav.viewControllers.firstIndex(of: self), index > 0 {
            let vc = nav.viewControllers[index - 1]
            nav.popToViewController(vc, animated: true)
        }
    }
    
    func previousNavVC() -> UIViewController? {
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
}

// MARK:- 控制器的跳转操作
public extension UINavigationController {
    
    // MARK: 从当前控制器返回再跳转到另外一个控制器
    /// 从当前控制器返回再跳转到另外一个控制器
    /// - Parameters:
    ///   - vc: 要跳转的控制器
    ///   - animated: 是否有动画
    func popCurrentAndPush(vc: UIViewController, animated: Bool) {
        var vcs = viewControllers
        if vcs.count < 1 { return }
        vcs.removeLast()
        vcs.append(vc)
        setViewControllers(vcs, animated: animated)
    }
    
    // MARK: 返回到第几个控制器
    /// 返回到第几个控制器
    /// - Parameters:
    ///   - count: 第几个
    ///   - animated: 是否有动画
    func pop(count: Int, animated: Bool) {
        if count < 1 {
            JKPrint("can't pop count less 1")
            return
        }
        
        let vcsCount = viewControllers.count
        if count >= vcsCount {
            JKPrint("count: \(count), must less than viewControllers count: \(vcsCount); will pop to root now!")
            popToRootViewController(animated: animated)
            return
        }
        
        let vc = viewControllers[vcsCount - count - 1]
        popToViewController(vc, animated: animated)
        print("pop to:", vc)
    }
    
    // MARK: 返回到第几个控制器后再跳转到某个控制器
    /// 返回到第几个控制器后再跳转到某个控制器
    /// - Parameters:
    ///   - count: 返回到第几个控制器
    ///   - vc: 返回后再跳转到第几个
    ///   - animated: 是否要动画
    func pop(count: Int, andPush vc: UIViewController, animated: Bool = true) {
        if count < 1 {
            JKPrint("can't pop count less 1")
            return
        }
        
        let vcsCount = viewControllers.count
        if count >= vcsCount {
            JKPrint("count: \(count), must less than viewControllers count: \(vcsCount); will pop to root now!")
            if let first = viewControllers.first {
                setViewControllers([first, vc], animated: animated)
            }
            return
        }

        var vcs = viewControllers[0...(vcsCount - count - 1)]
        vcs.append(vc)
        setViewControllers(Array(vcs), animated: animated)
        // JKPrint("vcs stack:", vcs)
    }
    
    // MARK: pop 到某个vc，以传入的vc类型为准，从栈顶逐个便利，直到找到这个vc，如果遍历完成后没找到，则返回false
    /// pop 到某个vc，以传入的vc类型为准，从栈顶逐个便利，直到找到这个vc，如果遍历完成后没找到，则返回false
    /// - Parameters:
    ///   - aClass: 要pop到的vc的类型
    ///   - animated: 是否有动画
    /// - Returns: 成功找到vc并pop 返回true  否则 false
    func popToViewController(as aClass: AnyClass, animated: Bool) -> Bool {
        for vc in viewControllers.reversed() {
            if vc.isMember(of: aClass) {
                popToViewController(vc, animated: animated)
                return true
            }
        }
        return false
    }
}

public extension UIViewController {
    
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
    
    /// 获取顶部控制器
    /// - Parameter window: window description
    /// - Returns: description
    static func top(window: UIWindow?) -> UIViewController? {
        return top(rootVC: window?.rootViewController ?? UIApplication.shared.keyWindow?.rootViewController)
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
