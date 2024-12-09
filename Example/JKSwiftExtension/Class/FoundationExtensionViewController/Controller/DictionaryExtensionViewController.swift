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
        dataArray = [["检查字典里面是否有某个 key", "检验 Dictionary 中是否存在某个key的值", "字典的key或者value组成的数组", "JSON字符串 -> 字典", "字典 -> JSON字符串", "字典里面所有的 key", "字典里面所有的 value", "设置value1", "设置value2"], ["字典转JSON"]]
    }
    
}

// MARK: - 二、其他基本扩展
extension DictionaryExtensionViewController {
    
    // MARK: 2.01、字典转JSON
    @objc func test201() {
        let dictionary: Dictionary<String, Any> = ["b": "2", "a": "1"]
        JKPrint("字典转JSON", "字典：\(dictionary) 转JSON为：\(dictionary.jk.dictionaryToJson() ?? "无法解析")")
    }
}

// MARK: - 一、基本的扩展
extension DictionaryExtensionViewController {
    
    // MARK: 1.09、设置value
    @objc func test109() {
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
    
    // MARK: 1.08、设置value
    @objc func test108() {
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
    
    // MARK: 1.07、字典里面所有的 values
    @objc func test107() {
        let dictionary = ["b": "2", "a": "1"]
        JKPrint("字典里面所有的 values", "字典：\(dictionary) 的所有values为：\(dictionary.allValues())")
    }
    
    // MARK: 1.06、字典里面所有的 key
    @objc func test106() {
        let dictionary = ["b": "2", "a": "1"]
        JKPrint("字典里面所有的 keys", "字典：\(dictionary) 的所有keys为：\(dictionary.allKeys())")
    }
    
    // MARK: 1.05、字典 -> JSON字符串
    @objc func test105() {
        let dictionary = ["a": "1", "b": "2"]
        guard let json = dictionary.toJSON() else {
            return
        }
        JKPrint("字典 -> JSON字符串", "字典：\(dictionary) 转JSON字符串后为：\(json)")
    }
    
    // MARK: 1.04、JSON字符串 -> 字典
    @objc func test104() {
        let dictionary = ["a": "1", "b": "2"]
        guard let json = dictionary.toJSON(), let newDictionary = json.jk.jsonStringToDictionary() else {
            return
        }
        JKPrint("JSON字符串 -> 字典", "JSON字符串：\(json) 转为字典为：\(newDictionary)")
    }
    
    // MARK: 1.03、字典的key或者value组成的数组
    @objc func test103() {
        let dictionary = ["a": "1", "b": "2"]
        let array = dictionary.toArray { (key, value) -> String in
            return key
        }
        JKPrint("字典的key或者value组成的数组", "字典 \(dictionary) 的key组成的数组是：\(array)")
    }
    
    // MARK: 1.02、检验 Dictionary 中是否存在某个key的值
    @objc func test102() {
        let japan: [String: Any] = [
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
    
    // MARK: 1.01、检查字典里面是否有某个 key
    @objc func test101() {
        let dictionary = ["a": "1", "b": "2"]
        let key = "c"
        JKPrint("检查字典里面是否有某个 key", "检查字典\(dictionary) 里面有没有键：\(key) ，结果是：\(dictionary.has(key))")
    }
}
