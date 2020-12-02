//
//  UIDevice+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/30.
//

import Foundation

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
public extension UIDevice {
    
    // MARK: 1.1、设备的名字
    /// 设备的名字
    static let modelName: String = {
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
    }()
    
    // MARK: 1.2、获取设备类型
    /// 获取设备类型
    /// - Returns: 设备类型
    static func screenType() -> UIDeviceScreenType {
        let modelName = UIDevice.modelName
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
        let modelName = UIDevice.modelName
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
    class func isIphone5Screen() -> Bool {
        if UIDevice.screenType() == .IPHONE_5 {
            return true
        }
        return false
    }
    
    // MARK: 1.7、判断是否是 iphone6
    /// 判断是否是 iphone5
    /// - Returns: bool
    class func isIphone6Screen() -> Bool {
        if UIDevice.screenType() == .IPHONE_6 {
            return true
        }
        return false
    }
    
    // MARK: 1.8、是不是 x 系列
    /// 是不是 x 系列
    /// - Returns: bool
    static func isIphoneXScreen() -> Bool {
        if UIDevice.screenType() == .IPHONE_X || UIDevice.screenType() == .IPHONE_XS || UIDevice.screenType() == .IPHONE_XR || UIDevice.screenType() == .IPHONE_XS_Max ||  UIDevice.screenType() == .IPHONE_11 ||  UIDevice.screenType() == .IPHONE_11_PRO ||  UIDevice.screenType() == .IPHONE_11_PRO_MAX {
            return true
        }
        return false
    }
    
    // MARK: 1.9、是不是 xs系列
    /// 是不是 xs 系列
    /// - Returns: bool
    static func isIphoneXSScreen() -> Bool {
        if UIDevice.screenType() == .IPHONE_XS || UIDevice.screenType() == .IPHONE_XR || UIDevice.screenType() == .IPHONE_XS_Max {
            return true
        }
        return false
    }
}

// MARK:- 二、设备的基本信息
public extension UIDevice {
    
    // MARK: 2.1、当前设备的系统版本
    /// 当前设备的系统版本
    static var currentSystemVersion : String {
        get {
            return UIDevice.current.systemVersion
        }
    }
    
    // MARK: 2.2、当前系统的名称
    /// 当前系统的名称
    static var currentSystemName : String {
        get {
            return UIDevice.current.systemName
        }
    }
    
    // MARK: 2.3、当前设备的名称
    /// 当前设备的名称
    static var currentDeviceName : String {
        get {
            return UIDevice.current.name
        }
    }
    
    
}

