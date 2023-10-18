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

// MARK: - 二、一些常用的方法
extension NSObjectExtensionViewController {
    
    // MARK: 2.01、利用运行时获取类里面的成员变量
    @objc func test201() {
        JKPrint("利用运行时获取类里面的成员变量", "\(UIView.printIvars())")
    }
}

// MARK: - 一、 NSObject 属性的扩展
extension NSObjectExtensionViewController {
    
    // MARK: 1.02、类名（类方法）
    @objc func test102() {
        JKPrint("类名（类方法）", "\(Self.className)")
    }
    
    // MARK: 1.01、类名（对象方法）
    @objc func test101() {
        JKPrint("类名（对象方法）", "\(self.className)")
    }
}
