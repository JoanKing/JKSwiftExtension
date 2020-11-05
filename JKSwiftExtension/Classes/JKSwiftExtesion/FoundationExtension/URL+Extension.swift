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
}

