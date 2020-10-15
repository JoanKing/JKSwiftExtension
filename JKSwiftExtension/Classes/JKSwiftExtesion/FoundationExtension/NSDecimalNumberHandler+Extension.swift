//
//  NSDecimalNumberHandler+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/14.
//

import UIKit

// MARK:- 苹果针对浮点类型计算精度问题提供出来的计算类
/// NSDecimalNumberHandler 苹果针对浮点类型计算精度问题提供出来的计算类
/**
 初始化方法
 roundingMode 舍入方式
 scale 小数点后舍入值的位数
 raiseOnExactness 精度错误处理
 raiseOnOverflow 溢出错误处理
 raiseOnUnderflow 下溢错误处理
 raiseOnDivideByZero 除以0的错误处理
 */
/**
 public enum RoundingMode : UInt {
 case plain = 0 是四舍五入
 case down = 1 是向下取整
 case up = 2 是向上取整
 case bankers = 3 是在四舍五入的基础上，加上末尾数为5时，变成偶数的规则
 }
 */

/// 计算的类型
public enum DecimalNumberHandlerType: String {
    // 加
    case add
    // 减
    case subtracting
    // 乘
    case multiplyingBy
    // 除
    case dividing
}

public extension NSDecimalNumberHandler {
    
    /// 向下取整取倍数
    /// - Parameters:
    ///   - value1: 除数
    ///   - value2: 被除数
    /// - Returns: 值
    static func getFloorValue(value1: Double, value2: Double) -> Int {
        return decimalNumberHandlerValue(type: .dividing, value1: value1, value2: value2, roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false).intValue
    }
}

// MARK:- Private 私有方法
public extension NSDecimalNumberHandler {
    
    /// 两个数组的：加 减 乘 除
    /// - Parameters:
    ///   - type: 计算的类型
    ///   - value1: 第一个值
    ///   - value2: 第二个人值
    ///   - roundingMode: 舍入方式
    ///   - scale: 小数点后舍入值的位数
    ///   - exact:  精度错误处理
    ///   - overflow: 溢出错误处理
    ///   - underflow: 下溢错误处理
    ///   - divideByZero: 除以0的错误处理
    /// - Returns: NSDecimalNumber
    static func decimalNumberHandlerValue(type: DecimalNumberHandlerType ,value1: Double, value2: Double, roundingMode: NSDecimalNumber.RoundingMode, scale: Int16, raiseOnExactness exact: Bool, raiseOnOverflow overflow: Bool, raiseOnUnderflow underflow: Bool, raiseOnDivideByZero divideByZero: Bool) -> NSDecimalNumber {

        let amountHandler = NSDecimalNumberHandler(roundingMode: roundingMode, scale: scale, raiseOnExactness: exact, raiseOnOverflow: overflow, raiseOnUnderflow: underflow, raiseOnDivideByZero: divideByZero)
        let oneNumber = NSDecimalNumber(value: value1)
        let twoNumber = NSDecimalNumber(value: value2)
        
        var result = NSDecimalNumber()
        if type == .add {
            result = oneNumber.adding(twoNumber, withBehavior: amountHandler)
        } else if type == .subtracting {
            result = oneNumber.subtracting(twoNumber, withBehavior: amountHandler)
        } else if type == .multiplyingBy {
            result = oneNumber.multiplying(by: twoNumber, withBehavior: amountHandler)
        } else if type == .dividing {
            result = oneNumber.dividing(by: twoNumber, withBehavior: amountHandler)
        }
        return result
    }
}


