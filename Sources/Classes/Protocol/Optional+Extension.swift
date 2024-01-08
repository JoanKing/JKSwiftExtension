//
//  Optional+Extension.swift
//  JKSwiftExtension
//
//  Created by 小冲冲 on 2023/12/25.
//
import Foundation
/*
 Swift 标准库中定义后缀 ？为可选类型 Optional<Wrapped> 的语法糖，这里语法糖可以简单理解为一种便捷的书写语法。也就是说，下面两个声明是等价的：
 var name: Optional<String>
 var name: String?
 */

//MARK: - 一、基本的扩展
public extension Optional {
    //MARK: 1.1、是否为nil
    /// 是否为nil
    var isNil: Bool {
        return self == nil
    }
    
    //MARK: 1.2、是否是有值
    /// 是否是可选值
    var isSome: Bool {
        return self != nil
    }
    
    //MARK: 1.3、可选值取值
    /// 可选值取值
    /// - Parameters:
    ///   - defaultValue: 默认值
    ///   - calc: 如果可选值有值，calc也返回了对应的值，就取calc返回的值，否则去可选值解析后的值
    /// - Returns: 结果
    func or(_ defaultValue: @autoclosure () -> Wrapped, _ calc: ((Wrapped) -> Wrapped)? = nil) -> Wrapped {
        switch self {
        case .some(let value):
            if let calc = calc {
                return calc(value)
            } else {
                return value
            }
        case .none:
            return defaultValue()
        }
    }
    
    //MARK: 1.4、可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`
    /// 可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`
    /// - Parameter predicate: 条件，返回true和false
    /// - Returns: 结果
    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
              predicate(unwrapped) else { return nil }
        return unwrapped
    }
    
    //MARK: 1.5、当可选值不为空时，执行some闭包
    /// 当可选值不为空时，执行 `some` 闭包
    /// - Parameter some: some description
    func onSome(_ some: (Wrapped) -> Void) {
        guard let unwrapped = self else { return }
        some(unwrapped)
    }
    
    //MARK: 1.6、当可选值为空时，执行none闭包
    /// 当可选值为空时，执行 `none` 闭包
    /// - Parameter none: none description
    func onNone(_ none: () -> Void) {
        guard self == nil else { return }
        none()
    }
}

