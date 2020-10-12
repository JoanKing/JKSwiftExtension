//
//  Array+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/7.
//

public extension Array {
    
    // MARK: 数组新增元素(可转入一个数组)
    /// 数组新增元素(可转入一个数组)
    /// - Parameter elements: 数组
    mutating func append(_ elements: [Element]) {
        for e in elements {
            self.append(e)
        }
    }
}

public extension Array where Element : Equatable {
    
    // MARK: 删除数组的中的元素
    /// 删除数组的中的元素
    /// - Parameters:
    ///   - element: 要删除的元素
    ///   - isRepeat: 是否删除重读的元素
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
    
    mutating func removeArr(_ elements: [Element], isRepeat: Bool = true) {
        for e in elements {
            if self.contains(e) {
                self.remove(e)
            }
        }
    }
    
}

public extension Array where Element : NSObjectProtocol {
    
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
        for index in removeIndexs {
            self.remove(at: index)
        }
    }
    
    mutating func removeArr(objects: [NSObjectProtocol], isRepeat: Bool = true) {
        for obj in objects {
            if self.contains(where: {$0.isEqual(obj)} ){
                self.remove(obj)
            }
        }
    }
}

public extension Array {
    @inlinable func forEach(_ body: (Int, Element) throws -> Void) rethrows {
        if count == 0 { return }
        for i in 0 ..< count {
            try body(i, self[i])
        }
    }
}


