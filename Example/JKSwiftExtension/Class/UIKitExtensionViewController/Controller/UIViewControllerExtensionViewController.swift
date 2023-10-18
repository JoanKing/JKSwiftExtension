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
        dataArray = [["pop回上一个界面", "获取push进来的 VC", "获取顶部控制器(类方法)", "获取顶部控制器(实例方法)", "是否正在展示", "关闭当前的控制器"], ["push跳转Storyboard(首个初始化的控制器)", "push跳转到Storyboard中指定UIViewController"]]
    }
}

// MARK: - 二、Storyboard 的 VC 交互
extension UIViewControllerExtensionViewController {
    
    // MARK: 2.02、push跳转到Storyboard中指定UIViewController
    @objc func test202() {
        self.jk.pushStoryboard("MyStoryboard", identifier: "456") { (vc) in
        }
    }
    
    // MARK: 2.01、push跳转Storyboard(首个初始化的控制器)
    @objc func test201() {
        self.jk.pushStoryboard("MyStoryboard2") { (vc) in
        }
    }
}

// MARK: - 一、基本的扩展
extension UIViewControllerExtensionViewController {
    
    // MARK: 1.06、关闭当前的控制器
    @objc func test106() {
        JKPrint("关闭当前的控制器")
        self.jk.closeCurrentVC()
    }
    
    // MARK: 1.05、是否正在展示
    @objc func test105() {
        JKPrint("是否正在展示：\(self.jk.isCurrentVC)")
    }
    
    // MARK: 1.04、获取顶部控制器(实例方法)
    @objc func test104() {
        guard let vc = self.jk.topViewController() else {
            return
        }
        JKPrint("获取顶部控制器", "\(vc.className)")
    }
    
    // MARK: 1.03、获取顶部控制器(类方法)
    @objc func test103() {
        guard let vc = UIViewController.jk.topViewController() else {
            return
        }
        JKPrint("获取顶部控制器", "\(vc.className)")
    }
    
    // MARK: 1.02、获取push进来的 VC
    @objc func test102() {
        guard let vc = jk.getPreviousNavVC() else {
            return
        }
        JKPrint("pop回上一个界面", "\(vc.className)")
    }
    
    // MARK: 1.01、pop回上一个界面
    @objc func test101() {
        JKPrint("pop回上一个界面", "\(jk.popToPreviousVC())")
    }
}

