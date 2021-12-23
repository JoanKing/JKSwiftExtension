//
//  UIFont+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/2.
//

import UIKit
extension UIFont: JKPOPCompatible {}
// MARK: - 一、常用的基本字体扩展
public extension JKPOP where Base: UIFont {
    
    // MARK: 1.1、默认字体
    /// 默认字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textF(_ ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize)
    }
    
    // MARK: 1.2、常规字体
    /// 常规字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textR(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .regular)
    }
    
    // MARK: 1.3、中等的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textM(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .medium)
    }
    
    // MARK: 1.4、加粗的字体
    /// 加粗的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textB(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .bold)
    }
    
    // MARK: 1.5、半粗体的字体
    /// 半粗体的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textSB(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .semibold)
    }
    
    // MARK: 1.6、超细的字体
    /// 超细的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textUltraLight(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .ultraLight)
    }
    
    // MARK: 1.7、纤细的字体
    /// 纤细的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textThin(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .thin)
    }
    
    // MARK: 1.8、亮字体
    /// 亮字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textLight(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .light)
    }
    
    // MARK: 1.9、介于Bold和Black之间
    /// 介于Bold和Black之间
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textHeavy(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .heavy)
    }
    
    // MARK: 1.10、最粗字体
    /// 最粗字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func textBlack(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .black)
    }
 
    /// 文字字体
    fileprivate static func text(_ ofSize: CGFloat, W Weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: Weight)
    }
}

// MARK: - 二、自定义字体
fileprivate enum UIFontWeight: String {
    /// 常规
    case Regular = "Regular"
    /// 中等
    case Medium = "Medium"
    /// 加粗
    case Bold = "Bold"
    /// 半粗体
    case Semibold = "Semibold"
}

public extension JKPOP where Base: UIFont {
    
    // MARK: 2.1、常规字体
    /// 常规字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func customFontR(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .Regular)
    }
    
    // MARK: 2.2、中等的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func customFontM(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .Medium)
    }
    
    // MARK: 2.3、加粗的字体
    /// 加粗的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func customFontB(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .Bold)
    }
    
    // MARK: 2.4、半粗体的字体
    /// 半粗体的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func customFontSB(_ ofSize: CGFloat) -> UIFont {
        return text(ofSize, W: .Semibold)
    }
    
    /// 文字字体
    private static func text(_ ofSize: CGFloat, W Weight: UIFontWeight) -> UIFont {
        let fontName = "PingFangSC-" + Weight.rawValue
        return appFont(fontName: fontName, ofSize: ofSize, Weight: Weight)
    }
    
    private static func appFont(fontName: String, ofSize: CGFloat, Weight: UIFontWeight = .Regular) -> UIFont {
        if let font = UIFont(name: fontName, size: ofSize) {
            return font
        } else if Weight == .Regular {
            return UIFont.systemFont(ofSize: ofSize)
        } else {
            return UIFont.boldSystemFont(ofSize: ofSize)
        }
    }
}
