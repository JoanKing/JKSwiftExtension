//
//  UITabBar+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/13.
//

import UIKit

//MARK: - 一、基本的扩展
public extension UITabBar {
    // MARK: 让图片和文字在iOS11以上时仍然保持上下排列
    /// 让图片和文字在iOS11以上时仍然保持上下排列
    ///
    /// 当系统更新到了 iOS11 以上时，图片和文字在 iPad 下就变成了左右排列（iPhone 下仍然是上下排列）。
    /// iPad 下的这种左右排列方式是 iOS11 的新特性，如果想要改回上下排列的话可以通过重写 UITabBar 的 traitCollection 方法来实现。
    /// compact: 紧凑模式 regular:宽松模式(在pad机会优化显示，不会显得拥挤)
    override var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if #available(iOS 17, *) {
                self.traitOverrides.horizontalSizeClass = .compact
            } else {
                return UITraitCollection(horizontalSizeClass: .compact)
            }
        }
        return super.traitCollection
    }
}

public extension JKPOP where Base: UITabBar {
    // MARK: 1.1、设置透明背景
    /// 设置透明背景
    func setTransparentBackground() {
        self.base.backgroundImage = UIImage()
        self.base.shadowImage = UIImage()
        self.base.isTranslucent = true
    }
}

