//
//  Double+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/2.
//

import UIKit
extension Double: JKPOPCompatible {}
// MARK: - 一、Double 的基本转换
public extension JKPOP where Base == Double {
   
    // MARK: 1.1、转 Int
    /// 转 Int
    var int: Int { return Int(self.base) }
    
    // MARK: 1.2、Double 四舍五入转 Int
    /// Double 四舍五入转 Int
    var lroundToInt: Int { return lround(self.base) }
    
    // MARK: 1.3、转 CGFloat
    /// 转 CGFloat
    var cgFloat: CGFloat { return CGFloat(self.base) }

    // MARK: 1.4、转 Int64
    /// 转 Int64
    var int64: Int64 { return Int64(self.base) }
    
    // MARK: 1.5、转 Float
    /// 转 Float
    var float: Float { return Float(self.base) }
    
    // MARK: 1.6、转 String
    /// 转 String
    var string: String { return String(self.base) }
    
    // MARK: 1.7、转 NSNumber
    /// 转 NSNumber
    var number: NSNumber { return NSNumber(value: self.base) }
    
    // MARK: 1.8、转 Double
    /// 转 Double
    var double: Double { return self.base }
    
    // MARK: 1.9、Double转十六进制字符串
    /// Double转十六进制字符串
    var doubleToHexString: String {
        var value = self.base
        let data = withUnsafeBytes(of: &value) { Data($0) }
        var hexString = ""
        data.reversed().forEach { byte in
            hexString.append(String(format: "%02x", byte))
        }
        return hexString
    }
}

// MARK: - 二、数字的处理
/**
 拾：代表的是10的1次方.
 佰：代表的是10的2次方.
 仟：代表的是10的3次方.
 万：代表的是10的4次方.
 亿：代表的是10的8次方.
 兆：代表的是10的12次方.
 京：代表的是10的16次方.
 垓：代表的是10的20次方.
 杼：代表的是10的24次方.
 穰：代表的是10的28次方.
 沟：代表的是10的32次方.
 涧：代表的是10的36次方.
 正：代表的是10的40次方.
 载：代表的是10的44次方.
 极：代表的是10的48次方.
 恒河沙：代表的是10的52次方.
 阿僧□：代表的是10的56次方.
 那由它：代表的是10的60次方.
 不可思议：代表的是10的64次方.
 无量：代表的是10的68次方.
 大数：代表的是10的72次方.
 */
public extension JKPOP where Base == Double {
    // MARK: 2.1、浮点数四舍五入
    /// 浮点数四舍五入
    /// - Parameter places: 数字
    /// - Returns: Double
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self.base * divisor).rounded() / divisor
    }
    
    // MARK: 2.2、数字金额转换成大写人民币金额
    /// 数字金额转换成大写人民币金额
    /// - Parameters:
    ///   - scale: 保留小数位数
    ///   - roundingMode: 取舍方式
    /// - Returns: 大写人民币金额
    ///
    /// 提示：double 双精度浮点, 64取值范围是-1022 - 1023 有效数位15
    func convertToRMB(scale: Int16 = 2, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        return "\(self.base)".jk.convertToRMB(scale: scale, roundingMode: roundingMode)
    }
}

// MARK: - 三、角度和弧度相互转换
public extension JKPOP where Base == Double {
    
    // MARK: 角度转弧度
    /// 角度转弧度
    /// - Returns: 弧度
    func degreesToRadians() -> Double {
        return (.pi * self.base) / 180.0
    }
    
    // MARK: 弧度转角度
    /// 角弧度转角度
    /// - Returns: 角度
    func radiansToDegrees() -> Double {
        return (self.base * 180.0) / .pi
    }
}
