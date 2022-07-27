//
//  CGFloat+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
extension CGFloat: JKPOPCompatible {}
// MARK: - 一、CGFloat 的基本转换
public extension JKPOP where Base == CGFloat {

    // MARK: 1.1、转 Int
    /// 转 Int
    var int: Int { return Int(self.base) }
    
    // MARK: 1.2、转 CGFloat
    /// 转 CGFloat
    var cgFloat: CGFloat { return self.base }
    
    // MARK: 1.3、转 Int64
    /// 转 Int64
    var int64: Int64 { return Int64(self.base) }
    
    // MARK: 1.4、转 Float
    /// 转 Float
    var float: Float { return Float(self.base) }
    
    // MARK: 1.5、转 String
    /// 转 String
    var string: String { return String(self.base.jk.double) }
    
    // MARK: 1.6、转 NSNumber
    /// 转 NSNumber
    var number: NSNumber { return NSNumber(value: self.base.jk.double) }
    
    // MARK: 1.7、转 Double
    /// 转 Double
    var double: Double { return Double(self.base) }
}

// MARK: - 二、角度和弧度相互转换
public extension JKPOP where Base == CGFloat {
    
    // MARK: 角度转弧度
    /// 角度转弧度
    /// - Returns: 弧度
    func degreesToRadians() -> CGFloat {
        return (.pi * self.base) / 180.0
    }
    
    // MARK: 弧度转角度
    /// 角弧度转角度
    /// - Returns: 角度
    func radiansToDegrees() -> CGFloat {
        return (self.base * 180.0) / .pi
    }
}


//MARK: -三、基本的扩展
public extension JKPOP where Base == CGFloat {
    // MARK:3.1、一个数字四舍五入返回
    /// 一个数字四舍五入返回
    /// - Parameters:
    ///   - value: 值
    ///   - scale: 保留小数的位数
    /// - Returns: 四舍五入返回结果
    func rounding(scale: Int16 = 1) -> CGFloat {
        let value = NSDecimalNumberHandler.jk.rounding(value: self.base, scale: scale)
        return "\(value.floatValue)".jk.toCGFloat() ?? 0
    }
}
