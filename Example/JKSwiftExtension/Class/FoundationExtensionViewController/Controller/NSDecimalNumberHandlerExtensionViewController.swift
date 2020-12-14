//
//  NSDecimalNumberHandlerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NSDecimalNumberHandlerExtensionViewController: BaseViewController {

    private var currentPrice: Double = 4.65
    /// 价格增长基数
    private var priceAnrBase: Double = 0.01
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["向下取整取倍数", "一个数字能否整除另外一个数字", "测试", "测试2", "取整测试Float", "取整测试Decimal"]]
    }
}

// MARK:- 一、基本的扩展
extension NSDecimalNumberHandlerExtensionViewController {
    
    @objc func test16() {
        let valueInt = NSDecimalNumberHandler.getFloorIntValue(value1: Decimal(currentPrice), value2: Decimal(priceAnrBase))
        
        currentPrice = Double(NSDecimalNumber(string: "\(Decimal(valueInt) * Decimal(priceAnrBase) + Decimal(priceAnrBase))").floatValue)
        print("Decimal：\(Double(valueInt)) * \(priceAnrBase) + \(priceAnrBase) = \(currentPrice)")
        
    }
    @objc func test15() {
        let valueInt = NSDecimalNumberHandler.getFloorIntValue1(value1: Float(currentPrice), value2:  Float(priceAnrBase))
        
        currentPrice = Double(valueInt) * priceAnrBase + priceAnrBase
        print("Double：\(Double(valueInt)) * \(priceAnrBase) + \(priceAnrBase) = \(currentPrice)")
        
    }
    
    @objc func test14() {
        let douleValue1: Double = 124.38
        let douleValue2: Double = 0.01
        print("Double类型直接相减：\(douleValue1) - \(douleValue2) = \(douleValue1 - douleValue2)")
        let value = NSDecimalNumberHandler.decimalNumberHandlerValue(type: .subtracting, value1: douleValue1, value2: douleValue2, roundingMode: .down, scale: 10, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false).floatValue
        print("使用NSDecimalNumberHandler后：\(douleValue1) - \(douleValue2) = \(value)")
        
    }
    
    // MARK: 1.3、
    @objc func test13() {
        let value1: Double = 124.3899999
        let value2: Double = 0.01
        let value3: Double = 0.01
        JKPrint("一个数字能否整除另外一个数字", "\(Decimal(value1) - Decimal(value2)) 除以 \(Decimal(value3)) 能否整除：\(NSDecimalNumberHandler.isDivisible(value1: Decimal(value1) - Decimal(value2), value2: Decimal(value3)))")
        let douleValue: Double = 158.99999999
        test1(value: CGFloat(douleValue))
        test2(value: Float(douleValue))
    }
    
    func test1(value: CGFloat)  {
       print("CGFloat：\(value)")
    }
    
    func test2(value: Float)  {
        print("Float：\(value)")
    }
    
    // MARK: 1.2、一个数字能否整除另外一个数字
    @objc func test12() {
        let value1: Double = 12.44
        let value2: Double = 10.0
        let value3: Double = 0.02
        JKPrint("一个数字能否整除另外一个数字", "\(Float(value1 - value2)) 除以 \(value3) 能否整除：\(NSDecimalNumberHandler.isDivisible(value1: Decimal(value1) - Decimal(value2), value2: Decimal(value3)))")
    }
    
    // MARK: 1.1、向下取整取倍数
    @objc func test11() {
        let value1: Double = 12.46
        let value2: Double = 10.0
        let value3: Double = 0.02
        JKPrint("向下取整取倍数", "\(Float(value1 - value2)) 除以 \(value3) 取整为：\(NSDecimalNumberHandler.getFloorIntValue(value1: Decimal(value1) - Decimal(value2), value2: Decimal(value3)))")
    }
}

