//
//  Float+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
extension Float: JKPOPCompatible {}
// MARK:- 一、Float 与其他类型的转换
public extension JKPOP where Base == Float {
    
    // MARK: 1.1、转 Int
    /// 转 Int
    var int: Int { return Int(self.base) }
    
    // MARK: 1.2、Float四舍五入转Int
    /// Float四舍五入转Int
    var lroundfToInt: Int { return lroundf(self.base) }
    
    // MARK: 1.3、转 CGFloat
    /// 转 CGFloat
    var cgFloat: CGFloat { return CGFloat(self.base) }
    
    // MARK: 1.4、转 Int64
    /// 转 Int64
    var int64: Int64 { return Int64(self.base) }
    
    // MARK: 1.5、转 Double
    /// 转 Double
    var double: Double { return Double(self.base) }
    
    // MARK: 1.6、转 String
    /// 转 String
    var string: String { return String(self.base) }
    
    // MARK: 1.7、转 NSNumber
    /// 转 NSNumber
    var number: NSNumber { return NSNumber(value: self.base) }
    
    // MARK: 1.8、转 Float
    /// 转 Float
    var float: Float { return self.base }
}

// MARK:- 二、其他常用的方法
public extension JKPOP where Base == Float {

    // MARK: 2.1、浮点数四舍五入
    /// 浮点数四舍五入,places
    /// - Parameter places: 小数保留的位数
    /// - Returns: 保留后的小数
    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self.base * divisor).rounded() / divisor
    }
}
