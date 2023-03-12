//
//  NSDecimalNumberHandler+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/14.
//

import UIKit

// MARK: - 苹果针对浮点类型计算精度问题提供出来的计算类
/// NSDecimalNumberHandler 苹果针对浮点类型计算精度问题提供出来的计算类
/**
 初始化方法
 roundingMode 舍入方式
 scale 小数点后舍入值的位数
 raiseOnExactness 精度错误处理(发生精确错误时是否抛出异常，一般为false)
 raiseOnOverflow 溢出错误处理(发生溢出错误时是否抛出异常，一般为false)
 raiseOnUnderflow 下溢错误处理(发生不足错误时是否抛出异常，一般为false)
 raiseOnDivideByZero 除以0的错误处理（被0除时是否抛出异常，一般为true）
 */
/**
 public enum RoundingMode : UInt {
 case plain = 0 是四舍五入
 case down = 1 是向下取整
 case up = 2 是向上取整
 case bankers = 3 是在四舍五入的基础上，加上末尾数为5时，变成偶数的规则
 }
 */
extension NSDecimalNumberHandler: JKPOPCompatible {}

/// 计算的类型
public enum DecimalNumberHandlerType: String {
    // 加
    case add
    // 减
    case subtracting
    // 乘
    case multiplying
    // 除
    case dividing
}

// MARK: - 一、基本的扩展
public extension JKPOP where Base: NSDecimalNumberHandler {
    
    // MARK: 1.1、向下取整取倍数
    /// 向下取整取倍数
    /// - Parameters:
    ///   - value1: 除数
    ///   - value2: 被除数
    /// - Returns: 值
    static func getFloorIntValue(value1: Any, value2: Any) -> Int {
        return decimalNumberHandlerValue(type: .dividing, value1: value1, value2: value2, roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false).intValue
    }
    
    // MARK: 1.2、一个数字能否整除另外一个数字
    static func isDivisible(value1: Any, value2: Any) -> Bool {
        let value = decimalNumberHandlerValue(type: .dividing, value1: value1, value2: value2, roundingMode: .down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false).stringValue
        let valueArray = value.jk.separatedByString(with: ".")
        // 没有小数代表是整除
        guard valueArray.count > 1 else {
            return true
        }
        let decimalValue = valueArray[1]
        // 有小数的情况
        guard decimalValue.count == 1, decimalValue == "0" else {
            return false
        }
        return true
    }
    
    // MARK:1.3、两个数字之间的计算
    /// 两个数字之间的计算
    /// - Parameters:
    ///   - type: 计算的类型
    ///   - value1: 值
    ///   - value2: 值
    /// - Returns: 计算结果
    static func calculation(type: DecimalNumberHandlerType, value1: Any, value2: Any, roundingMode: NSDecimalNumber.RoundingMode, scale: Int16) -> NSDecimalNumber {
        return decimalNumberHandlerValue(type: type, value1: value1, value2: value2, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    }
    
    // MARK:1.4、一个数字四舍五入返回
    /// 一个数字四舍五入返回
    /// - Parameters:
    ///   - value: 值
    /// - Returns:四舍五入返回结果
    static func rounding(value: Any, scale: Int16 = 0) -> NSDecimalNumber {
        return decimalNumberHandlerValue(type: .multiplying, value1: value, value2: "1", roundingMode: .plain, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    }
    
    // MARK:1.5、数字取舍以及位数的处理
    /// 数字取舍以及位数的处理
    /// - Parameters:
    ///   - value1: 值
    ///   - roundingMode: 舍入方式
    ///   - scale: 保留位数
    /// - Returns: 处理结果
    static func digitalTradeOff(value1: Any, roundingMode: NSDecimalNumber.RoundingMode, scale: Int16) -> NSDecimalNumber {
        return decimalNumberHandlerValue(type: .multiplying, value1: value1, value2: "1", roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    }
}

// MARK: - public 公有方法
public extension JKPOP where Base: NSDecimalNumberHandler {
    
    /// 两个数的：加 减 乘 除
    /// - Parameters:
    ///   - type: 计算的类型
    ///   - value1: 第一个值
    ///   - value2: 第二个人值
    ///   - roundingMode: 舍入方式
    ///   - scale: 保留有效小数的个数（为0的无效小数后自动过滤)
    ///   - exact:  精度错误处理
    ///   - overflow: 溢出错误处理
    ///   - underflow: 下溢错误处理
    ///   - divideByZero: 除以0的错误处理
    /// - Returns: NSDecimalNumber
    static func decimalNumberHandlerValue(type: DecimalNumberHandlerType ,value1: Any, value2: Any, roundingMode: NSDecimalNumber.RoundingMode, scale: Int16, raiseOnExactness exact: Bool, raiseOnOverflow overflow: Bool, raiseOnUnderflow underflow: Bool, raiseOnDivideByZero divideByZero: Bool) -> NSDecimalNumber {

        let amountHandler = NSDecimalNumberHandler(roundingMode: roundingMode, scale: scale, raiseOnExactness: exact, raiseOnOverflow: overflow, raiseOnUnderflow: underflow, raiseOnDivideByZero: divideByZero)
        let oneNumber = NSDecimalNumber(string: "\(value1)")
        let twoNumber = NSDecimalNumber(string: "\(value2)")
        
        var result = NSDecimalNumber()
        if type == .add {
            result = oneNumber.adding(twoNumber, withBehavior: amountHandler)
        } else if type == .subtracting {
            result = oneNumber.subtracting(twoNumber, withBehavior: amountHandler)
        } else if type == .multiplying {
            result = oneNumber.multiplying(by: twoNumber, withBehavior: amountHandler)
        } else if type == .dividing {
            result = oneNumber.dividing(by: twoNumber, withBehavior: amountHandler)
        }
        return result
    }
}


