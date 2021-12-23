//
//  Character+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
extension Character: JKPOPCompatible {}
// MARK: - 一、Character 与其他类型的转换
public extension JKPOP where Base == Character {

    // MARK: 1.1、Character 转 String
    /// Character 转 String
    var charToString: String { return String(self.base) }

    // MARK: 1.2、Character 转 Int
    /// Character 转 Int
    var charToInt: Int? {
        return Int(String(self.base))
        
    }
}

// MARK: - 二、常用的属性和方法
public extension JKPOP where Base == Character {
    
    // MARK: 2.1、判断是不是 Emoji 表情
    /// 判断是不是 Emoj 表情
    var isEmoji: Bool {
        return String(self.base).jk.includesEmoji()
    }
}
