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
        
        headDataArray = ["一、基本的扩展", "二、设备的基本信息", "三、有关设备运营商的信息", "四、设备的震动"]
        dataArray = [["设备的名字", "获取设备类型", "判断是否为 iPad", "判断是否是 pad", "判断是否为 iphone", "判断是否是 iphone5", "判断是否是 iphone6", "是不是 x 系列", "是不是 xs系列", "当前设备是不是模拟器"], ["当前设备的系统版本", "当前系统更新时间", "当前设备的类型", "当前系统的名称", "当前设备的名称", "当前设备是否越狱", "当前硬盘的空间", "当前硬盘可用空间", "当前硬盘已经使用的空间", "获取总内存大小", "当前设备能否打电话", "当前设备语言", "设备区域化型号", "获取最高刷新率", "获取设备是否是省电模式", "获取屏幕亮度比例"], ["sim卡信息", "数据业务对应的通信技术", "设备网络制式", "运营商名字", "移动国家码(MCC)", "移动网络码(MNC)", "ISO国家代码", "是否允许VoIP"], ["通过SystemSoundID震动", "UINotificationFeedbackGenerator 来设置的手机振动", "UIImpactFeedbackGenerator 来设置的手机振动", "模拟选择滚轮一类控件时的震动"]]
    }
}

// MARK: - 四、设备的震动
extension UIDeviceExtensionViewController {
    
    // MARK: 4.04、模拟选择滚轮一类控件时的震动
    @available(iOS 10.0, *)
    @objc func test404() {
        JKPrint("模拟选择滚轮一类控件时的震动")
        UIDevice.jk.selectionFeedbackGeneratorChanged()
    }
    
    // MARK: 4.03、UIImpactFeedbackGenerator 来设置的手机振动
    @available(iOS 10.0, *)
    @objc func test403() {
        JKPrint("UIImpactFeedbackGenerator 来设置的手机振动")
        JKAsyncs.asyncDelay(1) {
        } _: {
            UIDevice.jk.impactFeedbackGenerator(style: .light)
            JKAsyncs.asyncDelay(2) {
            } _: {
                UIDevice.jk.impactFeedbackGenerator(style: .medium)
                JKAsyncs.asyncDelay(2) {
                } _: {
                    UIDevice.jk.impactFeedbackGenerator(style: .heavy)
                }
            }
        }
    }
    
    //MARK: 4.02、UINotificationFeedbackGenerator 来设置的手机振动
    @available(iOS 10.0, *)
    @objc func test402() {
        JKPrint("UINotificationFeedbackGenerator 来设置的手机振动")
        JKAsyncs.asyncDelay(1) {
        } _: {
            UIDevice.jk.notificationFeedbackGeneratorSuccess(.success)
            JKAsyncs.asyncDelay(2) {
            } _: {
                UIDevice.jk.notificationFeedbackGeneratorSuccess(.error)
                JKAsyncs.asyncDelay(2) {
                } _: {
                    UIDevice.jk.notificationFeedbackGeneratorSuccess(.warning)
                }
            }
        }
    }
    
    // MARK: 4.01、通过SystemSoundID震动
    @objc func test401() {
        JKPrint("通过SystemSoundID震动")
        JKAsyncs.asyncDelay(1) {
        } _: {
            // 1、短振动，普通短震，3D Touch 中 Peek 震动反馈
            UIDevice.jk.systemSoundIDShock(type: .short3DTouchPeekVibration)
            JKAsyncs.asyncDelay(2) {
            } _: {
                // 2、普通短震，3D Touch 中 Pop 震动反馈,home 键的振动
                UIDevice.jk.systemSoundIDShock(type: .short3DPopHomeVibration)
                JKAsyncs.asyncDelay(2) {
                } _: {
                    // 3、连续三次短震
                    UIDevice.jk.systemSoundIDShock(type: .thereshortVibration)
                }
            }
        }
    }
}

// MARK: - 三、有关设备运营商的信息
extension UIDeviceExtensionViewController {
    
    // MARK: 3.08、是否允许VoIP
    @objc func test308() {
        guard let isAllows = UIDevice.jk.isAllowsVOIPs() else {
            return
        }
        JKPrint("是否允许VoIP：\(isAllows)")
    }
    
    // MARK: 3.07、ISO国家代码
    @objc func test307() {
        guard let isoCountryCode = UIDevice.jk.isoCountryCodes() else {
            return
        }
        JKPrint("ISO国家代码：\(isoCountryCode)")
    }
    
    // MARK: 3.06、移动网络码(MNC)
    @objc func test306() {
        guard let mobileNetworkCode = UIDevice.jk.mobileNetworkCodes() else {
            return
        }
        JKPrint("移动网络码(MNC)：\(mobileNetworkCode)")
    }
    
    // MARK: 3.05、移动国家码(MCC)
    @objc func test305() {
        guard let mobileCountryCode = UIDevice.jk.mobileCountryCodes() else {
            return
        }
        JKPrint("移动国家码：\(mobileCountryCode)")
    }
    
    // MARK: 3.04、运营商名字
    @objc func test304() {
        guard let carrierName = UIDevice.jk.carrierNames() else {
            return
        }
        JKPrint("运营商名字：\(carrierName)")
    }
    
    // MARK: 3.03、设备网络制式
    @objc func test303() {
        guard let networkType = UIDevice.jk.networkTypes() else {
            return
        }
        JKPrint("设备网络制式：\(networkType)")
    }
    
    // MARK: 3.02、数据业务对应的通信技术
    @objc func test302() {
        guard let currentRadioAccessTechnology = UIDevice.jk.currentRadioAccessTechnologys() else {
            return
        }
        JKPrint("数据业务对应的通信技术：\(currentRadioAccessTechnology)")
    }
    
    // MARK: 3.01、sim卡信息
    @objc func test301() {
        guard let carriers = UIDevice.jk.simCardInfos() else {
            return
        }
        JKPrint("数据业务对应的通信技术：\(carriers)")
    }
}

// MARK: - 二、设备的基本信息
extension UIDeviceExtensionViewController {
    
    //MARK: 2.16、获取屏幕亮度比例
    @objc func test216() {
        JKPrint("获取屏幕亮度比例：\(UIDevice.jk.brightnessRatio)")
    }
    
    //MARK: 2.1.5、获取设备是否是省电模式
    @objc func test215() {
        JKPrint("获取设备是否是省电模式：\(UIDevice.jk.isLowPowerMode)")
    }
    
    //MARK: 2.14、获取最高刷新率
    @available(iOS 10.3, *)
    @objc func test214() {
        JKPrint("获取最高刷新率：\(UIDevice.jk.maximumFramesPerSecond)")
    }
    
    //MARK: 2.13、设备区域化型号
    @objc func test213() {
        JKPrint("设备区域化型号：\(UIDevice.jk.localizedModel)")
    }
    
    //MARK: 2.12、当前设备语言
    @objc func test212() {
        JKPrint("当前设备语言：\(UIDevice.jk.deviceLanguage)")
    }
    
    // MARK: 2.11、当前设备能否打电话
    @objc func test211() {
        JKPrint("当前设备能否打电话：\(UIDevice.jk.isCanCallTel())")
    }
    
    // MARK: 2.10、获取总内存大小
    @objc func test210() {
        JKPrint("获取总内存大小", "\(FileManager.jk.covertUInt64ToString(with: UInt64(UIDevice.jk.memoryTotal)))")
    }
    
    // MARK: 2.09、当前硬盘已经使用的空间
    @objc func test209() {
        JKPrint("当前硬盘已经使用的空间", "\(FileManager.jk.covertUInt64ToString(with: UInt64(UIDevice.jk.diskSpaceUsed)))")
    }
    
    // MARK: 2.08、当前硬盘可用空间
    @objc func test208() {
        JKPrint("当前硬盘可用空间", "\(FileManager.jk.covertUInt64ToString(with: UInt64(UIDevice.jk.diskSpaceFree)))")
    }
    
    // MARK: 2.07、当前硬盘的空间
    @objc func test207() {
        JKPrint("当前硬盘的空间", "\(FileManager.jk.covertUInt64ToString(with: UInt64(UIDevice.jk.diskSpace)))")
    }
    
    // MARK: 2.06、当前设备是否越狱
    @objc func test206() {
        JKPrint("当前设备是否越狱", "\(UIDevice.jk.isJailbroken)")
    }
    
    // MARK: 2.05、当前设备的名称
    @objc func test205() {
        JKPrint("当前设备的名称", "\(UIDevice.jk.currentDeviceName)")
    }
    
    // MARK: 2.04、当前系统的名称
    @objc func test204() {
        JKPrint("当前系统的名称", "\(UIDevice.jk.currentSystemName)")
    }
    
    // MARK: 2.03、当前设备的类型
    @objc func test203() {
        JKPrint("当前系统的类型", "\(UIDevice.jk.deviceType)")
    }
    // MARK: 2.02、当前系统更新时间
    @objc func test202() {
        JKPrint("当前系统更新时间", "\(UIDevice.jk.systemUptime)")
    }
    
    // MARK: 2.01、当前设备的系统版本
    @objc func test201() {
        JKPrint("当前设备的系统版本", "\(UIDevice.jk.currentSystemVersion)")
    }
}
// MARK: - 一、基本的扩展
extension UIDeviceExtensionViewController {

    // MARK: 1.10、当前设备是不是模拟器
    @objc func test110() {
        JKPrint("当前设备是不是模拟器", "\(UIDevice.jk.isSimulator())")
    }
    
    // MARK: 1.09、是不是 xs系列
    @objc func test109() {
        JKPrint("是不是 xs系列", "\(UIDevice.jk.isIphoneXSScreen())")
    }
    
    // MARK: 1.08、是不是 x 系列
    @objc func test108() {
        JKPrint("是不是 x 系列", "\(UIDevice.jk.isIphoneXScreen())")
    }
    
    // MARK: 1.07、判断是否是 iphone6
    @objc func test107() {
        JKPrint("判断是否是 iphone6", "\(UIDevice.jk.isIphone6Screen())")
    }
    
    // MARK: 1.06、判断是否是 iphone5
    @objc func test106() {
        JKPrint("判断是否是 iphone5", "\(UIDevice.jk.isIphone5Screen())")
    }
    
    // MARK: 1.05、判断是否为 iphone
    @objc func test105() {
        JKPrint("判断是否为 iphone", "\(UIDevice.jk.isIphone())")
    }
    
    // MARK: 1.04、判断是否是 pad
    @objc func test104() {
        JKPrint("判断是否是 pad", "\(UIDevice.jk.isPadDevice())")
    }
    
    // MARK: 1.03、判断是否为 iPad
    @objc func test103() {
        JKPrint("判断是否为 iPad", "\(UIDevice.jk.isIpad())")
    }
    
    // MARK: 1.02、获取设备类型
    @objc func test102() {
        let screenType = UIDevice.jk.screenType
        JKPrint("获取设备类型", "\(String(describing: screenType))")
    }
    
    // MARK: 1.01、设备的名字
    @objc func test101() {
        JKPrint("设备的名字", "\(UIDevice.jk.modelName)")
    }
}
