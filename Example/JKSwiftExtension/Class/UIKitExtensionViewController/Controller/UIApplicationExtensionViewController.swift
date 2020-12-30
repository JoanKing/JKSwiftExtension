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
        dataArray = [["Info.plist", "项目名称", "获取app的名字", "获取app的版本号", "获取app的 Build ID", "获取app的 Bundle Identifier", "获取屏幕的方向", "获取根控制器", "设备信息的获取", "app定位区域"]]
    }
}

// MARK:- 一、基本的扩展
extension UIApplicationExtensionViewController {
    
    // MARK: 1.1、Info.plist
    @objc func test11() {
        guard let infoDictionary = UIApplication.jk.infoDictionary else {
            return
        }
        JKPrint("项目 Info.plist 打印" ,"\(infoDictionary)")
    }
    
    // MARK: 1.2、项目名称
    @objc func test12() {
        JKPrint("项目名称：\(UIApplication.jk.projectName)")
    }
    
    // MARK: 1.3、获取app的名字
    @objc func test13() {
        JKPrint("\(UIApplication.jk.appDisplayName)")
    }
    
    // MARK: 1.4、获取app的版本号
    @objc func test14() {
        JKPrint("\(UIApplication.jk.appVersion)")
    }
    
    // MARK: 1.5、获取app的 Build ID
    @objc func test15() {
        guard let appBuild = UIApplication.jk.appBuild else {
            return
        }
        JKPrint("\(appBuild)")
    }
    
    // MARK: 1.6、获取app的 Bundle Identifier
    @objc func test16() {
        JKPrint("\(UIApplication.jk.appBundleIdentifier)")
    }
    
    // MARK: 1.7、获取屏幕的方向
    @objc func test17() {
        JKPrint("获取屏幕的方向", "\(UIApplication.jk.screenOrientation)")
    }
    
    // MARK: 1.8、获取根控制器
    @objc func test18() {
        guard let vc = UIApplication.jk.topViewController() else {
            return
        }
        JKPrint("获取屏幕的方向", "\(vc.className)")
    }
    
    // MARK: 1.9、设备信息的获取
    @objc func test19() {
        JKPrint("设备信息的获取", "\(UIApplication.jk.userAgent)")
    }
    
    // MARK: 1.10、app定位区域
    @objc func test110() {
        JKPrint("app定位区域", "\(UIApplication.jk.localizations ?? "")")
    }
}
