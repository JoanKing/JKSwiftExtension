//
//  UIColor+BaseExtension.swift
//  JKLive
//
//  Created by IronMan on 2020/8/28.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

// MARK: 有关颜色的判断
public extension UIColor {
    
    // MARK:- 自定义RGBA的颜色
    /// 自定义初始化器设置 Color
    /// - Parameters:
    ///   - r: red 颜色值
    ///   - g: green颜色值
    ///   - b: blue颜色值
    ///   - alpha: 透明度
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        // 提示：在 extension 中给系统的类扩充构造函数，只能扩充：遍历构造函数
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // Mark: 十六进制字符串设置颜色
    /// 十六进制字符串设置颜色
    /// - Parameters:
    ///   - hex: 十六进制字符串
    ///   - alpha: 透明度
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let color = Self.hexCustomColor(hex: hex)
        guard let r = color.r, let g = color.g, let b = color.b else {
            assert(false, "颜色值有误")
            self.init(r: 1.0, g: 1.0, b: 1.0, alpha: alpha)
        }
        self.init(r: r, g: g, b: b, alpha: alpha)
    }
    
    // MARK:- RGBA的颜色设置
    static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    // MARK:- 随机色
    /// 随机色
    /// - Returns: 返回颜色
    static func randomColor() -> UIColor {
        return color(r: CGFloat(arc4random()%256) , g: CGFloat(arc4random()%256), b: CGFloat(arc4random()%256), a: 1.0)
    }
    
    // MARK:- 十六进制颜色的设置
    static func hexColor(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let newColor = hexCustomColor(hex: hex)
        guard let r = newColor.r, let g = newColor.g, let b = newColor.b else {
            assert(false, "颜色值有误")
            return .white
        }
        return color(r: r, g: g, b: b, a: alpha)
    }
    
    // MARK: 获取颜色的渐变的 RGB
    /// 获取颜色的渐变色
    /// - Parameters:
    ///   - firstColor: 第一个颜色
    ///   - secondColor: 第二个颜色
    /// - Returns: 返回渐变的 RGB
    static func getRGBDelta(_ firstColor: UIColor, _ secondColor: UIColor) -> (CGFloat, CGFloat, CGFloat) {
        
        let firstRGB = firstColor.getRGB()
        let secondRGB = secondColor.getRGB()
        
        return (firstRGB.0 - secondRGB.0, firstRGB.1 - secondRGB.1, firstRGB.2 - secondRGB.2)
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let cpms = cgColor.components else {
            fatalError("保证普通颜色是RGB方式传入")
        }
        return (cpms[0] * 255, cpms[1] * 255, cpms[2] * 255)
    }
    
    // MARK:- 十六进制 Int 颜色的使用
    /// 十六进制颜色的使用
    /// - Parameters:
    ///   - color: 16进制 Int 颜色
    ///   - alpha: 透明度
    /// - Returns: 返回一个 UIColor
    static func hexIntColor(color: Int, alpha: Float = 1) -> UIColor {
        let redComponet: Float = Float(color >> 16)
        let greenComponent: Float = Float((color & 0xFF00) >> 8)
        let blueComponent: Float = Float(color & 0xFF)
        return UIColor(red: CGFloat(redComponet / 255.0), green: CGFloat(greenComponent / 255.0), blue: CGFloat(blueComponent / 255.0), alpha: CGFloat(alpha))
    }
    
    // MARK:- 私有 - RGBA的颜色设置
    fileprivate static func hexCustomColor(hex: String) -> (r: CGFloat?, g: CGFloat?, b: CGFloat?) {
        
        // 1、判断字符串的长度是否符合
        guard hex.count >= 6 else {
            return (nil, nil, nil)
        }
        
        // 2、将字符串转成大写
        var tempHex = hex.uppercased()
        
        // 3、判断开头： 0x/#/##
        if tempHex.hasSuffix("0x") || tempHex.hasSuffix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasSuffix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        
        // 4、分别取出 RGB
        // FF --> 255
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        // 5、将十六进制转成 255 的数字
        var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        return (r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
}

// MARK:- 个性化的颜色设置
extension UIColor {
    
    // MARK: 背景灰色
    static func JKGlobalColor() -> UIColor {
        return color(r: 240, g: 240, b: 240, a: 1)
    }
    
    // MARK: 红色
    static func JKGlobalRedColor() -> UIColor {
        return color(r: 245, g: 80, b: 83, a: 1.0)
    }
    
    // MARK: 字体的灰色
    static func JKTextGayColor() -> UIColor {
        return color(r: 140, g: 140, b: 140, a: 1.0)
    }
    
    // MARK: 字体的蓝色
    static func JKTextzhuBlueColor() -> UIColor {
        return color(r: 0, g: 150, b: 255, a: 1.0)
    }
    
    /// 通用btn字体的颜色
    public private(set) static var c444444: UIColor = UIColor(hex: "#444444", alpha: 1.0)
}

