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

        headDataArray = ["一、运行时"]
        dataArray = [["使用运行时打印一个类中所有的属性", "获取所有的属性名字"]]
    }
}

// MARK:- 一、运行时
extension JKRuntimeViewController {
   
    // MARK: 1.1、使用运行时打印一个类中所有的属性
    @objc func test11() {
        print("------JKRuntime运行时----------")
        JKRuntime.ivars(UIGestureRecognizer.self)
        print("------类运行时----------")
        UIGestureRecognizer.printIvars()
    }
    
    // MARK: 1.2、获取所有的属性名字
    @objc func test12() {
        print("------获取所有的属性名字----------", "\(JKRuntime.getAllPropertyName(UIGestureRecognizer.self))")
    }
}
