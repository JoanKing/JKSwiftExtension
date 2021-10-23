//
//  Bool+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
extension Bool: JKPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JKPOP where Base == Bool {
 
    // MARK: 1.1、Bool 值转 Int
    /// Bool 值转 Int
    var boolToInt: Int { return self.base ? 1 : 0 }
}
