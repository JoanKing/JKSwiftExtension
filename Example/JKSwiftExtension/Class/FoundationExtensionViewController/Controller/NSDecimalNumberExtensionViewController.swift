//
//  NSDecimalNumberExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2024/11/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class NSDecimalNumberExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["如果是小数，小数部分是不是0", "如果包含小数，小数部分是0是否舍弃0"]]
    }
}

// MARK: - 一、基本的扩展
extension NSDecimalNumberExtensionViewController {

    //MARK: 1.05、数字取舍以及位数的处理
    @objc func test105() {
        let array: [Float] = [12.971, 0.291, 3.111]
        for (_, item) in array.enumerated() {
            let result = NSDecimalNumberHandler.jk.digitalTradeOff(value1: item, roundingMode: .up, scale: 2)
            print("原值：\(item) —> 处理后的值为：\(result)")
        }
    }
    
    // MARK:1.04、一个数字四舍五入返回
    @objc func test104() {
        let array: [Float] = [0.2000020, 0.3993930004, 0.382710002, 5.2000000009, 8.0040009, 1.0]
        for (_, item) in array.enumerated() {
            let result = NSDecimalNumberHandler.jk.rounding(value: item, scale: 2)
            print("原值：\(item) 四舍五入保留2位后的结果：\(result) 再转float后的值为：\(result)")
        }
    }
    
    // MARK: 1.03、两个数字之间的计算
    @objc func test103() {
    
    }
    
    // MARK: 1.02、如果包含小数，小数部分是0是否舍弃0
    @objc func test102() {
        let result1 = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: 567.0, value2: 1, roundingMode: .plain, scale: 1)
        let result2 = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: 567.0, value2: 1, roundingMode: .plain, scale: 1)
        let result3 = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: 567.1, value2: 1, roundingMode: .plain, scale: 1)
        debugPrint("\(result1.stringValue) 结果：\(result1.jk.decimalValue(isRemoveDecimalZero: true))")
        debugPrint("\(result2.stringValue) 结果：\(result2.jk.decimalValue(isRemoveDecimalZero: true))")
        debugPrint("\(result3.stringValue) 结果：\(result3.jk.decimalValue(isRemoveDecimalZero: true))")
    }
    
    // MARK: 1.01、如果是小数，小数部分是不是0
    @objc func test101() {
        let result1 = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: 5.670, value2: 100, roundingMode: .plain, scale: 2)
        let result2 = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: 567.48, value2: 1, roundingMode: .plain, scale: 0)
        let result3 = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: 567.1, value2: 1, roundingMode: .plain, scale: 1)
        debugPrint("\(result1.stringValue) 结果：\(result1.jk.isDecimalValueZero)")
        debugPrint("\(result2.stringValue) 结果：\(result2.jk.isDecimalValueZero)")
        debugPrint("\(result3.stringValue) 结果：\(result3.jk.isDecimalValueZero)")
    }
}

