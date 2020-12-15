//
//  Float+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

// MARK:- 一、Float 与其他类型的转换
extension Float {
    
    // MARK: 1.1、转 Int
    /// 转 Int
    public var int: Int { return Int(self) }
    
    // MARK: 1.2、转 CGFloat
    /// 转 CGFloat
    public var cgFloat: CGFloat { return CGFloat(self) }
    
    // MARK: 1.3、转 Int64
    /// 转 Int64
    public var int64: Int64 { return Int64(self) }
    
    // MARK: 1.4、转 Double
    /// 转 Double
    public var double: Double { return Double(self) }
    
    // MARK: 1.5、转 String
    /// 转 String
    public var string: String { return String(self) }
    
    // MARK: 1.6、转 NSNumber
    /// 转 NSNumber
    public var number: NSNumber { return NSNumber(value: self) }
    
    // MARK: 1.7、转 Float
    /// 转 Float
    public var float: Float { return self }
}

// MARK:- 二、其他常用的方法
public extension Float {

    // MARK: 2.1、浮点数四舍五入
    /// 浮点数四舍五入,places
    /// - Parameter places: 小数保留的位数
    /// - Returns: 保留后的小数
    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
