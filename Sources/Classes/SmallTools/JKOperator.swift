//
//  JKOperator.swift
//  JKSwiftExtension
//
//  Created by 小冲冲 on 2023/12/8.
//

import Foundation


//MARK: 一、位移运算符
/**
 Swift里面的运算符有三种:
 infix（中缀）,如：+、-、*、/
 prefix（前缀）,如：逻辑运算!a
 postfix（后缀）,如：自增运算符i++
 */
infix operator |>>>| : BitwiseShiftPrecedence
/**
 Int32(truncatingIfNeeded: lhs)，truncatingIfNeeded是一种整数类型转换方式，用于将一个整数值转换为另一个整数类型，并在需要时截断高位或低位的位数。Int32(truncatingIfNeeded: lhs)中 Int32指的是32位，最大32个1的二进制，也就是4294967295，如果是33位，最前面就会被截取掉，保留32位；这里以Int8作为个例子，比如： Int8(truncatingIfNeeded: 300)，Int8类型只能表示 -128 到 127 的范围内的值，而 300 超出了这个范围，因此会发生截断。300的二进制是：100101100，Int8只能表示8位，那么 100101100 从右边往左截取8位为：00101100 转化为10进制为44
 */

//MARK: 1.01、无符号右移运算符
/// 无符号右移运算符
/// - Parameters:
///   - lhs: 值
///   - rhs: 右移位数字
/// - Returns: 右移动后的结果
public func |>>>| (lhs: Int, rhs: Int) -> UInt32 {
    let truncating = Int32(truncatingIfNeeded: lhs)
    let value: UInt32 = UInt32(bitPattern: truncating)
    return value >> UInt32(rhs)
}
