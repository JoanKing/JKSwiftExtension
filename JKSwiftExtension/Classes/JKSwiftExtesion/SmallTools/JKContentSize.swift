//
//  JKContentSize.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

public struct JKContentSize {
    
    // MARK:- 返回文字的高度
    /// 返回文字的高度
    /// - Parameters:
    ///   - string: 文字的内容
    ///   - size: 文字的最大宽高
    ///   - fontSize: 字体的大小
    /// - Returns: 返回 Size
    public static func textStringSize(string: NSString, size: CGSize, fontSize: CGFloat) -> CGSize {
        return string.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    // MARK: 计算富文本的高度以及宽度
    /// 计算富文本的高度以及宽度
    /// - Parameters:
    ///   - aString: 富文本字符串
    ///   - width: 最大宽度
    ///   - height: 最大高度
    ///   - font: 富文本字体的大小
    /// - Returns: CGSize
    public static func attributedStringSize(aString:NSAttributedString ,width:CGFloat, height:CGFloat, font: CGFloat) -> CGSize {
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        tempLabel.font = UIFont.systemFont(ofSize: font)
        tempLabel.attributedText = aString;
        tempLabel.numberOfLines = 0;
        tempLabel.sizeToFit()
        let size: CGSize = tempLabel.jk.size
        return size;
    }
}
