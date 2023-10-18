//
//  UIScreenExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
class UIScreenExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["获取宽度", "获取高度", "截屏和录屏通知"]]
    }
}

// MARK: - 一、基本的扩展
extension UIScreenExtensionViewController {
    
    // MARK: 1.03、截屏通知
    @objc func test103() {
        UIScreen.jk.detectScreenShot { (result) in
            JKPrint("\(result)")
        }
    }
    
    // MARK: 1.02、获取高度
    @objc func test102() {
        JKPrint("获取高度：\(UIScreen.jk.height)")
    }
    
    // MARK: 1.01、获取宽度
    @objc func test101() {
        JKPrint("获取宽度：\(UIScreen.jk.width)")
    }
}

