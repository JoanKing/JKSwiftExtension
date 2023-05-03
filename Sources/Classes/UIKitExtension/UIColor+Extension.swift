//
//  UIColor+Extension.swift
//  FDFullscreenPopGesture
//
//  Created by IronMan on 2020/10/29.
//

import UIKit

// MARK: - 一、构造器设置颜色
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

// MARK: - 二、使用方法设置颜色
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

// MARK: - 三、UIColor的一些方法
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
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("0X") || tempHex.hasPrefix("##") {
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
        return ("\(Int(red * multiplier))".jk.toCGFloat(), "\(Int(green * multiplier))".jk.toCGFloat(), "\(Int(blue * multiplier))".jk.toCGFloat(), alpha)
    }
}

// MARK: - 四、UIColor 的一些属性
public extension UIColor {
    
    // MARK: 4.1、UIColor 转十六进制颜色的字符串
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

// MARK: - 五、获取UIColor的HSV/HSB值（Hue色相、S饱和度、B亮度）
/**
 在平时开发中我们使用的都是 RGB 颜色模式，即通过红、绿、蓝三原色来表示一种颜色。RGB 是对机器很友好的色彩模式，但并不够人性化。
     相对于 RGB，还有种 HSB（也叫 HSV）颜色模式，该模式更便于描述人眼对与颜色的感觉。使用该模式可以很明确的表达是什么颜色？鲜艳不鲜艳？亮还是暗？
 1，HSB 模式介绍
 HSB 又称 HSV，表示一种颜色模式。在 HSB 模式中，颜色由如下三种值组成：
 H（hue）代表色相：色相指色彩的种类和名称。如红、橙、黄.... 取值范围 0°~360°，每个角度可以代表一种颜色。
 S（saturation）表示饱和度：它用 0% 至 100% 的值描述了相同色相、明度下色彩纯度的变化。数值越大，颜色中的灰色越少，颜色越鲜艳，呈现一种从灰度到纯色的变化。
 B（brightness）表示亮度：其作用是控制色彩的明暗变化。它同样使用了 0% 至 100% 的取值范围。数值越小，色彩越暗，越接近于黑色；数值越大，色彩越亮，越接近于白色。
 */
public extension UIColor {
    // MARK: 5.1、返回HSBA模式颜色值
    // 返回HSBA模式颜色值
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        /**
         hue：色相
         saturation：饱和度
         brightness：亮度
         alpha：透明度
         */
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h * 360, s, b, a)
    }
}

public extension UIColor {
    
    // MARK: 获取颜色的渐变的 RGB -------不建议使用
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

// MARK: 六、暗黑模式颜色处理类
public extension UIColor {
    
    // MARK: 6.1、深色模式和浅色模式颜色设置，非layer颜色设置
    /// 深色模式和浅色模式颜色设置，非layer颜色设置
    /// - Parameters:
    ///   - lightColor: 浅色模式的颜色
    ///   - darkColor: 深色模式的颜色
    /// - Returns: 返回一个颜色（UIColor）
    static func darkModeColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
       if #available(iOS 13.0, *) {
          return UIColor { (traitCollection) -> UIColor in
               if traitCollection.userInterfaceStyle == .dark {
                   return darkColor
               } else {
                   return lightColor
               }
           }
       } else {
          return lightColor
       }
   }
}

// MARK: - 私有的一些方法
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

// MARK: - 个性化的颜色设置
extension UIColor {
    
    // MARK: 背景灰色
    /// 背景灰色
    /// - Returns: 背景灰色
    static func JKGlobalColor() -> UIColor {
        return color(r: 240, g: 240, b: 240, alpha: 1)
    }
    
    // MARK: 红色
    /// 红色
    /// - Returns: 红色
    static func JKGlobalRedColor() -> UIColor {
        return color(r: 245, g: 80, b: 83, alpha: 1.0)
    }
    
    // MARK: 字体的灰色
    /// 字体的灰色
    /// - Returns: 字体的灰色
    static func JKTextGayColor() -> UIColor {
        return color(r: 140, g: 140, b: 140, alpha: 1.0)
    }
}


