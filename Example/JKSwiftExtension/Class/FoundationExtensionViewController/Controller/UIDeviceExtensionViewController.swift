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
        
        headDataArray = ["一、基本的扩展", "二、设备的基本信息", "三、有关设备运营商的信息"]
        dataArray = [["设备的名字", "获取设备类型", "判断是否为 iPad", "判断是否是 pad", "判断是否为 iphone", "判断是否是 iphone5", "判断是否是 iphone6", "是不是 x 系列", "是不是 xs系列", "当前设备是不是模拟器"], ["当前设备的系统版本", "当前系统更新时间", "当前设备的类型", "当前系统的名称", "当前设备的名称", "当前设备是否越狱", "当前硬盘的空间", "当前硬盘可用空间", "当前硬盘已经使用的空间", "获取总内存大小", "当前设备能否打电话"], ["sim卡信息", "数据业务对应的通信技术", "设备网络制式", "运营商名字", "移动国家码(MCC)", "移动网络码(MNC)", "ISO国家代码", "是否允许VoIP"]]
    }
}

// MARK:- 三、有关设备运营商的信息
extension UIDeviceExtensionViewController {
    
    // MARK: 3.8、是否允许VoIP
    @objc func test38() {
        guard let isAllows = UIDevice.jk.isAllowsVOIPs() else {
            return
        }
        JKPrint("是否允许VoIP：\(isAllows)")
    }
    
    // MARK: 3.7、ISO国家代码
    @objc func test37() {
        guard let isoCountryCode = UIDevice.jk.isoCountryCodes() else {
            return
        }
        JKPrint("ISO国家代码：\(isoCountryCode)")
    }
    
    // MARK: 3.6、移动网络码(MNC)
    @objc func test36() {
        guard let mobileNetworkCode = UIDevice.jk.mobileNetworkCodes() else {
            return
        }
        JKPrint("移动网络码(MNC)：\(mobileNetworkCode)")
    }
    
    // MARK: 3.5、移动国家码(MCC)
    @objc func test35() {
        guard let mobileCountryCode = UIDevice.jk.mobileCountryCodes() else {
            return
        }
        JKPrint("移动国家码：\(mobileCountryCode)")
    }
    
    // MARK: 3.4、运营商名字
    @objc func test34() {
        guard let carrierName = UIDevice.jk.carrierNames() else {
            return
        }
        JKPrint("运营商名字：\(carrierName)")
    }
    
    // MARK: 3.3、设备网络制式
    @objc func test33() {
        guard let networkType = UIDevice.jk.networkTypes() else {
            return
        }
        JKPrint("设备网络制式：\(networkType)")
    }
    
    // MARK: 3.2、数据业务对应的通信技术
    @objc func test32() {
        guard let currentRadioAccessTechnology = UIDevice.jk.currentRadioAccessTechnologys() else {
            return
        }
        JKPrint("数据业务对应的通信技术：\(currentRadioAccessTechnology)")
    }
    
    // MARK: 3.1、数据业务对应的通信技术
    @objc func test31() {
        guard let currentRadioAccessTechnology = UIDevice.jk.currentRadioAccessTechnologys() else {
            return
        }
        JKPrint("数据业务对应的通信技术：\(currentRadioAccessTechnology)")
    }
}

// MARK:- 二、设备的基本信息
extension UIDeviceExtensionViewController {
    
    // MARK: 2.11、当前设备能否打电话
    @objc func test211() {
        JKPrint("当前设备能否打电话：\(UIDevice.jk.canMakePhoneCalls())")
    }
    
    // MARK: 2.10、获取总内存大小
    @objc func test210() {
        JKPrint("获取总内存大小", "\(FileManager.jk.covertUInt64ToString(with: UInt64(UIDevice.jk.memoryTotal)))")
    }
    
    // MARK: 2.9、当前硬盘已经使用的空间
    @objc func test29() {
        JKPrint("当前硬盘已经使用的空间", "\(FileManager.jk.covertUInt64ToString(with: UInt64(UIDevice.jk.diskSpaceUsed)))")
    }
    
    // MARK: 2.8、当前硬盘可用空间
    @objc func test28() {
        JKPrint("当前硬盘可用空间", "\(FileManager.jk.covertUInt64ToString(with: UInt64(UIDevice.jk.diskSpaceFree)))")
    }
    
    // MARK: 2.7、当前硬盘的空间
    @objc func test27() {
        JKPrint("当前硬盘的空间", "\(FileManager.jk.covertUInt64ToString(with: UInt64(UIDevice.jk.diskSpace)))")
    }
    
    // MARK: 2.6、当前设备是否越狱
    @objc func test26() {
        JKPrint("当前设备是否越狱", "\(UIDevice.jk.isJailbroken)")
    }
    
    // MARK: 2.5、当前设备的名称
    @objc func test25() {
        JKPrint("当前设备的名称", "\(UIDevice.jk.currentDeviceName)")
    }
    
    // MARK: 2.4、当前系统的名称
    @objc func test24() {
        JKPrint("当前系统的名称", "\(UIDevice.jk.currentSystemName)")
    }
    
    // MARK: 2.3、当前设备的类型
    @objc func test23() {
        JKPrint("当前系统的类型", "\(UIDevice.jk.deviceType)")
    }
    // MARK: 2.2、当前系统更新时间
    @objc func test22() {
        JKPrint("当前系统更新时间", "\(UIDevice.jk.systemUptime)")
    }
    
    // MARK: 2.1、当前设备的系统版本
    @objc func test21() {
        JKPrint("当前设备的系统版本", "\(UIDevice.jk.currentSystemVersion)")
    }
}
// MARK:- 一、基本的扩展
extension UIDeviceExtensionViewController {
    
    // MARK: 1.1、设备的名字
    @objc func test11() {
        JKPrint("设备的名字", "\(UIDevice.jk.modelName)")
    }
    
    // MARK: 1.2、获取设备类型
    @objc func test12() {
        let screenType = UIDevice.jk.screenType
        JKPrint("获取设备类型", "\(String(describing: screenType))")
    }
    
    // MARK: 1.3、判断是否为 iPad
    @objc func test13() {
        JKPrint("判断是否为 iPad", "\(UIDevice.jk.isIpad())")
    }
    
    // MARK: 1.4、判断是否是 pad
    @objc func test14() {
        JKPrint("判断是否是 pad", "\(UIDevice.jk.isPadDevice())")
    }
    
    // MARK: 1.5、判断是否为 iphone
    @objc func test15() {
        JKPrint("判断是否为 iphone", "\(UIDevice.jk.isIphone())")
    }
    
    // MARK: 1.6、判断是否是 iphone5
    @objc func test16() {
        JKPrint("判断是否是 iphone5", "\(UIDevice.jk.isIphone5Screen())")
    }
    
    // MARK: 1.7、判断是否是 iphone6
    @objc func test17() {
        JKPrint("判断是否是 iphone6", "\(UIDevice.jk.isIphone6Screen())")
    }
    
    // MARK: 1.8、是不是 x 系列
    @objc func test18() {
        JKPrint("是不是 x 系列", "\(UIDevice.jk.isIphoneXScreen())")
    }
    
    // MARK: 1.9、是不是 xs系列
    @objc func test19() {
        JKPrint("是不是 xs系列", "\(UIDevice.jk.isIphoneXSScreen())")
    }
    
    // MARK: 1.10、当前设备是不是模拟器
    @objc func test110() {
        JKPrint("当前设备是不是模拟器", "\(UIDevice.jk.isSimulator())")
    }
}
