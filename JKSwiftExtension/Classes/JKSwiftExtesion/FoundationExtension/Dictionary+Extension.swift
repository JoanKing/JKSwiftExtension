//
//  Dictionary+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

// MARK:- 一、基本的扩展
public extension Dictionary  {

    // MARK: 1.1、检查字典里面是否有某个 key
    /// 检查字典里面是否有某个 key
    func has(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    // MARK: 1.2、字典的key或者value组成的数组
    /// 字典的key或者value组成的数组
    /// - Parameter map: map
    /// - Returns: 数组
    func toArray<V>(_ map: (Key, Value) -> V) -> [V] {
        return self.map(map)
    }

    // MARK: 1.3、JSON字符串 -> 字典
    /// JsonString转为字典
    /// - Parameter json: JSON字符串
    /// - Returns: 字典
    static func jsonToDictionary(json: String) -> Dictionary<String, Any>? {
        if let data = (try? JSONSerialization.jsonObject(
            with: json.data(using: String.Encoding.utf8,
                            allowLossyConversion: true)!,
            options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String, Any> {
            return data
        } else {
            return nil
        }
    }

    // MARK: 1.4、字典 -> JSON字符串
    /// 字典转换为JSONString
    func toJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
    
    // MARK: 1.5、字典里面所有的 key
    /// 字典里面所有的key
    /// - Returns: key 数组
    func allKeys() -> [Key] {
        /*
         shuffled：不会改变原数组，返回一个新的随机化的数组。  可以用于let 数组
         */
       return self.keys.shuffled()
    }
    
    // MARK: 1.6、字典里面所有的 value
    /// 字典里面所有的value
    /// - Returns: value 数组
    func allValues() -> [Value] {
        return self.values.shuffled()
    }
}

