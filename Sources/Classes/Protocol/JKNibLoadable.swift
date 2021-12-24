//
//  NibLoadable.swift
//  JKLive
//
//  Created by 王冲 on 2020/7/23.
//  Copyright © 2020 王冲. All rights reserved.
//

import Foundation
import UIKit

public protocol JKNibLoadable {
}

// MARK: - 一、继承于UIView的才可以使用该协议的扩展
public extension JKNibLoadable where Self: UIView {
    
    // MARK: 1.1、加载xib视图
    /// 加载xib视图
    /// - Parameter nibName: xib名字
    /// - Returns: 返回视图
    static func loadFromNib(_ nibName: String? = nil) -> Self {
        let loadNme = nibName == nil ? "\(self)" : nibName!
        return Bundle.main.loadNibNamed(loadNme, owner: nil, options: nil)?.first as! Self
    }
}
