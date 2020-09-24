//
//  CALayer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

public extension CALayer {
    @discardableResult
    func corner(_ cornerRadius: CGFloat) -> Self {
        self.cornerRadius = cornerRadius
        masksToBounds = true
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color.cgColor
        return self
    }
    
    @discardableResult
    func backgroundColor(_ hex: String) -> Self {
        backgroundColor = UIColor.hexColor(hex: hex).cgColor
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func addTo(_ superView: UIView) -> Self {
        superView.layer.addSublayer(self)
        return self
    }
    @discardableResult
    func addTo(_ superLayer: CALayer) -> Self {
        superLayer.addSublayer(self)
        return self
    }
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    @discardableResult
    func borderWidth(_ width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }
    
    @discardableResult
    func borderColor(_ color: UIColor) -> Self {
        self.borderColor = color.cgColor
        return self
    }
    
    /// 是否开启光栅化
    @discardableResult
    func shouldRasterize(_ rasterize: Bool) -> Self {
        self.shouldRasterize = rasterize
        return self
    }
    
    /// 开启光栅化比例
    @discardableResult
    func rasterizationScale(_ scale: CGFloat) -> Self {
        self.rasterizationScale = scale
        self.shouldRasterize = true
        return self
    }
    
    /// 阴影颜色
    @discardableResult
    func shadowColor(_ color: UIColor) -> Self {
        self.shadowColor = color.cgColor
        return self
    }
    
    /// 阴影的透明度
    @discardableResult
    func shadowOpacity(_ opacity: Float) -> Self {
        self.shadowOpacity = opacity
        return self
    }
    
    /// 阴影偏移量
    @discardableResult
    func shadowOffset(_ offset: CGSize) -> Self {
        self.shadowOffset = offset
        return self
    }
    /// 阴影圆角
    @discardableResult
    func shadowRadius(_ radius: CGFloat) -> Self {
        self.shadowRadius = radius
        return self
    }
    /// 阴影偏移量
    @discardableResult
    func shadowPath(_ path: CGPath) -> Self {
        self.shadowPath = path
        return self
    }
}


