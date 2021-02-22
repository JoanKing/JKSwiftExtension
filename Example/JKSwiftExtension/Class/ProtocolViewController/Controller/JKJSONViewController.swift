//
//  JKJSONViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/2/22.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

//用户类
class User: JKJSON {
    /// 姓名
    var name: String = ""
    /// 昵称
    var nickname: String?
    /// 年龄
    var age: Int?
    /// 邮件地址
    var emails: [String]?
    /// 电话
    var tels: [Telephone]?
    /// 创建时间
    var createTime: Date = Date()
}
 
//电话结构体
struct Telephone: JKJSON {
    /// 电话标题
    var title: String
    /// 电话号码
    var number: String
}
class JKJSONViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "签名"
        self.view.backgroundColor = .white

        // 创建一个User实例对象
        let user1 = User()
        user1.name = "hangge"
        user1.age = 100
        user1.emails = ["hangge@hangge.com","system@hangge.com"]
        // 添加动画
        let tel1 = Telephone(title: "手机", number: "123456")
        let tel2 = Telephone(title: "公司座机", number: "001-0358")
        user1.tels = [tel1, tel2]
         
        // 输出json字符串
        print(user1.toJSONString()!)
    }
}
