//
//  NSRange+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/2/18.
//

import Foundation
extension NSRange: JKPOPCompatible {}

// MARK:- 一、基本的扩展
public extension JKPOP where Base == NSRange {
    
    // MARK: 1.1、NSRange转换成Range的方法
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.index(string.startIndex, offsetBy: self.base.location)
        let endIndex = string.index(startIndex, offsetBy: self.base.length)
        return startIndex..<endIndex
    }
}
