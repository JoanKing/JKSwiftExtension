//
//  Float+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

extension Float {
    
    // MARK: 转换成千位分隔符（每三位）
    /// 转换成千位分隔符（每三位）
    /// - Returns: description
    func toPrice() -> String? {
        let priceNumberFormatter = NumberFormatter()
        priceNumberFormatter.positiveFormat = "###,###.#"
        return priceNumberFormatter.string(from: NSNumber(value: self))
    }

    // MARK: 浮点数四舍五入
    ///  浮点数四舍五入
    /// - Parameter places: places description
    /// - Returns: description
    public func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
