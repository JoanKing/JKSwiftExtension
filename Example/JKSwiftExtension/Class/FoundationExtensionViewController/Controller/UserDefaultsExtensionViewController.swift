//
//  UserDefaultsExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

struct PersonItem: Codable {
    var name: String?
    var age: String?
    var height: String?
    
    //区别 可以将字典中`Name`的值解析到`name`
    fileprivate enum CodingKeys: String, CodingKey {
        case name = "Name"
        case age
        case height
    }
}

class UserDefaultsExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展", "二、模型持久化（复杂类型）"]
        dataArray = [["存值", "取值"], ["存储模型", "取出模型"]]
    }

}
// MARK:- 二、模型持久化（复杂类型）
extension UserDefaultsExtensionViewController {
    
    // MARK: 2.3
    @objc func test23() {
        
     
    }
    
    // MARK: 2.2、取出模型
    @objc func test22() {
        
        guard let person =  UserDefaults.jk.getItem(PersonItem.self, forKey: "plistData") else {
            return
        }
        JKPrint("有内容：", "名字：\(person.name ?? "")", "年龄：\(person.age ?? "")", "身高：\(person.height ?? "")")
        
    }
    
    // MARK: 2.1、存储模型
    @objc func test21() {
        let  filePath: String? = Bundle.main.path(forResource: "", ofType: "plist")
        guard let plistData = NSDictionary(contentsOfFile: filePath ?? "") else {
            return
        }
        
        let person = PersonItem(name: (plistData["Name"] as! String), age: (plistData["age"] as! String), height: (plistData["height"] as! String))
        UserDefaults.jk.setItem(person, forKey: "plistData")
    }
}
// MARK:- 一、基本的扩展
extension UserDefaultsExtensionViewController {
    
    // MARK: 1.1、存值
    @objc func test11() {
        let isSuccess = UserDefaults.jk.userDefaultsSetValue(value: "我是小可爱", key: "a")
        if isSuccess {
            JKPrint("存值成功")
        } else {
            JKPrint("存值失败")
        }
    }
    
    // MARK: 1.2、取值
    @objc func test12() {
        guard let value = UserDefaults.jk.userDefaultsGetValue(key: "a") else {
            return
        }
        JKPrint("存值成功：\(value)")
    }
}
