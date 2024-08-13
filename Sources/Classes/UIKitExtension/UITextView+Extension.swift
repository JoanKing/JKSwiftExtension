//
//  UITextView+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

// MARK: - 一、基本的扩展
public extension UITextView {
    
}

// MARK: - 二、文本链接的扩展
public extension JKPOP where Base: UITextView {
    
    // MARK: 2.1、添加链接文本（链接为空时则表示普通文本）
    /// 添加链接文本（链接为空时则表示普通文本）
    /// - Parameters:
    ///   - string: 文本
    ///   - withURLString: 链接
    func appendLinkString(string: String, font: UIFont, withURLString: String = "") {
        // 原来的文本内容
        let attrString: NSMutableAttributedString = NSMutableAttributedString()
        attrString.append(self.base.attributedText)
        
        // 新增的文本内容（使用默认设置的字体样式）
        let attrs = [NSAttributedString.Key.font: font]
        let appendString = NSMutableAttributedString(string: string, attributes:attrs)
        // 判断是否是链接文字
        if withURLString != "" {
            let range:NSRange = NSMakeRange(0, appendString.length)
            appendString.beginEditing()
            appendString.addAttribute(NSAttributedString.Key.link, value:withURLString, range:range)
            appendString.endEditing()
        }
        // 合并新的文本
        attrString.append(appendString)
        // 设置合并后的文本
        self.base.attributedText = attrString
    }
    
    // MARK: 2.2、转换特殊符号标签字段
    /// 转换特殊符号标签字段
    func resolveHashTags() {
        let nsText: NSString = self.base.text! as NSString
        // 使用默认设置的字体样式
        let attrs = [NSAttributedString.Key.font : self.base.font!]
        let attrString = NSMutableAttributedString(string: nsText as String, attributes:attrs)
        
        //用来记录遍历字符串的索引位置
        var bookmark = 0
        //用于拆分的特殊符号
        let charactersSet = CharacterSet(charactersIn: "@#")
        
        //先将字符串按空格和分隔符拆分
        let sentences: [String] = self.base.text.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        
        for sentence in sentences {
            // 如果是url链接则跳过
            if !(sentence as String).jk.verifyUrl() {
                // 再按特殊符号拆分
                let words: [String] = sentence.components(separatedBy: charactersSet)
                var bookmark2 = bookmark
                for i in 0..<words.count {
                    let word = words[i]
                    let keyword = chopOffNonAlphaNumericCharacters(word as String)
                    if keyword != "" && i > 0 {
                        // 使用自定义的scheme来表示各种特殊链接，比如：mention:hangge
                        // 使得这些字段会变蓝色且可点击
                        // 匹配的范围
                        let remainingRangeLength = min((nsText.length - bookmark2 + 1), word.count + 2)
                        let remainingRange = NSRange(location: bookmark2 - 1, length: remainingRangeLength)
                        // print(keyword, bookmark2, remainingRangeLength)
                        // 获取转码后的关键字，用于url里的值
                        //（确保链接的正确性，比如url链接直接用中文就会有问题）
                        let encodeKeyword = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                        // 匹配@某人
                        var matchRange = nsText.range(of: "@\(keyword)", options: .literal, range: remainingRange)
                        attrString.addAttribute(NSAttributedString.Key.link, value: "test1:\(encodeKeyword)", range: matchRange)
                        // 匹配#话题#
                        matchRange = nsText.range(of: "#\(keyword)#", options: .literal, range:remainingRange)
                        attrString.addAttribute(NSAttributedString.Key.link, value: "test2:\(encodeKeyword)", range: matchRange)
                        // attrString.addAttributes([NSAttributedString.Key.link : "test2:\(encodeKeyword)"], range: matchRange)
                    }
                    // 移动坐标索引记录
                    bookmark2 += word.count + 1
                }
            }
            // 移动坐标索引记录
            bookmark += sentence.count + 1
        }
        // print(nsText.length, bookmark)
        // 最终赋值
        self.base.attributedText = attrString
    }
    
    /// 过滤部多余的非数字和字符的部分
    /// - Parameter text: @hangge.123 -> @hangge
    /// - Returns: 返回过滤后的字符串
    private func chopOffNonAlphaNumericCharacters(_ text: String) -> String {
        let nonAlphaNumericCharacters = CharacterSet.alphanumerics.inverted
        let characterArray = text.components(separatedBy: nonAlphaNumericCharacters)
        return characterArray[0]
    }
}

// MARK: - 三、输入内容以及正则的配置
public extension JKPOP where Base: UITextView {
    // MARK: 3.1、限制字数的输入(可配置正则)(提示在：- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;方法里面调用)
    /// 限制字数的输入(可配置正则)
    /// - Parameters:
    ///   - range: 范围
    ///   - text: 输入的文字
    ///   - maxCharacters: 限制字数
    ///   - regex: 可输入内容(正则)
    ///   - isInterceptString: 复制文字进来，在字数限制的情况下，多余的字体是否截取掉，默认true
    ///   - isRemovePasteboardNewlineCharacters: 复制的内容是否移除前后的换行符
    ///   - isMarkedTextRangeCanInput: 高亮状态，原始数据如果小于限制 字数，默认不可以继续输入
    /// - Returns: 返回是否可输入
    ///
    /// 提示：注入想要处理复制的内容：使用的UITextView继承JKPastedTextView，也可以自己按照我的这种方式自己个性化处理
    func inputRestrictions(shouldChangeTextIn range: NSRange, replacementText text: String, maxCharacters: Int, regex: String?, isInterceptString: Bool = true, lenghType: StringTypeLength = .count, isRemovePasteboardNewlineCharacters: Bool = false, isMarkedTextRangeCanInput: Bool = false) -> Bool {
        guard !text.isEmpty else {
            return true
        }
        guard let oldContent = self.base.text else {
            return false
        }
        
        // 输入新的内容
        var inputingContent = text
        if let pastedTextView = self.base as? JKPastedTextView, pastedTextView.isPasting, isRemovePasteboardNewlineCharacters {
            // 复制内容，只处理前后的空格和换行
            inputingContent = inputingContent.jk.removeBeginEndAllSapceAndLinefeed
            pastedTextView.isPasting = false
            if let weakRegex = regex, !JKRegexHelper.match(inputingContent, pattern: weakRegex) {
                
                return false
            }
            let remainingLength = maxCharacters - oldContent.jk.typeLengh(lenghType)
            // 可以插入字符串
            let endString = getInputText(inputingContent: inputingContent, remainingLength: remainingLength, lenghType: lenghType)
            let newString = oldContent.jk.insertString(content: endString, locat: range.location)
            self.base.text = newString
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
            // 获取标记的文本
            // let markedText = self.base.text(in: markedTextRange)
            // debugPrint("标记的文本: \(markedText ?? "")")
            // 有高亮
            if range.length == 0 {
                let oldContentLength = oldContent.jk.typeLengh(lenghType)
                if isMarkedTextRangeCanInput {
                    let markedRange = rangeFromTextRange(textRange: markedTextRange)
                    let markedRangeContent = oldContent.jk.replacingCharacters(range: markedRange)
                    if markedRangeContent.jk.typeLengh(lenghType) < maxCharacters {
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
                    // self.base.sendActions(for: .editingChanged)
                    return false
                }
            }
        } else {
            guard !inputingContent.jk.isNineKeyBoard() else {
                return (oldContent.jk.typeLengh(lenghType) - getSelectedRangeLength(lenghType: lenghType)) < maxCharacters
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
    
    func getInputText(inputingContent: String, remainingLength: Int, lenghType: StringTypeLength) -> String {
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
        guard self.base.selectedRange.length > 0 else { return 0 }
        let selectedRangeText = self.base.text as NSString
        // 获取选中文字的内容
        let selectedText = selectedRangeText.substring(with: NSRange(location: self.base.selectedRange.location, length: self.base.selectedRange.length))
        // 获取选中文字的内容长度
        let selectedRangeLength = selectedText.jk.typeLengh(lenghType)
        // debugPrint("选中的长度：\(selectedRangeLength) 选中的内容：\(selectedText)")
        return selectedRangeLength
    }
}
