//
//  JKValidateHelper.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/29.
//

import UIKit

class JKValidateHelper: NSObject {
    
    // MARK: - 正则匹配用户手机号
    class func validateUserMobile(_ userMobile: String) -> Bool {
        let pattern = "^(13[0-9]|14[579]|15[0-3,5-9]|17[0135678]|18[0-9])\\d{8}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch: Bool = pred.evaluate(with: userMobile)
        return isMatch
    }
    
    // MARK: - 正则匹配用户姓名
    class func validateUserName(_ userName: String) -> Bool {
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch: Bool = pred.evaluate(with: userName)
        return isMatch
    }
    
    // MARK: - 正则匹配用户身份证号15或18位
    class func validateUserIdCard(_ userIdCard: String) -> Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch: Bool = pred.evaluate(with: userIdCard)
        return isMatch
    }
}
