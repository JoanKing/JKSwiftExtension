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
        dataArray = [["通用匹配", "获取匹配的Range", "验证邮箱是否合法", "判断是否是有效的手机号码", "正则匹配用户姓名", "正则匹配用户身份证号15或18位", "正则匹配结果"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、基本的使用
extension JKRegexHelperViewController {
    
    // MARK: 1.07、正则匹配结果
    @objc func test107() {
        let content = "门前大桥1下，游过一群鸭，数1个一二三四五，二四六七八"
        JKPrint("内容：\(content) 正则匹配结果：\(JKRegexHelper.matchesResult(content: content, pattern: "1"))")
    }

    // MARK: 1.06、正则匹配用户身份证号15或18位
    @objc func test106() {
        let userCard = "422423199202026035"
        JKPrint("正则匹配用户身份证号15或18位", "身份证号：\(userCard) 是不是身份证号：\(JKRegexHelper.validateUserIdCard(userCard))")
    }
    
    // MARK: 1.05、正则匹配用户姓名
    @objc func test105() {
        let name = "##"
        JKPrint("正则匹配用户姓名", "姓名：\(name) 是不是姓名：\(JKRegexHelper.validateUserName(name))")
    }
    
    // MARK: 1.04、判断是否是有效的手机号码
    @objc func test104() {
        let phoneNumber = "18500652889"
        let result = JKRegexHelper.validateTelephoneNumber(phoneNumber)
        JKPrint("手机号：\(phoneNumber) 是否是有效的手机号码：\(result)")
    }
    
    // MARK: 1.03、验证邮箱是否合法
    @objc func test103() {
        // "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{8,20}$"
        let maybeMailAddress = "jkironman@163.com"
        let result = JKRegexHelper.validateEmail(maybeMailAddress)
        JKPrint("邮箱：\(maybeMailAddress) 是否是有效的邮箱地址：\(result)")
    }
    
    // MARK: 1.02、获取匹配的Rangex
    @objc func test102() {
        let maybeMailAddress = "我是一只小小鸟，不停滴飞，飞呀飞，小鸟"
        let pattern = "飞"
        let result = JKRegexHelper.matchRange(maybeMailAddress, pattern: pattern)
        JKPrint("获取匹配的Range", "获取匹配的Range：\(result)")
    }
    
    // MARK: 1.01、通用匹配
    @objc func test101() {
        let versions = ["0.0.1", "0.9", "1.0.1", "2.0.1", "3.A", "5.6", "我.是", "1.0.0", "0.8.0", ".0.0.08", "1.0.08"]
        var resultString = ""
        for items in versions {
            let result = JKRegexHelper.match(items, pattern: JKRegexCharacterType.type13.rawValue)
            resultString = resultString + "\n\(items) 是否符合校验：\(result)"
        }
        JKPrint(resultString)
        JKPrint("字符串开头和结尾都是数字，中间可以包含数字和小数点(判断app版本号的时候使用)", "\(resultString)")
    }
}

