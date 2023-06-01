//
//  UIApplicationExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIApplicationExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、APP权限的检测", "三、打开系统应用和第三方APP"]
        dataArray = [["获取屏幕的方向", "获取根控制器", "设备信息的获取", "app定位区域", "网络状态是否可用", "消息推送是否可用", "注册APNs远程推送", "app商店链接", "app详情链接", "APP是否常亮", "APP主动崩溃"], ["判断是否拥有权限，目前支持 照相机、相册、麦克风、定位，提示：这里判断是这些权限有没有被用户手动关闭", "打开淘宝"], ["打开 safari", "打开googleMaps", "打开打电话Phone", "打开SMS", "打开Mail", "打开iBooks", "打开AppStore", "打开Music", "打开Videos", "打开微信", "打开QQ", "打开腾讯微博", "打开淘宝", "打开支付宝", "打开微博","打开QQ浏览器", "打开UC浏览器", "打开海豚浏览器", "打开欧朋浏览器", "打开搜狗浏览器", "打开百度地图", "打开谷歌Chrome浏览器", "打开优酷", "打开京东", "打开人人", "打开美团", "打开1号店", "打开我查查", "打开有道词典", "打开知乎", "打开点评", "打开微盘", "打开豆瓣fm", "打开网易公开课", "打开名片全能王", "打开QQ音乐", "打开腾讯视频", "打开豆瓣电影", "打开网易云音乐", "打开网易新闻", "打开网易应用", "打开网易彩票", "打开有道云笔记", "打开多看", "打开全国空气质量指数", "打开百度音乐", "打开下厨房"]]
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

// MARK: - 三、打开系统应用和第三方APP
extension UIApplicationExtensionViewController {
    
    // MARK: 3.48、下厨房
    @objc func test348() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.xcfapp.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    // MARK: 3.47、百度音乐
    @objc func test347() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.baidumusic.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.46、全国空气质量指数
    @objc func test346() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.dirtybeijing.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    // MARK: 3.45、打开多看
    @objc func test345() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.duokan.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.44、打开有道云笔记
    @objc func test344() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.youdaonote.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.43、打开网易彩票
    @objc func test343() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.ntescaipiao.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.42、打开网易应用
    @objc func test342() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.apper.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.41、打开网易新闻
    @objc func test341() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.newsapp.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.40、打开网易云音乐
    @objc func test340() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.orpheus.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.39、打开豆瓣电影
    @objc func test339() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.doubanmovie.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.38、打开腾讯视频
    @objc func test338() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.tenvideo.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.37、QQ音乐
    @objc func test337() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.qqmusic.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.36、打开名片全能王
    @objc func test336() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.camcard.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.35、打开网易公开课
    @objc func test335() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.ntesopen.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.34、打开豆瓣fm
    @objc func test334() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.doubanradio.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.33、打开微盘
    @objc func test333() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.sinavdisk.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.32、打开点评
    @objc func test332() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.dianping.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.31、打开知乎
    @objc func test331() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.zhihu.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.30、打开有道词典
    @objc func test330() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.youdaonote.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.29、打开我查查
    @objc func test329() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.wcc.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.28、打开1号店
    @objc func test328() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.wccbyihaodian.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.27、打开美团
    @objc func test327() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.meituan.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.26、打开
    @objc func test326() {
        
    }
    
    // MARK: 3.25、打开人人
    @objc func test325() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.renren.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.24、打开京东
    @objc func test324() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.jd.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.23、打开优酷
    @objc func test323() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.youku.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.22、打开谷歌Chrome浏览器
    @objc func test322() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.googlechrome.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.21、打开百度地图
    @objc func test321() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.baidumap.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.20、打开搜狗浏览器
    @objc func test320() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.sogouMSE.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.19、打开欧朋浏览器
    @objc func test319() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.ohttp.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.18、打开海豚浏览器
    @objc func test318() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.dolphin.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.17、打开UC浏览器
    @objc func test317() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.ucbrowser.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.16、打开QQ浏览器
    @objc func test316() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.mqqbrowser.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.15、打开微博
    @objc func test315() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.weico.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.14、打开支付宝
    @objc func test314() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.alipay.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.13、打开淘宝
    @objc func test313() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.taobao.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.12、打开腾讯微博
    @objc func test312() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.tencentWeibo.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.11、打开QQ
    @objc func test311() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.qq.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.10、打开微信
    @objc func test310() {
        UIApplication.jk.openThirdPartyApp(thirdPartyAppDeeplink: JKThirdPartyAppType.weixin.rawValue) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.9、打开Videos
    @objc func test39() {
        UIApplication.jk.openSystemApp(type: .Videos) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.8、打开Music
    @objc func test38() {
        UIApplication.jk.openSystemApp(type: .Music) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.7、打开AppStore
    @objc func test37() {
        UIApplication.jk.openSystemApp(type: .AppStore) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.6、打开iBooks
    @objc func test36() {
        UIApplication.jk.openSystemApp(type: .iBooks) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.5、打开Mail
    @objc func test35() {
        UIApplication.jk.openSystemApp(type: .Mail) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.4、打开SMS
    @objc func test34() {
        UIApplication.jk.openSystemApp(type: .SMS) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.3、打开 打电话Phone
    @objc func test33() {
        UIApplication.jk.openSystemApp(type: .Phone) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.2、打开 googleMaps
    @objc func test32() {
        UIApplication.jk.openSystemApp(type: .googleMaps) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.1、打开 safari
    @objc func test31() {
        UIApplication.jk.openSystemApp(type: .safari) { (result) in
            JKPrint("结果：\(result)")
        }
    }
}

// MARK: - 二、APP权限的检测
extension UIApplicationExtensionViewController {
    
    @objc func test22() {
        let urlString = "itms-apps://itunes.apple.com/gb/app/yi-dong-cai-bian/id336141475?mt=8"
        JKGlobalTools.openUrl(url: URL(string: urlString)!) { (result) in
            
        }
    }
    
    // MARK: 2.1、判断是否拥有权限，目前支持 照相机、相册、麦克风、定位，提示：这里判断是这些权限有没有被用户手动关闭
    @objc func test21() {
        let result1 = UIApplication.jk.isOpenPermission(.camera)
        let result2 = UIApplication.jk.isOpenPermission(.album)
        let result3 = UIApplication.jk.isOpenPermission(.audio)
        let result4 = UIApplication.jk.isOpenPermission(.location)
        JKPrint(" 照相机：\(result1)、相册：\(result2)、麦克风：\(result3)、定位：\(result4)")
    }
}
// MARK: - 一、基本的扩展
extension UIApplicationExtensionViewController {

    // MARK: 1.11、APP主动崩溃
    @objc func test111() {
        JKPrint("app详情链接：\(UIApplication.jk.exitApp())")
    }
    
    // MARK: 1.10、APP是否常亮
    @objc func test110() {
        JKPrint("APP是否常亮：\(UIApplication.jk.isIdleTimerDisabled(isIdleTimerDisabled: true))")
    }
    
    // MARK: 1.9、app详情链接
    @objc func test19() {
        JKPrint("app详情链接：\(UIApplication.jk.appDetailUrlWithID(""))")
    }
    
    // MARK: 1.8、app商店链接
    @objc func test18() {
        JKPrint("app商店链接：\(UIApplication.jk.appUrlWithID(""))")
    }
    
    // MARK: 1.7、注册APNs远程推送
    @objc func test17() {
        JKPrint("注册APNs远程推送：\(UIApplication.jk.registerAPNsWithDelegate(self))")
    }
    
    // MARK: 1.6、消息推送是否可用
    @objc func test16() {
        JKPrint("消息推送是否可用：\(UIApplication.jk.hasRightOfPush())")
    }
    
    // MARK: 1.5、网络状态是否可用
    @objc func test15() {
        JKPrint("网络状态是否可用：\(UIApplication.jk.reachable())")
    }
    
    // MARK: 1.4、app定位区域
    @objc func test14() {
        JKPrint("app定位区域", "\(UIApplication.jk.localizations ?? "")")
    }
    
    // MARK: 1.3、设备信息的获取
    @objc func test13() {
        JKPrint("设备信息的获取", "\(UIApplication.jk.userAgent)")
    }
    
    // MARK: 1.2、获取根控制器
    @objc func test12() {
        guard let vc = UIApplication.jk.topViewController() else {
            return
        }
        JKPrint("获取屏幕的方向", "\(vc.className)")
    }
    
    // MARK: 1.1、获取屏幕的方向
    @objc func test11() {
        JKPrint("获取屏幕的方向", "\(UIApplication.jk.screenOrientation.rawValue)")
    }
}
