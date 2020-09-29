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
let isIPhone4 = (CGSize(width: 640, height: 960).equalTo(UIScreen.main.currentMode!.size))
let isIPhone5 = (CGSize(width: 640, height: 1136).equalTo(UIScreen.main.currentMode!.size))
let isIPhone6 = (CGSize(width: 750, height: 1334).equalTo(UIScreen.main.currentMode!.size))
let isIPhone6P = (CGSize(width: 1242, height: 2208).equalTo(UIScreen.main.currentMode!.size))
let isIPhoneX = UIScreen.main.bounds.height >= 812//(CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size))
let isIPhoneXR = (CGSize(width: 828, height: 1792).equalTo(UIScreen.main.currentMode!.size))
let isIPhoneXS = (CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size))
let isIiPhoneXSMax = (CGSize(width: 1242, height: 2688).equalTo(UIScreen.main.currentMode!.size))

/// 屏幕的宽
public let kScreenW: CGFloat = UIScreen.main.bounds.width
/// 屏幕的高
public let kScreenH: CGFloat = UIScreen.main.bounds.height
/// 获取statusBar的高度
public let kStatusBarFrameH: CGFloat = UIApplication.shared.statusBarFrame.height
/// 获取导航栏的高度
public var kNavFrameH: CGFloat { return isIPhoneX ? 88 : 64 }
/// 获取tabbar的高度
public var kTabbarFrameH: CGFloat { return isIPhoneX ? 83 : 49 }
/// 底部tabbar多出的部分
public var kTabbatBottom: CGFloat { return isIPhoneX ? 34 : 0 }

public let kPixel = 1.0 / UIScreen.main.scale

// MARK: 设备型号
/// 设备型号
/// - Returns: 设备型号信息
public func deviceModel() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let size = Int(_SYS_NAMELEN)
    let deviceModelName = withUnsafeMutablePointer(to: &systemInfo.machine) { p in
        p.withMemoryRebound(to: CChar.self, capacity: size, { p2 in
            return String(cString: p2)
        })
    }
    return deviceModelName
}

// MARK: 是不是 iPhone X
/// 是不是 iPhone X
/// - Returns: bool
public func isIphoneX() -> Bool {
    return isIphone() && kScreenH == 812
}

// MARK: 是不是 iPhone XS
/// 是不是 iPhone XS
/// - Returns: description
public func isXs() -> Bool {
    return isIphone() && kScreenH == 812
}

// MARK: 是不是 iPhone XR
/// 是不是 iPhone XR
/// - Returns: description
public func isXR() -> Bool {
    return isIphone() && kScreenH == 896 && kScreenW == 414
}
/// iPhone XsMax

// MARK: 是不是 iPhone XsMax
/// 是不是 iPhone XsMax
/// - Returns: description
public func isXsMax() -> Bool {
    return isIphone() && kScreenH == 896 && kScreenW == 414
}

// MARK: 是不是 iPhone
/// 判断是不是 iPhone
/// - Returns: bool
public func isIphone() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
}

// MARK: 判断是否是 pad
/// 判断是否是 pad
/// - Returns: bool
public func isPadDevice() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == .pad
}

// MARK: 判断是不是 4 4s
/// 4 4s
/// - Returns: description
public func is4OrLess() -> Bool {
    return isIphone() && kScreenH < 568
}

// MARK: 判断是不是 5 5c 5s
/// 判断是不是 5 5c 5s
/// - Returns: description
public func is5() -> Bool {
    return isIphone() && kScreenH == 568
}

// MARK: 判断是不是 6 6s 7 8
/// 判断是不是 6 6s 7 8
/// - Returns: description
public func is678() -> Bool {
    return isIphone() && kScreenH == 667
}

// MARK: 判断是不是 6p 7p 8p
/// 判断是不是 6p 7p 8p
/// - Returns: description
public func is678P() -> Bool {
    return isIphone() && kScreenH == 736
}

extension UIView: JKPOPCompatible {}

public extension JKPOP where Base : UIView {
    /// x的位置
    var x: CGFloat {
        get {
            return base.frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.x    = newValue
            base.frame                 = tempFrame
        }
    }
    
    /// y的位置
    var y: CGFloat {
        get {
            return base.frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.y    = newValue
            base.frame                 = tempFrame
        }
    }
    
    /// height: 视图的高度
    var height: CGFloat {
        get {
            return base.frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size.height = newValue
            base.frame                 = tempFrame
        }
    }
    
    /// width: 视图的宽度
    var width: CGFloat {
        get {
            return base.frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size.width = newValue
            base.frame = tempFrame
        }
    }
    
    /// size: 视图的zize
    var size: CGSize {
        get {
            return base.frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size = newValue
            base.frame = tempFrame
        }
    }
    
    /// centerX: 视图的X中间位置
    var centerX: CGFloat {
        get {
            return base.center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = base.center
            tempCenter.x = newValue
            base.center = tempCenter
        }
    }
    
    /// centerY: 视图Y的中间位置
    var centerY: CGFloat {
        get {
            return base.center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = base.center
            tempCenter.y = newValue
            base.center = tempCenter;
        }
    }
    
    /// 上端横坐标
    var top: CGFloat {
        get {
            return base.frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.y    = newValue
            base.frame                 = tempFrame
        }
    }
    
    /// 右端横坐标
    var left: CGFloat {
        get {
            return base.frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.x    = newValue
            base.frame                 = tempFrame
        }
    }
    
    /// 底端纵坐标
    var bottom: CGFloat {
        get {
            return base.frame.origin.y + base.frame.size.height
        }
        set(newValue) {
            base.frame.origin.y = newValue - base.frame.size.height
        }
    }
    
    /// 右端横坐标
    var right: CGFloat {
        get {
            return base.frame.origin.x + base.frame.size.width
        }
        set(newValue) {
            base.frame.origin.x = newValue - base.frame.size.width
        }
    }
}
// MARK:- 关于UIView的x，y,width,height的判断
public extension UIView {
    
    
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

// MARK:- 获取当前view的viewcontroller
public extension UIView {
    /// 获取当前view的viewcontroller
    var currentVC: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
