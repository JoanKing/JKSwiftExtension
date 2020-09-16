//
//  JKCommonTool.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/16.
//

import UIKit

public struct JKCommonTool {

    // MARK: 交换两个值
    /// 交换两个值
    /// - Parameters:
    ///   - value1: 值一
    ///   - value2: 值二
    @discardableResult
    public static func swapMe<T>(value1: inout T, value2: inout T) -> (T,T) {
        (value1,value2) = (value2,value1)
        return (value1, value2)
    }
}
