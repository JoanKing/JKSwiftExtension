//
//  CGFloat+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

// MARK:- 一、CGFloat 的基本转换
extension CGFloat {

    // MARK: 1.1、转 Int
    /// 转 Int
    public var int: Int { return Int(self) }
    
    // MARK: 1.2、转 CGFloat
    /// 转 CGFloat
    public var cgFloat: CGFloat { return self }
    
    // MARK: 1.3、转 Int64
    /// 转 Int64
    public var int64: Int64 { return Int64(self) }
    
    // MARK: 1.4、转 Float
    /// 转 Float
    public var float: Float { return Float(self) }
    
    // MARK: 1.5、转 String
    /// 转 String
    public var string: String { return String(self.double) }
    
    // MARK: 1.6、转 NSNumber
    /// 转 NSNumber
    public var number: NSNumber { return NSNumber.init(value: self.double) }
    
    // MARK: 1.7、转 Double
    /// 转 Double
    public var double: Double { return Double(self) }
}

// MARK:- 二、角度和弧度相互转换
extension CGFloat {
    
    // MARK: 角度转弧度
    /// 角度转弧度
    /// - Returns: 弧度
    public func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    // MARK: 弧度转角度
    /// 角弧度转角度
    /// - Returns: 角度
    public func radiansToDegrees() -> CGFloat {
        return (self * 180.0) / .pi
    }
}
