//
//  JKRegexHelper.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/4.
//

import Foundation
// MARK:- 一、正则匹配的使用
public struct JKRegexHelper {

    // MARK: 1.1、通用匹配
    /// 通用匹配
    /// - Parameters:
    ///   - input: 匹配的字符串
    ///   - pattern: 匹配规则
    /// - Returns: 返回匹配的结果
    public static func match(_ input: String, pattern: String) -> Bool {
        let regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern,
                    options: .caseInsensitive)
        } catch _ {
            return false
        }
        let matches = regex.matches(in: input,
                               options: [],
                                 range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
    
    // MARK: 1.2、验证邮箱是否合法
    /// 验证邮箱是否合法
    /// - Parameters:
    ///   - emailString: 邮箱
    ///   - pattern: 匹配规则
    /// - Returns: 返回结果
    public static func validateEmail(_ emailString: String, pattern: String = "^([a-z0-9A-Z]+[-_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$") -> Bool {
        return match(emailString, pattern: pattern)
    }
    
    // MARK: 1.3、 判断是否是有效的手机号码
    ///  判断是否是有效的手机号码
    /// - Parameter telNum: 手机号码
    /// - Returns: 返回结果
    public static func validateTelephoneNumber(_ telNum: String, pattern: String = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199)\\d{8}$") -> Bool {
        // let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return match(telNum, pattern: pattern)
    }
}
