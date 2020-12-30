//
//  DataExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/1.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class DataExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["base64编码成 Data", "base64解码成 Data"]]
    }
}

// MARK:- 一、基本的扩展
extension DataExtensionViewController {
   
    // MARK: 1.2、base64解码成 Data
    @objc func test12() {
        let content = "我是一只小小鸟"
        guard let data = content.data(using: String.Encoding.utf8), let resultData = data.jk.encodeToData  else {
            return
        }
        guard let oldData = resultData.jk.decodeToDada, let oldString = String(data: oldData, encoding: .utf8) else {
            return
        }
        JKPrint("base64编码成 Data：\(resultData)", "解码后的data是：\(oldData)", "解码后的 String：\(oldString)")
    }
    
    // MARK: 1.1、base64编码成 Data
    @objc func test11() {
        let content = "我是一只小小鸟"
        guard let data = content.data(using: String.Encoding.utf8), let resultData = data.jk.encodeToData else {
            return
        }
        JKPrint("\(content ) 被 base64编码成 Data：\(resultData)")
    }
}
