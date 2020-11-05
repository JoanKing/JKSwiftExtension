//
//  DateFormatter+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import Foundation

// MARK:- 一、基本扩展
public extension DateFormatter {

    // MARK: 1.1、格式化快捷方式
    /// 格式化快捷方式
    /// - Parameter format: 格式
    convenience init(format: String) {
        self.init()
        dateFormat = format
    }
}
