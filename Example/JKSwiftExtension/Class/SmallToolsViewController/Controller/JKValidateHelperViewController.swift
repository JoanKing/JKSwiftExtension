//
//  JKValidateHelperViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKValidateHelperViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、正则匹配"]
        dataArray = [["正则匹配用户手机号", "正则匹配用户姓名", "正则匹配用户身份证号15或18位"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 一、正则匹配
extension JKValidateHelperViewController {
    
    // MARK: 1.3、正则匹配用户身份证号15或18位
    @objc func test13() {
        let userCard = "422423199202026035"
        JKPrint("正则匹配用户身份证号15或18位", "身份证号：\(userCard) 是不是身份证号：\(JKValidateHelper.validateUserIdCard(userCard))")
    }
    
    // MARK: 1.2、正则匹配用户姓名
    @objc func test12() {
        let name = "##"
        JKPrint("正则匹配用户姓名", "姓名：\(name) 是不是姓名：\(JKValidateHelper.validateUserName(name))")
    }
    
    // MARK: 1.1、正则匹配用户手机号
    @objc func test11() {
        let phoneNumber = "18500652880"
        JKPrint("正则匹配用户手机号", "号码：\(phoneNumber) 是不是手机号：\(JKValidateHelper.validateUserMobile(phoneNumber))")
    }
}
