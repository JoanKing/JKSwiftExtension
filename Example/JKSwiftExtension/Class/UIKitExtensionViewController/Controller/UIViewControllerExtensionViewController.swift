//
//  UIViewControllerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIViewControllerExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、Storyboard 的 VC 交互"]
        dataArray = [["pop回上一个界面", "获取push进来的 VC", "（类）获取顶部控制器", "(实例)获取顶部控制器", "是否正在展示"], ["push跳转Storyboard(首个初始化的控制器)", "push跳转到Storyboard中指定UIViewController"]]
    }
}

// MARK:- 二、Storyboard 的 VC 交互
extension UIViewControllerExtensionViewController {
    
    // MARK: 2.2、push跳转到Storyboard中指定UIViewController
    @objc func test22() {
        self.jk.pushStoryboard("MyStoryboard", identifier: "456") { (vc) in
        }
    }
    
    // MARK: 2.1、push跳转Storyboard(首个初始化的控制器)
    @objc func test21() {
        self.jk.pushStoryboard("MyStoryboard2") { (vc) in
        }
    }
}

// MARK:- 一、基本的扩展
extension UIViewControllerExtensionViewController {
    
    // MARK: 1.1、pop回上一个界面
    @objc func test11() {
        JKPrint("pop回上一个界面", "\(jk.popToPreviousVC())")
    }
    
    // MARK: 1.2、获取push进来的 VC
    @objc func test12() {
        guard let vc = jk.getPreviousNavVC() else {
            return
        }
        JKPrint("pop回上一个界面", "\(vc.className)")
    }
    
    // MARK: 1.3、获取顶部控制器
    @objc func test13() {
        guard let vc = jk.topViewController() else {
            return
        }
        JKPrint("获取顶部控制器", "\(vc.className)")
    }
    
    // MARK: 1.4、获取顶部控制器
    @objc func test14() {
        guard let vc = jk.topViewController() else {
            return
        }
        JKPrint("获取顶部控制器", "\(vc.className)")
    }
    
    // MARK: 1.5、是否正在展示
    @objc func test15() {
        JKPrint("是否正在展示：\(self.jk.isCurrentVC)")
    }
}

