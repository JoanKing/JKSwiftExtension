//
//  UIApplicationExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension
class UIApplicationExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、打开系统应用和第三方APP"]
        dataArray = [["获取当前的keyWindow", "获取屏幕的方向", "获取根控制器", "设备信息的获取", "app定位区域", "网络状态是否可用", "消息推送是否可用", "注册APNs远程推送", "app商店链接", "打开app商店链接", "app详情链接", "评分App链接", "打开评分App界面", "设置APP是否常亮", "APP主动崩溃"], ["打开系统app", "打开淘宝"], ["打开系统app，比如safari", "打开第三方app，比如淘宝"]]
    }
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

// MARK: - 二、打开系统应用和第三方APP
extension UIApplicationExtensionViewController {
    
    // MARK: 2.02、打开第三方app，比如淘宝
    @objc func test202() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.taobao.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 2.1、打开系统app，比如safari
    @objc func test201() {
        UIApplication.jk.openSystemApp(type: .safari) { (result) in
            JKPrint("结果：\(result)")
        }
    }
}

// MARK: - 一、基本的扩展
extension UIApplicationExtensionViewController {

    // MARK: 1.15、APP主动崩溃
    @objc func test115() {
        JKPrint("app详情链接：\(UIApplication.jk.exitApp())")
    }
    
    // MARK: 1.14、设置APP是否常亮
    @objc func test114() {
        JKPrint("设置APP是否常亮：\(UIApplication.jk.isIdleTimerDisabled(isIdleTimerDisabled: true))")
    }
    
    //MARK: 1.13、打开评分App界面
    @objc func test113() {
        JKPrint("打开评分App界面")
        UIApplication.jk.openRateAppUrlWithID("1142110895")
    }
    
    // MARK: 1.12、评分App链接
    @objc func test112() {
        // 这里以打开抖音详情链接为例
        JKPrint("评分App链接：\(UIApplication.jk.rateAppUrlWithID("1142110895"))")
    }
    
    // MARK: 1.11、app详情链接
    @objc func test111() {
        // 这里以抖音详情链接为例
        UIApplication.jk.appDetailUrlWithID("1142110895")
    }
    
    // MARK: 1.10、打开app商店链接
    @objc func test110() {
        // 这里以抖音为例 打开app商店链接
        JKPrint("打开app商店链接")
        UIApplication.jk.openAppSroreUrlWithID("1142110895")
    }
    
    // MARK: 1.09、app商店链接
    @objc func test109() {
        // 这里以抖音为例
        JKPrint("app商店链接：\(UIApplication.jk.appSroreUrlWithID("1142110895"))")
    }
    
    // MARK: 1.08、注册APNs远程推送
    @objc func test108() {
        JKPrint("注册APNs远程推送：\(UIApplication.jk.registerAPNsWithDelegate(self))")
    }
    
    // MARK: 1.07、消息推送是否可用
    @objc func test107() {
        UIApplication.jk.checkPushNotification { authorized in
            JKPrint("消息推送是否可用：\(authorized)")
        }
    }
    
    // MARK: 1.06、网络状态是否可用
    @objc func test106() {
        JKPrint("网络状态是否可用：\(UIApplication.jk.reachable())")
    }
    
    // MARK: 1.05、app定位区域
    @objc func test105() {
        JKPrint("app定位区域", "\(UIApplication.jk.localizations ?? "")")
    }
    
    // MARK: 1.04、设备信息的获取
    @objc func test104() {
        JKPrint("设备信息的获取", "\(UIApplication.jk.userAgent)")
    }
    
    // MARK: 1.03、获取根控制器
    @objc func test103() {
        guard let vc = UIApplication.jk.topViewController() else {
            return
        }
        JKPrint("获取屏幕的方向", "\(vc.className)")
    }
    
    // MARK: 1.02、获取屏幕的方向
    @objc func test102() {
        JKPrint("获取屏幕的方向", "\(UIApplication.jk.screenOrientation.rawValue)")
    }
    
    //MARK: 1.01、获取当前的keyWindow
    @objc func test101() {
        guard let window = UIApplication.jk.keyWindow else{return}
        JKPrint("获取当前的keyWindow", "\(window)")
    }
}
