//
//  JKGlobalToolsViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKGlobalToolsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        headDataArray = ["一、基本的工具"]
        dataArray = [["拨打电话", "App更新", "从 storyboard 中唤醒 viewcontroller"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 一、基本的工具
extension JKGlobalToolsViewController {
    
    // MARK: 1.3、从 storyboard 中唤醒 viewcontroller
    @objc func test13() {
        JKPrint("从 storyboard 中唤醒 viewcontroller")
    }
    
    // MARK: 1.2、App更新
    @objc func test12() {
        JKPrint("App更新")
        
        // 抖音：1142110895
        JKGlobalTools.updateApp(vc: self, appId: "1142110895")
    }
    
    // MARK: 1.1、拨打电话
    @objc func test11() {
        JKPrint("拨打电话")
        
        JKGlobalTools.callPhone(phoneNumber: "18500652880") { (_) in
        }
    }
}

