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

// MARK: - 三、打开系统应用和第三方APP
extension UIApplicationExtensionViewController {
    
    // MARK: 3.48、下厨房
    @objc func test348() {
        UIApplication.jk.openThirdPartyApp(type: .xcfapp) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    // MARK: 3.47、百度音乐
    @objc func test347() {
        UIApplication.jk.openThirdPartyApp(type: .baidumusic) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.46、全国空气质量指数
    @objc func test346() {
        UIApplication.jk.openThirdPartyApp(type: .dirtybeijing) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    // MARK: 3.45、打开多看
    @objc func test345() {
        UIApplication.jk.openThirdPartyApp(type: .duokan) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.44、打开有道云笔记
    @objc func test344() {
        UIApplication.jk.openThirdPartyApp(type: .youdaonote) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.43、打开网易彩票
    @objc func test343() {
        UIApplication.jk.openThirdPartyApp(type: .ntescaipiao) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.42、打开网易应用
    @objc func test342() {
        UIApplication.jk.openThirdPartyApp(type: .apper) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.41、打开网易新闻
    @objc func test341() {
        UIApplication.jk.openThirdPartyApp(type: .newsapp) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.40、打开网易云音乐
    @objc func test340() {
        UIApplication.jk.openThirdPartyApp(type: .orpheus) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.39、打开豆瓣电影
    @objc func test339() {
        UIApplication.jk.openThirdPartyApp(type: .doubanmovie) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.38、打开腾讯视频
    @objc func test338() {
        UIApplication.jk.openThirdPartyApp(type: .tenvideo) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.37、QQ音乐
    @objc func test337() {
        UIApplication.jk.openThirdPartyApp(type: .qqmusic) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.36、打开名片全能王
    @objc func test336() {
        UIApplication.jk.openThirdPartyApp(type: .camcard) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.35、打开网易公开课
    @objc func test335() {
        UIApplication.jk.openThirdPartyApp(type: .ntesopen) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.34、打开豆瓣fm
    @objc func test334() {
        UIApplication.jk.openThirdPartyApp(type: .doubanradio) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.33、打开微盘
    @objc func test333() {
        UIApplication.jk.openThirdPartyApp(type: .sinavdisk) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.32、打开点评
    @objc func test332() {
        UIApplication.jk.openThirdPartyApp(type: .dianping) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.31、打开知乎
    @objc func test331() {
        UIApplication.jk.openThirdPartyApp(type: .zhihu) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.30、打开有道词典
    @objc func test330() {
        UIApplication.jk.openThirdPartyApp(type: .youdaonote) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.29、打开我查查
    @objc func test329() {
        UIApplication.jk.openThirdPartyApp(type: .wcc) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.28、打开1号店
    @objc func test328() {
        UIApplication.jk.openThirdPartyApp(type: .wccbyihaodian) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.27、打开美团
    @objc func test327() {
        UIApplication.jk.openThirdPartyApp(type: .meituan) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.26、打开
    @objc func test326() {
        
    }
    
    // MARK: 3.25、打开人人
    @objc func test325() {
        UIApplication.jk.openThirdPartyApp(type: .renren) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.24、打开京东
    @objc func test324() {
        UIApplication.jk.openThirdPartyApp(type: .jd) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.23、打开优酷
    @objc func test323() {
        UIApplication.jk.openThirdPartyApp(type: .youku) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.22、打开谷歌Chrome浏览器
    @objc func test322() {
        UIApplication.jk.openThirdPartyApp(type: .googlechrome) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.21、打开百度地图
    @objc func test321() {
        UIApplication.jk.openThirdPartyApp(type: .baidumap) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.20、打开搜狗浏览器
    @objc func test320() {
        UIApplication.jk.openThirdPartyApp(type: .sogouMSE) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.19、打开欧朋浏览器
    @objc func test319() {
        UIApplication.jk.openThirdPartyApp(type: .ohttp) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.18、打开海豚浏览器
    @objc func test318() {
        UIApplication.jk.openThirdPartyApp(type: .dolphin) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.17、打开UC浏览器
    @objc func test317() {
        UIApplication.jk.openThirdPartyApp(type: .ucbrowser) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.16、打开QQ浏览器
    @objc func test316() {
        UIApplication.jk.openThirdPartyApp(type: .mqqbrowser) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.15、打开微博
    @objc func test315() {
        UIApplication.jk.openThirdPartyApp(type: .weico) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.14、打开支付宝
    @objc func test314() {
        UIApplication.jk.openThirdPartyApp(type: .alipay) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.13、打开淘宝
    @objc func test313() {
        UIApplication.jk.openThirdPartyApp(type: .taobao) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.12、打开腾讯微博
    @objc func test312() {
        UIApplication.jk.openThirdPartyApp(type: .tencentWeibo) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.11、打开QQ
    @objc func test311() {
        UIApplication.jk.openThirdPartyApp(type: .qq) { (result) in
            JKPrint("结果：\(result)")
        }
    }
    
    // MARK: 3.10、打开微信
    @objc func test310() {
        UIApplication.jk.openThirdPartyApp(type: .weixin) { (result) in
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
