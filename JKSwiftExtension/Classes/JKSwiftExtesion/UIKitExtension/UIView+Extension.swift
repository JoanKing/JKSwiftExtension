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

// MARK:- 一、机型的判断
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
let isIPhoneX = UIScreen.main.bounds.height >= 812
let isIPhoneXR = (CGSize(width: 828, height: 1792).equalTo(UIScreen.main.currentMode!.size))
let isIPhoneXS = (CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size))
let isIiPhoneXSMax = (CGSize(width: 1242, height: 2688).equalTo(UIScreen.main.currentMode!.size))

// MARK: 1.1、设备型号
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

// MARK: 1.2、是不是 iPhone X
/// 是不是 iPhone X
/// - Returns: bool
public func isIphoneX() -> Bool {
    return isIphone() && kScreenH == 812
}

// MARK: 1.3、是不是 iPhone XS
/// 是不是 iPhone XS
/// - Returns: description
public func isXs() -> Bool {
    return isIphone() && kScreenH == 812
}

// MARK: 1.4、是不是 iPhone XR
/// 是不是 iPhone XR
/// - Returns: description
public func isXR() -> Bool {
    return isIphone() && kScreenH == 896 && kScreenW == 414
}

// MARK: 1.5、是不是 iPhone XsMax
/// 是不是 iPhone XsMax
/// - Returns: description
public func isXsMax() -> Bool {
    return isIphone() && kScreenH == 896 && kScreenW == 414
}

// MARK: 1.6、是不是 iPhone
/// 判断是不是 iPhone
/// - Returns: bool
public func isIphone() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
}

// MARK: 1.7、判断是否是 pad
/// 判断是否是 pad
/// - Returns: bool
public func isPadDevice() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == .pad
}

// MARK: 1.8、判断是不是 4 4s
/// 4 4s
/// - Returns: description
public func is4OrLess() -> Bool {
    return isIphone() && kScreenH < 568
}

// MARK: 1.9、判断是不是 5 5c 5s
/// 判断是不是 5 5c 5s
/// - Returns: description
public func is5() -> Bool {
    return isIphone() && kScreenH == 568
}

// MARK: 1.10、判断是不是 6 6s 7 8
/// 判断是不是 6 6s 7 8
/// - Returns: description
public func is678() -> Bool {
    return isIphone() && kScreenH == 667
}

// MARK: 1.11、判断是不是 6p 7p 8p
/// 判断是不是 6p 7p 8p
/// - Returns: description
public func is678P() -> Bool {
    return isIphone() && kScreenH == 736
}

// MARK:- 二、屏幕尺寸常用的常量
// MARK: 2.1、屏幕的宽
/// 屏幕的宽
public let kScreenW: CGFloat = UIScreen.main.bounds.width
// MARK: 2.2、屏幕的高
/// 屏幕的高
public let kScreenH: CGFloat = UIScreen.main.bounds.height
// MARK: 2.3、获取statusBar的高度
/// 获取statusBar的高度
public let kStatusBarFrameH: CGFloat = UIApplication.shared.statusBarFrame.height
// MARK: 2.4、获取导航栏的高度
/// 获取导航栏的高度
public var kNavFrameH: CGFloat { return isIPhoneX ? 88 : 64 }
// MARK: 2.5、获取tabbar的高度
/// 获取tabbar的高度
public var kTabbarFrameH: CGFloat { return isIPhoneX ? 83 : 49 }
// MARK: 2.6、底部tabbar多出的部分
/// 底部tabbar多出的部分
public var kTabbatBottom: CGFloat { return isIPhoneX ? 34 : 0 }
// MARK: 2.7、缩放比
/// 缩放比
public let kPixel = 1.0 / UIScreen.main.scale

// MARK: - 屏幕16:9比例系数下的宽高
// 宽
public let kScreenW16_9: CGFloat = kScreenW * 9.0 / 16.0
// 高
public let kScreenH16_9: CGFloat = kScreenH * 16.0 / 9.0

// MARK:- 三、UIView 有关 Frame 的扩展
extension UIView: JKPOPCompatible {}
public extension JKPOP where Base : UIView {
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
            base.center = tempCenter;
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

// MARK:- 四、继承于 UIView 视图的 平面、3D 旋转 以及 缩放
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
extension JKPOP where Base : UIView {
    
    // MARK: 4.1、平面旋转
    /// 平面旋转
    /// - Parameters:
    ///   - angle: 旋转多少度
    ///   - isInverted: 顺时针还是逆时针，默认是顺时针
    public func setRotation(_ angle: CGFloat, isInverted: Bool = false) {
        self.base.transform = isInverted ? CGAffineTransform(rotationAngle: angle).inverted() : CGAffineTransform(rotationAngle: angle)
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
}

// MARK:- 五、关于UIView的 圆角、阴影、边框 的设置
public extension UIView {
    
    // MARK: 5.1、添加圆角
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
    
    // MARK: 5.2、给继承于view的类添加阴影
    /// 给继承于view的类添加阴影
    /// - Parameters:
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    func addShadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        // 设置阴影颜色
        layer.shadowColor = shadowColor.cgColor
        // 设置透明度
        layer.shadowOpacity = shadowOpacity
        // 设置阴影半径
        layer.shadowRadius = shadowRadius
        // 设置阴影偏移量
        layer.shadowOffset = shadowOffset
    }
    
    // MARK: 5.3、添加阴影和圆角并存
    /// 添加阴影和圆角并存
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角大小
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    func addCornerAndShadow(superview: UIView, conrners: UIRectCorner , radius: CGFloat = 3, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        let subLayer = CALayer()
        let fixframe = self.frame
        subLayer.frame = fixframe
        subLayer.cornerRadius = shadowRadius
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
        superview.layer.insertSublayer(subLayer, below: self.layer)
    }
    
    // MARK: 5.4、添加边框
    /// 添加边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    func addBorder(borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    
    // MARK: 5.5、添加顶部的 边框
    /// 添加顶部的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderTop(borderWidth: CGFloat, borderColor: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.6、添加顶部的 内边框
    /// 添加顶部的 内边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - padding: 边框距离边上的距离
    func addBorderTopWithPadding(borderWidth: CGFloat, borderColor: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.7、添加底部的 边框
    /// 添加底部的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderBottom(borderWidth: CGFloat, borderColor: UIColor) {
        addBorderUtility(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.8、添加左边的 边框
    /// 添加左边的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderLeft(borderWidth: CGFloat, borderColor: UIColor) {
        addBorderUtility(x: 0, y: 0, width: borderWidth, height: frame.height, color: borderColor)
    }
    
    // MARK: 5.9、添加右边的 边框
    /// 添加右边的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderRight(borderWidth: CGFloat, borderColor: UIColor) {
        addBorderUtility(x: frame.width - borderWidth, y: 0, width: borderWidth, height: frame.height, color: borderColor)
    }
    
    // MARK: 5.10、画圆环
    /// 画圆环
    /// - Parameters:
    ///   - fillColor: 内环的颜色
    ///   - strokeColor: 外环的颜色
    ///   - strokeWidth: 外环的宽度
    func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let ciecleRadius = self.jk.width > self.jk.height ? self.jk.height : self.jk.width
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: ciecleRadius, height: ciecleRadius), cornerRadius: ciecleRadius / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
}

// MARK:- 六、自定义链式编程
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

// MARK:- 七、其他的方法
public extension UIView {
    
    // MARK: 7.1、获取当前view的viewcontroller
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
    
    // MARK: 7.2、添加水印
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
    
    // MARK: 7.3、移除所有的子视图
    /// 移除所有的子视图
    func removeAllSubViews() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
    
    // MARK: 7.4、将 View 转换成图片
    /// 将 View 转换成图片
    /// - Returns: 图片
    func toImage() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        self.layer.render(in: context)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return viewImage
    }
    
    // MARK: 7.5、添加点击事件
    /// 添加点击事件
    /// - Parameters:
    ///   - target: 监听对象
    ///   - selector: 方法
    func addTapGestureRecognizerAction(_ target : Any ,_ selector : Selector) {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: selector))
    }

}

// MARK:- private method
extension UIView {
    /// 边框的私有内容
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}
