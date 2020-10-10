//
//  UIApplication+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/9.
//

import UIKit

public extension UIApplication {
    
    // MARK:- 获取顶部的控制器
    /// 获取顶部的控制器
    /// - Returns: description
    static func getTopViewController() -> UIViewController? {
        let currentController = getCurrentViewController()
        if let currentPresentedController = currentController?.getPresentedViewController() {
            return currentPresentedController
        }
        return currentController
    }
    
    // MARK: 获取当前的控制器
    /// 获取当前的控制器
    /// - Returns: description
    static func getCurrentViewController() -> UIViewController? {
        var window = UIApplication.shared.keyWindow
        if (window?.windowLevel != .normal) {
            let windows = UIApplication.shared.windows
            for win in windows {
                if (win.windowLevel == .normal) {
                    window = win
                    break
                }
            }
        }
        
        let frontView = window?.subviews[0]
        let nextResponder = frontView?.next
        if let next = nextResponder as? UIViewController {
            return next
        } else {
            return window?.rootViewController
        }
    }
}

extension UIApplication {

    public static let userAgent: String = {
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

    /// Returns app's name
    public static var appDisplayName: String {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        return ""
    }

    /// Returns app's version number
    public static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }

    /// Return app's build number
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    /// Return app's bundle ID
    public static var appBundleID: String {
        return Bundle.main.bundleIdentifier ?? ""
    }

    /// Returns current screen orientation
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }

    /// Get the top most view controller from the base view controller; default param is UIWindow's rootViewController
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
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

    /// Return app's version integer number
    public class func appVersionNum(_ appVersion: String?) -> Int {
        guard let appVersionTemp = appVersion else { return 0 }
        var appVersionString = appVersionTemp.replacingOccurrences(of: ".", with: "")
        guard appVersionString.length > 0 else { return 0 }
        if appVersionString.length == 2 {
            appVersionString = appVersionString.appending("0")
        }
        return appVersionString.toInt() ?? 0
    }

}
