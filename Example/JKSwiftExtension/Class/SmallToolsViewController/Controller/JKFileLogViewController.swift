//
//  JKFileLogViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2023/11/20.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension

class JKFileLogViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、日志的操作"]
        dataArray = [["内容的写入正序", "内容的写入倒序", "读取日志内容", "获取日志文件路径", "移除日志文件", "导出日志"]]
    }
}

//MARK: - 一、日志的操作
extension JKFileLogViewController {
    
    //MARK: 1.06、导出日志
    @objc func test106() {
        let isSuccess = JKFileLog.exportLog()
        guard isSuccess else {
            debugPrint("暂时没有日志文件")
            return
        }
    }
    
    //MARK: 1.05、移除日志文件
    @objc func test105() {
        let isSuccess = JKFileLog.removeLogFile()
        debugPrint("移除日志文件：\(isSuccess)")
    }
    
    //MARK: 1.04、获取日志文件路径
    @objc func test104() {
        let content = JKFileLog.getLogFilePath()
        debugPrint("获取日志文件路径：\(content)")
    }
    
    //MARK: 1.03、读取日志内容
    @objc func test103() {
        let content = JKFileLog.getFilePathContent()
        debugPrint("内容：\(content)")
    }
    
    //MARK: 1.02、内容的写入：倒序
    @objc func test102() {
        JKFileLog.writeLog("hello(倒序)", isSeekToEndOfFile: false)
    }
    
    //MARK: 1.01、内容的写入：正序
    @objc func test101() {
        for i in 0...100 {
            JKFileLog.writeLog("hello(正序)：\(i)", isSeekToEndOfFile: true)
        }
    }
}
