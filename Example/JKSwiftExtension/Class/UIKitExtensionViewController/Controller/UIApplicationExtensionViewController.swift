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
        dataArray = [["获取屏幕的方向", "获取根控制器", "设备信息的获取", "app定位区域"]]
    }
}

// MARK:- 一、基本的扩展
extension UIApplicationExtensionViewController {
    
    // MARK: 1.1、获取屏幕的方向
    @objc func test11() {
        JKPrint("获取屏幕的方向", "\(UIApplication.jk.screenOrientation)")
    }
    
    // MARK: 1.2、获取根控制器
    @objc func test12() {
        guard let vc = UIApplication.jk.topViewController() else {
            return
        }
        JKPrint("获取屏幕的方向", "\(vc.className)")
    }
    
    // MARK: 1.3、设备信息的获取
    @objc func test13() {
        JKPrint("设备信息的获取", "\(UIApplication.jk.userAgent)")
    }
    
    // MARK: 1.4、app定位区域
    @objc func test14() {
        JKPrint("app定位区域", "\(UIApplication.jk.localizations ?? "")")
    }
}
