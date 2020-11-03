//
//  Date+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation

/// 时间戳的类型
public enum TimestampType: Int {
    // 秒
    case second
    // 毫秒
    case millisecond
}

// MARK:- 一、Date 基本的扩展
public extension Date {
    // MARK: 1.1、获取当前 秒级 时间戳 - 10 位
    /// 获取当前 秒级 时间戳 - 10 位
    static var secondStamp : String {
        let timeInterval: TimeInterval = Self().timeIntervalSince1970
        return "\(Int(timeInterval))"
    }
    
    // MARK: 1.2、获取当前 毫秒级 时间戳 - 13 位
    /// 获取当前 毫秒级 时间戳 - 13 位
    static var milliStamp : String {
        let timeInterval: TimeInterval = Self().timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    // MARK: 1.3、获取当前的时间 Date
    /// 获取当前的时间 Date
    static var currentDate : Date {
        return Self()
    }
    
    // MARK: 1.4、从 Date 获取年份
    /// 从 Date 获取年份
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    // MARK: 1.5、从 Date 获取月份
    /// 从 Date 获取年份
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    // MARK: 1.6、从 Date 获取 日
    /// 从 Date 获取 日
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    // MARK: 1.7、从 Date 获取 小时
    /// 从 Date 获取 日
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    // MARK: 1.8、从 Date 获取 分钟
    /// 从 Date 获取 分钟
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    // MARK: 1.9、从 Date 获取 秒
    /// 从 Date 获取 秒
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    // MARK: 1.9、从 Date 获取 毫秒
    /// 从 Date 获取 毫秒
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    // MARK: 1.10、从日期获取 星期(英文)
    /// 从日期获取 星期
    var weekday: String {
        return DateFormatter(format: "EEEE").string(from: self)
    }
    
    // MARK: 1.11、从日期获取 月(英文)
    /// 从日期获取 月(英文)
    var monthAsString: String {
        return DateFormatter(format: "MMMM").string(from: self)
    }
}

//MARK: - 二、时间格式的转换
public extension Date {
    
    // MARK: 2.1、时间戳 按照对应的格式 转化为 对应时间的字符串，支持10位 和 13位 
    /// 时间戳 按照对应的格式 转化为 对应时间的字符串，支持10位 和 13位 如：1603849053 按照 "yyyy-MM-dd HH:mm:ss" 转化后为：2020-10-28 09:37:33
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - format: 格式
    /// - Returns: 对应时间的字符串
    static func timestampToFormatterTimeString(timestamp: String, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        // 时间戳转为Date
        let date = timestampToFormatterDate(timestamp: timestamp)
        let dateFormatter = DateFormatter()
        // 设置 dateFormat
        dateFormatter.dateFormat = format
        // 按照dateFormat把Date转化为String
        return dateFormatter.string(from: date)
    }
    
    // MARK: 2.2、时间戳 转 Date, 支持 10 位 和 13 位
    /// 时间戳 转 Date, 支持 10 位 和 13 位
    /// - Parameter timestamp: 时间戳
    /// - Returns: 返回 Date
    static func timestampToFormatterDate(timestamp: String) -> Date {
        guard timestamp.count == 10 ||  timestamp.count == 13 else {
            #if DEBUG
            fatalError("时间戳位数不是 10 也不是 13")
            #else
            return Date()
            #endif
        }
        guard let timestampDouble = timestamp.toDouble() else {
            #if DEBUG
            fatalError("时间戳位有问题")
            #else
            return Date()
            #endif
        }
        let timestampValue = timestamp.count == 10 ? timestampDouble : timestampDouble / 1000
        // 时间戳转为Date
        let date = Date(timeIntervalSince1970: timestampValue)
        return date
    }
    
    // MARK: 2.3、Date 转换为相应格式的时间字符串，如 Date 转为 2020-10-28
    /// Date 转换为相应格式的字符串，如 Date 转为 2020-10-28
    /// - Parameter format: 转换的格式
    /// - Returns: 返回具体的字符串
    func toformatterTimeString(formatter: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
    
    // MARK: 2.4、带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳
    /// 带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致
    /// - Parameters:
    ///   - timeString: 时间字符串，如：2020-10-26 16:52:41
    ///   - formatter: 时间格式，如：yyyy-MM-dd HH:mm:ss
    ///   - timestampType: 返回的时间戳类型，默认是秒 10 为的时间戳字符串
    /// - Returns: 返回转化后的时间戳
    static func formatterTimeStringToTimestamp(timesString: String, formatter: String, timestampType: TimestampType = .second) -> String {
        let date = formatterTimeStringToDate(timesString: timesString, formatter: formatter)
        if timestampType == .second {
            return "\(Int(date.timeIntervalSince1970))"
        }
        return "\(Int((date.timeIntervalSince1970) * 1000))"
    }
    
    // MARK: 2.5、带格式的时间转 Date，支持返回 13位 和 10位的时间戳
    /// 带格式的时间转 Date，支持返回 13位 和 10位的时间戳
    /// - Parameters:
    ///   - timesString: 时间字符串
    ///   - formatter: 格式
    /// - Returns: 返回 Date
    static func formatterTimeStringToDate(timesString: String, formatter: String) -> Date {
        let dateFormatter = DateFormatter(format: formatter)
        guard let date = dateFormatter.date(from: timesString) else {
            #if DEBUG
            fatalError("时间有问题")
            #else
            return Date()
            #endif
        }
        return date
    }
}

// MARK:- 三、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断
public extension Date {
    
    // MARK: 3.1、今天的日期
    /// 今天的日期
    var todayDate: Date {
        return Date()
    }
    
    // MARK: 3.2、昨天的日期
    /// 昨天的日期
    var yesterDayDate: Date? {
        return adding(day: -1)
    }
    
    // MARK: 3.3、明天的日期
    /// 明天的日期
    var tomorrowDate: Date? {
        return adding(day: 1)
    }
    
    // MARK: 3.4、前天的日期
    /// 前天的日期
    var theDayBeforYesterDayDate: Date? {
        return adding(day: -2)
    }
    
    // MARK: 3.5、后天的日期
    /// 后天的日期
    var theDayAfterYesterDayDate: Date? {
        return adding(day: 2)
    }
    
    // MARK: 3.6、是否为今天（只比较日期，不比较时分秒）
    /// 是否为今天（只比较日期，不比较时分秒）
    /// - Returns: bool
    var isToday: Bool {
        let date = Date()
        if self.toformatterTimeString(formatter: "yyyyMMdd") == date.toformatterTimeString(formatter: "yyyyMMdd") {
            return true
        }
        return false
    }
    
    // MARK: 3.7、是否为昨天
    /// 是否为昨天
    var isYesterday: Bool {
        // 1.先拿到昨天的 date
        guard let date = Date().yesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return isSameYeaerMountDay(date)
    }
    
    // MARK: 3.8、是否为前天
    /// 是否为前天
    var isTheDayBeforeYesterday: Bool  {
        // 1.先拿到前天的 date
        guard let date = Date().theDayBeforYesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return isSameYeaerMountDay(date)
    }
    
    // MARK: 3.9、是否为今年
    /// 是否为今年
    var isThisYear: Bool  {
        let calendar = Calendar.current
        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self)
        let result = nowCmps.year == selfCmps.year
        return result
    }
    
    // MARK: 3.10、是否为 同一年 同一月 同一天
    /// 是否为  同一年  同一月 同一天
    /// - Returns: bool
    var isSameYearMonthDayWithToday: Bool {
        return isSameYeaerMountDay(Date())
    }
    
    /// 日期的加减操作
    /// - Parameter day: 天数变化
    /// - Returns: date
    private func adding(day: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:day), to: self)
    }
    
    /// 是否为  同一年  同一月 同一天
    /// - Parameter date: date
    /// - Returns: 返回bool
    private func isSameYeaerMountDay(_ date: Date) -> Bool {
        let com = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let comToday = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return (com.day == comToday.day &&
            com.month == comToday.month &&
            com.year == comToday.year )
    }
}

// MARK:- 四、相对的时间变化
public extension Date {
    
    // MARK: 4.1、取得与当前时间的间隔差
    /// 取得与当前时间的间隔差
    /// - Returns: 时间差
    func callTimeAfterNow() -> String {
        let timeInterval = Date().timeIntervalSince(self)
        if timeInterval < 0 {
            return "刚刚"
        }
        
        let interval = fabs(timeInterval)
        
        let i60 = interval/60
        let i3600 = interval/3600
        let i86400 = interval/86400
        let i2592000 = interval/2592000
        let i31104000 = interval/31104000
        
        var time:String!
        
        if i3600 < 1 {
            let s = NSNumber(value: i60 as Double).intValue
            if s == 0 {
                time = "刚刚"
            } else {
                time = "\(s)分钟前"
            }
        } else if i86400 < 1 {
            let s = NSNumber(value: i3600 as Double).intValue
            time = "\(s)小时前"
        } else if i2592000 < 1 {
            let s = NSNumber(value: i86400 as Double).intValue
            time = "\(s)天前"
        } else if i31104000 < 1 {
            let s = NSNumber(value: i2592000 as Double).intValue
            time = "\(s)个月前"
        } else {
            let s = NSNumber(value: i31104000 as Double).intValue
            time = "\(s)年前"
        }
        return time
    }
}
