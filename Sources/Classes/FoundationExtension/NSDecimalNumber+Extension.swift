//
//  NSDecimalNumber+Extension.swift
//  JKSwiftExtension
//
//  Created by chongwang on 2024/11/5.
//

import Foundation

// MARK: NSDecimalNumber 基本扩展
public extension JKPOP where Base: NSDecimalNumber {
    /// 小数位是否是0
    var isDecimalValueZero: Bool {
        // 检查小数部分是否为 0
        return self.base.decimalValue.isEqual(to: NSDecimalNumber.zero.decimalValue)
    }
    
    // MARK: 如果小数是0，是否只展示整数部分
    /// 如果小数是0，是否只展示整数部分
    /// - Parameter isRemoveDecimalZero: 如果小数是0，是否去除0，只返回整数
    /// - Returns: 结果
    func decimalValue(isRemoveDecimalZero: Bool = false) -> String {
        guard isRemoveDecimalZero else { return "\(self.base.stringValue)" }
        // 检查小数部分是否为 0
        if self.base.decimalValue.isEqual(to: NSDecimalNumber.zero.decimalValue) {
            return "\(self.base.intValue)"
        } else {
            return "\(self.base.stringValue)"
        }
    }
}
