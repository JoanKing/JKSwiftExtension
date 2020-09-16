//
//  JKRuntime.swift
//  JKLive
//
//  Created by 王冲 on 2020/7/22.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

public class JKRuntime: NSObject {

    // MARK:- 使用运行时打印一个类中所有的属性
    /// 使用运行时打印一个类中所有的属性
    /// - Parameter type: 类型
    public static func ivars(_ type: NSObject.Type) {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(type, &count)!
        for i in 0..<count {
            let nameP = ivar_getName(ivars[Int(i)])!
            let name = String(cString: nameP)
            #if DEBUG
            print("name=\(name)")
            #endif
        }
    }
}

/**
 使用方式如下：
 打印手势的属性
 JKRuntime.ivars(UIGestureRecognizer.self)
*/
