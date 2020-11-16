//
//  UIDeviceExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIDeviceExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["设备的名字", "获取设备类型", "判断是否为 iPad", "判断是否是 pad", "判断是否为 iphone", "判断是否是 iphone5", "判断是否是 iphone6", "是不是 x 系列", "是不是 xs系列"]]
    }
}

// MARK:- 一、基本的扩展
extension UIDeviceExtensionViewController {
    
    // MARK: 1.1、设备的名字
    @objc func test11() {
        JKPrint("设备的名字", "\(UIDevice.modelName)")
    }
    
    // MARK: 1.2、获取设备类型
    @objc func test12() {
        let screenType = UIDevice.screenType
        JKPrint("获取设备类型", "\(String(describing: screenType))")
    }
    
    // MARK: 1.3、判断是否为 iPad
    @objc func test13() {
        JKPrint("判断是否为 iPad", "\(UIDevice.isIpad())")
    }
    
    // MARK: 1.4、判断是否是 pad
    @objc func test14() {
        JKPrint("判断是否是 pad", "\(UIDevice.isPadDevice())")
    }
    
    // MARK: 1.5、判断是否为 iphone
    @objc func test15() {
        JKPrint("判断是否为 iphone", "\(UIDevice.isIphone())")
    }
    
    // MARK: 1.6、判断是否是 iphone5
    @objc func test16() {
        JKPrint("判断是否是 iphone5", "\(UIDevice.isIphone5Screen())")
    }
    
    // MARK: 1.7、判断是否是 iphone6
    @objc func test17() {
        JKPrint("判断是否是 iphone6", "\(UIDevice.isIphone6Screen())")
    }
    
    // MARK: 1.8、是不是 x 系列
    @objc func test18() {
        JKPrint("是不是 x 系列", "\(UIDevice.isIphoneXScreen())")
    }
    
    // MARK: 1.9、是不是 xs系列
    @objc func test19() {
        JKPrint("是不是 xs系列", "\(UIDevice.isIphoneXSScreen())")
    }
}
