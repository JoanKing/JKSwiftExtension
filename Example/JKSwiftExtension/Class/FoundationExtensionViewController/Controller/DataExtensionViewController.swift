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

        headDataArray = ["一、基本的扩展", "二、给 Data 添加用于在末尾追加 0x00 字节的扩展"]
        dataArray = [["base64编码成 Data", "base64解码成 Data", "转成bytes", "Data转16进制的字符串"], [ "返回一个新的 Data，该数据为当前 Data 在末尾追加了 count 个 0x00 字节的副本。"]]
    }
}

// MARK: 二、给 Data 添加用于在末尾追加 0x00 字节的扩展
extension DataExtensionViewController {
    
    // MARK: 2.1、返回一个新的 Data，该数据为当前 Data 在末尾追加了 count 个 0x00 字节的副本。
    @objc func test201() {
        
        let original = Data([0x0a, 0x0b])
        let padded = original.jk.paddedWithZeroBytes(7)
        // 打印十进制字节数组
        debugPrint("bytes:", Array(padded))
        // 打印连续十六进制字符串
        debugPrint("hex:", padded.map { String(format: "%02x", $0) }.joined())
        // 打印带空格的十六进制（可读性更好）
        debugPrint("hex spaced:", padded.map { String(format: "%02x", $0) }.joined(separator: " "))
    }
}

// MARK: - 一、基本的扩展
extension DataExtensionViewController {
    
    // MARK: 1.04、Data转16进制的字符串
    @objc func test104() {
        // yourData
        let stringValue = "yourData"
        // 十六进制字符串
        let hexString = stringValue.jk.hexString() ?? ""
        // 十六进制字符串转为Data
        let data = hexString.jk.hexStringToData() ?? Data()
        // Data转十六进制的字符串
        let dataToHexString = data.jk.toHexString ?? ""
        // 十六进制字符串转换回原始字符串
        let origionString = dataToHexString.jk.stringFromHexString() ?? ""
        JKPrint("十六进制字符串转化为data", "字符串：\(stringValue) 转十六进制字符串 为：\(hexString)", "十六进制字符串：\(stringValue) 转Data 为：\(data)", "Data：\(data) 转十六进制的字符串 为：\(dataToHexString)", "十六进制字符串：\(dataToHexString) 转原始字符串 为：\(origionString)")
    }
    
    // MARK: 1.03、转成bytes
    @objc func test103() {
        let content = "我是一只小小鸟"
        guard let data = content.data(using: String.Encoding.utf8), let resultData = data.jk.encodeToData  else {
            return
        }
        JKPrint("转成bytes：\(resultData.jk.bytes)")
    }
    
    // MARK: 1.02、base64解码成 Data
    @objc func test102() {
        let content = "我是一只小小鸟"
        guard let data = content.data(using: String.Encoding.utf8), let resultData = data.jk.encodeToData  else {
            return
        }
        guard let oldData = resultData.jk.decodeToDada, let oldString = String(data: oldData, encoding: .utf8) else {
            return
        }
        JKPrint("base64编码成 Data：\(resultData)", "解码后的data是：\(oldData)", "解码后的 String：\(oldString)")
    }
    
    // MARK: 1.01、base64编码成 Data
    @objc func test101() {
        let content = "我是一只小小鸟"
        guard let data = content.data(using: String.Encoding.utf8), let resultData = data.jk.encodeToData else {
            return
        }
        JKPrint("\(content ) 被 base64编码成 Data：\(resultData)")
    }
}
