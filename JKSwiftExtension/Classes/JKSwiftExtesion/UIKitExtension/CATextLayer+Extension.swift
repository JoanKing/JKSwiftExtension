//
//  CATextLayer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

public extension CATextLayer {
    
    @discardableResult
    func text(_ text: String) -> Self {
        self.string = text
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString) -> Self {
        self.string = attributedText
        return self
    }

    /// 自动换行，默认NO
    @discardableResult
    func isWrapped(_ isWrapped: Bool) -> Self {
        self.isWrapped = isWrapped
        return self
    }
    
    /// 当文本显示不全时的裁剪方式
    ///
    /// - Parameter truncationMode: 裁剪方式
    /// none 不剪裁，默认
    /// start 剪裁开始部分
    /// end 剪裁结束部分
    /// middle 剪裁中间部分;
    @discardableResult
    func truncationMode(_ truncationMode: CATextLayerTruncationMode) -> Self {
        self.truncationMode = truncationMode
        return self
    }
    
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

    @discardableResult
    func color(_ color: UIColor) -> Self {
        foregroundColor = color.cgColor
        return self
    }
    @discardableResult
    func color(_ hex: String) -> Self {
        foregroundColor = UIColor.hexStringColor(hexString: hex).cgColor
        return self
    }
    
    @discardableResult
    func font(_ fontSize: CGFloat) -> Self {
        self.fontSize = fontSize
        if #available(iOS 9.0, *) {
            self.font = CTFontCreateWithName("PingFangSC-Regular" as CFString, fontSize, nil)
        }
        self.contentsScale = UIScreen.main.scale
        return self
    }
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font =  CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        self.contentsScale = UIScreen.main.scale
        return self
    }
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
