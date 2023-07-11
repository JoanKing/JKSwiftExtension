//
//  Dictionary+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
import AVFoundation
extension Dictionary: JKPOPCompatible { }

// MARK: - 一、基本的扩展
public extension Dictionary {
    
    // MARK: 1.1、检查字典里面是否有某个 key
    /// 检查字典里面是否有某个 key
    func has(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    // MARK: 1.2、检验 Dictionary 中是否存在某个key的值
    /// 检验 Dictionary 中是否存在某个key的值
    /// - Parameter key: 待检验的 key
    /// - Returns: 检验结果的布尔值
    func hasValue(key: Key) -> Bool {
        return self[key] != nil
    }
    
    // MARK: 1.3、字典的key或者value组成的数组
    /// 字典的key或者value组成的数组
    /// - Parameter map: map
    /// - Returns: 数组
    func toArray<V>(_ map: (Key, Value) -> V) -> [V] {
        return self.map(map)
    }
    
    // MARK: 1.4、JSON字符串 -> 字典
    /// JsonString转为字典
    /// - Parameter json: JSON字符串
    /// - Returns: 字典
    static func jsonToDictionary(json: String) -> Dictionary<String, Any>? {
        if let data = (try? JSONSerialization.jsonObject(
            with: json.data(using: String.Encoding.utf8,allowLossyConversion: true)!,
            options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String, Any> {
            return data
        } else {
            return nil
        }
    }
    
    // MARK: 1.5、字典 -> JSON字符串
    /// 字典转换为JSONString
    func toJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
    
    // MARK: 1.6、字典里面所有的 key
    /// 字典里面所有的key
    /// - Returns: key 数组
    func allKeys() -> [Key] {
        /*
         shuffled：不会改变原数组，返回一个新的随机化的数组。  可以用于let 数组
         */
        return self.keys.shuffled()
    }
    
    // MARK: 1.7、字典里面所有的 value
    /// 字典里面所有的value
    /// - Returns: value 数组
    func allValues() -> [Value] {
        return self.values.shuffled()
    }
    
    // MARK: 1.8、设置value
    subscript<Result>(key: Key, as type: Result.Type) -> Result? {
        get {
            return self[key] as? Result
        }
        set {
            // 如果传⼊ nil, 就删除现存的值。
            guard let value = newValue else {
                self[key] = nil
                return
            }
            // 如果类型不匹配，就忽略掉。
            guard let value2 = value as? Value else {
                return
            }
            self[key] = value2
        }
    }
    
    // MARK: 1.9、设置value
    /// 设置value
    /// - Parameters:
    ///   - keys: key链
    ///   - newValue: 新的value
    @discardableResult
    mutating func setValue(keys: [String], newValue: Any) -> Bool {
        guard keys.count > 1 else {
            guard keys.count == 1, let key = keys[0] as? Dictionary<Key, Value>.Keys.Element else {
                return false
            }
            self[key] = (newValue as! Value)
            return true
        }
        guard let key = keys[0] as? Dictionary<Key, Value>.Keys.Element, self.keys.contains(key), var value1 = self[key] as? [String: Any] else {
            return false
        }
        let result = Dictionary<String, Any>.value(keys: Array(keys[1..<keys.count]), oldValue: &value1, newValue: newValue)
        self[key] = (value1 as! Value)
        return result
    }
    
    /// 字典深层次设置value
    /// - Parameters:
    ///   - keys: key链
    ///   - oldValue: 字典
    ///   - newValue: 新的值
    @discardableResult
    private static func value(keys: [String], oldValue: inout [String: Any], newValue: Any) -> Bool {
        guard keys.count > 1 else {
            oldValue[keys[0]] = newValue
            return true
        }
        guard var value1 = oldValue[keys[0]] as? [String : Any] else { return false}
        let key = Array(keys[1..<keys.count])
        let result = value(keys: key, oldValue: &value1, newValue: newValue)
        oldValue[keys[0]] = value1
        return result
    }
}

// MARK: - 二、其他基本扩展
public extension JKPOP where Base == Dictionary<String, Any> {
    
    // MARK: 2.1、字典转JSON
    /// 字典转JSON
    @discardableResult
    func dictionaryToJson() -> String? {
        if (!JSONSerialization.isValidJSONObject(self.base)) {
            JKPrint("无法解析出JSONString")
            return nil
        }
        if let data = try? JSONSerialization.data(withJSONObject: self.base) {
            let JSONString = NSString(data:data,encoding: String.Encoding.utf8.rawValue)
            return JSONString! as String
        } else {
            JKPrint("无法解析出JSONString")
            return nil
        }
    }
}

