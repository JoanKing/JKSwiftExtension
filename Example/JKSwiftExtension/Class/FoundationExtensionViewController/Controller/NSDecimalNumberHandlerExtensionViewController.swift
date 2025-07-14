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
        dataArray = [["向下取整取倍数", "一个数字能否整除另外一个数字", "两个数字之间的计算", "一个数字四舍五入返回", "数字取舍以及位数的处理"]]
    }
}

// MARK: - 一、基本的扩展
extension NSDecimalNumberHandlerExtensionViewController {
    
    //MARK: 1.05、数字取舍以及位数的处理
    @objc func test105() {
        let array: [Float] = [12.971, 0.291, 3.111]
        for (_, item) in array.enumerated() {
            let result = NSDecimalNumberHandler.jk.digitalTradeOff(value1: item, roundingMode: .up, scale: 2)
            debugPrint("原值：\(item) —> 处理后的值为：\(result)")
        }
    }
    
    // MARK:1.04、一个数字四舍五入返回
    @objc func test104() {
        let array: [Float] = [0.2000020, 0.3993930004, 0.382710002, 5.2000000009, 8.0040009, 1.0]
        for (_, item) in array.enumerated() {
            let result = NSDecimalNumberHandler.jk.rounding(value: item, scale: 2)
            debugPrint("原值：\(item) 四舍五入保留2位后的结果：\(result) 再转float后的值为：\(result)")
        }
    }
    
    // MARK: 1.03、两个数字之间的计算
    @objc func test103() {
        let value1 = 12.971
        let value2 = 1
        let result = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: value1, value2: value2, roundingMode: .up, scale: 2)
        let stringValue = result.stringValue
        
        JKPrint("结果：\(result)", "两个数字之间的计算：Float: \(value1) * \(value2) = \(result.floatValue)", "两个数字之间的计算：Double: \(value1) * \(value2) = \(result.doubleValue)", "两个数字之间的计算：stringValue: \(stringValue)")
    }
    
    // MARK: 1.02、一个数字能否整除另外一个数字
    @objc func test102() {
        
        let value12 = 12
        let value13 = 0
    
        
        let value1: Double = 0
        let value2: Double = 10
        let value3: Double = 32
        let value4: Double = 16
        let value5: Double = 0
        debugPrint( "\(value5) 除以 \(value5) 能否整除：\(NSDecimalNumberHandler.jk.isDivisible(value1: value4, value2: value5))")
        debugPrint( "\(value1) 除以 \(value4) 能否整除：\(NSDecimalNumberHandler.jk.isDivisible(value1: value1, value2: value4))")
        debugPrint( "\(value2) 除以 \(value4) 能否整除：\(NSDecimalNumberHandler.jk.isDivisible(value1: value2, value2: value4))")
        debugPrint( "\(value3) 除以 \(value4) 能否整除：\(NSDecimalNumberHandler.jk.isDivisible(value1: value3, value2: value4))")
        debugPrint( "\(value4) 除以 \(value5) 能否整除：\(NSDecimalNumberHandler.jk.isDivisible(value1: value4, value2: value5))")
    }
    
    // MARK: 1.01、向下取整取倍数
    @objc func test101() {
        let value1: Double = 12.46
        let value2: Double = 10.0
        let value3: Double = 0.02
        JKPrint("向下取整取倍数", "\(Float(value1 - value2)) 除以 \(value3) 取整为：\(NSDecimalNumberHandler.jk.getFloorIntValue(value1: Decimal(value1) - Decimal(value2), value2: Decimal(value3)))")
    }
}

