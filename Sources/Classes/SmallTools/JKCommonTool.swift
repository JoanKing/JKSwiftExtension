//
//  JKCommonTool.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/16.
//

import UIKit

// MARK: - 一、基本的方法
public struct JKCommonTool {
    
    // MARK: 1.1、交换两个值
    /// 交换两个值
    /// - Parameters:
    ///   - value1: 值一
    ///   - value2: 值二
    @discardableResult
    public static func swapMe<T>(value1: inout T, value2: inout T) -> (T, T) {
        (value1, value2) = (value2, value1)
        return (value1, value2)
    }
    
    //MARK: 模型对比返回差异
    public static func diffBetween<T: Equatable>(bleModel: T, netModel: T, ignores: [String] = []) -> [String: AnyHashable] {
        var differences: [String: AnyHashable] = [:]
        let bleMirror = Mirror(reflecting: bleModel)
        let netMirror = Mirror(reflecting: netModel)
        for (bleLabel, bleValue) in bleMirror.children {
            guard let bleLabel = bleLabel else {
                continue
            }
            if ignores.contains(where: { $0 == bleLabel }) {
                continue
            }
            if let netValue = netMirror.children.first(where: { $0.label == bleLabel })?.value, let weakBleValue = bleValue as? AnyHashable, weakBleValue != netValue as? AnyHashable {
                differences[bleLabel] = weakBleValue
            }
        }
        return differences
    }
}
