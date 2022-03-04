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
    var minX: CGFloat = 0
    /// 范围 <= 0
    var minY: CGFloat = 0
    /// 范围  >=  0
    var maxX: CGFloat = 0
    /// 范围  >= 0
    var maxY: CGFloat = 0
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
      
        guard point.x <= maxX && point.x >= minX + self.frame.size.width && point.y <= maxY + self.frame.size.height && point.y >= minY  else {
            return super.hitTest(point, with: event)
        }
        return super.hitTest(CGPoint(x: 0, y: 0), with: event)
    }
}
