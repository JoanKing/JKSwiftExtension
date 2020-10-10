//
//  Int+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

public extension Int {
    
    /// Converts integer value to Double.
    var toDouble: Double { return Double(self) }

    /// Converts integer value to Float.
    var toFloat: Float { return Float(self) }

    /// Converts integer value to CGFloat.
    var toCGFloat: CGFloat { return CGFloat(self) }

    /// Converts integer value to String.
    var toString: String { return String(self) }

    /// Converts integer value to UInt.
    var toUInt: UInt { return UInt(self) }

    /// Converts integer value to a 0..<Int range. Useful in for loops.
    var range: CountableRange<Int> { return 0..<self }

    /// Returns a random integer number in the range min...max, inclusive.
    static func random(within: Range<Int>) -> Int {
        let delta = within.upperBound - within.lowerBound
        return within.lowerBound + Int(arc4random_uniform(UInt32(delta)))
    }
    
    /// 转换万单位
    func unitString() -> String {
        if self < 0 {
            return "0"
        } else if self <= 9999 {
            return "\(self)"
        } else {
            let doub = CGFloat(self) / 10000
            let str = String(format: "%.1f", doub)
            let index = str.index(str.endIndex, offsetBy: -1)
            let suffix = str.substring(from: index)
            if suffix == "0" {
                let toIndex = str.index(str.endIndex, offsetBy: -2)
                return str.substring(to: toIndex) + "万"
            } else {
                return str + "万"
            }
        }
    }
    
    /// 转换成千位分隔符（每三位）
    func getPrice() -> String? {
        let priceNumberFormatter = NumberFormatter()
        priceNumberFormatter.positiveFormat = "###,###"
        return priceNumberFormatter.string(from: NSNumber(value: self))
    }
    
    /// 整形时间戳转换
    func toTimeString(dateFormat format: String) -> String {
        if self < 0 { return "" }
        let formater = DateFormatter()
        formater.dateFormat = format
        formater.locale = Locale.current
        return formater.string(from: Date(timeIntervalSince1970: Double(self)))
    }
}
