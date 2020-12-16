//
//  UIApplication+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/9.
//

import UIKit

// MARK:- 一、基本的扩展
public extension UIApplication {
    
    // MARK: 1.1、Info.plist
    /// Info.plist
    static let infoDictionary: [String : Any]? = Bundle.main.infoDictionary
    // MARK: 1.2、项目名称
    /// 项目名称
    static var projectName: String {
        guard let weakInfoDictionary =  infoDictionary , let content = weakInfoDictionary[String(kCFBundleLocalizationsKey)] else {
            return ""
        }
        return content as! String
    }
    // MARK: 1.3、获取app的名字
    /// 获取app的名字
    static var appDisplayName: String {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        return ""
    }
    
    // MARK: 1.4、获取app的版本号
    /// 获取app的版本号
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    // MARK: 1.5、获取app的 Build ID
    /// 获取app的 Build ID
    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    // MARK: 1.6、获取app的 Bundle Identifier
    /// 获取app的 Bundle Identifier
    static var appBundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? ""
    }

    // MARK: 1.7、获取屏幕的方向
    /// 获取屏幕的方向
    static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    // MARK: 1.8、获取根控制器
    /// 获取根控制器
    /// - Parameter base: 哪个控制器为基准
    /// - Returns: 返回 UIViewController
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
    // MARK: 1.9、设备信息的获取
    /// 设备信息的获取
    static let userAgent: String = {
        if let info = Bundle.main.infoDictionary {
            let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
            let bundle = info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
            let version = info[kCFBundleVersionKey as String] as? String ?? "Unknown"
            let osNameVersion: String = {
                let versionString: String
                if #available(OSX 10.10, *) {
                    let version = ProcessInfo.processInfo.operatingSystemVersion
                    versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
                } else {
                    versionString = "10.9"
                }
                return "iOS \(versionString)"
            }()
            return "\(executable)/\(bundle) (\(version); \(osNameVersion))"
        }
        return "JK" + UIApplication.appVersion
    }()
    
    // MARK: 1.10、app定位区域
    /// app定位区域
    static var localizations: String? {
        guard let weakInfoDictionary =  infoDictionary, let content = weakInfoDictionary[String(kCFBundleLocalizationsKey)] else {
            return nil
        }
        return (content as! String)
    }
    
}
