//
//  UIView+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit
import Foundation
import CoreFoundation
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

// MARK: Transform Extensions
extension JKPOP where Base : UIView {
    
    // MARK: 旋转x
    /// 旋转x
    /// - Parameter x: x值
    public func setRotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        self.base.layer.transform = transform
    }
    
    // MARK: 旋转y
    /// 旋转y
    /// - Parameter y: y 值
    public func setRotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        self.base.layer.transform = transform
    }
    
    // MARK:- 旋转z
    /// 旋转z
    /// - Parameter z: z 值
    public func setRotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.base.layer.transform = transform
    }
    
    
    /// 旋转xyz
    /// - Parameters:
    ///   - x: x description
    ///   - y: y description
    ///   - z: z description
    public func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.base.layer.transform = transform
    }
    
    /// 设置缩放
    /// - Parameters:
    ///   - x: x description
    ///   - y: y description
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.base.layer.transform = transform
    }
}

public extension JKPOP where Base : UIView {
    /// x的位置
    var x: CGFloat {
        get {
            return base.frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.x = newValue
            base.frame = tempFrame
        }
    }
    
    /// y的位置
    var y: CGFloat {
        get {
            return base.frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.y = newValue
            base.frame = tempFrame
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
            base.frame = tempFrame
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
            tempFrame.origin.y = newValue
            base.frame = tempFrame
        }
    }
    
    /// 右端横坐标
    var left: CGFloat {
        get {
            return base.frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.x = newValue
            base.frame = tempFrame
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

// MARK:- 关于UIView的 圆角和阴影的设置
public extension UIView {
    
    // MARK: 添加圆角
    /// 添加圆角
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角的大小
    func addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    // MARK: 给继承于view的类添加阴影
    /// 给继承于view的类添加阴影
    /// - Parameters:
    ///   - sColor: 阴影的颜色
    ///   - offset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
    ///   - opacity: 阴影的透明度
    ///   - radius: 阴影半径，默认3
    func xcr_setShadow(sColor:UIColor,offset:CGSize,opacity:Float,radius:CGFloat) {
        // 设置边框圆角
        layer.cornerRadius = radius
        // 设置阴影颜色
        layer.shadowColor = sColor.cgColor
        // 设置透明度
        layer.shadowOpacity = opacity
        // 设置阴影半径
        layer.shadowRadius = radius
        // 设置阴影偏移量
        layer.shadowOffset = offset
    }
    
    // MARK: 添加边框
    /// 添加边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    /// XCRKit
    func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    
    /// XCRKit
    func addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }
    
    /// XCRKit
    func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    
    /// XCRKit
    func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    
    /// XCRKit
    func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    /// XCRKit
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    
    /// XCRKit
    func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.jk.width, height: self.jk.width), cornerRadius: self.jk.width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    
    /// XCRKit
    func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.jk.width, height: self.jk.width), cornerRadius: self.jk.width / 2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
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

// MARK:- 添加水印
public extension UIView {
    
    // MARK:- 添加水印
    /// 添加水印
    /// - Parameters:
    ///   - markText: 水印文字
    ///   - textColor: 水印文字颜色
    ///   - font: 水印文字大小
    func addWater(markText: String, textColor: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 12)) {
        let waterMark: NSString = markText.toNSString
        let textSize: CGSize = waterMark.size(withAttributes: [NSAttributedString.Key.font : font])
        // 多少行
        let line: NSInteger = NSInteger(self.jk.height * 3.5 / 80)
        // 多少列：自己的宽度/(每个水印的宽度+间隔)
        let row: NSInteger = NSInteger(self.jk.width / markText.rectWidth(font: font, size: CGSize(width: self.jk.width, height: CGFloat(MAXFLOAT))))
        for i in 0..<line {
            for j in 0..<row {
                let textLayer: CATextLayer = CATextLayer()
                // textLayer.backgroundColor = UIColor.randomColor().cgColor
                //按当前屏幕分辨显示，否则会模糊
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = font
                textLayer.fontSize = font.pointSize
                textLayer.foregroundColor = textColor.cgColor
                textLayer.string = waterMark
                textLayer.frame = CGRect(x: CGFloat(j) * (textSize.width + 30), y: CGFloat(i) * 60, width: textSize.width, height: textSize.height)
                // 旋转文字
                textLayer.transform = CATransform3DMakeRotation(CGFloat(Double.pi*0.2), 0, 0, 3)
                self.layer.addSublayer(textLayer)
            }
        }
    }
}
