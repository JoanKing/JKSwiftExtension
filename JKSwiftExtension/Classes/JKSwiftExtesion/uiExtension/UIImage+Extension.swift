//
//  UIImage+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 利用资源文件直接初始化 UIImage 实例化对象
    /// - Parameter name: 图片的枚举值
    convenience init?(_ name: JKResource.image) {
        self.init(named: name.rawValue)
    }
    
}
