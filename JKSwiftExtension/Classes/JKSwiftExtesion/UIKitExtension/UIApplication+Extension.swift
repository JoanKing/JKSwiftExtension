//
//  UIApplication+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/9.
//

import UIKit
import Photos

extension UIApplication: JKPOPCompatible {}
// MARK:- 一、基本的扩展
public extension JKPOP where Base: UIApplication {
    
    // MARK: 1.1、获取屏幕的方向
    /// 获取屏幕的方向
    static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    // MARK: 1.2、获取根控制器
    /// 获取根控制器
    /// - Parameter base: 哪个控制器为基准
    /// - Returns: 返回 UIViewController
    static func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
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
    
    // MARK: 1.3、设备信息的获取
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
    
    // MARK: 1.4、app定位区域
    /// app定位区域
    static var localizations: String? {
        guard let weakInfoDictionary = Bundle.jk.infoDictionary, let content = weakInfoDictionary[String(kCFBundleLocalizationsKey)] else {
            return nil
        }
        return (content as! String)
    }
    
    // MARK: 1.5、网络状态是否可用
    /// 网络状态是否可用
    static func reachable() -> Bool {
        let data = NSData(contentsOf: URL(string: "https://www.baidu.com/")!)
        return (data != nil)
    }
    
    // MARK: 1.6、消息推送是否可用
    /// 消息推送是否可用
    static func hasRightOfPush() -> Bool {
        let notOpen = UIApplication.shared.currentUserNotificationSettings?.types == UIUserNotificationType(rawValue: 0)
        return !notOpen
    }
    
    // MARK: 1.7、注册APNs远程推送
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
    
    // MARK: 1.8、app商店链接
    /// app商店链接
    @discardableResult
    static func appUrlWithID(_ appStoreID: String) -> String {
        let appStoreUrl = "itms-apps://itunes.apple.com/app/id\(appStoreID)?mt=8"
        return appStoreUrl
    }
    
    // MARK: 1.9、app详情链接
    /// app详情链接
    @discardableResult
    static func appDetailUrlWithID(_ appStoreID: String) -> String {
        let detailUrl = "http://itunes.apple.com/cn/lookup?id=\(appStoreID)"
        return detailUrl
    }
}

// MARK:- 二、APP权限的检测
public enum JKAppPermissionType {
    // 照相机
    case camera
    // 相册
    case album
    // 麦克风
    case audio
    // 定位
    case location
}
public extension JKPOP where Base: UIApplication {
    
    // MARK: 2.1、判断是否拥有权限，目前支持 照相机、相册、麦克风、定位，提示：这里判断是这些权限有没有被用户手动关闭
    /// 判断是否拥有权限，目前支持 照相机、相册、麦克风、定位，提示：这里判断是这些权限有没有被用户手动关闭
    /// - Parameter permission: 权限的类型
    /// - Returns: 结果
    static func isOpenPermission(_ permission: JKAppPermissionType) -> Bool {
        
        var result: Bool = true
        if permission == .camera || permission == .audio {
            // 是否开启相机和麦克风权限
            let authStatus = AVCaptureDevice.authorizationStatus(for: permission == .camera ? .video : .audio)
            result = authStatus != .restricted && authStatus != .denied
        } else if permission == .album {
            // 是否开启相册权限
            let authStatus = PHPhotoLibrary.authorizationStatus()
            result = authStatus != .restricted && authStatus != .denied
        } else if permission == .location {
            // 是否开启定位权限
            let authStatus = CLLocationManager.authorizationStatus()
            return authStatus != .restricted && authStatus != .denied
        }
        return result
    }
}

// MARK:- 三、打开系统应用和第三方APP
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

/// 第三方app
public enum JKThirdPartyAppType: String {
    /// 微信
    case weixin = "weixin://"
    /// QQ
    case qq = "mqq://"
    /// 腾讯微博
    case tencentWeibo = "TencentWeibo://"
    /// 淘宝
    case taobao = "taobao://"
    /// 支付宝
    case alipay = "alipay://"
    /// 微博
    case weico = "weico://"
    /// QQ浏览器
    case mqqbrowser = "mqqbrowser://"
    /// uc浏览器
    case ucbrowser = " ucbrowser://"
    /// 海豚浏览器
    case dolphin = "dolphin://"
    /// 欧朋浏览器
    case ohttp = "ohttp://"
    /// 搜狗浏览器
    case sogouMSE = "SogouMSE://"
    ///  百度地图
    case baidumap = "baidumap://"
    /// 谷歌Chrome浏览器
    case googlechrome = "googlechrome://"
    ///  优酷
    case youku = "youku://"
    /// 京东
    case jd = "openapp.jdmoble://"
    /// 人人
    case renren = "renren://"
    /// 美团
    case meituan = "imeituan://"
    /// 1号店
    case wccbyihaodian = "wccbyihaodian://"
    /// 我查查
    case wcc = " wcc://"
    /// 有道词典
    case yddictproapp = "yddictproapp://"
    /// 知乎
    case zhihu = "zhihu://"
    /// 点评
    case dianping = "dianping://"
    /// 微盘
    case sinavdisk = "sinavdisk://"
    /// 豆瓣fm
    case doubanradio = "doubanradio://"
    /// 网易公开课
    case ntesopen = "ntesopen://"
    /// 名片全能王
    case camcard = "camcard://"
    /// QQ音乐
    case qqmusic = "qqmusic://"
    /// 腾讯视频
    case tenvideo = "envideo://"
    /// 豆瓣电影
    case doubanmovie = "doubanmovie://"
    /// 网易云音乐
    case orpheus = "orpheus://"
    /// 网易新闻
    case newsapp = "newsapp://"
    /// 网易应用
    case apper = "apper://"
    /// 网易彩票
    case ntescaipiao = "ntescaipiao://"
    /// 有道云笔记
    case youdaonote = "youdaonote://"
    /// 多看
    case duokan = "duokan-reader://"
    /// 全国空气质量指数
    case dirtybeijing = "dirtybeijing://"
    /// 百度音乐
    case baidumusic = "baidumusic://"
    /// 下厨房
    case xcfapp = " xcfapp://"
}
 
public extension JKPOP where Base: UIApplication {
    // MARK: 打开系统app
    /// 打开系统app
    /// - Parameter type: 系统app类型
    static func openSystemApp(type: JKSystemAppType, complete: @escaping ((Bool) -> Void)) {
        JKGlobalTools.openUrl(url: URL(string: type.rawValue)!, complete: complete)
    }
    
    // MARK: 打开第三方app
    /// 打开第三方app
    /// - Parameter type: 第三方app类型
    static func openThirdPartyApp(type: JKThirdPartyAppType, complete: @escaping ((Bool) -> Void)) {
        JKGlobalTools.openUrl(url: URL(string: type.rawValue)!, complete: complete)
    }
}
