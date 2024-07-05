//
//  CAGradientLayer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/2/1.
//

import Foundation
import UIKit

// MARK: - 一、基本的扩展
public enum JKViewGradientDirection {
    /// 水平从左到右
    case horizontal
    /// 垂直从上到下
    case vertical
    /// 左上到右下
    case leftOblique
    /// 右上到左下
    case rightOblique
    /// 其他情况.
    case other(CGPoint, CGPoint)
    
    public func point() -> (CGPoint, CGPoint) {
        switch self {
        case .horizontal:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0))
        case .vertical:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1))
        case .leftOblique:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
        case .rightOblique:
            return (CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1))
        case .other(let stat, let end):
            return (stat, end)
        }
    }
}
public extension JKPOP where Base: CAGradientLayer {
    
    // MARK: 1.1、设置渐变色图层
    /// 设置渐变色图层
    /// - Parameters:
    ///   - direction: 渐变方向
    ///   - gradientColors: 渐变的颜色数组（颜色的数组）
    ///   - gradientLocations: 设置渐变颜色的终止位置，这些值必须是递增的，数组的长度和 colors 的长度最好一致
    func gradientLayer(_ direction: JKViewGradientDirection = .horizontal, _ gradientColors: [Any], _ gradientLocations: [NSNumber]? = nil, _ transform: CATransform3D? = nil) -> CAGradientLayer {
       
        // 设置渐变的颜色数组
        self.base.colors = gradientColors
        // 设置渐变颜色的终止位置，这些值必须是递增的，数组的长度和 colors 的长度最好一致
        self.base.locations = gradientLocations
        // 设置渲染的起始结束位置（渐变方向设置）
        self.base.startPoint = direction.point().0
        self.base.endPoint = direction.point().1
        if let weakTransform = transform {
            self.base.transform = weakTransform
        }
        
        return self.base
    }
}
