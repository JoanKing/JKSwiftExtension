//
//  JKContentSize.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

// MARK: - 一、文字内容的计算
public struct JKContentSize {
    
    // MARK: 1.1、返回文字的 size
    /// 返回文字的 size
    /// - Parameters:
    ///   - string: 文字的内容
    ///   - size: 文字的最大宽高
    ///   - font: 字体的 UIFont
    /// - Returns: 返回 Size
    @discardableResult
    public static func textStringSize(string: String, size: CGSize, font: UIFont) -> CGSize {
        return string.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
    
    // MARK: 1.2、计算富文本的 size
    /// 计算富文本的 size
    /// - Parameters:
    ///   - attributedString: 富文本字符串
    ///   - width: 最大宽度
    ///   - height: 最大高度
    ///   - font: 富文本字体的大小
    /// - Returns: CGSize
    @discardableResult
    public static func attributedStringSize(attributedString: NSAttributedString, width: CGFloat, height: CGFloat, font: UIFont) -> CGSize {
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        tempLabel.font = font
        tempLabel.attributedText = attributedString
        tempLabel.numberOfLines = 0
        tempLabel.sizeToFit()
        let size: CGSize = tempLabel.jk.size
        return size
    }
}

// MARK: - 二、文本行数和内容的计算
public extension JKContentSize {
    // MARK: 2.1、行数和每行的内容
    /// 获取已知 width 的 label 的文本行数 & 每一行内容
    /// - Parameters:
    ///   - content: 文本的内容
    ///   - font: 字体
    ///   - width: 宽度
    ///   - height: 高度
    ///   - minimumScaleFactor: 缩放率
    /// - Returns: 文本行数 & 每一行内容
    static func linesCountAndLinesContent(content: String, font: UIFont, width: CGFloat, height: CGFloat, minimumScaleFactor: CGFloat = 1.0) -> (Int?, [String]?) {
        let lodFontName = font.fontName == ".SFUI-Regular" ? "TimesNewRomanPSMT" : font.fontName
        let fontSize = getFontSizeForLabel(content: content, minimumScaleFactor: minimumScaleFactor, font: font, width: width, height: height)
        let newFont = UIFont(name: lodFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        let c_fn = newFont.fontName as CFString
        let fp = newFont.pointSize
        let c_f = CTFontCreateWithName(c_fn, fp, nil)
    
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byCharWrapping
        let contentDict = [NSAttributedString.Key.paragraphStyle : style] as [NSAttributedString.Key : Any]
        let attr = NSMutableAttributedString(string: content)
        let range = NSRange(location: 0, length: attr.length)
        attr.addAttributes(contentDict, range: range)
        attr.addAttribute(NSAttributedString.Key.font, value: c_f, range: range)
        let frameSetter = CTFramesetterCreateWithAttributedString(attr as CFAttributedString)
        
        let path = CGMutablePath()
        /// 2.5 是经验误差值
        path.addRect(CGRect(x: 0, y: 0, width: width, height: height > (fp * 1.5) ? height : fp * 1.5))
        let framef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        let lines = CTFrameGetLines(framef) as NSArray
        var lineArr = [String]()
        for line in lines {
            let lineRange = CTLineGetStringRange(line as! CTLine)
            let lineString = content.jk.sub(start: lineRange.location, length: lineRange.length)
            lineArr.append(lineString as String)
        }
        return (lineArr.count, lineArr)
    }
    
    // MARK: 获取字体的大小
    /// 获取字体的大小
    /// - Returns: 字体的大小
    private static func getFontSizeForLabel(content: String, minimumScaleFactor: CGFloat, font: UIFont, width: CGFloat, height: CGFloat) -> CGFloat {
        let text: NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: content))
        text.setAttributes([NSAttributedString.Key.font: font as Any], range: NSMakeRange(0, text.length))
        let context: NSStringDrawingContext = NSStringDrawingContext()
        context.minimumScaleFactor = minimumScaleFactor
        text.boundingRect(with: CGSize(width: width, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: context)
        let adjustedFontSize: CGFloat = font.pointSize * context.actualScaleFactor
        return adjustedFontSize
    }
}
