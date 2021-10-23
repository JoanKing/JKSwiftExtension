//
//  UIBarButtonItemExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIBarButtonItemExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["快捷创建 UIBarButtonItem"]]
    }
    
    @objc func click(sender: UIButton) {
        JKPrint("点击事件")
    }
}

 // MARK: - 一、基本的扩展
 extension UIBarButtonItemExtensionViewController {
     
     // MARK: 1.1、快捷创建 UIBarButtonItem
     @objc func test11() {
        let barButtonItem = UIBarButtonItem.jk.createBarbuttonItem(name: "mark", target: self, action: #selector(click))
        self.navigationItem.rightBarButtonItem = barButtonItem
     }
}

