//
//  UIAlertControllerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIAlertControllerExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["初始化创建 UIAlertController", "添加 UIAlertAction 事件", "添加 UIAlertAction 事件", "跳转 UIAlertController", "跳转 UIAlertController，不做操作自动返回"]]
    }
}

// MARK: - 一、基本的链式编程
extension UIAlertControllerExtensionViewController {
    
    // MARK: 1.05、跳转 UIAlertController，不做操作自动返回
    @objc func test105() {
        let alertAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
            JKPrint("确定")
        }
        UIAlertController(title: "主标题", message: "副标题").addAction(action: alertAction).show(self, dismiss: 3)
    }
    
    // MARK: 1.04、跳转 UIAlertController
    @objc func test104() {
       let alertAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
           JKPrint("确定")
       }
       UIAlertController(title: "主标题", message: "副标题").addAction(action: alertAction).show()
    }
    
    // MARK: 1.03、添加 UIAlertAction 事件
    @objc func test103() {
        let alertAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
            JKPrint("确定")
        }
        let alertController = UIAlertController(title: "主标题", message: "副标题").addAction(action: alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: 1.02、添加 UIAlertAction 事件
    @objc func test102() {
        let alertController = UIAlertController(title: "主标题", message: "副标题").addAction("确定", UIAlertAction.Style.default) {
            JKPrint("确定")
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: 1.01、初始化创建 UIAlertController
    @objc func test101() {
        let alertController = UIAlertController(title: "主标题", message: "副标题")
        let alertAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
            JKPrint("确定")
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
