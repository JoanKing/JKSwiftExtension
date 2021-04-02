//
//  UITabBar+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/13.
//

import UIKit

public extension UITabBar {
    
    // MARK: 让图片和文字在iOS11下仍然保持上下排列
    /// 让图片和文字在iOS11下仍然保持上下排列
    override var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return super.traitCollection
    }
}
