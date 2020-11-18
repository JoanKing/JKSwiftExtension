//
//  JKContentSize.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

// MARK:- 一、文字内容的计算
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
    public static func attributedStringSize(attributedString: NSAttributedString ,width: CGFloat, height: CGFloat, font: UIFont) -> CGSize {
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        tempLabel.font = font
        tempLabel.attributedText = attributedString
        tempLabel.numberOfLines = 0
        tempLabel.sizeToFit()
        let size: CGSize = tempLabel.jk.size
        return size;
    }
}
