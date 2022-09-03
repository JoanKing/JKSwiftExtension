//
//  UIAlertController+Extension1.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/8/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import JKSwiftExtension
@objc public extension UIAlertController {

    private var subView5: UIView? {
        guard let subView1: UIView = self.view.subviews.first,
              let subView2: UIView = subView1.subviews.first,
              let subView3: UIView = subView2.subviews.first,
              let subView4: UIView = subView3.subviews.first,
              let subView5: UIView = subView4.subviews.first
              else { return nil }
        return subView5
    }

    var titleLabel: UILabel? {
        guard let _ = self.title,
              let subView5 = subView5,
              subView5.subviews.count > 2,
              let label = subView5.subviews[1] as? UILabel
              else { return nil }
        return label
    }

    var messageLabel: UILabel? {
        guard let subView5 = subView5
              else { return nil }
        let messageLabelIndex = self.title == nil ? 1 : 2
        if subView5.subviews.count > messageLabelIndex,
           let label = subView5.subviews[messageLabelIndex] as? UILabel
           {
            return label
        }
        return nil
    }
}
