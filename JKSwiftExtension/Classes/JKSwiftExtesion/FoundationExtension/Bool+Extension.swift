//
//  Bool+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

// MARK:- 一、基本的扩展
public extension Bool {
 
    // MARK: 1.1、Bool 值转 Int
    /// Bool 值转 Int
    var toInt: Int { return self ? 1 : 0 }
}
