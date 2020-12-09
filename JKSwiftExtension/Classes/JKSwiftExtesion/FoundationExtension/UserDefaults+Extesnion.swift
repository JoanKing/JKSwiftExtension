//
//  UserDefaults+Extesnion.swift
//  FDFullscreenPopGesture
//
//  Created by IronMan on 2020/11/2.
//

import UIKit

// MARK:- 一、基本的扩展
public extension UserDefaults {
  
    // MARK: 1.1、存值
    /// 存值
    /// - Parameters:
    ///   - value: 值
    ///   - key: 键
    
    @discardableResult
    static func userDefaultsSetValue(value: Any?, key: String?) -> Bool {
        guard value != nil, key != nil else {
            return false
        }
        Self.standard.set(value, forKey: key!)
        Self.standard.synchronize()
        return true
    }
    
    // MARK: 1.2、取值
    /// 取值
    /// - Parameter key: 键
    /// - Returns: 返回值
    static func userDefaultsGetValue(key: String?) -> Any? {
        guard key != nil, let result = Self.standard.value(forKey: key!) else {
            return nil
        }
        return result
    }
}

// MARK:- 二、模型持久化
public extension UserDefaults {
    
    // MARK: 2.1、存储模型
    /// 存储模型
    /// - Parameters:
    ///   - object: 模型
    ///   - key: 对应的key
    static func setItem<T: Decodable & Encodable>(_ object: T, forKey key: String) {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(object) else {
            return
        }
        Self.standard.set(encoded, forKey: key)
        Self.standard.synchronize()
    }
    
    // MARK: 2.2、取出模型
    /// 取出模型
    /// - Parameters:
    ///   - type: 当时存储的类型
    ///   - key: 对应的key
    /// - Returns: 对应类型的模型
    static func getItem<T: Decodable & Encodable>(_ type: T.Type, forKey key: String) -> T? {
        
        guard let data = Self.standard.data(forKey: key) else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let object = try? decoder.decode(type, from: data) else {
            JKPrint("Couldnt find key")
            return nil
        }
        return object
    }
}
