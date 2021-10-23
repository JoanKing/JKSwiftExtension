//
//  JKJSON.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/2/22.
//

import Foundation

// MARK: - 自定义一个JSON协议
public protocol JKJSON: Codable {
    func toJSONString() -> String?
}
 
// MARK: - 扩展协议方法
public extension JKJSON {
    // MARK: 将数据转成可用的JSON模型
    func toJSONString() -> String? {
        // encoded对象
        if let encodedData = try? JSONEncoder().encode(self) {
            // 从encoded对象获取String
            return String(data: encodedData, encoding: .utf8)
        }
        return nil
    }
}
