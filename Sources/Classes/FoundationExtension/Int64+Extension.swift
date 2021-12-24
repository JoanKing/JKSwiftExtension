//
//  Int64+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/3.
//

import UIKit
extension Int64: JKPOPCompatible {}
// MARK: - 一、Int64 与其他类型的转换
public extension JKPOP where Base == Int64 {
    
    // MARK: 1.1、转 Int
    /// 转 Int
    var int64ToInt: Int {
        return Int(self.base)
    }
    // MARK: 1.2、转 CGFloat
    /// 转 CGFloat
    var int64ToCGFloat: CGFloat {
        return CGFloat(self.base)
    }
    // MARK: 1.3、转 Float
    /// 转 Float
    var int64ToFloat: Float {
        return Float(self.base)
    }
    // MARK: 1.4、转 Double
    /// 转 Double
    var int64ToDouble: Double {
        return Double(self.base)
    }
    // MARK: 1.5、转 String
    /// 转 String
    var int64ToString: String {
        return String(self.base)
    }
    // MARK: 1.6、转 NSNumber
    /// 转 NSNumber
    var int64ToNumber: NSNumber {
        return NSNumber(value: self.base)
    }
    // MARK: 1.7、转 Int64
    /// 转 Int64
    var int64ToInt64: Int64 {
        return self.base
    }
}
