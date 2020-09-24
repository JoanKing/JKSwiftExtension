//
//  Bundle+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

extension Bundle {
    
    // MARK:- 从其他的 Bundle 通过 bundlename 获取 bundle
    /// 从其他的 Bundle 通过 bundlename 获取 bundle
    /// - Parameters:
    ///   - bundleName: 目标bundle的名称
    ///   - aClass: 目标bundle所在的父bundle的class
    convenience init?(bundleName: String, forParent aClass: AnyClass) {
        guard let path = Bundle(for: aClass).path(forResource: bundleName, ofType: "bundle") else {
            return nil
        }
        self.init(path: path)
    }
}

