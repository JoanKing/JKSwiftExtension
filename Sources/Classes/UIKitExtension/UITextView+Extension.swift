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
                // 联想选中键盘
                let markedRange = rangeFromTextRange(textRange: markedTextRange)
                // 联想选中键盘
                let allContent = oldContent.jk.replacingCharacters(range: markedRange) + text
                if allContent.count > maxCharacters  {
                    let newContent = allContent.jk.sub(to: maxCharacters)
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
            // print("没有range---------：NO 内容：\(oldContent) 长度：\(oldContent.count) 新的内容：\(text) 长度：\(text.count) range：\(range)")
            // 2、如果数字大于指定位数，不能输入
            guard oldContent.count + text.count <= maxCharacters else {
                // 判断字符串是否要截取
                guard isInterceptString else {
                    // 不截取，也就是不让输入进去
                    return false
                }
                if oldContent.count < maxCharacters {
                    let remainingLength = maxCharacters - oldContent.count
                    let copyString = text.jk.removeBeginEndAllSapcefeed
                    // print("范围：\(range) copy的字符串：\(copyString) 长度：\(copyString.count)  截取的字符串：\(copyString.jk.sub(to: remainingLength))")
                    // 可以插入字符串
                    let replaceContent = copyString.jk.sub(to: remainingLength)
                    // let newString = oldContent.jk.insertString(content: replaceContent, locat: range.location)
                    let newString = oldContent.jk.replacingCharacters(range: range, replacingString: replaceContent)
                    // print("老的字符串：\(oldContent) 新的的字符串：\(newString) 长度：\(newString.count)")
                    self.base.text = newString
                    // 异步改变
                    JKAsyncs.asyncDelay(0.05) {} _: {
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
