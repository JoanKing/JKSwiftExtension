//
//  Array+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/7.
//

// MARK:- 普通的数组方法
public extension Array {
  
}

// MARK:- 普通的数组 赠你删改查的 方法
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

