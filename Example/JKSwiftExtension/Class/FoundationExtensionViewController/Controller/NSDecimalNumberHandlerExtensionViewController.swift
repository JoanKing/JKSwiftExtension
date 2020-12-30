//
//  NSDecimalNumberHandlerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NSDecimalNumberHandlerExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["向下取整取倍数", "一个数字能否整除另外一个数字", "两个数字之间的计算", "测试"]]
    }
}

// MARK:- 一、基本的扩展
extension NSDecimalNumberHandlerExtensionViewController {
    
    @objc func test14() {
        let value11 = 4.441
        let value12 = 2.22
        let result = value11.truncatingRemainder(dividingBy: value12)

        JKPrint("result：\(result)")
    }
    
    // MARK: 1.3、两个数字之间的计算
    @objc func test13() {
        let value1: Double = 12.9999999999
        let value2: Double = 0.01
        let result = NSDecimalNumberHandler.jk.calculation(type: .subtracting, value1: value1, value2: value2)
        let stringValue = result.stringValue
        
        JKPrint("两个数字之间的计算：Float: \(value1) - \(value2) = \(result.floatValue)", "两个数字之间的计算：Double: \(value1) - \(value2) = \(result.doubleValue)", "两个数字之间的计算：stringValue: \(stringValue)")
    }
    
    
    // MARK: 1.2、一个数字能否整除另外一个数字
    @objc func test12() {
        let value1: Double = 12.44
        let value2: Double = 10.0
        let value3: Double = 0.02
        JKPrint("一个数字能否整除另外一个数字", "\(Float(value1 - value2)) 除以 \(value3) 能否整除：\(NSDecimalNumberHandler.jk.isDivisible(value1: Decimal(value1) - Decimal(value2), value2: Decimal(value3)))")
    }
    
    // MARK: 1.1、向下取整取倍数
    @objc func test11() {
        let value1: Double = 12.46
        let value2: Double = 10.0
        let value3: Double = 0.02
        JKPrint("向下取整取倍数", "\(Float(value1 - value2)) 除以 \(value3) 取整为：\(NSDecimalNumberHandler.jk.getFloorIntValue(value1: Decimal(value1) - Decimal(value2), value2: Decimal(value3)))")
    }
}

