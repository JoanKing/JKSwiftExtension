//
//  JKWidthHeight.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//
import UIKit

public struct JKWidthHeight {
    
    /// MARK: 1.返回文字的高度
    /// - Parameter string: 文字的内容
    /// - Parameter size: 文字的最大宽高
    /// - Parameter fontSize: 字体的大小
    public static func JKtextStringSize(string: NSString, size: CGSize, fontSize: CGFloat) -> CGSize {
        return string.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    /// MARK: 2.计算富文本的高度以及宽度
    /// - Parameter aString: 富文本字符串
    /// - Parameter width: 最大宽度
    /// - Parameter height: 最大高度
    /// - Parameter font: 富文本字体的大小
    public static func attributedStringSize(aString:NSAttributedString ,width:CGFloat, height:CGFloat, font: CGFloat) -> CGSize {
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        tempLabel.font = UIFont.systemFont(ofSize: font)
        tempLabel.attributedText = aString;
        tempLabel.numberOfLines = 0;
        tempLabel.sizeToFit()
        let size: CGSize = tempLabel.size
        return size;
    }
}
