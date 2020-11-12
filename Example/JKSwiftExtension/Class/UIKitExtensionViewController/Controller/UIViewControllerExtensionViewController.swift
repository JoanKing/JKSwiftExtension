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
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["pop回上一个界面", "获取push进来的 VC", "获取顶部控制器"]]
    }
}

// MARK:- 一、基本的扩展
extension UIViewControllerExtensionViewController {
    
    // MARK: 1.1、pop回上一个界面
    @objc func test11() {
        JKPrint("pop回上一个界面", "\(popToPreviousVC())")
    }
    
    // MARK: 1.2、获取push进来的 VC
    @objc func test12() {
        guard let vc = getPreviousNavVC() else {
            return
        }
        JKPrint("pop回上一个界面", "\(vc.className)")
    }
    
    // MARK: 1.3、获取顶部控制器
    @objc func test13() {
        guard let vc = top() else {
            return
        }
        JKPrint("获取顶部控制器", "\(vc.className)")
    }
}

