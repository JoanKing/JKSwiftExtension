//
//  NSObjectExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/1.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NSObjectExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、 NSObject 属性的扩展", "二、一些常用的方法"]
        dataArray = [["类名（对象方法）", "类名（类方法）"], ["利用运行时获取类里面的成员变量"]]
    }
}

// MARK: - 一、 NSObject 属性的扩展
extension NSObjectExtensionViewController {
    
    // MARK: 1.1、类名（对象方法）
    @objc func test11() {
        JKPrint("类名（对象方法）", "\(self.className)")
    }
    
    // MARK: 1.2、类名（类方法）
    @objc func test12() {
        JKPrint("类名（类方法）", "\(Self.className)")
    }
}

// MARK: - 二、一些常用的方法
extension NSObjectExtensionViewController {
    
    // MARK: 2.1、利用运行时获取类里面的成员变量
    @objc func test21() {
        JKPrint("利用运行时获取类里面的成员变量", "\(UIView.printIvars())")
    }
}
