//
//  CGSize+Extension.swift
//  JKSwiftExtension
//
//  Created by chongwang on 2024/11/5.
//
import Foundation

extension CGSize {
    
    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
}
