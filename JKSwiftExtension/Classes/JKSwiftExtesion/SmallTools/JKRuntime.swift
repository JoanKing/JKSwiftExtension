//
//  JKRuntime.swift
//  JKLive
//
//  Created by 王冲 on 2020/7/22.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

// MARK:- 一、基本的方法
public class JKRuntime: NSObject {

    // MARK: 1.1、使用运行时打印一个类中所有的属性
    /// 使用运行时打印一个类中所有的属性(窥探小黑盒)
    /// - Parameter type: 类型
    public static func ivars(_ type: NSObject.Type) {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(type, &count)
        for i in 0..<count {
            let nameP = ivar_getName(ivars![Int(i)])!
            let name = String(cString: nameP)
            #if DEBUG
            print("name=\(name)")
            #endif
        }
        // 方法中有copy,create,的都需要释放
        free(ivars)
    }
    
    // MARK: 1.2、获取所有的属性名字
    /// 获取所有的属性名字
    /// - Parameter aClass: 类名
    /// - Returns: 返回属性名字数组
    @discardableResult
    public static func getAllPropertyName(_ aClass : AnyClass) -> [String] {
        var count = UInt32()
        let properties = class_copyPropertyList(aClass, &count)
        var propertyNames = [String]()
        let intCount = Int(count)
        for i in 0 ..< intCount {
            let property : objc_property_t = properties![i]
            guard let propertyName = NSString(utf8String: property_getName(property)) as String? else {
                debugPrint("Couldn't unwrap property name for \(property)")
                break
            }
            propertyNames.append(propertyName)
        }
        free(properties)
        return propertyNames
    }
}

/**
 使用方式如下：
 打印手势的属性
 JKRuntime.ivars(UIGestureRecognizer.self)
*/
