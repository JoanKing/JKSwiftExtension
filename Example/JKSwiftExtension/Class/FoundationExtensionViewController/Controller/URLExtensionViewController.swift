//
//  URLExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/4.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class URLExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["提取链接中的参数以字典像是显示", "属性说明"]]
    }

}

// MARK:- 一、基本的扩展
extension URLExtensionViewController {
    
    // MARK: 1.2、属性说明
    @objc func test12() {
        
        guard let url = URL(string: "https://www.jianshu.com?a=1&b=2") else {
            return
        }
        url.jk.propertyDescription()
    }
    
    // MARK: 1.1、提取链接中的参数以字典像是显示
    @objc func test11() {   
        
        guard let url = URL(string: "https://www.jianshu.com?a=1&b=2"), let query = url.jk.queryParameters else {
            return
        }
        JKPrint("内容", "\(url) 取后为 \(query)")
    }
}
