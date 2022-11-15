//
//  UITextField+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/29.
//

import UIKit

// MARK: - 一、基本的扩展
public extension JKPOP where Base: UITextField {
    
    // MARK: 1.1、添加左边的内边距
    /// 添加左边的内边距
    /// - Parameter padding: 边距
    func addLeftTextPadding(_ padding: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: padding, height: base.frame.height)
        self.base.leftView = leftView
        self.base.leftViewMode = UITextField.ViewMode.always
    }
    
    // MARK: 1.2、添加左边的图片
    /// 添加左边的图片
    /// - Parameters:
    ///   - image: 左边的图片
    ///   - leftViewFrame: 左边view的frame
    ///   - imageSize: 图片的大小
    func addLeftIcon(_ image: UIImage?, leftViewFrame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = leftViewFrame
        let imgageView = UIImageView()
        imgageView.frame = CGRect(x: leftViewFrame.width - 8 - imageSize.width, y: (leftViewFrame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgageView.image = image
        leftView.addSubview(imgageView)
        self.base.leftView = leftView
        self.base.leftViewMode = UITextField.ViewMode.always
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
    
    // MARK: 1.3、是否都是数字
    /// 是否都是数字
    /// - Returns: 返回结果
    func validateDigits() -> Bool {
        let digitsRegEx = "[0-9]*"
        let digitsTest = NSPredicate(format: "SELF MATCHES %@", digitsRegEx)
        return digitsTest.evaluate(with: self.base.text)
    }
    
    // MARK: 1.4、设置富文本的占位符
    /// 设置富文本的占位符
    /// - Parameters:
    ///   - font: 字体的大小
    ///   - color: 字体的颜色
    func setPlaceholderAttribute(font: UIFont, color: UIColor = .black) {
        let arrStr = NSMutableAttributedString(string: self.base.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        self.base.attributedPlaceholder = arrStr
    }
}

// MARK: - 二、链式编程
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
    // MARK: 2.11、设置键盘样式
    /// 设置代理
    /// - Parameter keyboardType: 键盘样式
    /// - Returns: 返回自身
    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
}

// MARK: - 三、输入内容以及正则的配置
public extension JKPOP where Base: UITextField {
    // MARK: 3.1、限制字数的输入(提示在：- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; 里面调用)
    /// 限制字数的输入
    /// - Parameters:
    ///   - range: 范围
    ///   - text: 输入的文字
    ///   - maxCharacters: 限制字数
    ///   - regex: 可输入内容(正则)
    ///   - isInterceptString: 复制文字进来，在字数限制的情况下，多余的字体是否截取掉，默认true
    /// - Returns: 返回是否可输入
    func inputRestrictions(shouldChangeTextIn range: NSRange, replacementText text: String, maxCharacters: Int, regex: String?, isInterceptString: Bool = true) -> Bool {
        guard !text.isEmpty else {
            return true
        }
        guard let oldContent = self.base.text else {
            return false
        }
        if let markedTextRange = self.base.markedTextRange {
             // 有高亮
            if range.length == 0 {
                // 联想中
                return oldContent.count + 1 <= maxCharacters
            } else {
                // 正则的判断
                if let weakRegex = regex, !JKRegexHelper.match(text, pattern: weakRegex) {
                    return false
                }
                let markedRange = rangeFromTextRange(textRange: markedTextRange)
                // 联想选中键盘
                let allContent = oldContent.jk.replacingCharacters(range: markedRange) + text
                if allContent.count > maxCharacters  {
                    let newContent = allContent.jk.sub(to: maxCharacters)
                    // print("content1：\(allContent) content2：\(newContent)")
                    self.base.text = newContent
                    return false
                }
            }
        } else {
            guard !text.jk.isNineKeyBoard() else {
                return true
            }
            // 正则的判断
            if let weakRegex = regex, !JKRegexHelper.match(text, pattern: weakRegex) {
                return false
            }
            // 2、如果数字大于指定位数，不能输入
            guard oldContent.count + text.count <= maxCharacters else {
                if oldContent.count < maxCharacters {
                    let remainingLength = maxCharacters - oldContent.count
                    let copyString = text.jk.removeBeginEndAllSapcefeed
                    // print("范围：\(range) copy的字符串：\(copyString) 长度：\(copyString.count)  截取的字符串：\(copyString.jk.sub(to: remainingLength))")
                    // 可以插入字符串
                    let replaceContent = copyString.jk.sub(to: remainingLength)
                    // let newString = oldContent.jk.insertString(content: replaceContent), locat: range.location)
                    let newString = oldContent.jk.replacingCharacters(range: range, replacingString: replaceContent)
                    // print("老的字符串：\(oldContent) 新的的字符串：\(newString) 长度：\(newString.count)")
                    self.base.text = newString
                    // 异步改变
                    JKAsyncs.asyncDelay(0.5) {} _: {
                        if let selectedRange = self.base.selectedTextRange {
                            if let newPosition = self.base.position(from: selectedRange.start, offset: remainingLength) {
                                self.base.selectedTextRange = self.base.textRange(from: newPosition, to: newPosition)
                            }
                        }
                    }
                }
                return false
            }
        }
        return true
    }
    
    /// UITextRange 转 NSRange
    /// - Parameter textRange: UITextRange对象
    /// - Returns: NSRange
    private func rangeFromTextRange(textRange: UITextRange) -> NSRange {
        let location: Int = self.base.offset(from: self.base.beginningOfDocument, to: textRange.start)
        let length: Int = self.base.offset(from: textRange.start, to: textRange.end)
        return NSMakeRange(location, length)
    }
}
