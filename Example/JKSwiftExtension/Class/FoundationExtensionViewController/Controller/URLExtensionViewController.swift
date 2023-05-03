//
//  URLExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/4.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension
class URLExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["提取链接中的参数以字典像是显示", "属性说明", "检测应用是否能打开这个URL实例", "从url中获取后缀 例：mp3/mp4等等"]]
    }

}

// MARK: - 一、基本的扩展
extension URLExtensionViewController {
    
    //MARK: 1.4、从url中获取后缀 例：mp3/mp4等等
    @objc func test14() {
        guard let url1 = URL(string: "https://download.niucache.com/78.rm") else {
            return
        }
        guard let url2 = URL(string: "https://download.niucache.com/76.mp4") else {
            return
        }
        JKPrint("\(url1)链接的后缀是：\(url1.jk.pathExtension)", "\(url2)链接的后缀是：\(url2.jk.pathExtension)")
    }
    
    // MARK: 1.3、检测应用是否能打开这个URL实例
    @objc func test13() {
        guard let url = URL(string: "https://www.baidu.com") else {
            return
        }
        let result = url.jk.verifyUrl()
        JKPrint("检测应用是否能打开这个URL实例：\(result)")
    }
    
    // MARK: 1.2、属性说明
    @objc func test12() {
        
        guard let url = URL(string: "huacai://com.huacai.stock/v5/detail?type=1&id=2") else {
            return
        }
        url.jk.propertyDescription()
    }
    
    // MARK: 1.1、提取链接中的参数以字典像是显示
    @objc func test11() {
        let encodeUrlString = "http://apitest.com/wx_hyqr?transport_sn=H20230307143536112330&transport_id=2647&time=2023-03-31 07:07:00&use_type=11".jk.urlEncode()
        guard let url = URL(string: encodeUrlString), let query = url.jk.queryParameters else {
            return
        }
        JKPrint("内容", "\(url) 取后参数为 \(query)")
    }
}
