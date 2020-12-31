//
//  UITabBarControllerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/31.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UITabBarControllerExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本扩展"]
        dataArray = [["当前选择索引"]]
    }
}

// MARK:- 一、基本扩展
extension UITabBarControllerExtensionViewController {
    
    // MARK: 1.1、当前选择索引
    @objc func test11() {
        JKPrint("当前选择索引：\(UITabBarController.selectedIdx)")
    }
}
