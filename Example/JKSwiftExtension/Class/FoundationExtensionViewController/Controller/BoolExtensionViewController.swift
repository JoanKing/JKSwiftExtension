//
//  BoolExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class BoolExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["Bool 值转 Int"]]
    }
}

// MARK: - 一、基本的扩展
extension BoolExtensionViewController {
    
    // MARK: 1.01、Bool 值转 Int
    @objc func test101() {
        let value: Bool = true
        JKPrint("Bool 值转 Int", "\(value) 转 Int 后为 \(value.jk.boolToInt)")
    }
}
