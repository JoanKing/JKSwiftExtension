//
//  Array+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/7.
//

import Foundation
import UIKit
// MARK: - 一、数组 的基本扩展
public extension Array {
    
    // MARK: 1.1、安全的取某个索引的值
    /// 安全的取某个索引的值
    /// - Parameter index: 索引
    /// - Returns: 对应 inde 的 value
    func indexValue(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    // MARK: 1.2、数组添加数组
    /// 数组新增元素(可转入一个数组)
    /// - Parameter elements: 数组
    mutating func appends(_ elements: [Element]) {
        self.append(contentsOf: elements)
    }
    
    // MARK: 1.3、数组 -> JSON字符串
    /// 字典转换为JSONString
    func toJSON() -> String? {
        let array = self
        guard JSONSerialization.isValidJSONObject(array) else {
            JKPrint("无法解析出JSONString")
            return ""
        }
        let data : NSData = try! JSONSerialization.data(withJSONObject: array, options: []) as NSData
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    // MARK: 1.4、分隔数组
    /// 分隔数组
    /// - Parameter condition: condition description
    /// - Returns: description
    func split(where condition: (Element, Element) -> Bool) -> [[Element]] {
        var result: [[Element]] = self.isEmpty ? [] : [[self[0]]]
        for (previous, current) in zip(self, self.dropFirst()) {
            if condition(previous, current) {
                result.append([current])
            } else {
                result[result.endIndex - 1].append(current)
            }
        }
        return result
    }
    
    /// 随机取出几个元素
    subscript (randomPick n: Int) -> [Element] {
        guard n <= self.count else { return self }
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}

// MARK: - 二、数组 有关索引 的扩展方法
public extension Array where Element : Equatable {
    
    // MARK: 2.1、获取数组中的指定元素的索引值
    /// 获取数组中的指定元素的索引值
    /// - Parameter item: 元素
    /// - Returns: 索引值数组
    func indexes(_ item: Element) -> [Int] {
        var indexes = [Int]()
        for index in 0..<count where self[index] == item {
            indexes.append(index)
        }
        return indexes
    }
    
    // MARK: 2.2、获取元素首次出现的位置
    /// 获取元素首次出现的位置
    /// - Parameter item: 元素
    /// - Returns: 索引值
    func firstIndex(_ item: Element) -> Int? {
        for (index, value) in self.enumerated() where value == item {
            return index
        }
        return nil
    }
    
    // MARK: 2.3、获取元素最后出现的位置
    /// 获取元素最后出现的位置
    /// - Parameter item: 元素
    /// - Returns: 索引值
    func lastIndex(_ item: Element) -> Int? {
        let indexs = indexes(item)
        return indexs.last
    }
    
    //MARK: 2.4、获取两个数组的相同元素
    /// 获取两个元素的相同元素
    /// - Parameter array: 数组元素
    /// - Returns: 返回相同的元素
    func sameElement(array: [Element]) -> [Element] {
        var dict1: [String: Int] = [:]
        self.forEach({
            dict1["\($0)"] = 1
        })
        var sameElements: [Element] = []
        array.forEach({
            if 1 == dict1["\($0)"] {
                // 此处便可取到相同元素
                debugPrint("相同的元素：\($0)")
                sameElements.append($0)
            }
        })
        return sameElements
    }
}

// MARK: - 三、遵守 Equatable 协议的数组 (增删改查) 扩展
public extension Array where Element : Equatable {
    
    // MARK: 3.1、删除数组的中的元素(可删除第一个出现的或者删除全部出现的)
    /// 删除数组的中的元素(可删除第一个出现的或者删除全部出现的)
    /// - Parameters:
    ///   - element: 要删除的元素
    ///   - isRepeat: 是否删除重复的元素
    @discardableResult
    mutating func remove(_ element: Element, isRepeat: Bool = true) -> Array {
        var removeIndexs: [Int] = []
        
        for i in 0 ..< count {
            if self[i] == element {
                removeIndexs.append(i)
                if !isRepeat { break }
            }
        }
        // 倒序删除
        for index in removeIndexs.reversed() {
            self.remove(at: index)
        }
        return self
    }
    
    // MARK: 3.2、从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素
    /// 从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素
    /// - Parameters:
    ///   - elements: 被删除的数组元素
    ///   - isRepeat: 是否删除重复的元素
    @discardableResult
    mutating func removeArray(_ elements: [Element], isRepeat: Bool = true) -> Array {
        for element in elements {
            if self.contains(element) {
                self.remove(element, isRepeat: isRepeat)
            }
        }
        return self
    }
}

// MARK: - 四、遵守 NSObjectProtocol 协议对应数组的扩展方法
public extension Array where Element : NSObjectProtocol {
    
    // MARK: 4.1、删除数组中遵守NSObjectProtocol协议的元素，是否删除重复的元素
    /// 删除数组中遵守NSObjectProtocol协议的元素
    /// - Parameters:
    ///   - object: 元素
    ///   - isRepeat: 是否删除重复的元素
    @discardableResult
    mutating func remove(object: NSObjectProtocol, isRepeat: Bool = true) -> Array {
        var removeIndexs: [Int] = []
        for i in 0..<count {
            if self[i].isEqual(object) {
                removeIndexs.append(i)
                if !isRepeat {
                    break
                }
            }
        }
        for index in removeIndexs.reversed() {
            self.remove(at: index)
        }
        return self
    }
    
    // MARK: 4.2、删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除
    /// 删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除
    /// - Parameters:
    ///   - objects: 遵守NSObjectProtocol的数组
    ///   - isRepeat: 是否删除重复的元素
    @discardableResult
    mutating func removeArray(objects: [NSObjectProtocol], isRepeat: Bool = true) -> Array {
        for object in objects {
            if self.contains(where: {$0.isEqual(object)} ){
                self.remove(object: object, isRepeat: isRepeat)
            }
        }
        return self
    }
}

// MARK: - 五、针对数组元素是 String 的扩展
public extension Array where Self.Element == String {
    
    // MARK: 5.1、数组转字符转（数组的元素是 字符串），如：["1", "2", "3"] 连接器为 - ，那么转化后为 "1-2-3"
    /// 数组转字符转（数组的元素是 字符串），如：["1", "2", "3"] 连接器为 - ，那么转化后为 "1-2-3"
    /// - Parameter separator: 连接器
    /// - Returns: 转化后的字符串
    func toString(separator: String = "") -> String {
        return self.joined(separator: separator)
    }
}
