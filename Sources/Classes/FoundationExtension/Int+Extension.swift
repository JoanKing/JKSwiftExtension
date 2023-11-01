//
//  Int+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
extension Int: JKPOPCompatible {}

// MARK: - 一、基本的扩展方法
public extension JKPOP where Base == Int {
    //MARK: 1.1、是否是偶数
    /// 是否是偶数
    /// - Returns: 结果
    func isEven() -> Bool {
        return self.base % 2 == 0
    }
    
    // MARK: 1.2、取区间内的随机数，如取  0..<10 之间的随机数
    ///  取区间内的随机数，如取  0..<10 之间的随机数
    /// - Parameter within: 0..<10
    /// - Returns: 返回区间内的随机数
    static func random(within: Range<Int>) -> Int {
        let delta = within.upperBound - within.lowerBound
        return within.lowerBound + Int(arc4random_uniform(UInt32(delta)))
    }
}

// MARK: - 二、Int 与其他类型的转换
public extension JKPOP where Base == Int {
    
    // MARK: 2.1、转 Double
    /// 转 Double
    var intToDouble: Double { return Double(self.base) }
    
    // MARK: 2.2、转 Float
    /// 转 Float
    var intToFloat: Float { return Float(self.base) }
    
    // MARK: 2.3、转 Int64
    /// 转 Int64
    var intToInt64: Int64 { return Int64(self.base) }
    
    // MARK: 2.4、转 CGFloat
    /// 转 CGFloat
    var intToCGFloat: CGFloat { return CGFloat(self.base) }
    
    // MARK: 2.5、转 String
    /// 转 String
    var intToString: String { return String(self.base) }
    
    // MARK: 2.6、转 UInt
    /// 转 UInt
    var intToUInt: UInt { return UInt(self.base) }
    
    // MARK: 2.7、转 CountableRange(可数的开区间)
    /// 转 CountableRange(可数的开区间)
    ///
    /// 分析一下：CountableClosedRange、CountableRange、ClosedRange、Range
    /// CountableClosedRange：可数的闭区间  如：[0, 5]
    ///  let rangeA = 0...5
    /// CountableRange：可数的开区间 [0, 5)
    ///  let rangeB = 0..<5
    /// ClosedRange：不可数的闭区间 [0.1, 5.1]
    ///  let rangeC = 0.1...5.1
    /// Range：不可数的开居间 [0.1,5.1)
    ///  let rangeD = 0.1..<5.1
    var intToCountableRange: CountableRange<Int>? {
        guard self.base > 0 else {
            return nil
        }
        return 0..<self.base
    }
}

// MARK: - 三、转换为其他单位
public extension JKPOP where Base == Int {
    
    //MARK: 3.1、转换万单位
    /// 转换万单位
    /// - Parameters:
    ///   - scale: 小数点后舍入值的位数，默认 1 位
    ///   - roundingMode: 小数取舍方式
    ///   - unit: 单位
    ///   - isNeedAddZero: 是否后面追加0，比如：1.201  保留2位是：1.20 或者 1.2，如果设置为true，则scale是几位则后面是几位，不足的使用0填充
    /// - Returns: 转换后的结果
    func toTenThousandString(scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain, unit: String = "万", isNeedAddZero: Bool = false) -> String {
        let absValue = abs(self.base)
        if absValue <= 9999 {
            return "\(self.base)"
        } else {
            let decimalValue = NSDecimalNumberHandler.jk.calculation(type: .dividing, value1: self.base, value2: 10000, roundingMode: roundingMode, scale: scale)
            return (isNeedAddZero ? "\(String(format: "%.\(scale)f", decimalValue.doubleValue))" : "\(decimalValue)") + unit
        }
    }
    
    // MARK: 3.2、转换为大小单位：UInt64 -> "bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"
    /// 转换为大小单位：UInt64 -> "bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"
    /// - Parameter size: 大小
    /// - Returns: 转换后的文件大小
    func covertUInt64ToString() -> String {
        var convertedValue: Double = Double(self.base)
        var multiplyFactor = 0
        let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        while convertedValue > 1024 {
            convertedValue /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
    }
}
