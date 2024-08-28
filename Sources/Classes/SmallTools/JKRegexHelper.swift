//
//  JKRegexHelper.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/4.
//

import Foundation
// MARK: - 校验字符的表达式
public enum JKRegexCharacterType: String {
    /// 汉字
    case type1 = "^[\\u4e00-\\u9fa5]{0,}$"
    /// 英文和数字 ^[A-Za-z0-9]+$ 或 ^[A-Za-z0-9]{4,40}$
    case type2 = "^[A-Za-z0-9]{4,40}$"
    /// 长度为3-20的所有字符
    case type3 = "^.{3,20}$"
    /// 由26个英文字母组成的字符串
    case type4 = "^[A-Za-z]+$"
    /// 由26个大写英文字母组成的字符串
    case type5 = "^[A-Z]+$"
    /// 由26个小写英文字母组成的字符串
    case type6 = "^[a-z]+$"
    /// 由数字和26个英文字母组成的字符串
    case type7 = "^[A-Za-z0-9]+$"
    /// 由数字、26个英文字母或者下划线组成的字符串 ^\w+$ 或 ^\w{3,20}$
    case type8 = "^\\w+$"
    /// 中文、英文、数字包括下划线
    case type9 = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
    /// 中文、英文、数字但不包括下划线等符号 ^[\u4E00-\u9FA5A-Za-z0-9]+$ 或 ^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$
    case type10 = "^[\\u4E00-\\u9FA5A-Za-z0-9]+$"
    /// 可以输入含有^%&',;=?$\"等字符
    case type11 = "[^%&',;=?$\\x22]+"
    /// 禁止输入含有~的字符
    case type12 = "[^~\\x22]+"
    /// 字符串开头和结尾都是数字，中间可以包含数字和小数点，最多有2个小数点(判断app版本号的时候使用)
    case type13 = "^[0-9]+(\\.[0-9]+){0,2}$"
}

// MARK: - 校验数字的表达式
public enum JKRegexDigitalType: String {
    /// 数字
    case type1 = "^[0-9]*$"
    /// 零和非零开头的数字
    case type2 = "^(0|[1-9][0-9]*)$"
    /// 非零开头的最多带两位小数的数字
    case type3 = "^([1-9][0-9]*)+(\\.[0-9]{1,2})?$"
    /// 非零的正整数：^[1-9]\d*$ 或 ^([1-9][0-9]*){1,3}$ 或 ^\+?[1-9][0-9]*$
    case type4 = "^[1-9]\\d*$"
    /// 非零的负整数：^\-[1-9][]0-9"*$ 或 ^-[1-9]\d*$
    case type5 = "^-[1-9]\\d*$"
    /// 非负整数：^\d+$ 或 ^[1-9]\d*|0$
    case type6 = "^\\d+$"
    /// 非正整数：^-[1-9]\d*|0$ 或 ^((-\d+)|(0+))$
    case type7 = "^((-\\d+)|(0+))$"
    /// 非负浮点数：^\d+(\.\d+)?$ 或 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$
    case type8 = "^\\d+(\\.\\d+)?$"
    /// 非正浮点数：^((-\d+(\.\d+)?)|(0+(\.0+)?))$ 或 ^(-([1-9]\d*\.\d*|0\.\d*[1-9]\d*))|0?\.0+|0$
    case type9 = "^((-\\d+(\\.\\d+)?)|(0+(\\.0+)?))$"
    /// 正浮点数：^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$ 或 ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
    case type10 = "^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$"
    /// 负浮点数：^-([1-9]\d*\.\d*|0\.\d*[1-9]\d*)$ 或 ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$
    case type11 = "^-([1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*)$"
    /// 浮点数：^(-?\d+)(\.\d+)?$ 或 ^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$
    case type12 = "^(-?\\d+)(\\.\\d+)?$"
    /// 手机号
    case type13 = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199)\\d{8}$"
}

// MARK: - 一、正则匹配的使用
public struct JKRegexHelper {

    // MARK: 1.1、通用匹配
    /// 通用匹配
    /// - Parameters:
    ///   - input: 匹配的字符串
    ///   - pattern: 匹配规则
    /// - Returns: 返回匹配的结果
    public static func match(_ input: String, pattern: String, options: NSRegularExpression.Options = []) -> Bool {
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: options) else {
            return false
        }
        let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
    
    // MARK: 1.2、获取匹配的Range
    /// 获取匹配的Range
    /// - Parameters:
    ///   - input: 匹配的字符串
    ///   - pattern: 匹配规则
    /// - Returns: 返回匹配的[NSRange]结果
    public static func matchRange(_ input: String, pattern: String, options: NSRegularExpression.Options = []) -> [NSRange] {
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: options) else {
            return []
        }
        let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.utf16.count))
        guard matches.count > 0 else {
            return []
        }
        return matches.map { value in
            value.range
        }
    }
    
    // MARK: 1.3、验证邮箱是否合法
    /// 验证邮箱是否合法
    /// - Parameters:
    ///   - emailString: 邮箱
    ///   - pattern: 匹配规则
    /// - Returns: 返回结果
    public static func validateEmail(_ emailString: String, pattern: String = "^([a-z0-9A-Z]+[-_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$") -> Bool {
        return match(emailString, pattern: pattern)
    }
    
    // MARK: 1.4、 判断是否是有效的手机号码
    ///  判断是否是有效的手机号码
    /// - Parameter telNum: 手机号码
    /// - Returns: 返回结果
    public static func validateTelephoneNumber(_ telNum: String, pattern: String = JKRegexDigitalType.type13.rawValue) -> Bool {
        return match(telNum, pattern: pattern)
    }
    
    // MARK: 1.5、正则匹配用户姓名
    /// 正则匹配用户姓名
    /// - Parameter userName: 用户姓名
    /// - Returns: 匹配结果
    public static func validateUserName(_ userName: String) -> Bool {
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch: Bool = pred.evaluate(with: userName)
        return isMatch
    }
    
    // MARK: 1.6、正则匹配用户身份证号15或18位
    /// 正则匹配用户身份证号15或18位
    /// - Parameter userIdCard: 用户身份证号15或18位
    /// - Returns: 匹配结果
    public static func validateUserIdCard(_ userIdCard: String) -> Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch: Bool = pred.evaluate(with: userIdCard)
        return isMatch
    }
    
    // MARK: 1.7、正则匹配结果
    /// 正则匹配结果
    /// - Parameters:
    ///   - content: 内容
    ///   - pattern: 正则表达式
    ///   - options: Options
    /// - Returns: 结果
    public static func matchesResult(content: String, pattern: String, options: NSRegularExpression.Options = []) -> [NSTextCheckingResult] {
        
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: options) else {
            return []
        }
        return regex.matches(in: content, options: [], range: NSMakeRange(0, content.utf16.count))
    }
}
