//
//  UITextField+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/29.
//

import UIKit

// MARK:- 一、基本的扩展
public extension UITextField {
    
    // MARK: 1.1、添加左边的内边距
    /// 添加左边的内边距
    /// - Parameter padding: 边距
    func addLeftTextPadding(_ padding: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: padding, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    // MARK: 1.2、添加左边的图片
    /// 添加左边的图片
    /// - Parameters:
    ///   - image: 左边的图片
    ///   - leftViewFrame: 左边view的frame
    ///   - imageSize: 图片的大小
    func addLeftIcon(_ image: UIImage?, leftViewFrame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.backgroundColor = .randomColor
        leftView.frame = leftViewFrame
        let imgageView = UIImageView()
        imgageView.frame = CGRect(x: leftViewFrame.width - 8 - imageSize.width, y: (leftViewFrame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgageView.image = image
        leftView.addSubview(imgageView)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    /// 判断的方式
    enum textFieldValidationOptions: Int {
        // 等于(=)
        case equalTo
        // 大于(>)
        case greaterThan
        // 大于等于(>=)
        case greaterThanOrEqualTo
        // 小于(<)
        case lessThan
        // 小于等于(<=)
        case lessThanOrEqualTo
    }
    
    // MARK: 1.3、验证UITextField中字符长度
    /// 验证UITextField中字符长度
    /// - Parameters:
    ///   - count: 字符数量
    ///   - option: 所需条件
    /// - Returns: 返回结果
    @discardableResult
    func validateLength(ofCount count: Int, option: UITextField.textFieldValidationOptions) -> Bool {
        switch option {
        case .equalTo:
            return self.text!.count == count
        case .greaterThan:
            return self.text!.count > count
        case .greaterThanOrEqualTo:
            return self.text!.count >= count
        case .lessThan:
            return self.text!.count < count
        case .lessThanOrEqualTo:
            return self.text!.count <= count
        }
    }
    
    // MARK: 1.4、是否都是数字
    /// 是否都是数字
    /// - Returns: 返回结果
    func validateDigits() -> Bool {
        let digitsRegEx = "[0-9]*"
        let digitsTest = NSPredicate(format: "SELF MATCHES %@", digitsRegEx)
        return digitsTest.evaluate(with: self.text)
    }
    
    // MARK: 1.5、设置富文本的占位符
    /// 设置富文本的占位符
    /// - Parameters:
    ///   - font: 字体的大小
    ///   - color: 字体的颜色
    func setPlaceholderAttribute(font: UIFont, color: UIColor = .black) {
        let arrStr = NSMutableAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        self.attributedPlaceholder = arrStr
    }
}

// MARK:- 二、链式编程
public extension UITextField {
    
    // MARK: 2.1、设置文字
    /// 设置文字
    /// - Parameter text: 文字
    /// - Returns: 返回自身
    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    // MARK: 2.2、设置富文本
    /// 设置富文本
    /// - Parameter attributedString: 富文本文字
    /// - Returns: 返回自身
    @discardableResult
    func attributedText(_ attributedString: NSAttributedString) -> Self {
        self.attributedText = attributedString
        return self
    }
    
    // MARK: 2.3、设置占位符
    /// 设置占位符
    /// - Parameter text: 占位符文字
    /// - Returns: 返回自身
    @discardableResult
    func placeholder(_ text: String) -> Self {
        placeholder = text
        return self
    }
    
    // MARK: 2.4、设置富文本占位符
    /// 设置富文本占位符
    /// - Parameter text: 富文本占位符
    /// - Returns: 返回自身
    @discardableResult
    func attributedPlaceholder(_ text: NSAttributedString) -> Self {
        attributedPlaceholder = text
        return self
    }
    
    // MARK: 2.5、设置文本格式
    /// 设置文本格式
    /// - Parameter alignment: 文本格式
    /// - Returns: 返回自身
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    // MARK: 2.6、设置文本颜色 （UIColor）
    /// 设置文本颜色
    /// - Parameter color: 文本颜色
    /// - Returns: 返回自身
    @discardableResult
    func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    // MARK: 2.7、设置文本颜色（十六进制字符串）
    /// 设置文本颜色（十六进制字符串）
    /// - Parameter hex: 十六进制字符串
    /// - Returns: 返回自身
    @discardableResult
    func color(_ hex: String) -> Self {
        textColor = UIColor.hexStringColor(hexString: hex)
        return self
    }
    
    // MARK: 2.8、设置文本字体大小(UIFont)
    /// 设置文本字体大小
    /// - Parameter font: font
    /// - Returns: 返回自身
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    // MARK: 2.9、设置文本字体大小(CGFloat)
    /// 设置文本字体大小(CGFloat)
    /// - Parameter fontSize: 字体大小
    /// - Returns: 返回自身
    @discardableResult
    func font(_ fontSize: CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    // MARK: 2.10、设置代理
    /// 设置代理
    /// - Parameter delegate: 代理
    /// - Returns: 返回自身
    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }
}
