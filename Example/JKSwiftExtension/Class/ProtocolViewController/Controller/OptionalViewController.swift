//
//  OptionalViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2023/12/25.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class OptionalViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["是否为nil", "是否是有值", "可选值取值", "可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`", "当可选值不为空时，执行 `some` 闭包", "当可选值为空时，执行none闭包"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、基本的扩展
extension OptionalViewController {
    
    //MARK: 1.6、当可选值为空时，执行none闭包
    @objc func test106() {
        let value1: Int? = 12
        value1.onNone {
            debugPrint("测试1")
        }
        let value2: Int? = nil
        value2.onNone {
            debugPrint("测试2")
        }
    }
    
    //MARK: 1.5、当可选值不为空时，执行 `some` 闭包
    @objc func test105() {
        let value1: Int? = 12
        value1.onSome { item in
            debugPrint("测试1：\(item)")
        }
        let value2: Int? = nil
        value2.onSome {_ in 
            debugPrint("测试2")
        }
    }
    
    //MARK: 1.4、可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`
    @objc func test104() {
        var value11: Int? = 12
        let value12 = value11.filter { item in
            item > 10
        }
        debugPrint("\(value11)取值：\(value12)")
    }
    //MARK: 1.3、可选值取值
    @objc func test103() {
        var value11: Int? = 12
        let value12 = value11.or(13)
        var value21: Int? = nil
        let value22 = value11.or(14)
        var value31: Int? = 15
        let value32 = value21.or(16) { _ in 19 }
        debugPrint("\(value11)取值：\(value12)", "\(value21)取值：\(value22)", "\(value31)取值：\(value32)")
    }
    //MARK: 1.2、是否是有值
    @objc func test102() {
        var value1: Int? = 12
        let value2: Int? = nil
        debugPrint("\(value1)是否是可选值：\(value1.isSome)", "\(value2)是否是可选值：\(value2.isSome)")
    }
    
    //MARK: 1.1、是否为nil
    @objc func test101() {
        var value1: Int? = 12
        let value2: Int? = nil
        debugPrint("\(value1)是否是nil：\(value1.isNil)", "\(value2)是否是nil：\(value2.isNil)")
    }
    
}

