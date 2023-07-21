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
    
    //MARK: 1.2、模型对比返回差异
    /// 模型对比返回差异
    /// - Parameters:
    ///   - firstModel: 模型一
    ///   - secondModel: 模型二
    ///   - ignores: 忽略的字段
    /// - Returns: 不同的部分
    public static func diffBetween<T: Equatable>(firstModel: T, secondModel: T, ignores: [String] = []) -> [String: AnyHashable] {
        var differences: [String: AnyHashable] = [:]
        let firstMirror = Mirror(reflecting: firstModel)
        let secondMirror = Mirror(reflecting: secondModel)
        for (firstLabel, firstValue) in firstMirror.children {
            guard let firstLabel = firstLabel else {
                continue
            }
            if ignores.contains(where: { $0 == firstLabel }) {
                continue
            }
            if let secondValue = secondMirror.children.first(where: { $0.label == firstLabel })?.value, let weakFirstValue = firstValue as? AnyHashable, weakFirstValue != secondValue as? AnyHashable {
                differences[firstLabel] = weakFirstValue
            }
        }
        return differences
    }
}
