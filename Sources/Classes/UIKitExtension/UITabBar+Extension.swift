//
//  UITabBar+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/13.
//

import UIKit

//MARK: - 一、基本的扩展
public extension JKPOP where Base: UITabBar {
    // MARK: 1.1、设置透明背景
    /// 设置透明背景
    func setTransparentBackground() {
        self.base.backgroundImage = UIImage()
        self.base.shadowImage = UIImage()
        self.base.isTranslucent = true
    }
}

