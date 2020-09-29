//
//  UILabel+Extension.swift
//  XCar
//
//  Created by 王冲 on 2020/1/14.
//  Copyright © 2020 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import Foundation
import UIKit
public extension UILabel {
    
    private class func genTextStyle(text: NSString, linebreakmode: NSLineBreakMode, align: NSTextAlignment, font: UIFont, lineSpace: CGFloat, textSpace: CGFloat, paraSpace: CGFloat) -> [NSAttributedString.Key : Any] {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = linebreakmode
        style.alignment = align
        style.lineSpacing = lineSpace
        style.hyphenationFactor = 1.0
        style.firstLineHeadIndent = 0.0
        style.paragraphSpacing = paraSpace
        style.paragraphSpacingBefore = 0.0
        style.headIndent = 0.0
        style.tailIndent = 0.0
        let dict = [
            NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.kern : textSpace] as [NSAttributedString.Key : Any]
        return dict
    }
    
    // MARK: 获取已知 frame 的 label 的文本行数 & 每一行内容
    /// 获取已知 frame 的 label 的文本行数 & 每一行内容
    /// - Precondition: 获取到 label 的frame，至少是 width
    /// - Parameters:
    ///     - lineSpace: 行间距
    ///     - textSpace: 字间距，默认为0.0
    ///     - paraSpace: 段间距，默认为0.0
    func linesCountAndLinesContent(lineSpace: CGFloat, textSpace: CGFloat = 0.0, paraSpace: CGFloat = 0.0) -> (Int?, [String]?) {
        return linesCountAndLinesContent(accordWidth: frame.size.width, lineSpace: lineSpace)
    }
    
    // MARK: 获取已知 width 的 label 的文本行数 & 每一行内容
    /// 获取已知 width 的 label 的文本行数 & 每一行内容
    /// - Precondition: 获取到 label 的 width
    /// - Parameters:
    ///     - lineSpace: 行间距
    ///     - textSpace: 字间距，默认为0.0
    ///     - paraSpace: 段间距，默认为0.0
    func linesCountAndLinesContent(accordWidth: CGFloat, lineSpace: CGFloat, textSpace: CGFloat = 0.0, paraSpace: CGFloat = 0.0) -> (Int?, [String]?) {
        guard let t = text, let f = font else {return (0, nil)}
        let align = textAlignment
        let c_fn = f.fontName as CFString
        let fp = f.pointSize
        let c_f = CTFontCreateWithName(c_fn, fp, nil)
        
        let contentDict = UILabel.genTextStyle(text: t as NSString, linebreakmode: NSLineBreakMode.byCharWrapping, align: align, font: f, lineSpace: lineSpace, textSpace: textSpace, paraSpace: paraSpace)
        
        let attr = NSMutableAttributedString(string: t)
        let range = NSRange(location: 0, length: attr.length)
        attr.addAttributes(contentDict, range: range)
        
        attr.addAttribute(NSAttributedString.Key.font, value: c_f, range: range)
        let frameSetter = CTFramesetterCreateWithAttributedString(attr as CFAttributedString)
        
        let path = CGMutablePath()
        /// 2.5是经验误差值
        path.addRect(CGRect(x: 0, y: 0, width: accordWidth - 2.5, height: CGFloat(MAXFLOAT)))
        let framef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        let lines = CTFrameGetLines(framef) as NSArray
        var lineArr = [String]()
        for line in lines {
            let lineRange = CTLineGetStringRange(line as! CTLine)
            let lineString = t.sub(start: lineRange.location, length: lineRange.length)
            lineArr.append(lineString as String)
        }
        return (lineArr.count, lineArr)
    }
    
    // MARK: 获取第一行内容
    /// - Important: 获取第一行内容
    var firstLineString: String? {
        return self.linesCountAndLinesContent(lineSpace: 0.0).1?.first
    }
    
    // MARK: 改变行间距
    /// 改变行间距
    /// - Parameter space: 行间距大小
    func changeLineSpace(space: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.attributedText = attributedString
        self.sizeToFit()
    }
    
    // MARK: 改变字间距
    /// 改变字间距
    /// - Parameter space: 字间距大小
    func changeWordSpace(space: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern:space])
        let paragraphStyle = NSMutableParagraphStyle()
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.attributedText = attributedString
        self.sizeToFit()
    }
    
    // MARK: 改变字间距和行间距
    /// 改变字间距和行间距
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - wordSpace: 字间距
    func changeSpace(lineSpace: CGFloat, wordSpace: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern:wordSpace])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.attributedText = attributedString
        self.sizeToFit()
        
    }
}

public extension UILabel {
    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func line(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    @discardableResult
    func color(_ hex: String) -> Self {
        textColor = UIColor.hexColor(hex: hex)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func font(_ fontSize: Float) -> Self {
        font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func font(_ fontSize: Int) -> Self {
        font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func boldFont(_ fontSize: Float) -> Self {
        font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func boldFont(_ fontSize: Int) -> Self {
        font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        return self
    }
}
