//
//  JKPrint.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/16.
//

import UIKit
import Foundation

// 之前是 JKPrint<T>(_ msg: T...
// MARK: - 自定义打印
/// 自定义打印
/// - Parameter msg: 打印的内容
/// - Parameter file: 文件路径
/// - Parameter line: 打印内容所在的 行
/// - Parameter column: 打印内容所在的 列
/// - Parameter fn: 打印内容的函数名
public func JKPrint(_ msg: Any...,
               isWriteLog: Bool = false,
                     file: NSString = #file,
                     line: Int = #line,
                   column: Int = #column,
                       fn: String = #function) {
    #if DEBUG
    var msgStr = ""
    for element in msg {
        msgStr += "\(element)\n"
    }
    let currentDate = Date.jk.currentDate
    let prefix = "---begin---------------🚀----------------\n当前时间：\(currentDate)\n当前文件完整的路径是：\(file)\n当前文件是：\(file.lastPathComponent)\n第 \(line) 行 \n第 \(column) 列 \n函数名：\(fn)\n打印内容如下：\n\(msgStr)---end-----------------😊----------------"
    print(prefix)
    guard isWriteLog else {
        return
    }
    // 将内容同步写到文件中去（Caches文件夹下）
    let cachePath = FileManager.jk.CachesDirectory()
    let logURL = cachePath + "/log.txt"
    appendText(fileURL: URL(string: logURL)!, string: "\(prefix)", currentDate: "\(currentDate)")
    #endif
}

// 在文件末尾追加新内容
private func appendText(fileURL: URL, string: String, currentDate: String) {
    do {
        // 如果文件不存在则新建一个
        FileManager.jk.createFile(filePath: fileURL.path)
        let fileHandle = try FileHandle(forWritingTo: fileURL)
        let stringToWrite = "\n" + "\(currentDate)：" + string
        // 找到末尾位置并添加
        fileHandle.seekToEndOfFile()
        fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
        
    } catch let error as NSError {
        print("failed to append: \(error)")
    }
}

public func JKPrintPointer<T>(ptr: UnsafePointer<T>) {
    #if DEBUG
    print("内存地址：\(ptr)) --------------")
    #endif
}

// MARK: - 以下内容是：MJ的Mems演变过来
// MARK: mark 变量的：地址、内存、大小 的打印
public func JKPrint<T>(val: inout T) {
    #if DEBUG
    print("-------------- \(type(of: val)) --------------")
    print("变量的地址:", JKMems.ptr(ofVal: &val))
    print("变量的内存:", JKMems.memStr(ofVal: &val))
    print("变量的大小:", JKMems.size(ofVal: &val))
    print("")
    #endif
}

// MARK: 对象的：地址、内存、大小 的打印
public func JKPrint<T>(ref: T) {
    #if DEBUG
    print("-------------- \(type(of: ref)) --------------")
    print("对象的地址:", JKMems.ptr(ofRef: ref))
    print("对象的内存:", JKMems.memStr(ofRef: ref))
    print("对象的大小:", JKMems.size(ofRef: ref))
    print("")
    #endif
}

public enum JKMemAlign : Int {
    case one = 1, two = 2, four = 4, eight = 8
}

private let _EMPTY_PTR = UnsafeRawPointer(bitPattern: 0x1)!

/// 辅助查看内存的小工具类
public struct JKMems<T> {
    private static func _memStr(_ ptr: UnsafeRawPointer,
                                _ size: Int,
                                _ aligment: Int) ->String {
        if ptr == _EMPTY_PTR { return "" }
        
        var rawPtr = ptr
        var string = ""
        let fmt = "0x%0\(aligment << 1)lx"
        let count = size / aligment
        for i in 0..<count {
            if i > 0 {
                string.append(" ")
                rawPtr += aligment
            }
            let value: CVarArg
            switch aligment {
            case JKMemAlign.eight.rawValue:
                value = rawPtr.load(as: UInt64.self)
            case JKMemAlign.four.rawValue:
                value = rawPtr.load(as: UInt32.self)
            case JKMemAlign.two.rawValue:
                value = rawPtr.load(as: UInt16.self)
            default:
                value = rawPtr.load(as: UInt8.self)
            }
            string.append(String(format: fmt, value))
        }
        return string
    }
    
    private static func _memBytes(_ ptr: UnsafeRawPointer,
                                  _ size: Int) -> [UInt8] {
        var arr: [UInt8] = []
        if ptr == _EMPTY_PTR { return arr }
        for i in 0..<size {
            arr.append((ptr + i).load(as: UInt8.self))
        }
        return arr
    }
    
    /// 获得变量的内存数据（字节数组格式）
    public static func memBytes(ofVal v: inout T) -> [UInt8] {
        return _memBytes(ptr(ofVal: &v), MemoryLayout.stride(ofValue: v))
    }
    
    /// 获得引用所指向的内存数据（字节数组格式）
    public static func memBytes(ofRef v: T) -> [UInt8] {
        let p = ptr(ofRef: v)
        return _memBytes(p, malloc_size(p))
    }
    
    /// 获得变量的内存数据（字符串格式）
    ///
    /// - Parameter alignment: 决定了多少个字节为一组
    public static func memStr(ofVal v: inout T, alignment: JKMemAlign? = nil) -> String {
        let p = ptr(ofVal: &v)
        return _memStr(p, MemoryLayout.stride(ofValue: v),
                       alignment != nil ? alignment!.rawValue : MemoryLayout.alignment(ofValue: v))
    }
    
    /// 获得引用所指向的内存数据（字符串格式）
    ///
    /// - Parameter alignment: 决定了多少个字节为一组
    public static func memStr(ofRef v: T, alignment: JKMemAlign? = nil) -> String {
        let p = ptr(ofRef: v)
        return _memStr(p, malloc_size(p),
                       alignment != nil ? alignment!.rawValue : MemoryLayout.alignment(ofValue: v))
    }
    
    /// 获得变量的内存地址
    public static func ptr(ofVal v: inout T) -> UnsafeRawPointer {
        return MemoryLayout.size(ofValue: v) == 0 ? _EMPTY_PTR : withUnsafePointer(to: &v) {
            UnsafeRawPointer($0)
        }
    }
    
    /// 获得引用所指向内存的地址
    public static func ptr(ofRef v: T) -> UnsafeRawPointer {
        if v is Array<Any>
            || Swift.type(of: v) is AnyClass
            || v is AnyClass {
            return UnsafeRawPointer(bitPattern: unsafeBitCast(v, to: UInt.self))!
        } else if v is String {
            var mstr = v as! String
            if mstr.mems.type() != .heap {
                return _EMPTY_PTR
            }
            return UnsafeRawPointer(bitPattern: unsafeBitCast(v, to: (UInt, UInt).self).1)!
        } else {
            return _EMPTY_PTR
        }
    }
    
    /// 获得变量所占用的内存大小
    public static func size(ofVal v: inout T) -> Int {
        return MemoryLayout.size(ofValue: v) > 0 ? MemoryLayout.stride(ofValue: v) : 0
    }
    
    /// 获得引用所指向内存的大小
    public static func size(ofRef v: T) -> Int {
        return malloc_size(ptr(ofRef: v))
    }
}

public enum JKStringMemType : UInt8 {
    /// TEXT段（常量区）
    case text = 0xd0
    /// taggerPointer
    case tagPtr = 0xe0
    /// 堆空间
    case heap = 0xf0
    /// 未知
    case unknow = 0xff
}

public struct JKMemsWrapper<Base> {
    public private(set) var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol JKMemsCompatible {}
public extension JKMemsCompatible {
    static var mems: JKMemsWrapper<Self>.Type {
        get { return JKMemsWrapper<Self>.self }
        set {}
    }
    var mems: JKMemsWrapper<Self> {
        get { return JKMemsWrapper(self) }
        set {}
    }
}

extension String: JKMemsCompatible {}
public extension JKMemsWrapper where Base == String {
    mutating func type() -> JKStringMemType {
        let ptr = JKMems.ptr(ofVal: &base)
        return JKStringMemType(rawValue: (ptr + 15).load(as: UInt8.self) & 0xf0)
            ?? JKStringMemType(rawValue: (ptr + 7).load(as: UInt8.self) & 0xf0)
            ?? .unknow
    }
}
