//
//  CALayer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

// MARK:- 一、自定义链式编程
public extension CALayer {
    
    // MARK: 1.1、设置圆角
    /// 设置圆角
    /// - Parameter cornerRadius: 圆角
    /// - Returns: 返回自身
    @discardableResult
    func corner(_ cornerRadius: CGFloat) -> Self {
        self.cornerRadius = cornerRadius
        masksToBounds = true
        return self
    }
    
    // MARK: 1.2、设置背景色
    /// 设置背景色
    /// - Parameter color: 背景色
    /// - Returns: 返回自身
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color.cgColor
        return self
    }
    
    // MARK: 1.3、设置背景色 (十六进制字符串)
    /// 设置背景色 (十六进制字符串)
    /// - Parameter hex: 背景色 (十六进制字符串)
    /// - Returns: 返回自身
    @discardableResult
    func backgroundColor(_ hex: String) -> Self {
        backgroundColor = UIColor.hexStringColor(hexString: hex).cgColor
        return self
    }
    
    // MARK: 1.4、设置frame
    /// 设置frame
    /// - Parameter frame: frame
    /// - Returns: 返回自身
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    // MARK: 1.5、添加到父视图(UIView)
    /// 添加到父视图
    /// - Parameter superView: 父视图(UIView)
    /// - Returns: 返回自身
    @discardableResult
    func addTo(_ superView: UIView) -> Self {
        superView.layer.addSublayer(self)
        return self
    }
    
    // MARK: 1.6、添加到父视图(CALayer)
    /// 添加到父视图(CALayer)
    /// - Parameter superLayer: 父视图(CALayer)
    /// - Returns: 返回自身
    @discardableResult
    func addTo(_ superLayer: CALayer) -> Self {
        superLayer.addSublayer(self)
        return self
    }
    
    // MARK: 1.7、是否隐藏
    /// 是否隐藏
    /// - Parameter isHidden: 是否隐藏
    /// - Returns: 返回自身
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    // MARK: 1.8、设置边框宽度
    /// 设置边框宽度
    /// - Parameter width: 边框宽度
    /// - Returns: 返回自身
    @discardableResult
    func borderWidth(_ width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }
    
    // MARK: 1.9、设置边框颜色
    /// 设置边框颜色
    /// - Parameter color: 边框颜色
    /// - Returns: 返回自身
    @discardableResult
    func borderColor(_ color: UIColor) -> Self {
        self.borderColor = color.cgColor
        return self
    }
    
    // MARK: 1.10、是否开启光栅化
    /// 是否开启光栅化
    /// - Parameter rasterize: 是否开启光栅化
    /// - Returns: 返回自身
    @discardableResult
    func shouldRasterize(_ rasterize: Bool) -> Self {
        self.shouldRasterize = rasterize
        return self
    }
    
    // MARK: 1.11、设置光栅化比例
    /// 设置光栅化比例
    /// - Parameter scale: 光栅化比例
    /// - Returns: 返回自身
    @discardableResult
    func rasterizationScale(_ scale: CGFloat) -> Self {
        self.rasterizationScale = scale
        self.shouldRasterize = true
        return self
    }
    
    // MARK: 1.12、设置阴影颜色
    /// 设置阴影颜色
    /// - Parameter color: 阴影颜色
    /// - Returns: 返回自身
    @discardableResult
    func shadowColor(_ color: UIColor) -> Self {
        self.shadowColor = color.cgColor
        return self
    }
    
    // MARK: 1.13、设置阴影的透明度，取值范围：0~1
    /// 设置阴影的透明度，取值范围：0~1
    /// - Parameter opacity: 阴影的透明度
    /// - Returns: 返回自身
    @discardableResult
    func shadowOpacity(_ opacity: Float) -> Self {
        self.shadowOpacity = opacity
        return self
    }
    
    // MARK: 1.14、设置阴影的偏移量
    /// 设置阴影的偏移量
    /// - Parameter offset: 偏移量
    /// - Returns: 返回自身
    @discardableResult
    func shadowOffset(_ offset: CGSize) -> Self {
        self.shadowOffset = offset
        return self
    }
    
    // MARK: 1.15、设置阴影圆角
    /// 设置阴影圆角
    /// - Parameter radius: 圆角大小
    /// - Returns: 返回自身
    @discardableResult
    func shadowRadius(_ radius: CGFloat) -> Self {
        self.shadowRadius = radius
        return self
    }
    
    // MARK: 1.16、高性能添加阴影路径 Shadow Path，提示：当用bounds设置path时,看起来的效果与只设置了shadowOpacity一样，但是添加了shadowPath后消除了离屏渲染问题
    /// 高性能添加阴影 Shadow Path
    /// - Parameter path: 阴影Path
    /// - Returns: 返回自身
    @discardableResult
    func shadowPath(_ path: CGPath) -> Self {
        self.shadowPath = path
        return self
    }
}


