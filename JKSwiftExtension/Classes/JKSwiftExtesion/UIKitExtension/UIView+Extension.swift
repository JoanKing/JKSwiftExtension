//
//  UIView+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit
import Foundation

// MARK:- 屏幕的宽高
/*
iphone硬件型号
iPhoneX的分辨率：      2436 * 1125 || pt: 812 * 375
iPhoneXR的分辨率：     1792 * 828 || pt: 896 * 414
iPhoneXS的分辨率：     2436 * 1125 || pt: 812 * 375
iPhoneXS Max的分辨率： 2688 * 1242 || pt: 896 * 414
*/
let iPhone4 = (CGSize(width: 640, height: 960).equalTo(UIScreen.main.currentMode!.size))
let iPhone5 = (CGSize(width: 640, height: 1136).equalTo(UIScreen.main.currentMode!.size))
let iPhone6 = (CGSize(width: 750, height: 1334).equalTo(UIScreen.main.currentMode!.size))
let iPhone6P = (CGSize(width: 1242, height: 2208).equalTo(UIScreen.main.currentMode!.size))
let iPhoneX = UIScreen.main.bounds.height >= 812//(CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size))
//let iPhoneXR = (CGSize(width: 828, height: 1792).equalTo(UIScreen.main.currentMode!.size))
//let iPhoneXS = (CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size))
//let iPhoneXSMax = (CGSize(width: 1242, height: 2688).equalTo(UIScreen.main.currentMode!.size))

/*
iphone硬件型号
iPhoneX的分辨率：      2436 * 1125 || pt: 812 * 375
iPhoneXR的分辨率：     1792 * 828 || pt: 896 * 414
iPhoneXS的分辨率：     2436 * 1125 || pt: 812 * 375
iPhoneXS Max的分辨率： 2688 * 1242 || pt: 896 * 414
*/

/// 屏幕的宽
public let kScreenW: CGFloat = UIScreen.main.bounds.width
/// 屏幕的高
public let kScreenH: CGFloat = UIScreen.main.bounds.height
/// 获取statusBar的高度
public let kStatusBarFrameH: CGFloat = UIApplication.shared.statusBarFrame.height
/// 获取导航栏的高度
public var kNavFrameH: CGFloat { return iPhoneX ? 88 : 64 }
/// 获取tabbar的高度
public var kTabbarFrameH: CGFloat { return iPhoneX ? 83 : 49 }
/// 底部tabbar多出的部分
public var kTabbatBottom: CGFloat { return iPhoneX ? 34 : 0 }

// MARK:- 关于UIView的x，y,width,height的判断
public extension UIView {

    // MARK: x的位置
    /// x的位置
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }

    /// y的位置
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }

    /// height: 视图的高度
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width: 视图的宽度
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size: 视图的zize
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }

    /// centerX: 视图的X中间位置
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY: 视图Y的中间位置
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    /// 上端横坐标
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// 右端横坐标
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// 底端纵坐标
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set(newValue) {
            frame.origin.y = newValue - frame.size.height
        }
    }
    
    /// 右端横坐标
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set(newValue) {
            frame.origin.x = newValue - frame.size.width
        }
    }

    /// 裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width:cornerRadius, height:cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    /// 添加圆角
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角的大小
    func xcr_addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
