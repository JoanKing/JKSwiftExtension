//
//  Array+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/7.
//

// MARK:- 一、数组 的基本扩展
public extension Array {
    
    // MARK: 1.1、安全的取某个索引的值
    /// 安全的取某个索引的值
    /// - Parameter index: 索引
    /// - Returns: 对应 inde 的 value
    func indexValue(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
    
// MARK:- 二、数组 有关索引 的扩展方法
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
        for (index, value) in lazy.enumerated() where value == item {
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
}

// MARK:- 三、数组有关 (增删改查) 的的扩展方法
public extension Array {
    
    // MARK: 数组新增元素(可转入一个数组)
    /// 数组新增元素(可转入一个数组)
    /// - Parameter elements: 数组
    mutating func append(_ elements: [Element]) {
        for element in elements {
            self.append(element)
        }
    }
}

// MARK:- 遵守 Equatable 协议的数组
public extension Array where Element : Equatable {
    
    // MARK: 删除数组的中的元素
    /// 删除数组的中的元素
    /// - Parameters:
    ///   - element: 要删除的元素
    ///   - isRepeat: 是否删除重复的元素
    mutating func remove(_ element: Element, isRepeat: Bool = true) {
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
    }
    
    // MARK: 删除一个数组
    /// 删除一个数组
    /// - Parameters:
    ///   - elements: 对应的数组
    ///   - isRepeat: 是否删除重复的元素
    mutating func removeArr(_ elements: [Element], isRepeat: Bool = true) {
        for element in elements {
            if self.contains(element) {
                self.remove(element)
            }
        }
    }
}

// MARK:- 针对数组元素是 String 的扩展
public extension Array where Self.Element == String {
  
    // MARK: 1.1、数组转字符转（数组的元素是 字符串）
    /// 数组转字符转（数组的元素是 字符串）
    /// - Returns: 字符串
    func toStrinig(separator: String = "") -> String {
        return self.joined(separator: separator)
    }
}

// MARK:- 遵守 NSObjectProtocol 协议对应数组的方法
public extension Array where Element : NSObjectProtocol {
    
    // MARK: 移除数组中遵守NSObjectProtocol协议的元素
    /// 移除数组中遵守NSObjectProtocol协议的元素
    /// - Parameters:
    ///   - object: 元素
    ///   - isRepeat: 是否删除重复的元素
    mutating func remove(_ object: NSObjectProtocol, isRepeat: Bool = true) {
        var removeIndexs: [Int] = []
        for i in 0 ..< count {
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
    }
    
    // MARK: 删除一个遵守NSObjectProtocol的数组
    /// 删除一个遵守NSObjectProtocol的数组
    /// - Parameters:
    ///   - objects: 遵守NSObjectProtocol的数组
    ///   - isRepeat: 是否删除重复的元素
    mutating func removeArr(objects: [NSObjectProtocol], isRepeat: Bool = true) {
        for object in objects {
            if self.contains(where: {$0.isEqual(object)} ){
                self.remove(object)
            }
        }
    }
}

