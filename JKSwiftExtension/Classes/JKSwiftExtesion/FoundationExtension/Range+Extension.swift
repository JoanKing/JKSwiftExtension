//
//  Range+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/3/25.
//

import Foundation

// MARK: - 一、基本的扩展
extension Range: JKPOPCompatible {}

public extension JKPOP where Base: RangeExpression, Base.Bound == String.Index {
    
    // MARK: 1.1、Range 转 NSRange
    /// Range 转 NSRange
    /// - Parameter string: 父字符串
    /// - Returns: NSRange
    func toNSRange<S: StringProtocol>(in string: S) -> NSRange {
        return NSRange(self.base, in: string)
    }
}
