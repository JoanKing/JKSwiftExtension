//
//  UITabBarController+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/12/31.
//

import Foundation

// MARK:- 一、基本的扩展
public extension UITabBarController {
    // MARK: 1.1、当前选择索引
    /// 当前选择索引
    static var selectedIdx: Int {
        guard let keyWindow = UIApplication.shared.keyWindow,
              let rootController = keyWindow.rootViewController as? UITabBarController else { return 0}
        return rootController.selectedIndex
    }
}
