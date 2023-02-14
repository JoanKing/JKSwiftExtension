//
//  NSDecimalNumberHandlerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import simd

class NSDecimalNumberHandlerExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["向下取整取倍数", "一个数字能否整除另外一个数字", "两个数字之间的计算", "一个数字四舍五入返回", "数字取舍以及位数的处理"]]
    }
}

// MARK: - 一、基本的扩展
extension NSDecimalNumberHandlerExtensionViewController {

    //MARK: 1.5、数字取舍以及位数的处理
    @objc func test15() {
        let array: [Float] = [12.971, 0.291, 3.111]
        for (_, item) in array.enumerated() {
            let result = NSDecimalNumberHandler.jk.digitalTradeOff(value1: item, roundingMode: .up, scale: 2)
            print("原值：\(item) —> 处理后的值为：\(result)")
        }
    }
    
    // MARK:1.4、一个数字四舍五入返回
    @objc func test14() {
        let array: [Float] = [0.2000020, 0.3993930004, 0.382710002, 5.2000000009, 8.0040009, 1.0]
        for (_, item) in array.enumerated() {
            let result = NSDecimalNumberHandler.jk.rounding(value: item, scale: 2)
            print("原值：\(item) 四舍五入保留2位后的结果：\(result) 再转float后的值为：\(result)")
        }
    }
    
    // MARK: 1.3、两个数字之间的计算
    @objc func test13() {
        let value1 = 12.971
        let value2 = 1
        let result = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: value1, value2: value2, roundingMode: .up, scale: 2)
        let stringValue = result.stringValue
        
        JKPrint("结果：\(result)", "两个数字之间的计算：Float: \(value1) * \(value2) = \(result.floatValue)", "两个数字之间的计算：Double: \(value1) * \(value2) = \(result.doubleValue)", "两个数字之间的计算：stringValue: \(stringValue)")
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

