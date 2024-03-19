//
//  Date+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation

extension Date: JKPOPCompatible {}
/// 时间戳的类型
public enum JKTimestampType: Int {
    /// 秒
    case second
    /// 毫秒
    case millisecond
}

// MARK: - 一、Date 基本的扩展
public extension JKPOP where Base == Date {
    // MARK: 1.1、获取当前 秒级 时间戳 - 10 位
    /// 获取当前 秒级 时间戳 - 10 位
    static var secondStamp : String {
        let timeInterval: TimeInterval = Base().timeIntervalSince1970
        return "\(Int(timeInterval))"
    }
    
    // MARK: 1.2、获取当前 毫秒级 时间戳 - 13 位
    /// 获取当前 毫秒级 时间戳 - 13 位
    static var milliStamp : String {
        let timeInterval: TimeInterval = Base().timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    // MARK: 1.3、获取当前的时间 Date
    /// 获取当前的时间 Date
    static var currentDate : Date {
        return Base()
    }
    
    // MARK: 1.4、从 Date 获取年份
    /// 从 Date 获取年份
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self.base)
    }
    
    // MARK: 1.5、从 Date 获取月份
    /// 从 Date 获取年份
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self.base)
    }
    
    // MARK: 1.6、从 Date 获取 日
    /// 从 Date 获取 日
    var day: Int {
        return Calendar.current.component(.day, from: self.base)
    }
    
    // MARK: 1.7、从 Date 获取 小时
    /// 从 Date 获取 日
    var hour: Int {
        return Calendar.current.component(.hour, from: self.base)
    }
    
    // MARK: 1.8、从 Date 获取 分钟
    /// 从 Date 获取 分钟
    var minute: Int {
        return Calendar.current.component(.minute, from: self.base)
    }
    
    // MARK: 1.9、从 Date 获取 秒
    /// 从 Date 获取 秒
    var second: Int {
        return Calendar.current.component(.second, from: self.base)
    }
    
    // MARK: 1.10、从 Date 获取 毫秒
    /// 从 Date 获取 毫秒
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self.base)
    }
    
    // MARK: 1.11、从日期获取 星期(英文)
    /// 从日期获取 星期
    var weekday: String {
        jk_formatter.dateFormat = "EEEE"
        return jk_formatter.string(from: self.base)
    }
    
    // MARK: 1.12、从日期获取 星期(中文)
    var weekdayStringFromDate: String {
        let weekdays = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: self.base as Date)
        return  weekdays[theComponents.weekday! - 1]
    }
    
    // MARK: 1.13、从日期获取 月(英文)
    /// 从日期获取 月(英文)
    var monthAsString: String {
        jk_formatter.dateFormat = "MM"
        return jk_formatter.string(from: self.base)
    }
}

//MARK: - 二、时间格式的转换
// MARK: 时间条的显示格式
public enum JKTimeBarType {
    // 默认格式，如 9秒：09，66秒：01：06，
    case normal
    case second
    case minute
    case hour
}
public extension JKPOP where Base == Date {
    
    // MARK: 2.1、时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串
    /// 时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串 如：1603849053 按照 "yyyy-MM-dd HH:mm:ss" 转化后为：2020-10-28 09:37:33
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - format: 格式
    /// - Returns: 对应时间的字符串
    static func timestampToFormatterTimeString(timestamp: String, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        // 时间戳转为Date
        let date = timestampToFormatterDate(timestamp: timestamp)
        // let dateFormatter = DateFormatter()
        // 设置 dateFormat
        jk_formatter.dateFormat = format
        // 按照dateFormat把Date转化为String
        return jk_formatter.string(from: date)
    }
    
    // MARK: 2.2、时间戳(支持 10 位 和 13 位) 转 Date
    /// 时间戳(支持 10 位 和 13 位) 转 Date
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
        guard let timestampInt = timestamp.jk.toInt() else {
            #if DEBUG
            fatalError("时间戳位有问题")
            #else
            return Date()
            #endif
        }
        let timestampValue = timestamp.count == 10 ? timestampInt : timestampInt / 1000
        // 时间戳转为Date
        let date = Date(timeIntervalSince1970: TimeInterval(timestampValue))
        return date
    }
    
    /// 根据本地时区转换
    private static func getNowDateFromatAnDate(_ anyDate: Date?) -> Date? {
        // 设置源日期时区
        let sourceTimeZone = NSTimeZone(abbreviation: "UTC")
        // 或GMT
        // 设置转换后的目标日期时区
        let destinationTimeZone = NSTimeZone.local as NSTimeZone
        // 得到源日期与世界标准时间的偏移量
        var sourceGMTOffset: Int? = nil
        if let aDate = anyDate {
            sourceGMTOffset = sourceTimeZone?.secondsFromGMT(for: aDate)
        }
        // 目标日期与本地时区的偏移量
        var destinationGMTOffset: Int? = nil
        if let aDate = anyDate {
            destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: aDate)
        }
        // 得到时间偏移量的差值
        let interval = TimeInterval((destinationGMTOffset ?? 0) - (sourceGMTOffset ?? 0))
        // 转为现在时间
        var destinationDateNow: Date? = nil
        if let aDate = anyDate {
            destinationDateNow = Date(timeInterval: interval, since: aDate)
        }
        return destinationDateNow
    }
    
    // MARK: 2.3、Date 转换为相应格式的时间字符串，如 Date 转为 2020-10-28
    /// Date 转换为相应格式的字符串，如 Date 转为 2020-10-28
    /// - Parameter format: 转换的格式
    /// - Returns: 返回具体的字符串
    func toformatterTimeString(formatter: String = "yyyy-MM-dd HH:mm:ss") -> String {
        // let dateFormatter = DateFormatter()
        jk_formatter.timeZone = TimeZone.autoupdatingCurrent
        jk_formatter.dateFormat = formatter
        return jk_formatter.string(from: self.base)
    }
    
    // MARK: 2.4、带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致
    /// 带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致
    /// - Parameters:
    ///   - timeString: 时间字符串，如：2020-10-26 16:52:41
    ///   - formatter: 时间格式，如：yyyy-MM-dd HH:mm:ss
    ///   - timestampType: 返回的时间戳类型，默认是秒 10 为的时间戳字符串
    /// - Returns: 返回转化后的时间戳
    static func formatterTimeStringToTimestamp(timesString: String, formatter: String, timestampType: JKTimestampType = .second) -> String {
        jk_formatter.dateFormat = formatter
        jk_formatter.locale = NSLocale.system
        guard let date = jk_formatter.date(from: timesString) else {
            #if DEBUG
            fatalError("日期格式不匹配")
            #else
            return ""
            #endif
        }
        if timestampType == .second {
            return "\(Int(date.timeIntervalSince1970))"
        }
        return "\(Int((date.timeIntervalSince1970) * 1000))"
    }
    
    // MARK: 2.5、带格式的时间转 Date
    /// 带格式的时间转 Date
    /// - Parameters:
    ///   - timesString: 时间字符串
    ///   - formatter: 格式
    /// - Returns: 返回 Date
    static func formatterTimeStringToDate(timesString: String, formatter: String) -> Date {
        jk_formatter.dateFormat = formatter
        jk_formatter.locale = NSLocale.system
        guard let date = jk_formatter.date(from: timesString) else {
            #if DEBUG
            fatalError("时间有问题")
            #else
            return Date()
            #endif
        }
        /*
        guard let resultDate = getNowDateFromatAnDate(date) else {
            return Date()
        }
        */
        return date
    }
    
    // MARK: 2.6、秒转换成播放时间条的格式
    /// 秒转换成播放时间条的格式
    /// - Parameters:
    ///   - secounds: 秒数
    ///   - type: 格式类型
    /// - Returns: 返回时间条
    static func getFormatPlayTime(seconds: Int, type: JKTimeBarType = .normal) -> String {
        if seconds <= 0{
            return "00:00"
        }
        // 秒
        let second = seconds % 60
        if type == .second {
            return String(format: "%02d", seconds)
        }
        // 分钟
        var minute = Int(seconds / 60)
        if type == .minute {
            return String(format: "%02d:%02d", minute, second)
        }
        // 小时
        var hour = 0
        if minute >= 60 {
            hour = Int(minute / 60)
            minute = minute - hour * 60
        }
        if type == .hour {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        // normal 类型
        if hour > 0 {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        if minute > 0 {
            return String(format: "%02d:%02d", minute, second)
        }
        return String(format: "%02d", second)
    }
    
    // MARK: 2.7、Date 转 时间戳
    /// Date 转 时间戳
    /// - Parameter timestampType: 返回的时间戳类型，默认是秒 10 为的时间戳字符串
    /// - Returns: 时间戳
    func dateToTimeStamp(timestampType: JKTimestampType = .second) -> String {
        // 10位数时间戳 和 13位数时间戳
        let interval = timestampType == .second ? CLongLong(Int(self.base.timeIntervalSince1970)) : CLongLong(round(self.base.timeIntervalSince1970 * 1000))
        return "\(interval)"
    }
    
    // 转成当前时区的日期
    func dateFromGMT() -> Date {
        let secondFromGMT: TimeInterval = TimeInterval(TimeZone.current.secondsFromGMT(for: self.base))
        return self.base.addingTimeInterval(secondFromGMT)
    }
}

// MARK: - 三、本地化时间格式的转换（在日期及其文本表示形式之间进行转换的格式化）
public extension JKPOP where Base == Date {
    
    //MARK: 3.1、date使用DateFormatter.Style的形式格式化(传本地化字符串)
    /// date使用DateFormatter.Style的形式格式化(传本地化字符串)
    /// - Parameters:
    ///   - localIdentifier: 本地化语言字符串
    ///   - formatter: 格式
    ///   - dateStyle: 日期格式
    ///   - timeStyle: 时间格式
    ///   - timeZone: 时区
    /// - Returns: 返回对应的格式化后的时间
    ///
    ///  - Note：在向用户显示日期时，可以根据您的具体需要设置 date formatter 的dateStyle和timeStyle属性。例如，如果您想要显示月份、日期和年份而不显示时间，则可以将dateStyle属性设置为DateFormatter.Style.long 并且将timeStyle属性设置为DateFormatter. Style.none 。相反，如果您只想显示时间，您可以将dateStyle属性设置为DateFormatter.Style.none 并且将timeStyle属性设置为DateFormatter.Style.short。DateFormatter根据dateStyle和timeStyle属性的值，提供适合于给定语言环境的指定日期的表示
    func toLocalDateFormatterStyleString(localIdentifier: String = "zh_CN" , formatter: String = "yyyyMMMd", dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .none, timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> String {
        return toLocalDateFormatterStyleString(locale: Locale(identifier: localIdentifier), formatter: formatter, dateStyle: dateStyle, timeStyle: timeStyle, timeZone: timeZone)
    }
    
    //MARK: 3.2、date使用DateFormatter.Style的形式格式化(传本地化Locale对象)
    /// date使用DateFormatter.Style的形式格式化(传Locale对象)
    /// - Parameters:
    ///   - locale: 本地化Locale对象
    ///   - formatter: 格式
    ///   - dateStyle: 日期格式
    ///   - timeStyle: 时间格式
    ///   - timeZone: 时区
    /// - Returns: 返回对应的格式化后的时间
    func toLocalDateFormatterStyleString(locale: Locale = Locale.current, formatter: String = "yyyyMMMd", dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .none, timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = timeStyle
        dateFormatter.setLocalizedDateFormatFromTemplate(formatter)
        dateFormatter.locale = locale
        return dateFormatter.string(from: self.base)
    }
    
    //MARK: 3.3、date使用locale和formatter的形式格式化(传本地化字符串)
    /// date使用locale和formatter的形式格式化(传本地化字符串)
    /// - Parameters:
    ///   - localIdentifier: 本地化语言字符串
    ///   - formatter: 格式
    ///   - timeZone: 时区
    /// - Returns: 返回对应的格式化后的时间
    func toFormatterLocalTimeString(localIdentifier: String = "zh_CN", formatter: String = "yyyyMMMd", timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> String {
        return toformatterLocalTimeString(locale: Locale(identifier: localIdentifier), formatter: formatter, timeZone: timeZone)
    }
    
    //MARK: 3.4、date使用locale和formatter的形式格式化(传本地化Locale对象)
    /// date使用locale和formatter的形式格式化(传本地化Locale对象)
    /// - Parameters:
    ///   - locale: 本地化Locale对象
    ///   - formatter: 格式
    ///   - timeZone: 时区
    /// - Returns: 返回对应的格式化后的时间
    func toformatterLocalTimeString(locale: Locale = Locale.current, formatter: String = "yyyyMMMd", timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.setLocalizedDateFormatFromTemplate(formatter)
        dateFormatter.locale = locale
        return dateFormatter.string(from: self.base)
    }
}

// MARK: - 四、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断
public extension JKPOP where Base == Date {
    
    // MARK: 4.1、今天的日期
    /// 今天的日期
    static var todayDate: Date {
        return Date()
    }
    
    // MARK: 4.2、昨天的日期（相对于date的昨天日期）
    /// 昨天的日期
    static var yesterDayDate: Date? {
        return Calendar.current.date(byAdding: DateComponents(day: -1), to: Date())
    }
    
    // MARK: 4.3、明天的日期
    /// 明天的日期
    static var tomorrowDate: Date? {
        return Calendar.current.date(byAdding: DateComponents(day: 1), to: Date())
    }
    
    // MARK: 4.4、前天的日期
    /// 前天的日期
    static var theDayBeforYesterDayDate: Date? {
        return Calendar.current.date(byAdding: DateComponents(day: -2), to: Date())
    }
    
    // MARK: 4.5、后天的日期
    /// 后天的日期
    static var theDayAfterYesterDayDate: Date? {
        return Calendar.current.date(byAdding: DateComponents(day: 2), to: Date())
    }
    
    // MARK: 4.6、是否为今天（只比较日期，不比较时分秒）
    /// 是否为今天（只比较日期，不比较时分秒）
    /// - Returns: bool
    var isToday: Bool {
        return Calendar.current.isDate(self.base, inSameDayAs: Date())
    }
    
    // MARK: 4.7、是否为昨天
    /// 是否为昨天
    var isYesterday: Bool {
        // 1.先拿到昨天的 date
        guard let date = Base.jk.yesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return Calendar.current.isDate(self.base, inSameDayAs: date)
    }
    
    // MARK: 4.8、是否为前天
    /// 是否为前天
    var isTheDayBeforeYesterday: Bool  {
        // 1.先拿到前天的 date
        guard let date = Base.jk.theDayBeforYesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return Calendar.current.isDate(self.base, inSameDayAs: date)
    }
    
    // MARK: 4.9、是否为今年
    /// 是否为今年
    var isThisYear: Bool  {
        let calendar = Calendar.current
        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self.base)
        let result = nowCmps.year == selfCmps.year
        return result
    }
    
    // MARK: 4.10、两个date是否为同一天
    /// 是否为  同一年  同一月 同一天
    /// - Returns: bool
    func isSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self.base, inSameDayAs: date)
    }
    
    // MARK: 4.11、当前日期是不是润年
    /// 当前日期是不是润年
    var isLeapYear: Bool {
        let year = base.jk.year
        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)))
    }
    
    /// 日期的加减操作
    /// - Parameter day: 天数变化
    /// - Returns: date
    private func adding(day: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:day), to: self.base)
    }
    
    /// 是否为  同一年  同一月 同一天
    /// - Parameter date: date
    /// - Returns: 返回bool
    private func isSameYeaerMountDay(_ date: Date) -> Bool {
        let com = Calendar.current.dateComponents([.year, .month, .day], from: self.base)
        let comToday = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return (com.day == comToday.day &&
            com.month == comToday.month &&
            com.year == comToday.year )
    }
    
    // MARK: 4.12、是否为本周
    /// 是否为本周
    /// - Returns: 是否为本周
    var isThisWeek: Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.weekday, .month, .year], from: Date())
        // self
        let selfComponents = calendar.dateComponents([.weekday,.month,.year], from: self.base as Date)
        return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.weekday == nowComponents.weekday)
    }
    
    // MARK: 4.13、是否为12小时制
    /// 是否为12小时制
    /// - Returns: true：12小时，否则24小时
    static var isTwelve: Bool {
        var isTwelve: Bool = false
        if let formatString = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current), formatString.contains("a") {
            // 12 小时制
            isTwelve = true
        } else {
            // 24 小时制
            isTwelve = false
        }
        return isTwelve
    }
}

// MARK: - 五、相对的时间变化
public extension JKPOP where Base == Date {
    
    // MARK: 5.1、取得与当前时间的间隔差
    /// 取得与当前时间的间隔差
    /// - Returns: 时间差
    func callTimeAfterNow() -> String {
        let timeInterval = Date().timeIntervalSince(self.base)
        if timeInterval < 0 {
            return "刚刚"
        }
        let interval = fabs(timeInterval)
        let i60 = interval / 60
        let i3600 = interval / 3600
        let i86400 = interval / 86400
        let i2592000 = interval / 2592000
        let i31104000 = interval / 31104000
        
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
    
    // MARK: 5.2、获取两个日期之间的数据
    /// 获取两个日期之间的数据
    /// - Parameters:
    ///   - date: 对比的日期
    ///   - unit: 对比的类型
    /// - Returns: 两个日期之间的数据
    func componentCompare(from date: Date, unit: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]) -> DateComponents {
        let calendar = Calendar.current
        let component = calendar.dateComponents(unit, from: date, to: base)
        return component
    }
    
    // MARK: 5.3、获取两个日期之间的天数
    /// 获取两个日期之间的天数
    /// - Parameter date: 对比的日期
    /// - Returns: 两个日期之间的天数
    func numberOfDays(from date: Date) -> Int? {
       return componentCompare(from: date, unit: [.day]).day
    }
    
    // MARK: 5.4、获取两个日期之间的小时
    /// 获取两个日期之间的小时
    /// - Parameter date: 对比的日期
    /// - Returns: 两个日期之间的小时
    func numberOfHours(from date: Date) -> Int? {
       return componentCompare(from: date, unit: [.hour]).hour
    }
    
    // MARK: 5.5、获取两个日期之间的分钟
    /// 获取两个日期之间的分钟
    /// - Parameter date: 对比的日期
    /// - Returns: 两个日期之间的分钟
    func numberOfMinutes(from date: Date) -> Int? {
       return componentCompare(from: date, unit: [.minute]).minute
    }
    
    // MARK: 5.6、获取两个日期之间的秒数
    /// 获取两个日期之间的秒数
    /// - Parameter date: 对比的日期
    /// - Returns: 两个日期之间的秒数
    func numberOfSeconds(from date: Date) -> Int? {
       return componentCompare(from: date, unit: [.second]).second
    }
}

// MARK: - 六、年/月/日 的一些判断
public extension JKPOP where Base == Date {
    
    // MARK: 6.1、获取当前的年
    /// 获取当前的年
    static var currentYear : Int {
        return currentDate.jk.year
    }
    
    // MARK: 6.2、今年是不是闰年
    /// 1.16、今年是不是闰年
    static var currentYearIsLeapYear: Bool {
        return todayDate.jk.isLeapYear
    }
    
    // MARK: 6.3、某年是不是闰年
    /// 6.3、某年是不是闰年
    static func yearIsLeapYear(year: Int) -> Bool {
        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)))
    }
    
    // MARK: 6.4、当前的月份
    /// 当前的月份
    static var currentMonth: Int {
        return currentDate.jk.month
    }
    
    // MARK: 6.5、获取当前月的天数
    /// 获取当前月的天数
    /// - Returns: 返回天数
    static var currentMonthDays: Int {
        return monthOfDays(month: currentMonth)
    }
    
    // MARK: 6.6、获取当前某月的天数
    /// 获取当前某月的天数
    /// - Returns: 返回天数
    static func monthOfDays(month: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 4, 6, 9, 11:
            return 30
        case 2:
            return currentYearIsLeapYear ? 29 : 28
        default:
            fatalError("非法的月份:\(month)")
        }
    }
}
