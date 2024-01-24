//
//  JKDecodeString.swift
//  JKSwiftExtension
//
//  Created by 小冲冲 on 2024/1/23.
//
// MARK: 不确定服务器的类型，使用String解析，目前支持其他类型是：Int，Double类型，不支持的使用返回nil
import UIKit

@propertyWrapper public struct JKDecodeString: Codable {
    public var wrappedValue: String?
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        /// 返回的数据类型
        var string: String?
        do {
            string = try container.decode(String.self)
        } catch {
            do {
                string = String(try container.decode(Int.self))
            } catch {
                do {
                    string = String(try container.decode(Double.self))
                } catch {
                    string = nil
                }
            }
        }
        wrappedValue = string
    }
}
