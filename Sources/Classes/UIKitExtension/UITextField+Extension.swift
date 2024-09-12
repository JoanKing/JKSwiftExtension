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
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    // MARK: 2.2、设置富文本
    /// 设置富文本
    /// - Parameter attributedString: 富文本文字
    /// - Returns: 返回自身
    @discardableResult
    func attributedText(_ attributedString: NSAttributedString?) -> Self {
        self.attributedText = attributedString
        return self
    }
    
    // MARK: 2.3、设置占位符
    /// 设置占位符
    /// - Parameter text: 占位符文字
    /// - Returns: 返回自身
    @discardableResult
    func placeholder(_ text: String?) -> Self {
        placeholder = text
        return self
    }
    
    // MARK: 2.4、设置富文本占位符
    /// 设置富文本占位符
    /// - Parameter text: 富文本占位符
    /// - Returns: 返回自身
    @discardableResult
    func attributedPlaceholder(_ text: NSAttributedString?) -> Self {
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
    ///   - isRemovePasteboardNewlineCharacters: 复制的内容是否移除前后的换行符
    ///   - isMarkedTextRangeCanInput: 高亮状态，原始数据如果小于限制字数，默认不可以继续输入
    /// - Returns: 返回是否可输入
    ///
    /// 提示：注入想要处理复制的内容：使用的UITextField继承JKPastedTextField，也可以自己按照我的这种方式自己个性化处理
    func inputRestrictions(shouldChangeTextIn range: NSRange, replacementText text: String, maxCharacters: Int, regex: String?, isInterceptString: Bool = true, lenghType: StringTypeLength = .count, isRemovePasteboardNewlineCharacters: Bool = false, isMarkedTextRangeCanInput: Bool = false) -> Bool {
        guard !text.isEmpty else {
            return true
        }
        guard let oldContent = self.base.text else {
            return false
        }
        // 输入新的内容
        var inputingContent = text
        if let pastedTextField = self.base as? JKPastedTextField, isRemovePasteboardNewlineCharacters, pastedTextField.isPasting {
            // 复制内容，只处理前后的空格和换行
            inputingContent = inputingContent.jk.removeAllLineAndSapcefeed
            pastedTextField.isPasting = false
            if let weakRegex = regex, !JKRegexHelper.match(inputingContent, pattern: weakRegex) {
                return false
            }
            let remainingLength = maxCharacters - oldContent.jk.typeLengh(lenghType)
            // 可以插入字符串
            let endString = getInputText(inputingContent: inputingContent, remainingLength: remainingLength, lenghType: lenghType)
            let newString = oldContent.jk.insertString(content: endString, locat: range.location)
            self.base.text = newString
            self.base.sendActions(for: .editingChanged)
            // 异步改变
            JKAsyncs.asyncDelay(0.1) {} _: {
                let endPosition = self.base.position(from: self.base.beginningOfDocument, offset: range.location + endString.count)
                if let endPosition = endPosition {
                    self.base.selectedTextRange = self.base.textRange(from: endPosition, to: endPosition)
                }
            }
            return false
        }
        
        if let markedTextRange = self.base.markedTextRange {
            // 有高亮
            if range.length == 0 {
                let oldContentLength = oldContent.jk.typeLengh(lenghType)
                if isMarkedTextRangeCanInput {
                    let markedRange = rangeFromTextRange(textRange: markedTextRange)
                    let markedRangeContent = oldContent.jk.replacingCharacters(range: markedRange)
                    if markedRangeContent.jk.typeLengh(lenghType) < maxCharacters{
                        return true
                    }
                }
                // 联想中
                return oldContentLength + 1 <= maxCharacters
            } else {
                // 正则的判断
                if let weakRegex = regex, !JKRegexHelper.match(inputingContent, pattern: weakRegex) {
                    return false
                }
                let markedRange = rangeFromTextRange(textRange: markedTextRange)
                let markedRangeString = oldContent.jk.replacingCharacters(range: markedRange)
                // 联想选中键盘
                let allContent = markedRangeString + inputingContent
                if allContent.jk.typeLengh(lenghType) > maxCharacters {
                    let remainingLength = maxCharacters - markedRangeString.jk.typeLengh(lenghType)
                    // 在此就需要遍历要输入的内容
                    let endString: String = getInputText(inputingContent: inputingContent, remainingLength: remainingLength, lenghType: lenghType)
                    let newContent = markedRangeString + endString
                    // debugPrint("content1：\(allContent) content2：\(newContent)")
                    self.base.text = newContent
                    self.base.sendActions(for: .editingChanged)
                    return false
                }
            }
        } else {
            guard !inputingContent.jk.isNineKeyBoard() else {
                return oldContent.jk.typeLengh(lenghType) - getSelectedRangeLength(lenghType: lenghType) < maxCharacters
            }
            // 正则的判断
            if let weakRegex = regex, !JKRegexHelper.match(inputingContent, pattern: weakRegex) {
                return false
            }
            // 2、如果数字大于指定位数，不能输入
            guard oldContent.jk.typeLengh(lenghType) + inputingContent.jk.typeLengh(lenghType) - getSelectedRangeLength(lenghType: lenghType) <= maxCharacters else {
                // 判断字符串是否要截取
                guard isInterceptString else {
                    // 不截取，也就是不让输入进去
                    return false
                }
                let oldLength = oldContent.jk.typeLengh(lenghType)
                if oldLength < maxCharacters, (maxCharacters - oldLength) > 0 {
                    let remainingLength = maxCharacters - oldLength
                    let copyString = inputingContent.jk.removeBeginEndAllSapcefeed
                    // debugPrint("范围：\(range) copy的字符串：\(copyString) 长度：\(copyString.count)  截取的字符串：\(copyString.jk.sub(to: remainingLength))")
                    // 可以插入字符串
                    let replaceContent = copyString.jk.sub(to: remainingLength)
                    // let newString = oldContent.jk.insertString(content: replaceContent), locat: range.location)
                    let newString = oldContent.jk.replacingCharacters(range: range, replacingString: replaceContent)
                    // debugPrint("老的字符串：\(oldContent) 新的的字符串：\(newString) 长度：\(newString.count)")
                    self.base.text = newString
                    self.base.sendActions(for: .editingChanged)
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
    
    private func getInputText(inputingContent: String, remainingLength: Int, lenghType: StringTypeLength) -> String {
        // 在此就需要遍历要输入的内容
        var count = 0
        var endString: String = ""
        if lenghType == .customCountOfChars {
            for character in inputingContent {
                var cLength = 0
                if ("\(character)".jk.containsEmoji()) {
                    count += 1
                    cLength = 1
                } else {
                    count += 2
                    cLength = 2
                }
                if (endString.jk.typeLengh(lenghType) + cLength) > remainingLength {
                    break
                }
                endString = endString + "\(character)"
            }
        } else {
            // containsEmoji
            for character in inputingContent {
                let cLength = "\(character)".jk.typeLengh(lenghType)
                if (endString.jk.typeLengh(lenghType) + cLength) > remainingLength {
                    break
                }
                endString = endString + "\(character)"
            }
        }
        return endString
    }
    
    /// UITextRange 转 NSRange
    /// - Parameter textRange: UITextRange对象
    /// - Returns: NSRange
    private func rangeFromTextRange(textRange: UITextRange) -> NSRange {
        let location: Int = self.base.offset(from: self.base.beginningOfDocument, to: textRange.start)
        let length: Int = self.base.offset(from: textRange.start, to: textRange.end)
        return NSMakeRange(location, length)
    }
    
    /// 获取选中内容的长度
    /// - Parameter lenghType: 字符串取类型的长度
    /// - Returns: 长度
    private func getSelectedRangeLength(lenghType: StringTypeLength) -> Int {
        guard let weakSelectedTextRange = self.base.selectedTextRange else { return 0 }
        // 获取选定的文本
        guard let selectedTextRangeText = self.base.text(in: weakSelectedTextRange) else { return 0 }
        // 获取选中文字的内容长度
        let selectedRangeLength = selectedTextRangeText.jk.typeLengh(lenghType)
        // debugPrint("选中的长度：\(selectedRangeLength) 选中的内容：\(selectedTextRangeText)")
        return selectedRangeLength
    }
}
