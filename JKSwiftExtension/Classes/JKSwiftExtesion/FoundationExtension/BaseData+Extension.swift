//
//  BaseData+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit
import Foundation

// MARK:- 协议
public protocol ConvertToInt {
    var int: Int { get }
}
public protocol ConvertToInt64 {
    var int64: Int64 { get }
}
public protocol ConvertToFloat {
    var float: Float { get }
}
public protocol ConvertToDouble {
    var double: Double { get }
}
public protocol ConvertToCGFloat {
    var cgFloat: CGFloat { get }
}
public protocol ConvertToNumber {
    var number: NSNumber { get }
}
public protocol ConvertToString {
    var string: String { get }
}

// MARK:- Int
extension Int: ConvertToInt64, ConvertToFloat, ConvertToDouble, ConvertToCGFloat, ConvertToNumber, ConvertToString, ConvertToInt {
    public var int64: Int64 {
        return Int64(self)
    }
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    public var float: Float {
        return Float(self)
    }
    public var double: Double {
        return Double(self)
    }
    public var string: String {
        return String(self)
    }
    public var number: NSNumber {
        return NSNumber.init(value: self)
    }
    public var int: Int {
        return self
    }
}

// MARK:- Int64
extension Int64: ConvertToInt, ConvertToFloat, ConvertToDouble, ConvertToCGFloat, ConvertToNumber, ConvertToString, ConvertToInt64 {
    public var int: Int {
        return Int(self)
    }
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    public var float: Float {
        return Float(self)
    }
    public var double: Double {
        return Double(self)
    }
    public var string: String {
        return String(self)
    }
    public var number: NSNumber {
        return NSNumber.init(value: self)
    }
    public var int64: Int64 {
        return self
    }
}

// MARK:- String
public extension String {
    var int: Int? {
        return Int(self)
    }
    var int64: Int64? {
        return Int64(self)
    }
    var float: Float? {
        return Float(self)
    }
    var double: Double? {
        return Double(self)
    }
    var cgFloat: CGFloat? {
        return self.double?.cgFloat
    }
    
    var intValue: Int {
        return Int(self) ?? 0
    }
    var int64Value: Int64 {
        return Int64(self) ?? 0
    }
    var floatValue: Float {
        return Float(self) ?? 0.0
    }
    var doubleValue: Double {
        return Double(self) ?? 0.0
    }
    var cgFloatValue: CGFloat {
        return self.double?.cgFloat ?? 0.0
    }
    var number: NSNumber? {
        return self.double?.number
    }
    
    @inlinable static func + (lhs: String, rhs: ConvertToString) -> String {
        return lhs + rhs.string
    }
    @inlinable static func + (lhs: ConvertToString, rhs: String) -> String {
        return lhs.string + rhs
    }
    
    @inlinable static func += (lhs: inout String, rhs: ConvertToString) {
        lhs += rhs.string
    }
}

