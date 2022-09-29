//
//  PresetntFourViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/9/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class PresetntFourViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Four"
        self.view.backgroundColor = .brown
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = self.bottomestPresentedViewController()
        print("vc：\(vc.className)")
        vc.dismiss(animated: true, completion: nil)
        // dismissViewController(currentVC: self)
    }
    
    /// dismiss到指定的控制器
    ///
    /// - Parameters:
    ///   - index: 指定的控制器序号，如：从vc1 present --> vc2 --> vc3 --> vc4，想从vc4直接dismiss到vc1，只需要传index=4即可
    ///   - vc: 当前控制器
    func dismissViewController(currentVC:UIViewController) {
        var tempVC: UIViewController = currentVC
        while tempVC.presentingViewController != nil {
            print("\(currentVC.className)")
            if currentVC.isMember(of: PresetntThreeViewController.self) {
                break
            }
            tempVC = tempVC.presentingViewController!
        }
        
        tempVC.dismiss(animated: true, completion: nil)
    }

}

extension UIViewController {
    /// 获取最底层的控制器
    public func bottomestPresentedViewController() -> UIViewController {
        var bottomestVC = self
        while bottomestVC.presentingViewController != nil {
            bottomestVC = bottomestVC.presentingViewController!
        }
        return bottomestVC
    }
    
    /// 获取最顶层的控制器
    public func topestPresentedViewController() -> UIViewController {
        var topestVC = self
        while topestVC.presentedViewController != nil {
            topestVC = topestVC.presentedViewController!
        }
        return topestVC
    }
}
