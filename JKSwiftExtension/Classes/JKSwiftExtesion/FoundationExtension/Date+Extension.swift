//
//  Date+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation

public extension Date {
    /// 获取当前 秒级 时间戳 - 10位
       var timeStamp : String {
           let timeInterval: TimeInterval = self.timeIntervalSince1970
           let timeStamp = Int(timeInterval)
           return "\(timeStamp)"
       }

       /// 获取当前 毫秒级 时间戳 - 13位
       var milliStamp : String {
           let timeInterval: TimeInterval = self.timeIntervalSince1970
           let millisecond = CLongLong(round(timeInterval*1000))
           return "\(millisecond)"
       }
}

//MARK: - Date
public extension Date {
    
    /// 日期转换为相应格式的字符串
    /// - Parameter format: 转换的格式
    /// - Returns: 返回具体的字符串
    func toString(_ format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    /// 是否为今天（只比较日期，不比较时分秒）
    /// - Returns: bool
    func isToday() -> Bool {
        let date = Date()
        if self.toString("yyyyMMdd") == date.toString("yyyyMMdd") {
            return true
        }
        return false
    }
    
    /// 取得与当前时间的间隔差
    /// - Returns: 时间差
    func calTimeAfterNow() -> String {
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

//MARK: - NSDate
public extension NSDate {
    
    /// 传 str 返回 NSDate
    /// - Parameter time: 时间戳字符串
    class func dateWithStr(time: String) ->NSDate {
        
        // 1. 将服务器返回给我们的时间字符串转化为NSDate
        // 1.1.创建formatter
        let formatter = DateFormatter()
        // 1.2.设置时间格式
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        // 1.3.设置时间的区域(真机必须设置，负责可能转化不成功)
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        // 1.4.转化字符串，转化好的字符串是去除时区的时间
        let createDate = formatter.date(from: time)
        
        return createDate! as NSDate
    }
    
    /// 判断时间
    /**
     刚刚(一分钟以内)
     X分钟以前（1个小时以内）
     X小时前（当天）
     昨天 HH:mm(昨天)
     MM-dd HH-mm (一年内)
     yyyy-MM-dd HH:mm (更早时间)
     */
    var descDate: String {
        
        let calendar = NSCalendar.current
        // 1.判断是否为今天
        if calendar.isDateInToday(self as Date) {
            
            // 1.0获取当前时间与紫铜时间之间的差距（秒数）
            let since = Int(NSDate().timeIntervalSince(self as Date))
            // 1.1.是否为刚刚
            print(since)
            if since < 60 {
                return "刚刚"
            }
            // 1.2.多少分钟以前
            if since < 60 * 60 {
                return "\(since/60)分钟前"
            }
            // 1.3.多少小时以前
            return "\(since/(60 * 60))小时前"
        }
        
        // 2.0.判断是否为昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self as Date) {
            // 昨天
            formatterStr = "昨天:" + formatterStr
        } else {
            // 判断是不是今年
            if isDateInThisYear(date: self) {
                // 是今年
                // 3. 处理一年以内
                formatterStr = "MM-dd-" + formatterStr
            } else {
                // 4.不是今年
                formatterStr = "yyyy-MM-dd-" + formatterStr
            }
        }
        // 5.按照指定的格式将时间转化为字符串
        // 5.1.创建formatter
        let formatter = DateFormatter()
        // 5.2.设置时间格式
        formatter.dateFormat = formatterStr
        // 5.3.设置时间的区域(真机必须设置，负责可能转化不成功)
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        // 5.4.格式化
        return formatter.string(from: self as Date)
    }
    
    // MARK: 判断是否是今年
    // - parameter date: 目标时间
    private func isDateInThisYear(date: NSDate) -> Bool {
        
        // 取到当前时间
        let currentDate = NSDate()
        // 初始化时间格式化器
        let df = DateFormatter()
        // 指定格式
        df.dateFormat = "yyyy"
        // 格式当前时间与目标时间成字符串
        let currentDateString = df.string(from: currentDate as Date)
        let dateString = df.string(from: date as Date)
        // 对比字符串是否相同
        return (currentDateString as NSString).isEqual(to: dateString)
    }
    
    // MARK: 判断是否是当前月
    // - parameter date: 目标时间
    private func isDateInThisMonth(date: NSDate) -> Bool {
        
        // 取到当前时间
        let currentDate = NSDate()
        // 初始化时间格式化器
        let df = DateFormatter()
        // 指定格式
        df.dateFormat = "mm"
        // 格式当前时间与目标时间成字符串
        let currentDateString = df.string(from: currentDate as Date)
        let dateString = df.string(from: date as Date)
        // 对比字符串是否相同
        return (currentDateString as NSString).isEqual(to: dateString)
    }
    
    // MARK: 这是一个综合的写法
    class func createdateWithStr(time: String) -> NSString {
        
        // 1. 将服务器返回给我们的时间字符串转化为NSDate
        // 1.1.创建formatter
        let formatter = DateFormatter()
        // 1.2.设置时间格式
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        // 1.3.设置时间的区域(真机必须设置，负责可能转化不成功)
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        // 1.4.转化字符串，转化好的字符串是去除时区的时间
        let date = formatter.date(from: time)
        
        let calendar = NSCalendar.current
        
        // 1.判断是否为今天
        if calendar.isDateInToday(date!) {
            
            // 1.0获取当前时间与紫铜时间之间的差距（秒数）
            let since = Int(NSDate().timeIntervalSince(date!))
            // 1.1.是否为刚刚
            print(since)
            if since < 60
            {
                return "刚刚"
            }
            // 1.2.多少分钟以前
            if since < 60 * 60
            {
                return "\(since/60)分钟前" as NSString
            }
            // 1.3.多少小时以前
            return "\(since/(60 * 60))小时前" as NSString
        }
        
        // 2.0.判断是否为昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(date!) {
            // 昨天
            formatterStr = "昨天:" + formatterStr
            
        } else {
            
            // 取到当前时间
            let currentDate = NSDate()
            // 初始化时间格式化器
            let df = DateFormatter()
            // 指定格式
            df.dateFormat = "yyyy"
            // 格式当前时间与目标时间成字符串
            let currentDateString = df.string(from: currentDate as Date)
            let dateString = df.string(from: date!)
            // 判断是不是今年
            if (currentDateString as NSString).isEqual(to: dateString) {
                // 是今年
                // 3. 处理一年以内
                formatterStr = "MM-dd-" + formatterStr
            } else {
                // 4.不是今年
                formatterStr = "yyyy-MM-dd-" + formatterStr
            }
        }
        // 5.按照指定的格式将时间转化为字符串
        // 5.1.创建formatter
        let formatter1 = DateFormatter()
        // 5.2.设置时间格式
        formatter1.dateFormat = formatterStr
        // 5.3.设置时间的区域(真机必须设置，负责可能转化不成功)
        formatter1.locale = NSLocale(localeIdentifier: "en") as Locale?
        // 5.4.格式化
        return formatter1.string(from: date!) as NSString
    }
 
    // MARK: 当前格式化后的时间
    /// 当前格式化后的时间
    /// - Parameter dateFormat: 格式化方式
    /// - Returns: 返回格式化后的字符串
    class func currentFormatTime(_ dateFormat: String = "yyyy年MM月HH时mm分ss秒") -> String {
        // 取到当前时间
        let currentDate = NSDate()
        // 初始化时间格式化器
        let df = DateFormatter()
        // 指定格式
        df.dateFormat = dateFormat
        // 格式当前时间与目标时间成字符串
        let currentDateString = df.string(from: currentDate as Date)
        return currentDateString
    }
}
