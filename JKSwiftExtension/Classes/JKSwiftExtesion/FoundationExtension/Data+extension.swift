//
//  Data+extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/28.
//

import UIKit
extension Data: JKPOPCompatible {}
// MARK:- 一、基本的扩展
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
    
}
