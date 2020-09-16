//
//  UIBarButtonItem+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation
import UIKit
extension UIBarButtonItem {
    
    class func createBarbuttonItem(name: String, target: Any?, action: Selector) -> UIBarButtonItem {
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: name), for: UIControl.State.normal)
        rightBtn.setImage(UIImage(named: name + "_highlighted"), for: UIControl.State.highlighted)
        // button自适应大小
        rightBtn.sizeToFit()
        rightBtn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return UIBarButtonItem(customView:rightBtn)
        
    }
    
    class func createBarbuttonItem2(name: String, target: Any?, action: Selector) -> UIBarButtonItem {
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: name), for: UIControl.State.normal)
        rightBtn.setImage(UIImage(named: name + "_highlighted"), for: UIControl.State.selected)
        // button自适应大小
        rightBtn.sizeToFit()
        rightBtn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return UIBarButtonItem(customView:rightBtn)
        
    }
    
    // 快速创建的方法
    convenience init(JKname: String, target: Any?, action: String?) {
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: JKname), for: UIControl.State.normal)
        rightBtn.setImage(UIImage(named: JKname + "_highlighted"), for: UIControl.State.selected)
        // button自适应大小
        rightBtn.sizeToFit()
        
        if action != nil {
            // 如果是自己封装一个按钮, 最好传入字符串, 然后再将字符串包装为Selector
            rightBtn.addTarget(target, action: Selector((action)!), for: UIControl.Event.touchUpInside)
        }
        
        self.init(customView: rightBtn)
    }
    
}
