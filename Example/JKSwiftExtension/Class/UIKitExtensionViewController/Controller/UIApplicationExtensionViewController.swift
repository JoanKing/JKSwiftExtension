//
//  UIApplicationExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIApplicationExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["获取app的名字", "获取app的版本号", "获取app的 Build ID", "获取app的 Bundle Identifier", "获取屏幕的方向", "获取根控制器", "设备信息的获取"]]
    }
}

// MARK:- 一、基本的扩展
extension UIApplicationExtensionViewController {
    
    // MARK: 1.1、获取app的名字
    @objc func test11() {
        JKPrint("\(UIApplication.appDisplayName)")
    }
    
    // MARK: 1.2、获取app的版本号
    @objc func test12() {
       JKPrint("\(UIApplication.appVersion)")
    }
    
    // MARK: 1.3、获取app的 Build ID
    @objc func test13() {
        guard let appBuild = UIApplication.appBuild else {
            return
        }
        JKPrint("\(appBuild)")
    }
    
    // MARK: 1.4、获取app的 Bundle Identifier
    @objc func test14() {
        JKPrint("\(UIApplication.appBundleIdentifier)")
    }
    
    // MARK: 1.5、获取屏幕的方向
    @objc func test15() {
        JKPrint("获取屏幕的方向", "\(UIApplication.screenOrientation)")
    }
    
    // MARK: 1.6、获取根控制器
    @objc func test16() {
        guard let vc = UIApplication.topViewController() else {
            return
        }
        JKPrint("获取屏幕的方向", "\(vc.className)")
    }
    
    // MARK: 1.7、设备信息的获取
    @objc func test17() {
        JKPrint("设备信息的获取", "\(UIApplication.userAgent)")
    }
}
