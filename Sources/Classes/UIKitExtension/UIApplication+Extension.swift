//
//  UIApplication+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/9.
//

import UIKit
import CoreLocation

extension UIApplication: JKPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JKPOP where Base: UIApplication {
    //MARK: 1.1、获取当前的keyWindow
    /// 获取当前的keyWindow
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    // MARK: 1.2、获取屏幕的方向
    /// 获取屏幕的方向
    static var screenOrientation: UIInterfaceOrientation {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.interfaceOrientation ?? .landscapeLeft
        } else {
            return UIApplication.shared.statusBarOrientation
        }
    }
    
    // MARK: 1.3、获取根控制器
    /// 获取根控制器
    /// - Parameter base: 哪个控制器为基准
    /// - Returns: 返回 UIViewController
    static func topViewController(_ base: UIViewController? = UIApplication.jk.keyWindow?.rootViewController) -> UIViewController? {
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
    
    // MARK: 1.4、设备信息的获取
    /// 设备信息的获取
    static var userAgent: String {
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
        return "JK" + Bundle.jk.appVersion
    }
    
    // MARK: 1.5、app定位区域
    /// app定位区域
    static var localizations: String? {
        guard let weakInfoDictionary = Bundle.jk.infoDictionary, let content = weakInfoDictionary[String(kCFBundleLocalizationsKey)] else {
            return nil
        }
        return (content as! String)
    }
    
    // MARK: 1.6、网络状态是否可用
    /// 网络状态是否可用
    static func reachable() -> Bool {
        let data = NSData(contentsOf: URL(string: "https://www.baidu.com/")!)
        return (data != nil)
    }
    
    // MARK: 1.7、检查用户是否打开系统推送权限
    /// 检查用户是否打开系统推送权限
    // 判断用户是否允许推送
    static func checkPushNotification(completion: @escaping (_ authorized: Bool) -> ()) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if (settings.authorizationStatus == .authorized){
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else {
            let _autorized = UIApplication.shared.currentUserNotificationSettings?.types.contains(.alert) ?? false
            completion(_autorized)
        }
    }
    
    // MARK: 1.8、注册APNs远程推送
    /// 注册APNs远程推送
    static func registerAPNsWithDelegate(_ delegate: Any) {
        if #available(iOS 10.0, *) {
            let options: UNAuthorizationOptions = [.alert, .badge, .sound]
            let center = UNUserNotificationCenter.current()
            center.delegate = (delegate as! UNUserNotificationCenterDelegate)
            center.requestAuthorization(options: options){ (granted: Bool, error:Error?) in
                if granted {
                    print("success")
                }
            }
            UIApplication.shared.registerForRemoteNotifications()
            //            center.delegate = self
        } else {
            // 请求授权
            let types: UIUserNotificationType = [.alert, .badge, .sound]
            let settings = UIUserNotificationSettings(types: types, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            // 需要通过设备UDID, 和app bundle id, 发送请求, 获取deviceToken
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    @available(iOS 10.0, *)
    func addLocalUserNoti(trigger: AnyObject,
                          content: UNMutableNotificationContent,
                       identifier: String,
                   notiCategories: AnyObject,
                          repeats: Bool = true,
                          handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        
        var notiTrigger: UNNotificationTrigger?
        if let date = trigger as? NSDate {
            var interval = date.timeIntervalSince1970 - NSDate().timeIntervalSince1970
            interval = interval < 0 ? 1 : interval
            notiTrigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeats)
        } else if let components = trigger as? DateComponents {
            notiTrigger = UNCalendarNotificationTrigger(dateMatching: components as DateComponents, repeats: repeats)
        } else if let region = trigger as? CLCircularRegion {
            notiTrigger = UNLocationNotificationTrigger(region: region, repeats: repeats)
        }
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: notiTrigger)
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error) in
            if error == nil {
                return
            }
            JKPrint("推送已添加成功")
        }
    }
    
    // MARK: 1.9、app商店链接
    /// app商店链接
    @discardableResult
    static func appSroreUrlWithID(_ appleID: String) -> String {
        return "itms-apps://itunes.apple.com/app/id\(appleID)?mt=8"
    }
    
    // MARK: 1.10、打开app商店链接
    /// app商店链接
    static func openAppSroreUrlWithID(_ appleID: String)  {
        let appStoreUrl = appSroreUrlWithID(appleID)
        openThirdPartyApp(thirdPartyAppDeeplink: appStoreUrl) { _ in
        }
    }
    
    // MARK: 1.11、app详情链接
    /// app详情链接
    @discardableResult
    static func appDetailUrlWithID(_ appleID: String) -> String {
        let detailUrl = "http://itunes.apple.com/cn/lookup?id=\(appleID)"
        return detailUrl
    }
    
    // MARK: 1.12、评分App链接
    /// 评分App链接
    @discardableResult
    static func rateAppUrlWithID(_ appleID: String) -> String {
        return "itms-apps://itunes.apple.com/app/id\(appleID)?action=write-review"
    }
    
    // MARK: 1.13、打开评分App界面
    /// 打开评分App链接
    static func openRateAppUrlWithID(_ appleID: String) {
        let rateAppUrl = rateAppUrlWithID(appleID)
        openThirdPartyApp(thirdPartyAppDeeplink: rateAppUrl) { _ in
        }
    }
    
    //MARK: 1.14、设置APP是否常亮
    /// 设置APP是否常亮
    static func isIdleTimerDisabled(isIdleTimerDisabled: Bool) {
        UIApplication.shared.isIdleTimerDisabled = isIdleTimerDisabled
    }
    
    //MARK: 1.15、APP主动崩溃
    /// APP主动崩溃
    static func exitApp() {
        // 默认的程序结束函数
        abort()
    }
}

// MARK: - 二、打开系统应用和第三方APP
/// 系统app
public enum JKSystemAppType: String {
    case safari = "http://"
    case googleMaps = "http://maps.google.com"
    case Phone = "tel://"
    case SMS = "sms://"
    case Mail = "mailto://"
    case iBooks = "ibooks://"
    case AppStore = "itms-apps://itunes.apple.com"
    case Music = "music://"
    case Videos = "videos://"
}

public extension JKPOP where Base: UIApplication {
    // MARK: 2.1、打开系统app
    /// 打开系统app
    /// - Parameter type: 系统app类型
    static func openSystemApp(type: JKSystemAppType, complete: @escaping ((Bool) -> Void)) {
        JKGlobalTools.openUrl(url: URL(string: type.rawValue)!, complete: complete)
    }
    
    // MARK: 2.2、打开第三方app
    /// 打开第三方app
    /// - Parameter thirdPartyAppDeeplink: 第三方app的Deeplink
    static func openThirdPartyApp(thirdPartyAppDeeplink: String, complete: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: thirdPartyAppDeeplink) else {
            complete(false)
            return
        }
        JKGlobalTools.openUrl(url: url, complete: complete)
    }
}
