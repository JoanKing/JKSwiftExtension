//
//  JKOperatorViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2023/12/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension

class JKOperatorViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、位移运算符"]
        dataArray = [["右移算符"]]
    }
}

//MARK: - 一、位移运算符
extension JKOperatorViewController {

    //MARK: 1.01、无符号右移运算符
    @objc func test101() {
        debugPrint("\(-8192)右移1位后结果为：\(-8192 |>>>| 1)")
        debugPrint("\(2147483642)右移1位后结果为：\(2147483642 |>>>| 1)")
    }
}
