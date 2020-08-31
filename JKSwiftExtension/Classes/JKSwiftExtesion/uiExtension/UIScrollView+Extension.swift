//
//  UIScrollView+Extension.swift
//  JKLive
//
//  Created by IronMan on 2020/8/28.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

extension UIScrollView {
    @objc  func neverAdjustContentInset() {
        if #available(iOS 11.0, *), responds(to: #selector(setter: contentInsetAdjustmentBehavior)) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
}
