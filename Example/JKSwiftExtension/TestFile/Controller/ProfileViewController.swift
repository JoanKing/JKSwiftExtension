//
//  ProfileViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2022/2/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .cBackViewColor
    
        let person = Person()
        person.addObserver(self, forKeyPath: "age", options: [.old, .new], context: nil)
        // 1、使用setter方法改变值KVO才会生效
        person.age = 2
        // 2、通过KVC改变value
        person.setValue(5, forKey: "age")
        // 3、手动触发KVO
        // person.willChangeValue(forKey: "age")
        debugPrint("----------")
        person.addValue()
        // person.didChangeValue(forKey: "age")
    }
    
    deinit {
        debugPrint("----------")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        debugPrint(keyPath ?? "")
        if let old = change?[NSKeyValueChangeKey.oldKey] {
            debugPrint(old)
        }
        if let new = change?[NSKeyValueChangeKey.newKey] {
            debugPrint(new)
        }
    }
}
