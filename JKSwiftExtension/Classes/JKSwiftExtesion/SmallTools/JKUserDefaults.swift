//
//  JKUserDefaults.swift
//  JKLive
//
//  Created by Creditease on 2020/8/27.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

// MARK:- UserDefaults
public struct JKUserDefaults {
    
    // MARK: 存值
    /// 存值
    /// - Parameter value: 值
    /// - Parameter key: 键
    public static func userDefaultsSetValue(value:Any?,key:String?) {
        if value == nil,key == nil {
            return
        }
        UserDefaults.standard.set(value, forKey: key!)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: 取值
    /// 取值
    /// - Parameter key: 键
    public static func userDefaultsGetValue(key:String?) -> Any? {
        if key == nil {
            return nil
        }
        guard let result = UserDefaults.standard.value(forKey: key!) else {
            return nil
        }
        return result
    }
}
