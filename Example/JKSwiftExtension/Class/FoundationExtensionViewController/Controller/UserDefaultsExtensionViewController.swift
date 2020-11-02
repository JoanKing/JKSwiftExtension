//
//  UserDefaultsExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UserDefaultsExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["存值", "取值"]]
    }

}

// MARK:- 一、基本的扩展
extension UserDefaultsExtensionViewController {
    
    // MARK: 1.1、存值
    @objc func test11() {
        let isSuccess = UserDefaults.userDefaultsSetValue(value: "我是小可爱", key: "a")
        if isSuccess {
            JKPrint("存值成功")
        } else {
            JKPrint("存值失败")
        }
    }
    
    // MARK: 1.2、取值
    @objc func test12() {
        guard let value = UserDefaults.userDefaultsGetValue(key: "a") else {
            return
        }
        print("value = \(value)")
    }
}
