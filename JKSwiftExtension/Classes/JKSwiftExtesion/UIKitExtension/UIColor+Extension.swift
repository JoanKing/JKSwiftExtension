//
//  UIColor+Extension.swift
//  FDFullscreenPopGesture
//
//  Created by IronMan on 2020/10/29.
//

import UIKit

// MARK:- 一、构造器设置颜色
public extension UIColor {
    
    // MARK: 1.1、根据 RGBA 设置颜色颜色
    /// 根据 RGBA 设置颜色颜色
    /// - Parameters:
    ///   - r: red 颜色值
    ///   - g: green颜色值
    ///   - b: blue颜色值
    ///   - alpha: 透明度
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        // 提示：在 extension 中给系统的类扩充构造函数，只能扩充：遍历构造函数
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // MARK: 1.2、十六进制字符串设置颜色
    /// 十六进制字符串设置颜色
    /// - Parameters:
    ///   - hex: 十六进制字符串
    ///   - alpha: 透明度
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        let color = Self.hexStringToColorRGB(hexString: hexString)
        guard let r = color.r, let g = color.g, let b = color.b else {
            #if DEBUG
            assert(false, "不是十六进制值")
            #endif
            return nil
        }
        self.init(r: r, g: g, b: b, alpha: alpha)
    }
    
    // MARK: 1.3、十六进制 Int 设置颜色
    /// 十六进制 Int 设置颜色
    /// - Parameters:
    ///   - hexInt: 十六进制 Int 值
    ///   - alpha:  透明度
    convenience init(hexInt: Int, alpha: CGFloat = 1.0) {
        let color = Self.hexIntToColorRGB(hexInt: hexInt)
        self.init(r: color.r, g: color.g, b: color.b, alpha: alpha)
    }
}

// MARK:- 二、使用方法设置颜色
public extension UIColor {
    
    // MARK: 2.1、根据RGBA的颜色(方法)
    /// 根据RGBA的颜色(方法)
    /// - Parameters:
    ///   - r: red 颜色值
    ///   - g: green颜色值
    ///   - b: blue颜色值
    ///   - alpha: 透明度
    /// - Returns: 返回 UIColor
    static func color(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // MARK: 2.2、十六进制字符串设置颜色(方法)
    static func hexStringColor(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let newColor = hexStringToColorRGB(hexString: hexString)
        guard let r = newColor.r, let g = newColor.g, let b = newColor.b else {
            assert(false, "颜色值有误")
            return .white
        }
        return color(r: r, g: g, b: b, alpha: alpha)
    }
    
    // MARK: 2.3、十六进制 Int 颜色的使用(方法)
    /// 十六进制颜色的使用
    /// - Parameters:
    ///   - color: 16进制 Int 颜色 0x999999
    ///   - alpha: 透明度
    /// - Returns: 返回一个 UIColor
    static func hexIntColor(hexInt: Int, alpha: CGFloat = 1) -> UIColor {
        let redComponet: Float = Float(hexInt >> 16)
        let greenComponent: Float = Float((hexInt & 0xFF00) >> 8)
        let blueComponent: Float = Float(hexInt & 0xFF)
        return UIColor(red: CGFloat(redComponet / 255.0), green: CGFloat(greenComponent / 255.0), blue: CGFloat(blueComponent / 255.0), alpha: alpha)
    }
}

// MARK:- 三、UIColor的一些方法
public extension UIColor {
    
    // MARK: 3.1、根据 十六进制字符串 颜色获取 RGB，如：#3CB371 或者 ##3CB371 -> 60,179,113
    /// 根据 十六进制字符串 颜色获取 RGB
    /// - Parameter hexString: 十六进制颜色的字符串，如：#3CB371 或者 ##3CB371 -> 60,179,113
    /// - Returns: 返回 RGB
    static func hexStringToColorRGB(hexString: String) -> (r: CGFloat?, g: CGFloat?, b: CGFloat?) {
        // 1、判断字符串的长度是否符合
        guard hexString.count >= 6 else {
            return (nil, nil, nil)
        }
        // 2、将字符串转成大写
        var tempHex = hexString.uppercased()
        // 检查字符串是否拥有特定前缀
        // hasPrefix(prefix: String)
        // 检查字符串是否拥有特定后缀。
        // hasSuffix(suffix: String)
        // 3、判断开头： 0x/#/##
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = String(tempHex[tempHex.index(tempHex.startIndex, offsetBy: 2)..<tempHex.endIndex])
        }
        if tempHex.hasPrefix("#") {
            tempHex = String(tempHex[tempHex.index(tempHex.startIndex, offsetBy: 1)..<tempHex.endIndex])
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
    
    // MARK: 3.2、根据 十六进制值 颜色获取 RGB， 如：0x3CB371 -> 60,179,113
    /// 根据 十六进制值 颜色获取 RGB， 如：0x3CB371 -> 60,179,113
    /// - Parameter hexInt: 十六进制值，如：0x3CB37
    /// - Returns: 返回 RGB
    static func hexIntToColorRGB(hexInt: Int) -> (r: CGFloat, g: CGFloat, b: CGFloat) {
        let red: CGFloat = CGFloat(hexInt >> 16)
        let green: CGFloat = CGFloat((hexInt & 0xFF00) >> 8)
        let blue: CGFloat = CGFloat(hexInt & 0xFF)
        return (red, green, blue)
    }
    
    // MARK: 3.3、color 转 RGBA
    /// color 转 RGBA
    /// - Returns: 返回对应的 RGBA
    func colorToRGBA() -> (r: CGFloat?, g: CGFloat?, b: CGFloat?, a: CGFloat?) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return (nil, nil, nil, nil)
        }
        return ("\(Int(red * multiplier))".toCGFloat(), "\(Int(green * multiplier))".toCGFloat(), "\(Int(blue * multiplier))".toCGFloat(), alpha)
    }
}

// MARK:- 四、UIColor 的一些属性
public extension UIColor {
    
    // MARK: 4.1、UIColor 转  十六进制颜色的字符串
    /// UIColor 转  十六进制颜色的字符串
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        } else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    
    // MARK: 4.2、随机色
    /// 随机色
    static var randomColor: UIColor {
        return UIColor(r: CGFloat(arc4random()%256), g: CGFloat(arc4random()%256), b: CGFloat(arc4random()%256), alpha: 1.0)
    }
}

public extension UIColor {
    
    // MARK: 获取颜色的渐变的 RGB
    /// 获取颜色的渐变的 RGB
    /// - Parameters:
    ///   - firstColor: 第一个颜色
    ///   - secondColor: 第二个颜色
    /// - Returns: 返回渐变的 RGB
    static func getRGBDelta(_ firstColor: UIColor, _ secondColor: UIColor) -> (CGFloat, CGFloat, CGFloat) {
        
        let firstRGB = firstColor.getRGB()
        let secondRGB = secondColor.getRGB()
        
        return (firstRGB.0 - secondRGB.0, firstRGB.1 - secondRGB.1, firstRGB.2 - secondRGB.2)
    }
}

// MARK:- 私有的一些方法
fileprivate extension UIColor {
    
    // MARK: 根据 UIColor 获取对应的 RGB(UIColor需要是 RGB创建的)
    /// 根据 UIColor 获取对应的 RGB(UIColor需要是 RGB创建的)
    /// - Returns: 返回对应额 RGB
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let cpms = cgColor.components else {
            fatalError("保证普通颜色是RGB方式传入")
        }
        return (cpms[0] * 255, cpms[1] * 255, cpms[2] * 255)
    }
}

// MARK:- 个性化的颜色设置
extension UIColor {
    
    // MARK: 背景灰色
    static func JKGlobalColor() -> UIColor {
        return color(r: 240, g: 240, b: 240, alpha: 1)
    }
    
    // MARK: 红色
    static func JKGlobalRedColor() -> UIColor {
        return color(r: 245, g: 80, b: 83, alpha: 1.0)
    }
    
    // MARK: 字体的灰色
    static func JKTextGayColor() -> UIColor {
        return color(r: 140, g: 140, b: 140, alpha: 1.0)
    }
    
    // MARK: 字体的蓝色
    static func JKTextzhuBlueColor() -> UIColor {
        return color(r: 0, g: 150, b: 255, alpha: 1.0)
    }
    
    /// 通用btn字体的颜色
    public private(set) static var c444444: UIColor = UIColor.hexStringColor(hexString: "#444444", alpha: 1.0)
}


