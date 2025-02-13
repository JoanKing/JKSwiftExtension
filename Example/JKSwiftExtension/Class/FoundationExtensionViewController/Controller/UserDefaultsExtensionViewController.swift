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
        dataArray = [["存值", "取值", "移除单个key存储的值", "移除包含某个key存储的值", "移除所有值"], ["存储模型", "取出模型", "保存模型数组", "读取模型数组"]]
    }
    
}
// MARK: - 二、模型持久化（复杂类型）
extension UserDefaultsExtensionViewController {
    
    //MARK: 2.04、读取模型数组
    @objc func test204() {
        let models: [UserDefaultsModel] = UserDefaults.jk.getModelArray(forKey: "GoRideHistory")
        for item in models {
            debugPrint("uid：\(item.uid) name：\(item.name)")
        }
    }
    //MARK: 2.03、保存模型数组
    @objc func test203() {
        let model1 = UserDefaultsModel(uid: 1, name: "A")
        let model2 = UserDefaultsModel(uid: 2, name: "B")
        let model3 = UserDefaultsModel(uid: 3, name: "C")
        UserDefaults.jk.setModelArray(modelArrry: [model1, model2, model3], key: "GoRideHistory")
    }
    
    // MARK: 2.02、取出模型
    @objc func test202() {
        
        guard let person =  UserDefaults.jk.getItem(PersonItem.self, forKey: "plistData") else {
            return
        }
        JKPrint("有内容：", "名字：\(person.name ?? "")", "年龄：\(person.age ?? "")", "身高：\(person.height ?? "")")
        
    }
    
    // MARK: 2.01、存储模型
    @objc func test201() {
        let person = PersonItem(name: "大帅", age: "19", height: "1.78")
        UserDefaults.jk.setItem(person, forKey: "plistData")
    }
}
// MARK: - 一、基本的扩展
extension UserDefaultsExtensionViewController {
    
    // MARK: 1.05、移除所有值
    @objc func test105() {
        UserDefaults.jk.removeAllKeyValue()
    }
    
    // MARK: 1.04、移除包含某个key存储的值
    @objc func test104() {
        UserDefaults.jk.userDefaultsSetValue(value: "1", key: "1_key_test")
        UserDefaults.jk.userDefaultsSetValue(value: "2", key: "2_key_test")
        UserDefaults.jk.userDefaultsSetValue(value: "3", key: "3_key_tes")
        JKAsyncs.asyncDelay(3) {
            debugPrint("异步------")
        } _: {
            UserDefaults.jk.removeContainKey("_key_test")
        }
    }
    
    // MARK: 1.03、移除单个key存储的值
    @objc func test103() {
        UserDefaults.jk.remove("a")
    }
    
    // MARK: 1.02、取值
    @objc func test102() {
        guard let value = UserDefaults.jk.userDefaultsGetValue(key: "a") else {
            return
        }
        JKPrint("存值成功：\(value)")
    }
    
    // MARK: 1.01、存值
    @objc func test101() {
        let isSuccess = UserDefaults.jk.userDefaultsSetValue(value: "我是小可爱", key: "a")
        if isSuccess {
            JKPrint("存值成功")
        } else {
            JKPrint("存值失败")
        }
    }
}
