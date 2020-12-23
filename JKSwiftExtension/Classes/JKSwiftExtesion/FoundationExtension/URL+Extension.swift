//
//  URL+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

// MARK:- 一、基本的扩展
public extension URL {
    
    // MARK: 1.1、提取链接中的参数以字典像是显示
    /// 提取链接中的参数以字典像是显示
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
    
    // MARK: 1.2、属性说明
    /// 属性说明
    func propertyDescription() {
        JKPrint("完整的url字符串 absoluteString：\(absoluteString)", "协议 scheme：\(scheme ?? "")", "相对路径 relativePath：\(relativePath)", "端口 port：\(port ?? 0)", "路径 path：\(path)", "pathComponents：\(pathComponents)", "参数 query：\(query ?? "")", "域名 host：\(host ?? "")")
    }
}

