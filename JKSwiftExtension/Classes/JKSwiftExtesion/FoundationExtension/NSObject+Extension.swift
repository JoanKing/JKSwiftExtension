//
//  NSObject+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/18.
//

import UIKit

// MARK:- 一、 NSObject 属性的扩展
#if os(iOS) || os(tvOS)
public extension NSObject {
    
    // MARK: 1.1、类名（对象方法）
    /// 类名
    var className: String {
        return type(of: self).className
    }
    
    // MARK: 1.2、类名（类方法）
    /// 类名
    static var className: String {
        return String(describing: self)
    }
}

#endif

// MARK:- 二、一些常用的方法
public extension NSObject {
    
    // MARK: 2.1、利用运行时获取类里面的成员变量
    /// 利用运行时获取类里面的成员变量
    @discardableResult
    static func printIvars() -> [String] {
        // 成员变量数量
        var outCount: UInt32 = 0
        // 成员变量名字
        var propertyNames = [String]()
        // ivars实际上是一个数组
        let ivars = class_copyIvarList(self, &outCount)
        // 获取里面的每一个元素
        for i in 0..<outCount {
            // ivar是一个结构体的指针
            let ivar = ivars![Int(i)]
            // 获取 成员变量的名称,cName c语言的字符串,首元素地址
            let cName = ivar_getName(ivar)
            let name = String(cString: cName!, encoding: String.Encoding.utf8)
            #if DEBUG
            print("name: \(name ?? "没有内容")")
            #endif
            propertyNames.append(name ?? "没有内容")
        }
        // 方法中有copy,create,的都需要释放
        free(ivars)
        return propertyNames
    }
}


