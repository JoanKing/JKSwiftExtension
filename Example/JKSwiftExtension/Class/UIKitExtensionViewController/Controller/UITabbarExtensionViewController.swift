//
//  UITabbarExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2023/10/17.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class UITabbarExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本扩展"]
        dataArray = [["设置透明背景"]]
    }

}

// MARK: - 一、基本扩展
extension UITabbarExtensionViewController {
    
    // MARK: 1.1、设置透明背景
    @objc func test11() {
        JKPrint("设置透明背景")
    }
}
