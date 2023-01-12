//
//  UIFont+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/2.
//

import UIKit
extension UIFont: JKPOPCompatible {}

// MARK: - 一、常用的系统基本字体扩展
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

// MARK: - 二、PingFangSC-字体使用
fileprivate enum UIFontWeight: String {
    /// 常规
    case Regular = "Regular"
    /// 中等的字体(介于Regular和Semibold之间)
    case Medium = "Medium"
    /// 纤细的字体
    case Thin = "Thin"
    /// 亮字体
    case Light = "Light"
    /// 超细的字体
    case Ultralight = "Ultralight"
    /// 半粗体的字体
    case Semibold = "Semibold"
}

public extension JKPOP where Base: UIFont {
    
    // MARK: 2.1、常规字体
    /// 常规字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func pingFangR(_ ofSize: CGFloat) -> UIFont {
        return pingFangText(ofSize, W: .Regular)
    }
    
    // MARK: 2.2、中等的字体(介于Regular和Semibold之间)
    /// 中等的字体(介于Regular和Semibold之间)
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func pingFangM(_ ofSize: CGFloat) -> UIFont {
        return pingFangText(ofSize, W: .Medium)
    }
    
    // MARK: 2.3、纤细的字体
    /// 纤细的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func pingFangT(_ ofSize: CGFloat) -> UIFont {
        return pingFangText(ofSize, W: .Thin)
    }
    
    // MARK: 2.4、亮字体
    /// 亮字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func pingFangL(_ ofSize: CGFloat) -> UIFont {
        return pingFangText(ofSize, W: .Light)
    }
    
    // MARK: 2.5、超细的字体
    /// 超细的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func pingFangUL(_ ofSize: CGFloat) -> UIFont {
        return pingFangText(ofSize, W: .Ultralight)
    }
    
    // MARK: 2.6、半粗体的字体
    /// 半粗体的字体
    /// - Parameter ofSize: 字体大小
    /// - Returns: 字体
    static func pingFangSB(_ ofSize: CGFloat) -> UIFont {
        return pingFangText(ofSize, W: .Semibold)
    }
    
    /// 文字字体
    private static func pingFangText(_ ofSize: CGFloat, W Weight: UIFontWeight) -> UIFont {
        let fontName = "PingFangSC-" + Weight.rawValue
        return appCustomFont(fontName: fontName, ofSize: ofSize)
    }
}

// MARK: - 三、加载自定义的字体
/*
 使用自定义自提注意事项
 1、添加自定义字体到项目，保证TARGETS->Build Phases里面有对应的字体资源
 2、在info.plist添加字体资源 Fonts provided by application(数组类型，存放自定义字体名字)
 3、调用下面方法使用：UIFont.jk.customFont(26, fontName: "字体的名字")
 */
public extension JKPOP where Base: UIFont {
    //MARK: 3.1、自定义字体
    /// 自定义字体
    static func customFont(_ ofSize: CGFloat, fontName: String) -> UIFont {
        return appCustomFont(fontName: fontName, ofSize: ofSize)
    }
    
    // MARK: 3.2、查看所有字体的名字
    static func showAllFont() {
        var i = 0
        for family in UIFont.familyNames {
            debugPrint("\(i)---项目字体---\(family)")
            for names in UIFont.fontNames(forFamilyName: family) {
                debugPrint("== \(names)")
            }
            i += 1
        }
    }
}

//MARK: - private
private extension JKPOP where Base: UIFont {
    /// 自定义的字体
    /// - Parameters:
    ///   - fontName: 字体的名字
    ///   - ofSize: 字体大小
    /// - Returns: 对应的字体
    private static func appCustomFont(fontName: String, ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: fontName, size: ofSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: ofSize)
        }
    }
}
