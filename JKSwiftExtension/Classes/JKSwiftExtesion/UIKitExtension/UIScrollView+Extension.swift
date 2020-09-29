//
//  UIScrollView+Extension.swift
//  JKLive
//
//  Created by IronMan on 2020/8/28.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

public extension UIScrollView {
    @objc func neverAdjustContentInset() {
        if #available(iOS 11.0, *), responds(to: #selector(setter: contentInsetAdjustmentBehavior)) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
}

public extension UIScrollView {
    @discardableResult
    func contentOffset(_ offset: CGPoint) -> Self {
        contentOffset = offset
        return self
    }
    @discardableResult
    func contentOffset(x: CGFloat, y: CGFloat) -> Self {
        contentOffset = CGPoint.init(x: x, y: y)
        return self
    }
    @discardableResult
    func contentSize(width: CGFloat, height: CGFloat) -> Self {
        contentSize = CGSize.init(width: width, height: height)
        return self
    }
    @discardableResult
    func contentSize(_ size: CGSize) -> Self {
        contentSize = size
        return self
    }
    @discardableResult
    func contentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        contentInset = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    @discardableResult
    func contentInset(_ inset: UIEdgeInsets) -> Self {
        contentInset = inset
        return self
    }
    @discardableResult
    func delegate(_ delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    @discardableResult
    func bounces(_ bounces: Bool) -> Self {
        self.bounces = bounces
        return self
    }
    @discardableResult
    func alwaysBounceVertical(_ bounces: Bool) -> Self {
        self.alwaysBounceVertical = bounces
        return self
    }
    @discardableResult
    func alwaysBounceHorizontal(_ bounces: Bool) -> Self {
        self.alwaysBounceHorizontal = bounces
        return self
    }
    @discardableResult
    func isPagingEnabled(_ enabled: Bool) -> Self {
        self.isPagingEnabled = enabled
        return self
    }
    @discardableResult
    func showsHorizontalScrollIndicator(_ enabled: Bool) -> Self {
        self.showsHorizontalScrollIndicator = enabled
        return self
    }
    @discardableResult
    func showsVerticalScrollIndicator(_ enabled: Bool) -> Self {
        self.showsVerticalScrollIndicator = enabled
        return self
    }
    @discardableResult
    func setContentOffset(_ horizontal: CGFloat, _ vertical: CGFloat, animated: Bool = true) -> Self {
        setContentOffset(CGPoint.init(x: horizontal, y: vertical), animated: animated)
        return self
    }
    @discardableResult
    func setContentOffsetX(_ horizontal: CGFloat, animated: Bool = true) -> Self {
        setContentOffset(CGPoint.init(x: horizontal, y: self.contentOffset.y), animated: animated)
        return self
    }
    @discardableResult
    func setContentOffsetY( _ vertical: CGFloat, animated: Bool = true) -> Self {
        setContentOffset(CGPoint.init(x: self.contentOffset.x, y: vertical), animated: animated)
        return self
    }

}

