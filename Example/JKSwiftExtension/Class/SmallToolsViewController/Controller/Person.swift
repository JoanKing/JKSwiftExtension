//
//  Person.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2022/2/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class Person: NSObject {
    /// 年龄
    @objc dynamic var age: Int = 0
    
    var number: Int = 20 {
        willSet {
            self.number = 999
        }
        didSet {
            print("旧值：\(oldValue) 新值：\(self.number)")
        }
    }
    
    /// 修改成员变量的值
    func addValue() {
        age += 1
    }
    
    deinit {
        print("----销毁-----")
    }
}


class SonSon {
    var age = 10
}

protocol DDD {
    func test()
}
