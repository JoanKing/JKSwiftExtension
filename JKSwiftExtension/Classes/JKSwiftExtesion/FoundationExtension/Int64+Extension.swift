//
//  Int64+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/3.
//

import UIKit

// MARK:- 一、Int64 与其他类型的转换
public extension Int64 {
    
    // MARK: 1.1、转 Int
    /// 转 Int
    var toInt: Int {
        return Int(self)
    }
    // MARK: 1.2、转 CGFloat
    /// 转 CGFloat
    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
    // MARK: 1.3、转 Float
    /// 转 Float
    var toFloat: Float {
        return Float(self)
    }
    // MARK: 1.4、转 Double
    /// 转 Double
    var toDouble: Double {
        return Double(self)
    }
    // MARK: 1.5、转 String
    /// 转 String
    var toString: String {
        return String(self)
    }
    // MARK: 1.6、转 NSNumber
    /// 转 NSNumber
    var toNumber: NSNumber {
        return NSNumber.init(value: self)
    }
    // MARK: 1.7、转 Int64
    /// 转 Int64
    var toInt64: Int64 {
        return self
    }
}
