//
//  NSMutableAttributedString+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/9.
//

import UIKit
import Foundation

// MARK: - 富文本属性介绍
/**
 // NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
 // NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
 // NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
 // NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
 // NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
 // NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
 // NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
 // NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
 // NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
 // NSStrokeWidth AttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
 // NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
 // NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
 // NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
 // NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
 // NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
 // NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
 // NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
 // NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
 // NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
 // NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
 // NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象
 */

// MARK: - 一、基本的链式编程 扩展
public extension NSMutableAttributedString {
 
    // MARK: 1.1、设置 删除线
    /// 设置 删除线
    /// - Returns: 返回自身
    @discardableResult
    func strikethrough() -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.strikethroughStyle: NSUnderlineStyle.single.rawValue], range: range)
        return self
    }
    
    // MARK: 1.2、设置富文本文字的颜色
    /// 设置富文本文字的颜色
    /// - Parameter color: 富文本文字的颜色
    /// - Returns: 返回自身
    @discardableResult
    func color(_ color: UIColor) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.foregroundColor: color], range: range)
        return self
    }
    
    // MARK: 1.3、设置富文本文字的颜色(十六进制字符串颜色)
    /// 设置富文本文字的颜色(十六进制字符串颜色)
    /// - Parameter hexString: (十六进制字符串颜
    /// - Returns: 返回自身
    @discardableResult
    func color(_ hexString: String) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.foregroundColor: UIColor.hexStringColor(hexString: hexString)], range: range)
        return self
    }
    
    // MARK: 1.4、设置富文本文字的大小
    /// 设置富文本文字的大小
    /// - Parameter font: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func font(_ font: CGFloat) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.font: UIFont.systemFont(ofSize: font)], range: range)
        return self
    }
    
    // MARK: 1.5、设置富文本文字的 UIFont
    /// 设置富文本文字的 UIFont
    /// - Parameter font: UIFont
    /// - Returns: 返回自身
    @discardableResult
    func font(_ font: UIFont) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.font: font], range: range)
        return self
    }
    
    // MARK: 1.6、设置富文本文字的间距
    /// 设置富文本文字的间距
    /// - Parameter wordSpaceing: 字体之间的间距
    /// - Returns: 返回自身
    @discardableResult
    func kern(_ wordSpaceing: CGFloat) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.kern: wordSpaceing], range: range)
        return self
    }
    
    // MARK: 1.7、设置段落的样式
    /// 设置段落的样式
    /// - Parameter style: 样式
    /// - Returns: 返回自身
    @discardableResult
    func paragraphStyle(_ style: NSMutableParagraphStyle) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.paragraphStyle: style], range: range)
        return self
    }
}

// MARK: - 二、其他的扩展
public extension NSMutableAttributedString {
    
    static func createHighlightRichText(content: String, highlightRichTexts: [String], contentTextColor: UIColor, contentFont: UIFont, highlightRichTextColor: UIColor, highlightRichTextFont: UIFont, paraStyle: NSMutableParagraphStyle? = nil) -> NSMutableAttributedString {
        // 全部内容
        let allContent: String = content
        // 全部内容的富文本
        let allContentAttributedString = NSMutableAttributedString(string: allContent)
        var allParaStyle = NSMutableParagraphStyle()
        if let weakParaStyle = paraStyle {
            allParaStyle = weakParaStyle
        } else {
            // 右对齐
            allParaStyle.alignment = .left
        }
        // 整体富文本的设置
        let allContentDic: [NSAttributedString.Key: Any] = [.font: contentFont, .foregroundColor: contentTextColor, .paragraphStyle: allParaStyle]
        allContentAttributedString.addAttributes(allContentDic, range: NSRange(location: 0, length: allContent.count))
        
        let highlightRichTextAttrsDic: [NSAttributedString.Key: Any] = [.font: highlightRichTextFont, .foregroundColor: highlightRichTextColor, .paragraphStyle: allParaStyle]
        allContentAttributedString.addAttributes(allContentDic, range: NSRange(location: 0, length: allContent.count))
        // 单个高亮文本的设置
        for item in highlightRichTexts {
            let itemRanges = allContent.jk.nsRange(of: item)
            if itemRanges.count > 0 {
                allContentAttributedString.addAttributes(highlightRichTextAttrsDic, range: itemRanges[0])
            }
        }
        return allContentAttributedString
    }
}

