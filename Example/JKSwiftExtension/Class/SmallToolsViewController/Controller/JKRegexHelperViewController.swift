//
//  JKRegexHelperViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/1/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class JKRegexHelperViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的使用"]
        dataArray = [["通用匹配", "验证邮箱是否合法", "判断是否是有效的手机号码", "正则匹配用户姓名", "正则匹配用户身份证号15或18位"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 一、基本的使用
extension JKRegexHelperViewController {
    
    // MARK: 1.5、正则匹配用户身份证号15或18位
    @objc func test15() {
        let userCard = "422423199202026035"
        JKPrint("正则匹配用户身份证号15或18位", "身份证号：\(userCard) 是不是身份证号：\(JKRegexHelper.validateUserIdCard(userCard))")
    }
    
    // MARK: 1.4、正则匹配用户姓名
    @objc func test14() {
        let name = "##"
        JKPrint("正则匹配用户姓名", "姓名：\(name) 是不是姓名：\(JKRegexHelper.validateUserName(name))")
    }
    
    // MARK: 1.3、判断是否是有效的手机号码
    @objc func test13() {
        let phoneNumber = "18500652889"
        let result = JKRegexHelper.validateTelephoneNumber(phoneNumber)
        JKPrint("手机号：\(phoneNumber) 是否是有效的手机号码：\(result)")
    }
    
    // MARK: 1.2、验证邮箱是否合法
    @objc func test12() {
        let maybeMailAddress = "jkironman@163.com"
        let result = JKRegexHelper.validateEmail(maybeMailAddress)
        JKPrint("邮箱：\(maybeMailAddress) 是否是有效的邮箱地址：\(result)")
    }
    
    // MARK: 1.1、通用匹配
    @objc func test11() {
        let maybeMailAddress = "jkironman@163.com"
        let pattern = "^([a-z0-9A-Z]+[-_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$"
        let result = JKRegexHelper.match(maybeMailAddress, pattern: pattern)
        JKPrint("通用匹配", "有效的邮箱地址：\(result)")
    }
}

