//
//  Data+extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/28.
//

import UIKit
extension Data: JKPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JKPOP where Base == Data {

    // MARK: 1.1、base64编码成 Data
    /// 编码
    var encodeToData: Data? {
        return self.base.base64EncodedData()
    }
    
    // MARK: 1.2、base64解码成 Data
    /// 解码成 Data
    var decodeToDada: Data? {
        return Data(base64Encoded: self.base)
    }
    
    // MARK: 1.3、转成bytes
    /// 转成bytes
    var bytes: [UInt8] {
        return [UInt8](self.base)
    }
    
    // MARK: 1.4、Data转十六进制的字符串
    /// Data转16进制的字符串
    /// - Parameter data: data
    /// - Returns: 16进制的字符串
    var toHexString: String? {
        let data = self.base
        let dataBuffer = [UInt8](data)
        let dataLength = data.count
        var hexString = ""
        
        for i in 0..<dataLength {
            hexString += String(format: "%02lx", dataBuffer[i])
        }
        
        return hexString
    }
}

// MARK: 二、给 Data 添加用于在末尾追加 0x00 字节的扩展
public extension JKPOP where Base == Data {
    
    // MARK: 2.1、返回一个新的 Data，该数据为当前 Data 在末尾追加了 count 个 0x00 字节的副本。
    /// 返回一个新的 Data，该数据为当前 Data 在末尾追加了 count 个 0x00 字节的副本。
    /// - Parameter count: 要追加的 0 字节数量。若 count <= 0 则返回原数据（不变）。
    /// - Returns: 追加了零字节后的新 Data。
    func paddedWithZeroBytes(_ count: Int) -> Data {
        guard  self.base.count > 0 else { return self.base }
        var result = self.base
        result.append(Data(repeating: 0, count: count))
        return result
    }
}

