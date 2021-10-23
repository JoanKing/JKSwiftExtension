//
//  UINavigationBarExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UINavigationBarExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["改变StateBar的颜色", "去掉 StateBar 的颜色"]]
    }
}

// MARK: - 一、基本的扩展
extension UINavigationBarExtensionViewController {
    
    // MARK: 1.1、改变StateBar的颜色
    @objc func test11() {
        self.navigationController?.navigationBar.changeStateBarBackgroundColor(.green)
    }
    
    // MARK: 1.2、去掉 StateBar 的颜色
    @objc func test12() {
        self.navigationController?.navigationBar.resetBackgroundColor()
    }
}
