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
import WebKit

public enum JKDashLineDirection: Int {
    case vertical = 0
    case horizontal = 1
}

extension UIView: JKPOPCompatible {}
// MARK: - 一、机型的判断
// MARK: 1.1、设备型号
/// 设备型号
/// - Returns: 设备型号信息
public func jk_deviceModel() -> String {
    return UIDevice.jk.deviceIdentifier
}

// MARK: 1.2、是不是 iPhone X
/// 是不是 iPhone X
/// - Returns: bool
public func jk_isIphoneX() -> Bool {
    guard jk_isIphone() else {
        return false
    }
    return UIDevice.jk.screenType() == .IPHONE_X
}

// MARK: 1.3、是不是 iPhone XS
/// 是不是 iPhone XS
/// - Returns: description
public func jk_isXs() -> Bool {
    guard jk_isIphone() else {
        return false
    }
    return UIDevice.jk.screenType() == .IPHONE_XS
}

// MARK: 1.4、是不是 iPhone XR
/// 是不是 iPhone XR
/// - Returns: description
public func jk_isXR() -> Bool {
    guard jk_isIphone() else {
        return false
    }
    return UIDevice.jk.screenType() == .IPHONE_XR
}

// MARK: 1.5、是不是 iPhone XsMax
/// 是不是 iPhone XsMax
/// - Returns: description
public func jk_isXsMax() -> Bool {
    guard jk_isIphone() else {
        return false
    }
    return UIDevice.jk.screenType() == .IPHONE_XS_Max
}

// MARK: 1.6、是不是 iPhone
/// 判断是不是 iPhone
/// - Returns: bool
public func jk_isIphone() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

// MARK: 1.7、判断是否是 pad
/// 判断是否是 pad
/// - Returns: bool
public func jk_isPadDevice() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

// MARK: 1.8、判断是不是 4or4s
/// 判断是不是 4or4s
/// - Returns: description
public func jk_is4OrLess() -> Bool {
    guard jk_isIphone() else {
        return false
    }
    return UIDevice.jk.screenType() == .IPHONE_4
}

// MARK: 1.9、判断是不是 5 5c 5s
/// 判断是不是 5 5c 5s
/// - Returns: description
public func jk_is5() -> Bool {
    guard jk_isIphone() else {
        return false
    }
    return UIDevice.jk.screenType() == .IPHONE_5
}

// MARK: 1.10、判断是不是 6 6s 7 8
/// 判断是不是 6 6s 7 8
/// - Returns: description
public func jk_is678() -> Bool {
    guard jk_isIphone() else {
        return false
    }
    return UIDevice.jk.screenType() == .IPHONE_678
}

// MARK: 1.11、判断是不是 6p 7p 8p
/// 判断是不是 6p 7p 8p
/// - Returns: description
public func jk_is678P() -> Bool {
    guard jk_isIphone() else {
        return false
    }
    return UIDevice.jk.screenType() == .IPHONE_678PLUS
}

// MARK: 1.12、当前设备是不是模拟器
/// 当前设备是不是模拟器
/// - Returns: result
public func jk_isSimulator() -> Bool {
    return UIDevice.jk.isSimulator()
}

// MARK: 1.13、是否是缺口屏幕(刘海屏)或者灵动岛的屏幕
// 是否是缺口屏幕(刘海屏)或者灵动岛的屏幕
public var jk_isIPhoneNotch: Bool {
    if #available(iOS 11.0, *) {
        if let window = UIApplication.jk.keyWindow {
            return window.safeAreaInsets.bottom > 0
        } else {
            return false
        }
    } else {
        return UIApplication.shared.statusBarFrame.height > 20
    }
}

// MARK: - 二、屏幕尺寸常用的常量
// MARK: 2.1、屏幕的宽
/// 屏幕的宽
public var jk_kScreenW: CGFloat { return UIScreen.main.bounds.width }

// MARK: 2.2、屏幕的高
/// 屏幕的高
public var jk_kScreenH: CGFloat { return UIScreen.main.bounds.height }

// MARK: 2.3、获取statusBar的高度
/// 获取statusBar的高度
public var jk_kStatusBarFrameH: CGFloat {
    if #available(iOS 13.0, *) {
        let window: UIWindow? = UIApplication.shared.windows.first
        let statusBarHeight = (window?.windowScene?.statusBarManager?.statusBarFrame.height) ?? 0
        return statusBarHeight
    } else {
        // 防止界面没有出来获取为0的情况
        return UIApplication.shared.statusBarFrame.height > 0 ? UIApplication.shared.statusBarFrame.height : 44
    }
}

// MARK: 2.4、获取导航栏的高度
/// 获取导航栏的高度
public var jk_kNavFrameH: CGFloat { return 44 + jk_kStatusBarFrameH }
    
// MARK: 2.5、屏幕底部Tabbar高度
/// 屏幕底部Tabbar高度
public var jk_kTabbarFrameH: CGFloat { return jk_isIPhoneNotch ? 83 : 49 }

// MARK: 2.6、屏幕底部刘海高度
/// 屏幕底部刘海高度
public var jk_kTabbarBottom: CGFloat { return jk_isIPhoneNotch ? 34 : 0 }

// MARK: 2.7、屏幕比例
/// 屏幕比例
public let jk_kPixel = 1.0 / UIScreen.main.scale

// MARK: 2.8、身份证宽高比
/// 身份证宽高比
public let jk_kRatioIDCard: CGFloat = 0.63

// MARK: 2.9、375尺寸适配比例
/// 375尺寸适配比例
public var jk_scaleIphone: CGFloat { return jk_kScreenW / CGFloat(375.0) }

// MARK: - 屏幕16:9比例系数下的宽高
// 宽
public var jk_kScreenW16_9: CGFloat { return jk_kScreenW * 9.0 / 16.0 }
// 高
public var jk_kScreenH16_9: CGFloat { return jk_kScreenH * 16.0 / 9.0 }

// MARK: - 三、UIView 有关 Frame 的扩展
public extension JKPOP where Base: UIView {
    // MARK: 3.1、x 的位置
    /// x 的位置
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
    // MARK: 3.2、y 的位置
    /// y 的位置
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
    
    // MARK: 3.3、height: 视图的高度
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
    
    // MARK: 3.4、width: 视图的宽度
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
    
    // MARK: 3.5、size: 视图的zize
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
    
    // MARK: 3.6、centerX: 视图的X中间位置
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
    
    // MARK: 3.7、centerY: 视图的Y中间位置
    /// centerY: 视图Y的中间位置
    var centerY: CGFloat {
        get {
            return base.center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = base.center
            tempCenter.y = newValue
            base.center = tempCenter
        }
    }
    
    // MARK: 3.8、center: 视图的中间位置
    /// centerY: 视图Y的中间位置
    var center: CGPoint {
        get {
            return base.center
        }
        set(newValue) {
            var tempCenter: CGPoint = base.center
            tempCenter = newValue
            base.center = tempCenter
        }
    }
    
    // MARK: 3.9、top 上端横坐标(y)
    /// top 上端横坐标(y)
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
    
    // MARK: 3.10、left 左端横坐标(x)
    /// left 左端横坐标(x)
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
    
    // MARK: 3.11、bottom 底端纵坐标 (y + height)
    /// bottom 底端纵坐标 (y + height)
    var bottom: CGFloat {
        get {
            return base.frame.origin.y + base.frame.size.height
        }
        set(newValue) {
            base.frame.origin.y = newValue - base.frame.size.height
        }
    }
    
    // MARK: 3.12、right 底端纵坐标 (x + width)
    /// right 底端纵坐标 (x + width)
    var right: CGFloat {
        get {
            return base.frame.origin.x + base.frame.size.width
        }
        set(newValue) {
            base.frame.origin.x = newValue - base.frame.size.width
        }
    }
    
    // MARK: 3.13、origin 点
    /// origin 点
    var origin: CGPoint {
        get {
            return base.frame.origin
        }
        set(newValue) {
            var tempOrigin: CGPoint = base.frame.origin
            tempOrigin = newValue
            base.frame.origin = tempOrigin
        }
    }
}

// MARK: - 四、继承于 UIView 视图的 平面、3D 旋转 以及 缩放、位移
/**
 从m11到m44定义的含义如下：
 m11：x轴方向进行缩放
 m12：和m21一起决定z轴的旋转
 m13:和m31一起决定y轴的旋转
 m14:
 m21:和m12一起决定z轴的旋转
 m22:y轴方向进行缩放
 m23:和m32一起决定x轴的旋转
 m24:
 m31:和m13一起决定y轴的旋转
 m32:和m23一起决定x轴的旋转
 m33:z轴方向进行缩放
 m34:透视效果m34= -1/D，D越小，透视效果越明显，必须在有旋转效果的前提下，才会看到透视效果
 m41:x轴方向进行平移
 m42:y轴方向进行平移
 m43:z轴方向进行平移
 m44:初始为1
 */
extension JKPOP where Base: UIView {
    
    // MARK: 4.1、平面旋转
    /// 平面旋转
    /// - Parameters:
    ///   - angle: 旋转多少度
    ///   - isInverted: 顺时针还是逆时针，默认是顺时针
    public func setRotation(_ angle: CGFloat, isInverted: Bool = false) {
        let radians = Double(angle) / 180 * Double.pi
        self.base.transform = isInverted ? CGAffineTransform(rotationAngle: CGFloat(radians)).inverted() : CGAffineTransform(rotationAngle: CGFloat(radians))
    }
    
    // MARK: 4.2、沿X轴方向旋转多少度(3D旋转)
    /// 沿X轴方向旋转多少度(3D旋转)
    /// - Parameter angle: 旋转角度，angle参数是旋转的角度，为弧度制 0-2π
    public func set3DRotationX(_ angle: CGFloat) {
        // 初始化3D变换,获取默认值
        //var transform = CATransform3DIdentity
        // 透视 1/ -D，D越小，透视效果越明显，必须在有旋转效果的前提下，才会看到透视效果
        // 当我们有垂直于z轴的旋转分量时，设置m34的值可以增加透视效果，也可以理解为景深效果
        // transform.m34 = 1.0 / -1000.0
        // 空间旋转，x，y，z决定了旋转围绕的中轴，取值为 (-1,1) 之间
        //transform = CATransform3DRotate(transform, angle, 1.0, 0.0, 0.0)
        //self.base.layer.transform = transform
        self.base.layer.transform = CATransform3DMakeRotation(angle, 1.0, 0.0, 0.0)
    }
    
    // MARK: 4.3、沿 Y 轴方向旋转多少度(3D旋转)
    /// 沿 Y 轴方向旋转多少度
    /// - Parameter angle: 旋转角度，angle参数是旋转的角度，为弧度制 0-2π
    public func set3DRotationY(_ angle: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0)
        self.base.layer.transform = transform
    }
    
    // MARK: 4.4、沿 Z 轴方向旋转多少度(3D旋转)
    /// 沿 Z 轴方向旋转多少度
    /// - Parameter angle: 旋转角度，angle参数是旋转的角度，为弧度制 0-2π
    public func set3DRotationZ(_ angle: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, angle, 0.0, 0.0, 1.0)
        self.base.layer.transform = transform
    }
    
    // MARK: 4.5、沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)
    /// 沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)
    /// - Parameters:
    ///   - xAngle: x 轴的角度，旋转的角度，为弧度制 0-2π
    ///   - yAngle: y 轴的角度，旋转的角度，为弧度制 0-2π
    ///   - zAngle: z 轴的角度，旋转的角度，为弧度制 0-2π
    public func setRotation(xAngle: CGFloat, yAngle: CGFloat, zAngle: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, xAngle, 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, yAngle, 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, zAngle, 0.0, 0.0, 1.0)
        self.base.layer.transform = transform
    }
    
    // MARK: 4.6、设置 x,y 缩放
    /// 设置 x,y 缩放
    /// - Parameters:
    ///   - x: x 放大的倍数
    ///   - y: y 放大的倍数
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.base.layer.transform = transform
    }
    
    // MARK: 4.7、水平或垂直翻转
    /// 水平或垂直翻转
    public func flip(isHorizontal: Bool) {
        if isHorizontal {
            // 水平
            self.base.transform = self.base.transform.scaledBy(x: -1.0, y: 1.0)
        } else {
            // 垂直
            self.base.transform = self.base.transform.scaledBy(x: 1.0, y: -1.0)
        }
    }
    
    // MARK: 4.8、移动到指定中心点位置
    /// 移动到指定中心点位置
    public func moveToPoint(point: CGPoint) {
        var center = self.base.center
        center.x = point.x
        center.y = point.y
        self.base.center = center
    }
}

// MARK: - 五、关于UIView的 圆角、阴影、边框、虚线 的设置
public extension JKPOP where Base: UIView {
    
    // MARK: 5.1、添加圆角
    /// 添加圆角
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角的大小
    func addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.base.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.base.bounds
        maskLayer.path = maskPath.cgPath
        self.base.layer.mask = maskLayer
    }
    
    // MARK: 5.2、添加圆角和边框
    /// 添加圆角和边框
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角的大小
    ///   - borderWidth: 边框的宽度
    ///   - borderColor: 边框的颜色
    func addCorner(conrners: UIRectCorner , radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        let maskPath = UIBezierPath(roundedRect: self.base.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.base.bounds
        maskLayer.path = maskPath.cgPath
        self.base.layer.mask = maskLayer
        
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame =  self.base.bounds
        self.base.layer.addSublayer(borderLayer)
    }
    
    // MARK: 5.3、给继承于view的类添加阴影
    /// 给继承于view的类添加阴影
    /// - Parameters:
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移])
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    func addShadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        // 设置阴影颜色
        base.layer.shadowColor = shadowColor.cgColor
        // 设置透明度
        base.layer.shadowOpacity = shadowOpacity
        // 设置阴影半径
        base.layer.shadowRadius = shadowRadius
        // 设置阴影偏移量
        base.layer.shadowOffset = shadowOffset
    }
    
    // MARK: 5.4、添加阴影和圆角并存
    /// 添加阴影和圆角并存
    ///
    /// - Parameter superview: 父视图
    /// - Parameter conrners: 具体哪个圆角
    /// - Parameter radius: 圆角大小
    /// - Parameter shadowColor: 阴影的颜色
    /// - Parameter shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移])
    /// - Parameter shadowOpacity: 阴影的透明度
    /// - Parameter shadowRadius: 阴影半径，默认 3
    ///
    /// - Note1: 如果在异步布局(如：SnapKit布局)中使用，要在布局后先调用 layoutIfNeeded，再使用该方法
    /// - Note2: 如果在添加阴影的视图被移除，底部插入的父视图的layer是不会被移除的⚠️
    func addCornerAndShadow(superview: UIView, conrners: UIRectCorner , radius: CGFloat = 3, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        
        let maskPath = UIBezierPath(roundedRect: self.base.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.base.bounds
        maskLayer.path = maskPath.cgPath
        self.base.layer.mask = maskLayer
        
        let subLayer = CALayer()
        let fixframe = self.base.frame
        subLayer.frame = fixframe
        subLayer.cornerRadius = radius
        subLayer.backgroundColor = shadowColor.cgColor
        subLayer.masksToBounds = false
        // shadowColor阴影颜色
        subLayer.shadowColor = shadowColor.cgColor
        // shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        subLayer.shadowOffset = shadowOffset
        // 阴影透明度，默认0
        subLayer.shadowOpacity = shadowOpacity
        // 阴影半径，默认3
        subLayer.shadowRadius = shadowRadius
        subLayer.shadowPath = maskPath.cgPath
        superview.layer.insertSublayer(subLayer, below: self.base.layer)
    }
    
    // MARK: 5.5、通过贝塞尔曲线View添加阴影和圆角
    /// 通过贝塞尔曲线View添加阴影和圆角
    ///
    /// - Parameter conrners: 具体哪个圆角(暂时只支持：allCorners)
    /// - Parameter radius: 圆角大小
    /// - Parameter shadowColor: 阴影的颜色
    /// - Parameter shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移])
    /// - Parameter shadowOpacity: 阴影的透明度
    /// - Parameter shadowRadius: 阴影半径，默认 3
    ///
    /// - Note: 提示：如果在异步布局(如：SnapKit布局)中使用，要在布局后先调用 layoutIfNeeded，再使用该方法或者在override func layoutSublayers(of layer: CALayer) {} 里面调用，也要使用 layoutIfNeeded
    func addViewCornerAndShadow(conrners: UIRectCorner , radius: CGFloat = 3, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        // 切圆角
        base.layer.shadowColor = shadowColor.cgColor
        base.layer.shadowOffset = shadowOffset
        base.layer.shadowOpacity = shadowOpacity
        base.layer.shadowRadius = shadowRadius
        base.layer.cornerRadius = radius
       
        // 路径阴影
        let path = UIBezierPath.init(roundedRect: base.bounds, byRoundingCorners: conrners, cornerRadii: CGSize.init(width: radius, height: radius))
        base.layer.shadowPath = path.cgPath
    }
    
    // MARK: 5.6、添加边框
    /// 添加边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    func addBorder(borderWidth: CGFloat, borderColor: UIColor) {
        base.layer.borderWidth = borderWidth
        base.layer.borderColor = borderColor.cgColor
        base.layer.masksToBounds = true
    }
    
    // MARK: 5.7、添加顶部的 边框
    /// 添加顶部的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderTop(borderWidth: CGFloat, borderColor: UIColor) {
        base.addBorderUtility(x: 0, y: 0, width: base.frame.width, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.8、添加顶部的 内边框
    /// 添加顶部的 内边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - padding: 边框距离边上的距离
    func addBorderTopWithPadding(borderWidth: CGFloat, borderColor: UIColor, padding: CGFloat) {
        base.addBorderUtility(x: padding, y: 0, width: base.frame.width - padding * 2, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.9、添加底部的 边框
    /// 添加底部的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderBottom(borderWidth: CGFloat, borderColor: UIColor) {
        base.addBorderUtility(x: 0, y: base.frame.height - borderWidth, width: base.frame.width, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.10、添加左边的 边框
    /// 添加左边的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderLeft(borderWidth: CGFloat, borderColor: UIColor) {
        base.addBorderUtility(x: 0, y: 0, width: borderWidth, height: base.frame.height, color: borderColor)
    }
    
    // MARK: 5.11、添加右边的 边框
    /// 添加右边的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderRight(borderWidth: CGFloat, borderColor: UIColor) {
        base.addBorderUtility(x: base.frame.width - borderWidth, y: 0, width: borderWidth, height: base.frame.height, color: borderColor)
    }
    
    // MARK: 5.12、画圆环
    /// 画圆环
    /// - Parameters:
    ///   - fillColor: 内环的颜色
    ///   - strokeColor: 外环的颜色
    ///   - strokeWidth: 外环的宽度
    func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let ciecleRadius = self.base.jk.width > self.base.jk.height ? self.base.jk.height : self.base.jk.width
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: ciecleRadius, height: ciecleRadius), cornerRadius: ciecleRadius / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.base.layer.addSublayer(shapeLayer)
    }
    
    // MARK: 5.13、绘制虚线
    /// 绘制虚线
    /// - Parameters:
    ///   - strokeColor: 虚线颜色
    ///   - lineLength: 每段虚线的长度
    ///   - lineSpacing: 每段虚线的间隔
    ///   - direction: 虚线的方向
    func drawDashLine(strokeColor: UIColor,
                       lineLength: CGFloat = 4,
                      lineSpacing: CGFloat = 4,
                        direction: JKDashLineDirection = .horizontal) {
        // 线粗
        let lineWidth = direction == .horizontal ? self.base.jk.height : self.base.jk.width
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.base.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        // 每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        // 起点
        let path = CGMutablePath()
        if direction == .horizontal {
            path.move(to: CGPoint(x: 0, y: lineWidth / 2))
            // 终点
            // 横向 y = lineWidth / 2
            path.addLine(to: CGPoint(x: self.base.jk.width, y: lineWidth / 2))
        } else {
            path.move(to: CGPoint(x: lineWidth / 2, y: 0))
            // 终点
            // 纵向 Y = view 的height
            path.addLine(to: CGPoint(x: lineWidth / 2, y: self.base.jk.height))
        }
        shapeLayer.path = path
        self.base.layer.addSublayer(shapeLayer)
    }
    
    // MARK: 5.14、添加内阴影
    /// 添加内阴影
    /// - Parameters:
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移])
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    ///   - insetBySize: 内阴影偏移大小
    func addInnerShadowLayer(shadowColor: UIColor, shadowOffset: CGSize = CGSize(width: 0, height: 0), shadowOpacity: Float = 0.5, shadowRadius: CGFloat = 3, insetBySize: CGSize = CGSize(width: -42, height: -42)) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = self.base.bounds
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.fillRule = .evenOdd
        let path = CGMutablePath()
        path.addRect(self.base.bounds.insetBy(dx: insetBySize.width, dy: insetBySize.height))
      
        // let someInnerPath = UIBezierPath(roundedRect: self.base.bounds, cornerRadius: innerPathRadius).cgPath
        let someInnerPath = UIBezierPath(roundedRect: self.base.bounds, cornerRadius: shadowRadius).cgPath
        path.addPath(someInnerPath)
        path.closeSubpath()
        shadowLayer.path = path
        let maskLayer = CAShapeLayer()
        maskLayer.path = someInnerPath
        shadowLayer.mask = maskLayer
        self.base.layer.addSublayer(shadowLayer)
    }
    
    // MARK: 5.15、毛玻璃效果
    /// 毛玻璃效果
    /// - Parameters:
    ///   - alpha: 可设置模糊的程度(0-1)，越大模糊程度越大
    ///   - size: 毛玻璃的size
    ///   - style: 模糊效果
    func effectViewWithAlpha(alpha: CGFloat = 1.0, size: CGSize? = nil, style: UIBlurEffect.Style = .light) {
        // 模糊视图的大小
        var visualEffectViewSize = CGSize(width: 0, height: 0)
        if let weakSize = size {
            visualEffectViewSize = weakSize
        } else {
            visualEffectViewSize = self.size
        }
        let visualEffectView = UIVisualEffectView.jk.visualEffectView(size: visualEffectViewSize, alpha: alpha, style: style, isAddVibrancy: false)
        self.base.addSubview(visualEffectView)
    }

    //MARK: 5.16、添加多个View子视图
    /// 添加多个View子视图
    /// - Parameter views: 子视图数组
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.base.addSubview(view)
        }
    }
}

// MARK: - 六、自定义链式编程
public extension UIView {
    // MARK: 6.1、设置 tag 值
    /// 设置 tag 值
    /// - Parameter tag: 值
    /// - Returns: 返回自身
    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    // MARK: 6.2、设置圆角
    /// 设置圆角
    /// - Parameter cornerRadius: 圆角
    /// - Returns: 返回自身
    @discardableResult
    func corner(_ cornerRadius: CGFloat) -> Self {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        return self
    }
    
    // MARK: 6.3、图片的模式
    /// 图片的模式
    /// - Parameter mode: 模式
    /// - Returns: 返回图片的模式
    @discardableResult
    func contentMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    // MARK: 6.4、设置背景色
    /// 设置背景色
    /// - Parameter color: 颜色
    /// - Returns: 返回自身
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    // MARK: 6.5、设置十六进制颜色
    /// 设置十六进制颜色
    /// - Parameter hex: 十六进制颜色
    /// - Returns: 返回自身
    @discardableResult
    func backgroundColor(_ hex: String) -> Self {
        backgroundColor = UIColor.hexStringColor(hexString: hex)
        return self
    }
    
    // MARK: 6.6、设置 frame
    /// 设置 frame
    /// - Parameter frame: frame
    /// - Returns: 返回自身
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    // MARK: 6.7、被添加到某个视图上
    /// 被添加到某个视图上
    /// - Parameter superView: 父视图
    /// - Returns: 返回自身
    @discardableResult
    func addTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
    
    // MARK: 6.8、设置是否支持触摸
    /// 设置是否支持触摸
    /// - Parameter isUserInteractionEnabled: 是否支持触摸
    /// - Returns: 返回自身
    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    // MARK: 6.9、设置是否隐藏
    /// 设置是否隐藏
    /// - Parameter isHidden: 是否隐藏
    /// - Returns: 返回自身
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    // MARK: 6.10、设置透明度
    /// 设置透明度
    /// - Parameter alpha: 透明度
    /// - Returns: 返回自身
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    // MARK: 6.11、设置tintColor
    /// 设置tintColor
    /// - Parameter tintColor: tintColor description
    /// - Returns: 返回自身
    @discardableResult
    func tintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }
}

// MARK: - 七、其他的方法
// 抖动方向枚举
public enum JKShakeDirection: Int {
    case horizontal  //水平抖动
    case vertical  //垂直抖动
}

public extension JKPOP where Base: UIView {
    
    // MARK: 7.1、获取当前view的viewcontroller
    /// 获取当前view的viewcontroller
    var currentVC: UIViewController? {
        /**
         实现原理
         通过消息响应者链找到 UIView 所在的 UIViewController。
         UIView 类继承于 UIResponder，通过 UIResponder 的next 方法来获取 UIViewController。
         如果 next 返回是空，则继续向上遍历 superview 并再次使用 next 方法获取。这样一直找下去，直到找到或抛出异常。
         */
        var parentResponder: UIResponder? = self.base
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    // MARK: 7.2、添加水印
    /// 添加水印
    /// - Parameters:
    ///   - markText: 水印文字
    ///   - textColor: 水印文字颜色
    ///   - font: 水印文字大小
    func addWater(markText: String, textColor: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 12)) {
        let waterMark: NSString = markText.jk.toNSString
        let textSize: CGSize = waterMark.size(withAttributes: [NSAttributedString.Key.font : font])
        // 多少行
        let line: NSInteger = NSInteger(self.base.jk.height * 3.5 / 80)
        // 多少列：自己的宽度/(每个水印的宽度+间隔)
        let row: NSInteger = NSInteger(self.base.jk.width / markText.jk.rectWidth(font: font, size: CGSize(width: self.base.jk.width, height: CGFloat(MAXFLOAT))))
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
                self.base.layer.addSublayer(textLayer)
            }
        }
    }
    
    // MARK: 7.3、将 View 转换成图片
    /// 将 View 转换成图片
    /// - Returns: 图片
    func toImage() -> UIImage? {
        
        /**
         UIGraphicsBeginImageContext：在截图或者处理图片是会出现模糊的情况，可以使用以下函数代替         UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)
         size：缩放后的 size
         opaque：透明度，不透明设为true
         scale： 缩放因子，设0时系统自动设置缩放比例图片清晰；设1.0时模糊
         */
        // 防止size：(0, 0)崩溃
        var drawSize = self.base.frame.size
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        UIGraphicsBeginImageContextWithOptions(drawSize, false, UIScreen.main.scale)
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        self.base.layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
        // 下面的方法会导致子视图自动绘制
        /*
        return UIGraphicsImageRenderer(size: self.base.frame.size).image { context in
            self.base.layer.render(in: context.cgContext)
        }
         */
    }
    
    // MARK: 7.4、添加点击事件
    /// 添加点击事件
    /// - Parameters:
    ///   - target: 监听对象
    ///   - selector: 方法
    func addTapGestureRecognizerAction(_ target : Any ,_ selector : Selector) {
        self.base.isUserInteractionEnabled = true
        self.base.addGestureRecognizer(UITapGestureRecognizer(target: target, action: selector))
    }
    
    // MARK: 7.5、键盘收起来
    /// 键盘收起来
    func keyboardEndEditing() {
        self.base.endEditing(true)
    }
    
    // MARK: 7.6、视图抖动
    /// 视图抖动
    /// - Parameters:
    ///   - direction: 抖动方向（默认是水平方向）
    ///   - times: 抖动次数（默认5次）
    ///   - interval: 每次抖动时间（默认0.1秒）
    ///   - delta: 抖动偏移量（默认2）
    ///   - completion: 抖动动画结束后的回调
    func shake(direction: JKShakeDirection = .horizontal, times: Int = 3, interval: TimeInterval = 0.1, delta: CGFloat = 2, completion: (() -> Void)? = nil) {
        // 播放动画
        UIView.animate(withDuration: interval, animations: {
            switch direction {
            case .horizontal:
                self.base.layer.setAffineTransform(CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.base.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            // 如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.base.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            } else {
                // 如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
                self.shake(direction: direction, times: times - 1,  interval: interval, delta: delta * -1, completion:completion)
            }
        }
    }
    
    // MARK: 7.7、是否包含WKWebView
    /// 是否包含WKWebView
    /// - Returns: 结果
    func isContainsWKWebView() -> Bool {
        if base.isKind(of: WKWebView.self) {
            return true
        }
        for subView in base.subviews {
            if (subView.jk.isContainsWKWebView()) {
                return true
            }
        }
        return false
    }
}

// MARK: - private method
extension UIView {
    /// 边框的私有内容
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}

// MARK: 八、视图调试
public extension JKPOP where Base: UIView {
    
    // MARK: 8.1、图层调试(兼容OC)
    /// 图层调试(兼容OC)
    /// - Parameters:
    ///   - borderWidth: 视图的边框宽度
    ///   - borderColor: 视图的边框颜色
    ///   - backgroundColor: 视图的背景色
    func getViewLayer(borderWidth: CGFloat = 0.5, borderColor: UIColor = .randomColor, backgroundColor: UIColor = .randomColor) {
        #if DEBUG
        let subviews = self.base.subviews
        if subviews.count == 0 {
            return
        }
        for subview in subviews {
            subview.layer.borderWidth = borderWidth
            subview.layer.borderColor = borderColor.cgColor
            subview.backgroundColor = backgroundColor
            subview.jk.getViewLayer(borderWidth: borderWidth, borderColor: borderColor, backgroundColor: backgroundColor)
        }
        #endif
    }
    
    // MARK: 8.2、UIResponder.Type寻找某个类型子视图
    /// 寻找某个类型子视图
    /// - Parameters:
    ///   - type: 子视图类型
    ///   - resursion: 是否递归查找
    /// - Returns: 返回找到的子视图
    @discardableResult
    func findSubview(type: UIResponder.Type, resursion: Bool)-> UIView? {
        for e in self.base.subviews.enumerated() {
            if e.element.isKind(of: type) {
                return e.element
            }
        }
        // 是否递归查找
        guard resursion == true else {
            return nil
        }
        for e in self.base.subviews.enumerated() {
            let tmpView = e.element.jk.findSubview(type: type, resursion: resursion)
            if tmpView != nil {
                return tmpView
            }
        }
        return nil
    }
    
    //MARK: 8.3、T.Type寻找某个类型子视图
    /// 寻找某个类型子视图
    /// - Parameter childViewType: 子视图类型
    /// - Returns: 返回这个类型对象
    func findSubView<T>(childViewType: T.Type) -> T? {
        if let subView = self.base as? T {
            return subView
        }
        for subview in self.base.subviews {
            if let view = subview.jk.findSubView(childViewType: childViewType) {
                return view
            }
        }
        return nil
    }
    
    //MARK: 8.4、根据类名寻找某类型子视图
    /// 寻找某个类型子视图
    /// - Parameter childViewType: 子视图类型
    /// - Returns: 返回这个类型对象
    func findSubView(childViewClassName: String) -> UIView? {
        // print("className：\(self.base.className)")
        if self.base.className == childViewClassName {
            return self.base
        }
        for subview in self.base.subviews {
            if let view = subview.jk.findSubView(childViewClassName: childViewClassName) {
                return view
            }
        }
        return nil
    }
    
    // MARK: 8.5、移除所有的子视图
    /// 移除所有的子视图
    func removeAllSubViews() {
        for subView in self.base.subviews {
            subView.removeFromSuperview()
        }
    }
    
    // MARK: 8.6、移除layer
    /// 移除layer
    /// - Returns: 返回自身
    @discardableResult
    func removeLayer() -> JKPOP {
        base.layer.mask = nil
        base.layer.borderWidth = 0
        return self
    }
}

// MARK: 九、手势的扩展
public extension JKPOP where Base: UIView {
    
    // MARK: 9.1、通用响应添加方法
    /// 通用响应添加方法
    /// - Parameter actionClosure: 时间回调
    func addActionClosure(_ actionClosure: @escaping ViewClosure) {
        if let sender = self.base as? UIButton {
            sender.jk.setHandleClick(controlEvents: .touchUpInside) { (control) in
                guard let weakControl = control else {
                    return
                }
                actionClosure(nil, weakControl, weakControl.tag)
            }
        } else if let sender = self.base as? UIControl {
            sender.jk.addActionHandler({ (control) in
                actionClosure(nil, control, control.tag)
            }, for: .valueChanged)
        } else {
            _ = self.base.jk.addGestureTap { (reco) in
                actionClosure((reco as! UITapGestureRecognizer), reco.view!, reco.view!.tag)
            }
        }
    }

    // MARK: 9.2、手势 - 单击
    /// 手势 - 单击
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGestureTap(_ action: @escaping RecognizerClosure) -> UITapGestureRecognizer {
        let obj = UITapGestureRecognizer(target: nil, action: nil)
        // 轻点次数
        obj.numberOfTapsRequired = 1
        // 手指个数
        obj.numberOfTouchesRequired = 1
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }

    // MARK: 9.3、手势 - 长按
    /// 手势 - 长按
    /// - Parameters:
    ///   - action: 事件
    ///   - minimumPressDuration: 长按的时间
    /// - Returns: 手势
    @discardableResult
    func addGestureLongPress(_ action: @escaping RecognizerClosure, for minimumPressDuration: TimeInterval) -> UILongPressGestureRecognizer {
        let obj = UILongPressGestureRecognizer(target: nil, action: nil)
        obj.minimumPressDuration = minimumPressDuration
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    // MARK: 9.4、手势 - 拖拽
    /// 手势 - 拖拽
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGesturePan(_ action: @escaping RecognizerClosure) -> UIPanGestureRecognizer {
        let obj = UIPanGestureRecognizer(target: nil, action: nil)
        // 最大最小的手势触摸次数
        obj.minimumNumberOfTouches = 1
        obj.maximumNumberOfTouches = 3
        addCommonGestureRecognizer(obj)
          
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIPanGestureRecognizer, let senderView = sender.view {
                let translate: CGPoint = sender.translation(in: senderView.superview)
                senderView.center = CGPoint(x: senderView.center.x + translate.x, y: senderView.center.y + translate.y)
                sender.setTranslation( .zero, in: senderView.superview)
                action(recognizer)
            }
        }
        return obj
    }
      
    // MARK: 9.5、手势 - 屏幕边缘
    /// 手势 - 屏幕边缘
    /// - Parameters:
    ///   - target: 监听对象
    ///   - action: 事件
    ///   - edgs: 哪边缘手势
    /// - Returns: 手势
    @discardableResult
    func addGestureEdgPan(_ target: Any?, action: Selector?, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: target, action: action)
        obj.edges = edgs
        addCommonGestureRecognizer(obj)
        return obj
    }
    
    // MARK: 9.6、手势 - 屏幕边缘(闭包) - 靠近屏幕边缘的视图即可
    /// 手势 - 屏幕边缘(闭包)
    /// - Parameters:
    ///   - action: 事件
    ///   - edgs: 哪边缘手势
    /// - Returns: 手势
    @discardableResult
    func addGestureEdgPan(_ action: @escaping RecognizerClosure, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: nil, action: nil)
        obj.edges = edgs
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    // MARK: 9.7、手势 - 清扫
    /// 手势 - 清扫
    /// - Parameters:
    ///   - target: 对象
    ///   - action: 事件
    ///   - direction: 清扫的方向
    /// - Returns: 手势
    @discardableResult
    func addGestureSwip(_ target: Any?, action: Selector?, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: target, action: action)
        obj.direction = direction
        addCommonGestureRecognizer(obj)
        return obj
    }
    
    // MARK: 9.8、手势 - 清扫
    /// 手势 - 清扫
    /// - Parameters:
    ///   - action: 事件
    ///   - direction: 清扫的方向
    /// - Returns: 手势
    @discardableResult
    func addGestureSwip(_ action: @escaping RecognizerClosure, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: nil, action: nil)
        obj.direction = direction
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    // MARK: 9.9、手势 - 捏合
    /// 手势 - 捏合
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGesturePinch(_ action: @escaping RecognizerClosure) -> UIPinchGestureRecognizer {
        let obj = UIPinchGestureRecognizer(target: nil, action: nil)
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIPinchGestureRecognizer {
                let location = recognizer.location(in: sender.view!.superview)
                sender.view!.center = location
                sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
                sender.scale = 1.0
                action(recognizer)
            }
        }
        return obj
    }
    
    // MARK: 9.10、手势 - 旋转
    /// 手势 - 旋转
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGestureRotation(_ action: @escaping RecognizerClosure) -> UIRotationGestureRecognizer {
        let obj = UIRotationGestureRecognizer(target: nil, action: nil)
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIRotationGestureRecognizer {
                sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
                sender.rotation = 0.0
                action(recognizer)
            }
        }
        return obj
    }
    
    // MARK: 通用支持手势的方法 - private
    private func addCommonGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        base.isUserInteractionEnabled = true
        base.isMultipleTouchEnabled = true
        base.addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - 十、颜色渐变
public extension JKPOP where Base : UIView {

    // MARK: 10.1、添加渐变色图层
    /// 添加渐变色图层
    /// - Parameters:
    ///   - direction: 渐变方向
    ///   - gradientColors: 渐变的颜色数组（颜色的数组是）
    ///   - gradientLocations: 决定每个渐变颜色的终止位置，这些值必须是递增的，数组的长度和 colors 的长度最好一致，提示：如果设置[0, 0.2] 指的是0-0.2之间渐变 0.2-1.0颜色不渐变
    func gradientColor(_ direction: JKViewGradientDirection = .horizontal, _ gradientColors: [Any], _ gradientLocations: [NSNumber]? = nil, _ transform: CATransform3D? = nil) {
        // 获取渐变对象
        let gradientLayer = CAGradientLayer().jk.gradientLayer(direction, gradientColors, gradientLocations, transform)
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.base.jk.width, height: self.base.jk.height)
        if let sublayers = self.base.layer.sublayers {
            removeOldGradientLayer(sublayers: sublayers, gradientLayer: gradientLayer)
        } else {
            self.base.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    // MARK: 10.2、colors 变化渐变动画
    /// colors 变化渐变动画
    /// - Parameters:
    ///   - direction: 渐变方向
    ///   - startGradientColors: 开始渐变的颜色数组
    ///   - endGradientColors: 结束渐变的颜色数组
    ///   - gradientLocations: 决定每个渐变颜色的终止位置，这些值必须是递增的，数组的长度和 colors 的长度最好一致，提示：如果设置[0, 0.2] 指的是0-0.2之间渐变 0.2-1.0颜色不渐变
    ///   - isRemovedOnCompletion: 是否动画结束后保持最终的效果
    ///   - duration: 动画时长
    func gradientColorAnimation(direction: JKViewGradientDirection = .horizontal, startGradientColors: [Any], endGradientColors: [Any], isRemovedOnCompletion: Bool = true, duration: CFTimeInterval = 1.0, gradientLocations: [NSNumber]? = nil) {
        // 获取渐变对象
        let gradientLayer = CAGradientLayer().jk.gradientLayer(direction, startGradientColors, gradientLocations)
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.base.jk.width, height: self.base.jk.height)
        if let sublayers = self.base.layer.sublayers {
            // 替换旧的CAGradientLayer
            removeOldGradientLayer(sublayers: sublayers, gradientLayer: gradientLayer)
        } else {
            self.base.layer.insertSublayer(gradientLayer, at: 0)
        }
        // 启动动画
        startgradientColorAnimation(gradientLayer, startGradientColors, endGradientColors, isRemovedOnCompletion, duration)
    }
    
    /// 新的CAGradientLayer替换旧的
    /// - Parameters:
    ///   - sublayers: [CALayer]集合
    ///   - gradientLayer: 新的CAGradientLayer
    func removeOldGradientLayer(sublayers: [CALayer], gradientLayer: CAGradientLayer) {
        // 替换旧的CAGradientLayer
        for (index, layer) in sublayers.enumerated() {
            if layer is CAGradientLayer {
                // 替换旧的CAGradientLayer
                self.base.layer.replaceSublayer(layer, with: gradientLayer)
                break
            }
        }
    }
    
    private func startgradientColorAnimation(_ gradientLayer: CAGradientLayer, _ startGradientColors: [Any], _ endGradientColors: [Any], _ isRemovedOnCompletion: Bool = true, _ duration: CFTimeInterval = 1.0) {
        // 添加渐变动画
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        // colorChangeAnimation.delegate = self
        colorChangeAnimation.duration = duration
        colorChangeAnimation.fromValue = startGradientColors
        colorChangeAnimation.toValue = endGradientColors
        colorChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        // 动画结束后保持最终的效果
        colorChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
    }
}
