//
//  DateFormatter+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import Foundation
///DateFormattersManager 用来管理已经创建的formatter cache，
///DateFormatter 创建实例很耗时，如果多次创建 DateFormatter 实例，它可能会减慢 app 响应速度，甚至更快地耗尽手机电池的电量
///https://www.jianshu.com/p/be73296a62c2
let JKFormatterManager = DateFormattersManager.shared
class DateFormattersManager {
    static let shared = DateFormattersManager()
    
    let dateFormatters = SynchronizedDictionary<String, DateFormatter>()
    
    func getDateFormatter(for format: String) -> DateFormatter {
        var dateFormatter: DateFormatter?
        if let _dateFormatter = dateFormatters.getValue(for: format) {
            dateFormatter = _dateFormatter
        } else {
            dateFormatter = createDateFormatter(for: format)
        }
        
        return dateFormatter!
    }
    
    fileprivate func createDateFormatter(for format: String) -> DateFormatter {
        let formatter = DateFormatter(format: format)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatters.setValue(for: format, value: formatter)
        return formatter
    }
}

// MARK: - 一、基本扩展
public extension DateFormatter {
    // MARK: 1.1、格式化快捷方式
    /// 格式化快捷方式
    /// - Parameter format: 格式
    convenience init(format: String) {
        self.init()
        dateFormat = format
    }
    
    
}

//借鉴的EZSwiftExtensions
class SynchronizedDictionary <Key: Hashable, Value> {
   fileprivate let queue = DispatchQueue(label: "SynchronizedDictionary", attributes: .concurrent)
   fileprivate var dict = [Key: Value]()
   
   func getValue(for key: Key) -> Value? {
       var value: Value?
       queue.sync {
           value = dict[key]
       }
       return value
   }
   
   func setValue(for key: Key, value: Value) {
       queue.sync {
           dict[key] = value
       }
   }
   
   func getSize() -> Int {
       return dict.count
   }
   
   func containValue(for key: Key) -> Bool {
       return dict.has(key)
   }
}
