//
//  UIButton+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setTitle(_ title: JKResource.string, for state: UIControl.State) {
        setTitle(title.rawValue, for: state)
    }
}
