//
//  URL+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
extension URL: JKPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JKPOP where Base == URL {
    
    // MARK: 1.1、提取链接中的参数以字典像是显示
    /// 提取链接中的参数以字典形式显示
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self.base, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
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
        JKPrint("完整的url字符串 absoluteString：\(base.absoluteString)", "协议 scheme：\(base.scheme ?? "")", "域名 host：\(base.host ?? "")", "路径 path：\(base.path)", "相对路径 relativePath：\(base.relativePath)", "端口 port：\(base.port ?? 0)", "pathComponents：\(base.pathComponents)", "参数 query：\(base.query ?? "")")
    }
    
    // MARK: 1.3、检测应用是否能打开这个URL实例
    /// 1.3、检测应用是否能打开这个URL实例
    /// - Returns: 结果
    func verifyUrl() -> Bool {
        return UIApplication.shared.canOpenURL(self.base)
    }
    
    //MARK: 1.4、从url中获取后缀 例：mp3/mp4等等
    /// 从url中获取后缀 例：mp3/mp4等等
    var pathExtension: String {
        return self.base.pathExtension.isEmpty ? "" : "\(self.base.pathExtension)"
    }
}
