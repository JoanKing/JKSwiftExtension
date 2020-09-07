//
//  Array+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/7.
//

import UIKit

extension Array {
    public subscript(secure index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    public mutating func append(_ elements: [Element]) {
        for e in elements {
            self.append(e)
        }
    }
}
extension Array where Element : Equatable {
    public mutating func remove(_ element: Element, isRepeat: Bool = true) {
        var removeIndexs: [Int] = []
        
        for i in 0 ..< count {
            if self[i] == element {
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
    public mutating func removeArr(_ elements: [Element], isRepeat: Bool = true) {
        for e in elements {
            if self.contains(e) {
                self.remove(e)
            }
        }
    }
    
}
extension Array where Element : NSObjectProtocol {
    public mutating func remove(_ object: NSObjectProtocol, isRepeat: Bool = true) {
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
    public mutating func removeArr(objects: [NSObjectProtocol], isRepeat: Bool = true) {
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
    
    @inlinable func compactMap<ElementOfResult>(_ transform: (Int, Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        if count == 0 { return [] }
        var newElements: [ElementOfResult] = []
        for i in 0 ..< count {
            let newElement = try? transform(i, self[i])
            if let element = newElement {
                newElements.append(element!)
            }
        }
        return newElements
    }
    
    
    @inlinable func map<T>(_ transform: (Int, Element) throws -> T) rethrows -> [T] {
        if count == 0 { return [] }
        var newElements: [T] = []
        
        for i in 0 ..< count {
            if let newElement = try? transform(i, self[i]) {
                newElements.append(newElement)
            }
        }
        return newElements
    }
}

