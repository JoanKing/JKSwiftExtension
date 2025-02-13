//
//  Person.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2022/2/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

@objcMembers class Person: NSObject {
    /// 年龄
    @objc dynamic var age: Int = 0
    
    var name: String = ""
    
    var number: Int = 20 {
        willSet {
            self.number = 999 
        }
        didSet {
            debugPrint("旧值：\(oldValue) 新值：\(self.number)")
        }
    }
    
    var height: Int {
        if age > 10 {
            return 100
        }
        return 0
    }
    
    /// 修改成员变量的值
    func addValue() {
        age += 1
    }
    
    deinit {
        debugPrint("----销毁-----")
    }
}


@objcMembers class SonSon: NSObject {
    var age = 10
}

protocol DDD {
    func test()
}
