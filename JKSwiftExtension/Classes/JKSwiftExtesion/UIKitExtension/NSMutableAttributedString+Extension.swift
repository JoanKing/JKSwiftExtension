//
//  NSMutableAttributedString+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/9.
//

import UIKit

// MARK:- 一、基本的链式编程 扩展
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
}
