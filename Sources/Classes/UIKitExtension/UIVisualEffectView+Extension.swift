//
//  UIVisualEffectView+Extension.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2022/3/26.
//

import Foundation
import UIKit

// MARK: - 一、基本的扩展
public extension JKPOP where Base: UIVisualEffectView {
    
    // MARK: 1.1、创建一个UIVisualEffectView对象
    /// 创建一个UIVisualEffectView对象
    /// - Parameters:
    ///   - size: UIVisualEffectView的size
    ///   - alpha: 模糊透明度
    ///   - style: 模糊样式
    ///   - isAddVibrancy: 是否添加UIVibrancyEffect
    /// - Returns: 返回UIVisualEffectView
    static func visualEffectView(size: CGSize, alpha: CGFloat = 1.0, style: UIBlurEffect.Style = .light, isAddVibrancy: Bool = true) -> UIVisualEffectView {
        // 首先创建一个模糊效果
        let blurEffect = UIBlurEffect(style: style)
        // 接着创建一个承载模糊效果的视图
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 毛玻璃的透明度
        blurView.alpha = alpha
        // 设置模糊视图的大小（全屏）
        blurView.frame.size = size
        // 创建并添加vibrancy视图
        if isAddVibrancy {
            /*
             UIVibrancyEffect 主要用于放大和调整UIVisualEffectView 视图下面的内容的颜色，同时让UIVisualEffectView的  contentView中的内容看起来更加生动。通常UIVibrancyEffect 对象是与UIBlurEffect一起使用
             */
            let vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
            vibrancyView.frame.size = size
            blurView.contentView.addSubview(vibrancyView)
        }
        return blurView
    }
}
