//
//  UIntExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIntExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、UInt 的基本转换"]
        dataArray = [["转 Int"]]
    }
}

// MARK: - 一、基本的扩展
extension UIntExtensionViewController {

    // MARK: 1.01、转 Int
    @objc func test101() {
        let value: UInt = 2345
        JKPrint("转 Int", "\(value) 转 Int 后为 \(value.jk.uintToInt)")
    }
}
