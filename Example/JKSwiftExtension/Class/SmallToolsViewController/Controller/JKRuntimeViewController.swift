//
//  JKRuntimeViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKRuntimeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、运行时", "二、交换方法"]
        dataArray = [["成员变量列表", "获取所有的属性名字", "获取方法列表"], ["交换方法1", "交换方法2"]]
    }
}

// MARK: - 二、交换方法
extension JKRuntimeViewController {
    
    // MARK: 2.2、交换方法2
    @objc func test22() {
        JKPrint("------交换方法2----------")
        JKRuntime.exchangeMethod(selector: #selector(test11), replace: #selector(test12), class: JKRuntimeViewController.self)
    }
    
    // MARK: 2.1、交换方法1
    @objc func test21() {
        JKPrint("------交换方法1----------", "\(JKRuntime.methods(from: Self.self))")
        JKRuntime.exchangeMethod(target: "test13", replace: "test12", class: JKRuntimeViewController.self)
    }
}

// MARK: - 一、运行时
extension JKRuntimeViewController {
    
    // MARK: 1.3、获取方法列表
    @objc func test13() {
        JKPrint("------获取方法列表----------", "\(JKRuntime.methods(from: UIFont.self))")
    }
    
    // MARK: 1.2、获取所有的属性名字
    @objc func test12() {
        JKPrint("------获取所有的属性名字----------", "\(JKRuntime.getAllPropertyName(UIGestureRecognizer.self))")
    }
   
    // MARK: 1.1、成员变量列表
    @objc func test11() {
        JKPrint("------成员变量列表：\(JKRuntime.ivars(UIGestureRecognizer.self))")
    }
    
}
