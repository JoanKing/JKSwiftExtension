//
//  JKTouchView.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKTouchView: UIView {
    
    /// 范围 <= 0
    var min_x: CGFloat = 0
    /// 范围 <= 0
    var min_y: CGFloat = 0
    /// 范围  >=  0
    var max_x: CGFloat = 0
    /// 范围  >= 0
    var max_y: CGFloat = 0
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
      
        guard point.x <= max_x && point.x >= min_x + self.frame.size.width && point.y <= max_y + self.frame.size.height && point.y >= min_y  else {
            return super.hitTest(point, with: event)
        }
        return super.hitTest(CGPoint(x: 0, y: 0), with: event)
    }
}
