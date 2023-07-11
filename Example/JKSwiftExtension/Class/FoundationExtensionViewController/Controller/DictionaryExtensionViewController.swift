//
//  DictionaryExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/4.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension

class DictionaryExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、其他基本扩展"]
        dataArray = [["检查字典里面是否有某个 key", "检验 Dictionary 中是否存在某个key的值", "字典的key或者value组成的数组", "JSON字符串 -> 字典", "字典 -> JSON字符串", "字典里面所有的 key", "字典里面所有的 value", "设置value1", "设置value2", "获取value"], ["字典转JSON"]]
    }
    
}

// MARK: - 二、其他基本扩展
extension DictionaryExtensionViewController {
    
    // MARK: 2.1、字典转JSON
    @objc func test21() {
        let dictionary: Dictionary<String, Any> = ["b": "2", "a": "1"]
        JKPrint("字典转JSON", "字典：\(dictionary) 转JSON为：\(dictionary.jk.dictionaryToJson() ?? "无法解析")")
    }
}

// MARK: - 一、基本的扩展
extension DictionaryExtensionViewController {
    
    // MARK: 1.9、设置value
    @objc func test19() {
        var japan: [String: Any] = [
            "name": "Japan",
            "capital": "Tokyo",
            "population": 126_740_000,
            "coordinates": [
                "latitude": 35.0,
                "longitude": 139.0,
                "names": [
                    "A": "a",
                    "B": "b"
                ]
            ] as [String : Any]
        ]
        // 优化后
        japan.setValue(keys: ["capital"], newValue: "我是修改过的：capital")
        japan.setValue(keys: ["coordinates", "latitude"], newValue: "我是修改过的：latitude")
        japan.setValue(keys: ["coordinates", "names", "A"], newValue: "我是修改过的A")
        JKPrint(japan)
    }
    
    // MARK: 1.8、设置value
    @objc func test18() {
        var japan: [String: Any] = [
            "name": "Japan",
            "capital": "Tokyo",
            "population": 126_740_000,
            "coordinates": [
                "latitude": 35.0,
                "longitude": 139.0,
                "names": [
                    "A": "a",
                    "B": "b"
                ]
            ] as [String : Any]
        ]
        // 优化后
        japan["coordinates", as: [String: Any].self]?["names", as: [String: Any].self]?["A"] = "我是修改过的A"
        JKPrint(japan)
    }
    
    // MARK: 1.7、字典里面所有的 values
    @objc func test17() {
        let dictionary = ["b": "2", "a": "1"]
        JKPrint("字典里面所有的 values", "字典：\(dictionary) 的所有values为：\(dictionary.allValues())")
    }
    
    // MARK: 1.6、字典里面所有的 key
    @objc func test16() {
        let dictionary = ["b": "2", "a": "1"]
        JKPrint("字典里面所有的 keys", "字典：\(dictionary) 的所有keys为：\(dictionary.allKeys())")
    }
    
    // MARK: 1.5、字典 -> JSON字符串
    @objc func test15() {
        let dictionary = ["a": "1", "b": "2"]
        guard let json = dictionary.toJSON() else {
            return
        }
        JKPrint("字典 -> JSON字符串", "字典：\(dictionary) 转JSON字符串后为：\(json)")
    }
    
    // MARK: 1.4、JSON字符串 -> 字典
    @objc func test14() {
        let dictionary = ["a": "1", "b": "2"]
        guard let json = dictionary.toJSON(), let newDictionary = json.jk.jsonStringToDictionary() else {
            return
        }
        JKPrint("JSON字符串 -> 字典", "JSON字符串：\(json) 转为字典为：\(newDictionary)")
    }
    
    // MARK: 1.3、字典的key或者value组成的数组
    @objc func test13() {
        let dictionary = ["a": "1", "b": "2"]
        let array = dictionary.toArray { (key, value) -> String in
            return key
        }
        JKPrint("字典的key或者value组成的数组", "字典 \(dictionary) 的key组成的数组是：\(array)")
    }
    
    // MARK: 1.2、检验 Dictionary 中是否存在某个key的值
    @objc func test12() {
        var japan: [String: Any] = [
            "name": "Japan",
            "capital": "Tokyo",
            "population": 126_740_000,
            "coordinates": [
                "latitude": 35.0,
                "longitude": 139.0,
                "names": [
                    "A": "a",
                    "B": "b"
                ]
            ] as [String : Any]
        ]
        let key = "coordinates"
        let value = japan.hasValue(key: key)
        debugPrint("检验 Dictionary 中是否存在某个key的值：\(value)")
    }
    
    // MARK: 1.1、检查字典里面是否有某个 key
    @objc func test11() {
        let dictionary = ["a": "1", "b": "2"]
        let key = "c"
        JKPrint("检查字典里面是否有某个 key", "检查字典\(dictionary) 里面有没有键：\(key) ，结果是：\(dictionary.has(key))")
    }
}
