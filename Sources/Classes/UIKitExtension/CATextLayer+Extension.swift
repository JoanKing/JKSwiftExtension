//
//  CATextLayer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit
/**
 CATextLayer 使用Core Text 进行绘制，渲染速度比使用 Web Kit 的 UILable 快很多。而且 UILable 主要是管理内容，而 CATextLayer 则是绘制内容。
 */
// MARK: - 一、基本的链式编程 扩展
public extension CATextLayer {
    
    // MARK: 1.1、设置文字的内容
    /// 设置文字的内容
    /// - Parameter text: 文字内容
    /// - Returns: 返回自身
    @discardableResult
    func text(_ text: String?) -> Self {
        self.string = text
        return self
    }
    
    // MARK: 1.2、设置 NSAttributedString 文字
    /// 设置 NSAttributedString 文字
    /// - Parameter attributedText: NSAttributedString 文字
    /// - Returns: 返回自身
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString) -> Self {
        self.string = attributedText
        return self
    }
    
    // MARK: 1.3、自动换行，默认NO
    /// 自动换行，默认NO
    /// - Parameter isWrapped: 是否自动换行
    /// - Returns: 返回自身
    @discardableResult
    func isWrapped(_ isWrapped: Bool) -> Self {
        self.isWrapped = isWrapped
        return self
    }
    
    // MARK: 1.4、当文本显示不全时的裁剪方式
    /// 当文本显示不全时的裁剪方式
    /// - Parameter truncationMode: 裁剪方式
    /// none 不剪裁，默认
    /// start 剪裁开始部分
    /// end 剪裁结束部分
    /// middle 剪裁中间部分
    /// - Returns: 返回自身
    @discardableResult
    func truncationMode(_ truncationMode: CATextLayerTruncationMode) -> Self {
        self.truncationMode = truncationMode
        return self
    }
    
    // MARK: 1.5、文本显示模式：左 中 右
    /// 文本显示模式：左 中 右
    /// - Parameter alignment: 文本显示模式
    /// - Returns: 返回自身
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        switch alignment {
        case .left:
            self.alignmentMode = .left
        case .right:
            self.alignmentMode = .right
        case .center:
            self.alignmentMode = .center
        case .natural:
            self.alignmentMode = .natural
        case .justified:
            self.alignmentMode = .justified
        default:
            self.alignmentMode = .left
        }
        return self
    }
    
    // MARK: 1.6、设置字体的颜色
    /// 设置字体的颜色
    /// - Parameter color: 字体的颜色
    /// - Returns: 返回自身
    @discardableResult
    func color(_ color: UIColor) -> Self {
        foregroundColor = color.cgColor
        return self
    }
    
    // MARK: 1.7、设置字体的颜色(十六进制)
    /// 设置字体的颜色(十六进制)
    /// - Parameter hex: 十六进制字符串颜色
    /// - Returns: 返回自身
    @discardableResult
    func color(_ hex: String) -> Self {
        foregroundColor = UIColor.hexStringColor(hexString: hex).cgColor
        return self
    }
    
    // MARK: 1.8、设置字体的大小
    /// 设置字体的大小
    /// - Parameter fontSize: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func font(_ fontSize: CGFloat) -> Self {
        self.fontSize = fontSize
        if #available(iOS 9.0, *) {
            self.font = CTFontCreateWithName("PingFangSC-Regular" as CFString, fontSize, nil)
        }
        self.contentsScale = UIScreen.main.scale
        return self
    }
    
    // MARK: 1.9、设置字体的Font(暂时无效)
    /// 设置字体的Font
    /// - Parameter font: 字体的Font
    /// - Returns: 返回自身
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        self.contentsScale = UIScreen.main.scale
        return self
    }
    
    // MARK: 1.10、设置字体粗体
    /// 设置字体粗体
    /// - Parameter boldfontSize: 粗体字体大小
    /// - Returns: 返回自身
    @discardableResult
    func boldFont(_ boldfontSize: CGFloat) -> Self {
        self.fontSize = boldfontSize
        if #available(iOS 9.0, *) {
            self.font = CTFontCreateWithName("PingFangSC-Medium" as CFString, boldfontSize, nil)
        } else {
            self.font = CTFontCreateWithName("Helvetica-bold" as CFString, boldfontSize, nil)
        }
        self.contentsScale = UIScreen.main.scale
        return self
    }
}
