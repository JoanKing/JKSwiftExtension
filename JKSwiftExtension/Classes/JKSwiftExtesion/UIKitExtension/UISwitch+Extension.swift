//
//  UISwitch+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

// MARK:- 一、基本的扩展
public extension JKPOP where Base: UISwitch {

    // MARK: 1.1、开关切换
    /// 开关切换
    func toggle() {
        self.base.setOn(!self.base.isOn, animated: true)
    }
}
