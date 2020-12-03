//
//  JKGlobalTools.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/12/3.
//

import UIKit
import StoreKit

// MARK:- 一、基本的工具
public struct JKGlobalTools {
    
    // MARK: 1.1、拨打电话
    /// 拨打电话的才处理
    /// - Parameter phoneNumber: 电话号码
    public static func callPhone(phoneNumber: String, complete: @escaping ((Bool) -> Void)) {
        // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
        guard let phoneNumberEncoding = ("tel://" + phoneNumber).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let url = URL(string: phoneNumberEncoding), UIApplication.shared.canOpenURL(url) else {
            // 不能跳转就不要往下执行了
            complete(false)
            return
        }
        // iOS 10.0 以前
        guard #available(iOS 10.0, *)  else {
            let success = UIApplication.shared.openURL(url)
            if (success) {
                JKPrint("10以前可以跳转")
                complete(true)
            } else {
                JKPrint("10以前不能完成跳转")
                complete(false)
            }
            return
        }
        // iOS 10.0 以后
        UIApplication.shared.open(url, options: [:]) { (success) in
            if (success) {
                JKPrint("10以后可以跳转url")
                complete(true)
            } else {
                JKPrint("10以后不能完成跳转")
                complete(false)
            }
        }
    }
    
    // MARK: 1.2、应用跳转
    /// 应用跳转
    /// - Parameters:
    ///   - vc: 跳转时所在控制器
    ///   - appId: app的id(开发者账号里面：应用注册后生成的)
    public static func updateApp(vc: UIViewController, appId: String)  {
        guard appId.count > 0 else {
            return
        }
        let productView = SKStoreProductViewController()
        // productView.delegate = (vc as! SKStoreProductViewControllerDelegate)
        productView.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier : appId], completionBlock: { (result, error) in
            if !result {
                //点击取消
                productView.dismiss(animated: true, completion: nil)
            }
        })
        vc.showDetailViewController(productView, sender: vc)
    }
    
    // MARK: 1.3、从 storyboard 中唤醒 viewcontroller
    /// 从 storyboard 中唤醒 viewcontroller
    /// - Parameters:
    ///   - storyboardID: viewcontroller 在 storyboard 中的 id
    ///   - fromStoryboard: storyboard 名称
    ///   - bundle: Bundle  默认为 main
    /// - Returns: UIviewcontroller
    public static func getViewController(storyboardID: String, fromStoryboard: String, bundle: Bundle? = nil) -> UIViewController {
        let sBundle = bundle ?? Bundle.main
        let story = UIStoryboard(name: fromStoryboard, bundle: sBundle)
        return story.instantiateViewController(withIdentifier: storyboardID)
    }
    
    // MARK: 1.3、传进某个版本号 个 当前app版本号作对比，注意：版本号必须是三位的，比如：1.1.1、1.23.45、23.4.6
    /// 传进某个版本号 个 当前app版本号作对比
    /// - Parameter version: 传进来的版本号码
    /// - Returns: 返回对比加过，true：比当前的版本大，false：比当前的版本小
    public static func compareVersion(version: String) -> Bool {
        
        // 1、传进来的版本号获取 三位Int值
        let newVersionResult = appVersion(version: version)
        guard newVersionResult.isSuccess else {
            return false
        }
        
        // 2、当前版本的版本号获取 三位Int值
        let currentVersion = UIApplication.appVersion
        let currentVersionResult = appVersion(version: currentVersion)
        guard currentVersionResult.isSuccess else {
            return false
        }
        
        if newVersionResult.versions[0] > currentVersionResult.versions[0] {
            return true
        } else if newVersionResult.versions[0] == currentVersionResult.versions[0] {
            if newVersionResult.versions[1] > currentVersionResult.versions[1] {
                return true
            } else if newVersionResult.versions[1] > currentVersionResult.versions[1] {
                if newVersionResult.versions[3] > currentVersionResult.versions[3] {
                    return true
                } else if newVersionResult.versions[3] > currentVersionResult.versions[3] {
                    return false
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    // MARK: 版本号 version 分隔三个 Int 值
    /// 分隔版本号
    /// - Parameter version: 版本号
    /// - Returns: 结果 和 版本号数组
    private static func appVersion(version: String) -> (isSuccess: Bool, versions: [Int]) {
        let versionArray = version.separatedByString(char: ".")
        guard versionArray.count == 3, let versionString1 = versionArray[0] as? String, let versionString2 = versionArray[1] as? String, let versionString3 = versionArray[2] as? String else {
            return (false, [])
        }
        guard let versionValue1 = versionString1.toInt(), let versionValue2 = versionString2.toInt(), let versionValue3 = versionString3.toInt() else {
            return (false, [])
        }
        return (true, [versionValue1, versionValue2, versionValue3])
    }
}
