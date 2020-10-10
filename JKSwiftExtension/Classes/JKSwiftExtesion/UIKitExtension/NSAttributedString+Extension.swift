//
//  NSAttributedString+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/25.
//

import UIKit

public func + (lhs: NSMutableAttributedString, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
    let final = NSMutableAttributedString(attributedString: lhs)
    final.append(rhs)
    return final
}

public func + (lhs: String, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
    let final = NSMutableAttributedString(string: lhs)
    final.append(rhs)
    return final
}

public func + (lhs: NSMutableAttributedString, rhs: String) -> NSMutableAttributedString {
    let final = NSMutableAttributedString(attributedString: lhs)
    final.append(NSMutableAttributedString(string: rhs))
    return final
}

public extension String {
    func color(_ color: UIColor) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
        
        return attributedText
    }
    
    func font(_ font: Int) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(font))])
        return attributedText
    }
    
    func font(_ font: UIFont) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        return attributedText
    }
    
    func text() -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        return attributedText
    }
    
    /// 删除线
    ///
    /// - Returns: NSMutableAttributedString
    func Strikethrough() -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        return attributedText
    }
}

public extension NSMutableAttributedString {
    /// 删除线
    ///
    /// - Returns: NSMutableAttributedString
    func Strikethrough() -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.strikethroughStyle: NSUnderlineStyle.single.rawValue], range: range)
        return self
    }
    
    func color(_ color: UIColor) -> NSMutableAttributedString {
        let range = NSMakeRange(0, length)
        addAttributes([.foregroundColor: color], range: range)
        return self
    }
    
    func font(_ font: Int) -> NSMutableAttributedString {
        let range = NSMakeRange(0, length)
        addAttributes([.font: UIFont.systemFont(ofSize: CGFloat(font))], range: range)
        return self
    }
    
    func font(_ font: UIFont) -> NSMutableAttributedString {
        let range = NSMakeRange(0, length)
        addAttributes([.font: font], range: range)
        return self
    }
}
