//
//  JKPrint.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/16.
//

import UIKit

/// 自定义打印
/// - Parameter msg: 打印的内容
/// - Parameter file: 文件路径
/// - Parameter line: 打印内容所在的 行
/// - Parameter column: 打印内容所在的 列
/// - Parameter fn: 打印内容的函数名
public func JKPrint(_ msg: Any...,
               file: NSString = #file,
               line: Int = #line,
               column: Int = #column,
               fn: String = #function) {
    #if DEBUG
    var msgStr = ""
    for element in msg {
        msgStr += "\(element)\n"
    }
    let prefix = "---begin---------------🚀----------------\n当前时间：\(Date.currentDate)\n当前文件完整的路径是：\(file)\n当前文件是：\(file.lastPathComponent)\n第 \(line) 行 \n第 \(column) 列 \n函数名：\(fn)\n打印内容如下：\n\(msgStr)---end-----------------😊----------------"
    print(prefix)
    #endif
}

// 之前是 JKPrint<T>(_ msg: T...


