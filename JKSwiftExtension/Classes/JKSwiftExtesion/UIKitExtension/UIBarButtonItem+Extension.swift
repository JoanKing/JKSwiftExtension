//
//  UIBarButtonItem+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit

// MARK:- 一、基本的扩展
public extension UIBarButtonItem {
    
    // MARK: 1.1、快捷创建 UIBarButtonItem
    class func createBarbuttonItem(name: String, target: Any?, action: Selector) -> UIBarButtonItem {
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: name), for: UIControl.State.normal)
        rightBtn.setImage(UIImage(named: name + "_highlighted"), for: UIControl.State.highlighted)
        // button自适应大小
        rightBtn.sizeToFit()
        rightBtn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return UIBarButtonItem(customView:rightBtn)
    }
    
}
