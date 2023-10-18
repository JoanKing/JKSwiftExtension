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
    
    // MARK: 2.02、交换方法2
    @objc func test202() {
        JKPrint("------交换方法2----------")
        JKRuntime.exchangeMethod(selector: #selector(test101), replace: #selector(test102), class: JKRuntimeViewController.self)
    }
    
    // MARK: 2.01、交换方法1
    @objc func test201() {
        JKPrint("------交换方法1----------", "\(JKRuntime.methods(from: Self.self))")
        JKRuntime.exchangeMethod(target: "test103", replace: "test102", class: JKRuntimeViewController.self)
    }
}

// MARK: - 一、运行时
extension JKRuntimeViewController {
    
    // MARK: 1.03、获取方法列表
    @objc func test103() {
        JKPrint("------获取方法列表----------", "\(JKRuntime.methods(from: UIFont.self))")
    }
    
    // MARK: 1.02、获取所有的属性名字
    @objc func test102() {
        JKPrint("------获取所有的属性名字----------", "\(JKRuntime.getAllPropertyName(UIGestureRecognizer.self))")
    }
   
    // MARK: 1.01、成员变量列表
    @objc func test101() {
        JKPrint("------成员变量列表：\(JKRuntime.ivars(UIGestureRecognizer.self))")
    }
}
