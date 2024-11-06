//
//  CGRect+Extension.swift
//  JKSwiftExtension
//
//  Created by chongwang on 2024/11/5.
//

import Foundation

// MARK: - 一、基本的扩展方法
extension CGRect {
    
    static func * (lhs: CGRect, rhs: CGFloat) -> CGRect {
        return CGRect(origin: lhs.origin * rhs, size: lhs.size * rhs)
    }
}
