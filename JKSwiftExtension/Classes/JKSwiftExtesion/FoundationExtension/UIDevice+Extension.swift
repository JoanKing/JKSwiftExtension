//
//  UIDevice+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/30.
//

import Foundation
// 使用CoreTelephony获取运营商信息、网络制式（4G、3G、2G）
import CoreTelephony

extension UIDevice: JKPOPCompatible {}
// 这里只指屏幕类型
public enum UIDeviceScreenType: String {
    case IPHONE_5
    case IPHONE_6
    case IPHONE_PLUS
    case IPHONE_X
    case IPHONE_XS
    case IPHONE_XR
    case IPHONE_XS_Max
    case IPHONE_11
    case IPHONE_11_PRO
    case IPHONE_11_PRO_MAX
}

// MARK:- 一、基本的扩展
public extension JKPOP where Base: UIDevice {
    
    // MARK: 1.1、设备的名字
    /// 设备的名字
    static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String {
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                               return "iPhone 11 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        return mapToDevice(identifier: identifier)
    }
    
    // MARK: 1.2、获取设备类型
    /// 获取设备类型
    /// - Returns: 设备类型
    static func screenType() -> UIDeviceScreenType {
        let modelName = Base.jk.modelName
        if modelName == "iPhone 5" || modelName == "iPhone 5c" || modelName == "iPhone 5s" || modelName == "iPhone SE" {
            return UIDeviceScreenType.IPHONE_5
        } else if modelName == "iPhone 6" || modelName == "iPhone 6s" || modelName == "iPhone 7" || modelName == "iPhone 8" {
            return UIDeviceScreenType.IPHONE_6
        } else if modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus" {
            return UIDeviceScreenType.IPHONE_PLUS
        } else if modelName == "iPhone X" {
            return UIDeviceScreenType.IPHONE_X
        } else if modelName == "iPhone XS" {
            return UIDeviceScreenType.IPHONE_XS
        } else if modelName == "iPhone XR" {
            return UIDeviceScreenType.IPHONE_XR
        } else if modelName == "iPhone XS Max" {
            return UIDeviceScreenType.IPHONE_XS_Max
        } else if modelName == "iPhone 11" {
            return UIDeviceScreenType.IPHONE_11
        }   else if modelName == "iPhone 11 Pro" {
            return UIDeviceScreenType.IPHONE_11_PRO
        }   else if modelName == "iPhone 11 Pro Max" {
            return UIDeviceScreenType.IPHONE_11_PRO_MAX
        }
        return UIDeviceScreenType.IPHONE_6
    }
    
    // MARK: 1.3、判断是否为 iPad
    /// 判断是否为 Pad
    /// - Returns: bool
    static func isIpad() -> Bool {
        let modelName = Base.jk.modelName
        if modelName.contains("iPad") {
            return true
        }
        return false
    }
    
    // MARK: 1.4、判断是否是 pad
    /// 判断是否是 pad
    /// - Returns: bool
    static func isPadDevice() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
    
    // MARK: 1.5、判断是否为 iphone
    /// 判断是否为 iphone
    /// - Returns: bool
    static func isIphone() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .phone
    }
    
    // MARK: 1.6、判断是否是 iphone5
    /// 判断是否是 iphone5
    /// - Returns: bool
    static func isIphone5Screen() -> Bool {
        if Base.jk.screenType() == .IPHONE_5 {
            return true
        }
        return false
    }
    
    // MARK: 1.7、判断是否是 iphone6
    /// 判断是否是 iphone5
    /// - Returns: bool
    static func isIphone6Screen() -> Bool {
        if Base.jk.screenType() == .IPHONE_6 {
            return true
        }
        return false
    }
    
    // MARK: 1.8、是不是 x 系列
    /// 是不是 x 系列
    /// - Returns: bool
    static func isIphoneXScreen() -> Bool {
        if Base.jk.screenType() == .IPHONE_X || Base.jk.screenType() == .IPHONE_XS || Base.jk.screenType() == .IPHONE_XR || Base.jk.screenType() == .IPHONE_XS_Max ||  Base.jk.screenType() == .IPHONE_11 ||  Base.jk.screenType() == .IPHONE_11_PRO ||  Base.jk.screenType() == .IPHONE_11_PRO_MAX {
            return true
        }
        return false
    }
    
    // MARK: 1.9、是不是 xs系列
    /// 是不是 xs 系列
    /// - Returns: bool
    static func isIphoneXSScreen() -> Bool {
        if Base.jk.screenType() == .IPHONE_XS || Base.jk.screenType() == .IPHONE_XR || Base.jk.screenType() == .IPHONE_XS_Max {
            return true
        }
        return false
    }
    
    // MARK: 1.10、当前设备是不是模拟器
    /// 当前设备是不是模拟器
    static func isSimulator() -> Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }
}

// MARK:- 二、设备的基本信息

public extension JKPOP where Base: UIDevice {
    
    // MARK: 2.1、当前设备的系统版本
    /// 当前设备的系统版本
    static var currentSystemVersion : String {
        get {
            return Base.current.systemVersion
        }
    }
    
    // MARK: 2.2、当前系统更新时间
    /// 当前系统更新时间
    static var systemUptime: Date {
        let time = ProcessInfo.processInfo.systemUptime
        return Date(timeIntervalSinceNow: 0 - time)
    }
    
    // MARK: 2.3、当前设备的类型，如 iPhone、iPad 等等
    /// 当前设备的类型
    static var deviceType: String {
        return UIDevice.current.model
    }
    
    // MARK: 2.4、当前系统的名称
    /// 当前系统的名称
    static var currentSystemName : String {
        get {
            return UIDevice.current.systemName
        }
    }
    
    // MARK: 2.5、当前设备的名称
    /// 当前设备的名称
    static var currentDeviceName : String {
        get {
            return UIDevice.current.name
        }
    }
    
    // MARK: 2.6、当前设备是否越狱
    /// 当前设备是否越狱
    static var isJailbroken: Bool {
        if self.isSimulator() { return false }
        let paths = ["/Applications/Cydia.app", "/private/var/lib/apt/",
                     "/private/var/lib/cydia", "/private/var/stash"]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        let path = String(format: "/private/%@", String.jk.stringWithUUID() ?? "")
        do {
            try "test".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            NSLog(error.localizedDescription)
        }
        return false
    }
    
    // MARK: 2.7、当前硬盘的空间
    /// 当前硬盘的空间
    static var diskSpace: Int64 {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let space: NSNumber = attrs[FileAttributeKey.systemSize] as? NSNumber {
                if space.int64Value > 0 {
                    return space.int64Value
                }
            }
        }
        return -1
    }
    
    // MARK: 2.8、当前硬盘可用空间
    /// 当前硬盘可用空间
    static var diskSpaceFree: Int64 {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let space: NSNumber = attrs[FileAttributeKey.systemFreeSize] as? NSNumber {
                if space.int64Value > 0 {
                    return space.int64Value
                }
            }
        }
        return -1
    }
    
    // MARK: 2.9、当前硬盘已经使用的空间
    /// 当前硬盘已经使用的空间
    static var diskSpaceUsed: Int64 {
        let total = self.diskSpace
        let free = self.diskSpaceFree
        guard total > 0 && free > 0 else { return -1 }
        let used = total - free
        guard used > 0 else { return -1 }
        
        return used
    }
    
    // MARK: 2.10、获取总内存大小
    /// 获取总内存大小
    static var memoryTotal: UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
    // MARK: 2.11、当前设备能否打电话
    /// 当前设备能否打电话
    /// - Returns: 结果
    static func canMakePhoneCalls() -> Bool {
        if let url = URL(string: "tel://") {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    //MARK: 2.12、当前设备语言
    /// 当前设备语言
    static var deviceLanguage: String {
        return Bundle.main.preferredLocalizations[0]
    }
    
    //MARK: 2.13、设备区域化型号
    /// 设备区域化型号
    static var localizedModel: String {
        return UIDevice.current.localizedModel
    }
}

// MARK:- 三、有关设备运营商的信息
public extension JKPOP where Base: UIDevice {
    
    // MARK: 3.1、sim卡信息
    static func simCardInfos() -> [CTCarrier]? {
        return getCarriers()
    }
    
    // MARK: 3.2、数据业务对应的通信技术
    /// 数据业务对应的通信技术
    /// - Returns: 通信技术
    static func currentRadioAccessTechnologys() -> [String]? {
        guard !isSimulator() else {
            return nil
        }
        // 获取并输出运营商信息
        let info = CTTelephonyNetworkInfo()
        if #available(iOS 12.0, *) {
            guard let currentRadioTechs = info.serviceCurrentRadioAccessTechnology else {
                return nil
            }
            return currentRadioTechs.allValues()
        } else {
            guard let currentRadioTech = info.currentRadioAccessTechnology else {
                return nil
            }
            return [currentRadioTech]
        }
    }
    
    // MARK: 3.3、设备网络制式
    /// 设备网络制式
    /// - Returns: 网络
    static func networkTypes() -> [String]? {
        // 获取并输出运营商信息
        guard let currentRadioTechs = currentRadioAccessTechnologys() else {
            return nil
        }
        return currentRadioTechs.compactMap { getNetworkType(currentRadioTech: $0) }
    }
    
    // MARK: 3.4、运营商名字
    /// 运营商名字
    /// - Returns: 运营商名字
    static func carrierNames() -> [String]? {
        // 获取并输出运营商信息
        guard  let carriers = getCarriers(), carriers.count > 0 else {
            return nil
        }
        return carriers.map{ $0.carrierName!}
    }
    
    // MARK: 3.5、移动国家码(MCC)
    /// 移动国家码(MCC)
    /// - Returns: 移动国家码(MCC)
    static func mobileCountryCodes() -> [String]? {
        // 获取并输出运营商信息
        guard  let carriers = getCarriers(), carriers.count > 0 else {
            return nil
        }
        return carriers.map{ $0.mobileCountryCode!}
    }
    
    // MARK: 3.6、移动网络码(MNC)
    /// 移动网络码(MNC)
    /// - Returns: 移动网络码(MNC)
    static func mobileNetworkCodes() -> [String]? {
        // 获取并输出运营商信息
        guard  let carriers = getCarriers(), carriers.count > 0 else {
            return nil
        }
        return carriers.map{ $0.mobileNetworkCode!}
    }
    
    // MARK: 3.7、ISO国家代码
    /// ISO国家代码
    /// - Returns: ISO国家代码
    static func isoCountryCodes() -> [String]? {
        // 获取并输出运营商信息
        guard  let carriers = getCarriers(), carriers.count > 0 else {
            return nil
        }
        return carriers.map{ $0.isoCountryCode!}
    }
    
    // MARK: 3.8、是否允许VoIP
    /// 是否允许VoIP
    /// - Returns: 是否允许VoIP
    static func isAllowsVOIPs() -> [Bool]? {
        // 获取并输出运营商信息
        guard let carriers = getCarriers(), carriers.count > 0 else {
            return nil
        }
        return carriers.map{ $0.allowsVOIP}
    }
    
    /// 获取并输出运营商信息
    /// - Returns: 运营商信息
    private static func getCarriers() -> [CTCarrier]? {
        guard !isSimulator() else {
            return nil
        }
        // 获取并输出运营商信息
        let info = CTTelephonyNetworkInfo()
        if #available(iOS 12.0, *) {
            guard let providers = info.serviceSubscriberCellularProviders else {
                return []
            }
            return providers.filter { $0.value.carrierName != nil }.allValues()
        } else {
            guard let carrier = info.subscriberCellularProvider, carrier.carrierName != nil else {
                return []
            }
            return [carrier]
        }
    }
    
    /// 根据数据业务信息获取对应的网络类型
    /// - Parameter currentRadioTech: 当前的无线电接入技术信息
    /// - Returns: 网络类型
    private static func getNetworkType(currentRadioTech: String) -> String {
        /**
         手机的数据业务对应的通信技术
         CTRadioAccessTechnologyGPRS：2G（有时又叫2.5G，介于2G和3G之间的过度技术）
         CTRadioAccessTechnologyEdge：2G （有时又叫2.75G，是GPRS到第三代移动通信的过渡)
         CTRadioAccessTechnologyWCDMA：3G
         CTRadioAccessTechnologyHSDPA：3G (有时又叫 3.5G)
         CTRadioAccessTechnologyHSUPA：3G (有时又叫 3.75G)
         CTRadioAccessTechnologyCDMA1x ：2G
         CTRadioAccessTechnologyCDMAEVDORev0：3G
         CTRadioAccessTechnologyCDMAEVDORevA：3G
         CTRadioAccessTechnologyCDMAEVDORevB：3G
         CTRadioAccessTechnologyeHRPD：3G (有时又叫 3.75G，是电信使用的一种3G到4G的演进技术)
         CTRadioAccessTechnologyLTE：4G (或者说接近4G)
         // 5G：NR是New Radio的缩写，新无线(5G)的意思，NRNSA表示5G NR的非独立组网（NSA）模式。
         CTRadioAccessTechnologyNRNSA：5G NSA
         CTRadioAccessTechnologyNR：5G
         */
        if #available(iOS 14.1, *), currentRadioTech == CTRadioAccessTechnologyNRNSA || currentRadioTech == CTRadioAccessTechnologyNR {
            return "5G"
        }
    
        var networkType = ""
        switch currentRadioTech {
        case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyCDMA1x:
            networkType = "2G"
        case CTRadioAccessTechnologyeHRPD, CTRadioAccessTechnologyWCDMA, CTRadioAccessTechnologyHSDPA, CTRadioAccessTechnologyCDMAEVDORev0, CTRadioAccessTechnologyCDMAEVDORevA, CTRadioAccessTechnologyCDMAEVDORevB, CTRadioAccessTechnologyHSUPA:
            networkType = "3G"
        case CTRadioAccessTechnologyLTE:
            networkType = "4G"
        default:
            break
        }
        return networkType
    }
}
