//
//  Double+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/2.
//

import UIKit

// MARK:- 一、Double 的基本转换
extension Double {
   
    // MARK: 1.1、转 Int
    /// 转 Int
    public var int: Int { return Int(self) }
    
    // MARK: 1.2、转 CGFloat
    /// 转 CGFloat
    public var cgFloat: CGFloat { return CGFloat(self) }

    // MARK: 1.3、转 Int64
    /// 转 Int64
    public var int64: Int64 { return Int64(self) }
    
    // MARK: 1.4、转 Float
    /// 转 Float
    public var float: Float { return Float(self) }
    
    // MARK: 1.5、转 String
    /// 转 String
    public var string: String { return String(self) }
    
    // MARK: 1.6、转 NSNumber
    /// 转 NSNumber
    public var number: NSNumber { return NSNumber.init(value: self) }
    
    // MARK: 1.7、转 Double
    /// 转 Double
    public var double: Double { return self }
}

// MARK:- 浮点数四舍五入
extension Double {
    // MARK:- 浮点数四舍五入
    /// 浮点数四舍五入
    /// - Parameter places: 数字
    /// - Returns: Double
    public func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
