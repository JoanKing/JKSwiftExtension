//
//  CGPoint+Extension.swift
//  JKSwiftExtension
//
//  Created by 小冲冲 on 2024/1/22.
//
// MARK: CGPoint扩展
import UIKit

// MARK: - 一、基本的扩展
extension CGPoint {
    // MARK: 1.1、两个CGPoint之间的差
    /// 两个CGPoint之间的差
    /// - Parameters:
    ///   - lhs: 左边的点
    ///   - rhs: 右边的点
    /// - Returns: 结果
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    // MARK: 1.2、计算两个 CGPoint 的中点
    // MARK: 计算两个 CGPoint 的中点
    /// 计算两个 CGPoint 的中点
    /// - Parameter point: 另外一个点
    /// - Returns: 中间点
    public func midPoint(by point: CGPoint) -> CGPoint {
        return CGPoint(x: (self.x + point.x) / 2, y: (self.y + point.y) / 2)
    }
}

