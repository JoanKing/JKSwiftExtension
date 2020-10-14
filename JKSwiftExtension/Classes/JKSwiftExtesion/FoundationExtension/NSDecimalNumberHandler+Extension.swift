//
//  NSDecimalNumberHandler+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/14.
//

import UIKit

public extension NSDecimalNumberHandler {
    
    /// 向下取整取倍数
    /// - Parameters:
    ///   - value1: 除数
    ///   - value2: 被除数
    /// - Returns: 值
    static func getFloorValue(value1: Double, value2: Double) -> Double {
        let amountHandler = NSDecimalNumberHandler(roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let oneNum = NSDecimalNumber(value: value1)
        let dividingNum = NSDecimalNumber(value: value2)
        let result = oneNum.dividing(by: dividingNum, withBehavior: amountHandler)
        return result.doubleValue
    }
}
