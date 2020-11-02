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
