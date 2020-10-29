//
//  UIView+Features.swift
//  JKLive
//
//  Created by IronMan on 2020/8/28.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    @discardableResult
    func corner(_ cornerRadius: Float) -> Self {
        layer.cornerRadius = CGFloat(cornerRadius)
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func contentMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func backgroundColor(_ hex: String) -> Self {
        backgroundColor = UIColor.hexStringColor(hexString: hex)
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func addTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
    
    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }
    
}

