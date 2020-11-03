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
        dataArray = [["转 Int", "转 CGFloat", "转 Float", "转 Double", "转 String", "转 NSNumber", "转 Int64"]]
    }
}

// MARK:- 一、基本的扩展
extension UIntExtensionViewController {
    
    // MARK: 1.1、转 Int
    @objc func test11() {
        let value: UInt = 2345
        JKPrint("转 Int", "\(value) 转 Int 后为 \(value.toInt)")
    }
}
