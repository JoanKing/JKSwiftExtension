//
//  DateExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension
class DateExtensionViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、Date 基本的扩展", "二、时间格式的转换", "三、本地化时间格式的转换", "四、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断", "五、相对的时间变化", "六、年/月/日 的一些判断"]
        dataArray = [["获取当前 秒级 时间戳 - 10 位", "获取当前 毫秒级 时间戳 - 13 位", "获取当前的时间 Date", "从 Date 获取年份", "从 Date 获取月份", "从 Date 获取 日", "从 Date 获取 小时", "从 Date 获取 分钟", "从 Date 获取 秒", "从 Date 获取 毫秒", "从日期获取 星期(英文)", "从日期获取 星期(中文)", "从日期获取 月(英文)"], ["时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串 如：1603849053 按照 yyyy-MM-dd HH:mm:ss 转化后为：2020-10-28 09:37:33", "时间戳(支持 10 位 和 13 位) 转 Date", "Date 转换为相应格式的字符串", "带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致", "带格式的时间转 Date", "秒转换成播放时间条的格式", "Date 转 时间戳"], ["date使用DateFormatter.Style的形式格式化(传本地化字符串)", "date使用DateFormatter.Style的形式格式化(传本地化Locale对象)", "date使用locale和formatter的形式格式化(传本地化字符串)", "date使用locale和formatter的形式格式化(传本地化Locale对象)"], ["今天的日期", "昨天的日期", "明天的日期", "前天的日期", "后天的日期", "是否为今天（只比较日期，不比较时分秒）", "是否为昨天", "是否为前天", "是否为今年", "两个date是否为同一年同一月的同一天", "当前日期是不是润年", "是否为本周", "是否为12小时制"], ["取得与当前时间的间隔差", "获取两个日期之间的数据", "获取两个日期之间的天数", "获取两个日期之间的小时", "获取两个日期之间的分钟", "获取两个日期之间的秒数"], ["获取当前的年", "今年是不是闰年", "某年是不是闰年", "当前的月份", "获取当前月的天数", "获取当前某月的天数"]]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd aa HH:mm"
        // dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        print(dateFormatter.string(from: Date())) // --> Jun 28
        
        dateFormatter.locale = Locale(identifier: "zh-CN")
        dateFormatter.dateFormat = "yyyy年MM-dd aa HH:mm"
        // dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm aa")
        print(dateFormatter.string(from: Date())) // --> Jun 28
        
        dateFormatter.locale = Locale(identifier: "zh-Hant")
        dateFormatter.dateFormat = "aa HH:mm"
        // dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm aa")
        print(dateFormatter.string(from: Date())) // --> Jun 28
    
        dateFormatter.locale = Locale(identifier: "fr")
        dateFormatter.dateFormat = "aa HH:mm"
        print(dateFormatter.string(from: Date())) // --> 28 juin
        
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.dateFormat = "aa HH:mm"
        print(dateFormatter.string(from: Date())) // --> 28 juin
        
        dateFormatter.locale = Locale(identifier: "de")
        dateFormatter.dateFormat = "aa HH:mm"
        print(dateFormatter.string(from: Date())) // --> 28 juin
    
        dateFormatter.locale = Locale(identifier: "it")
        dateFormatter.dateFormat = "aa HH:mm"
        print(dateFormatter.string(from: Date())) // --> 28 juin
        
        dateFormatter.locale = Locale(identifier: "nl")
        dateFormatter.dateFormat = "aa HH:mm"
        print(dateFormatter.string(from: Date())) // --> 28 juin
        
        dateFormatter.locale = Locale(identifier: "sv-SE")
        dateFormatter.dateFormat = "aa HH:mm"
        print(dateFormatter.string(from: Date())) // --> 28 juin
        
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "aa HH:mm"
        print(dateFormatter.string(from: Date())) // --> 28 juin
        
    }
}

// MARK: - 六、年/月/日 的一些判断
extension DateExtensionViewController {
    
    // MARK: 6.6、获取当前某月的天数
    @objc func test66() {
        JKPrint("获取当前某2月的天数：\(Date.jk.monthOfDays(month: 2))", "获取当前某6月的天数：\(Date.jk.monthOfDays(month: 6))")
    }
    
    // MARK: 6.5、获取当前月的天数
    @objc func test65() {
        JKPrint("获取当前月的天数：\(Date.jk.currentMonthDays)")
    }
    
    // MARK: 6.4、当前的月份
    @objc func test64() {
        JKPrint("当前的月份：\(Date.jk.currentMonth)")
    }
    
    // MARK: 6.3、某年是不是闰年
    @objc func test63() {
        JKPrint("2026年是不是闰年：\(Date.jk.yearIsLeapYear(year: 2026))")
    }
    
    // MARK: 6.2、今年是不是闰年
    @objc func test62() {
        JKPrint("今年是不是闰年：\(Date.jk.currentYearIsLeapYear)")
    }
    
    // MARK: 6.1、获取当前的年
    @objc func test61() {
        JKPrint("获取当前的年：\(Date.jk.currentYear)")
    }
}

// MARK: - 五、相对的时间变化
extension DateExtensionViewController {
    // MARK: 5.6、获取两个日期之间的秒数
    @objc func test56() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("获取两个日期之间的秒数", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的秒数：\(date1.jk.numberOfSeconds(from: date2) ?? 0)")
    }
    
    // MARK: 5.5、获取两个日期之间的分钟
    @objc func test55() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("获取两个日期之间的分钟", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的分钟：\(date1.jk.numberOfMinutes(from: date2) ?? 0)")
    }
    
    // MARK: 5.4、获取两个日期之间的小时
    @objc func test54() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("获取两个日期之间的小时", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的小时：\(date1.jk.numberOfHours(from: date2) ?? 0)")
    }
    
    // MARK: 5.3、获取两个日期之间的天数
    @objc func test53() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("获取两个日期之间的天数", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的天数：\(date1.jk.numberOfDays(from: date2) ?? 0)")
    }
    
    // MARK: 5.2、获取两个日期之间的数据
    @objc func test52() {
        // 2023-03-12 11:11:53
        let timestamp1 = "1678590713000"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2023-03-18 02:03:12
        let timestamp2 = "1679076192000" 
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("获取两个日期之间的数据", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的数据：\(date2.jk.componentCompare(from: date1))")
    }
    
    // MARK: 5.1、取得与当前时间的间隔差
    @objc func test51() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("取得与当前时间的间隔差", "\(date1) 与当前时间的间隔差：\(date1.jk.callTimeAfterNow())")
    }
}

// MARK: - 四、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断
extension DateExtensionViewController {
    
    //MARK: 4.13、是否为12小时制
    @objc func test413() {
        let isTwelve = Date.jk.isTwelve
        JKPrint("是否为12小时制：\(isTwelve)")
    }
    
    // MARK: 4.12、是否为本周
    @objc func test412() {
        // 2021-06-23 14:09:06
        let timestamp = "1624428546"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp)
        let timestamp2 = "1629104010"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("是否为本周", "日期：\(date)", "是否为本周: \(date.jk.isThisWeek)", "日期：\(date2)", "是否为本周: \(date2.jk.isThisWeek)")
    }
    
    // MARK: 4.11、当前日期是不是润年
    @objc func test411() {
        // 2021-06-23 14:09:06
        let timestamp = "1624428546"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp)
        JKPrint("当前日期是不是润年", "日期：\(date)", "是不是润年: \(date.jk.isLeapYear)")
    }
    
    // MARK: 4.10、两个date是否为同一年同一月的同一天
    @objc func test410() {
        // 2022-06-17 06:18:00
        let timestamp1 = "1655417880"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2022-06-17 15:18:00
        let timestamp2 = "1655450280"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("是否为同一年同一月的同一天", "\(date1.jk.toformatterTimeString(formatter: "yyyy-MM-dd HH:mm:ss"))", "\(date2.jk.toformatterTimeString(formatter: "yyyy-MM-dd HH:mm:ss"))", "结果：\(date1.jk.isSameDay(date: date2))")
    }
    
    // MARK: 4.9、是否为今年
    @objc func test49() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2019-10-26 09:37:33
        let timestamp2 = "1572053853"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("是否为今年的判断", "\(date1) 是否为今年：\(date1.jk.isThisYear)", "\(date2) 是否为今年：\(date2.jk.isThisYear)")
    }
    
    // MARK: 4.8、是否为前天
    @objc func test48() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("今天：\(date)", "是否为前天：\(date.jk.isTheDayBeforeYesterday)")
    }
    
    // MARK: 4.7、是否为昨天
    @objc func test47() {
        let timestamp1 = "1603762653"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("是否为昨天", "\(date) 是否为昨天 \(date.jk.isYesterday)")
    }
    
    // MARK: 4.6、是否为今天（只比较日期，不比较时分秒）
    @objc func test46() {
        let timestamp1 = "1603849053"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("是否为今天（只比较日期，不比较时分秒）", "\(date) 是否为今天 \(date.jk.isToday)")
    }
    
    // MARK: 4.5、后天的日期
    @objc func test45() {
        guard let date = Date.jk.theDayAfterYesterDayDate else {
            return
        }
        JKPrint("后天的日期：\(date)")
    }
    
    // MARK: 4.4、前天的日期
    @objc func test44() {
        guard let date = Date.jk.theDayBeforYesterDayDate else {
            return
        }
        JKPrint("前天的日期：\(date)")
    }
    
    // MARK: 4.3、明天的日期
    @objc func test43() {
        guard let date = Date.jk.tomorrowDate else {
            return
        }
        JKPrint("明天的日期：\(date)")
    }
    
    // MARK: 4.2、昨天的日期
    @objc func test42() {
        guard let date = Date.jk.yesterDayDate else {
            return
        }
        JKPrint("昨天的日期：\(date)")
    }
    
    // MARK: 4.1、今天的日期
    @objc func test41() {
        JKPrint("今天的日期：\(Date.jk.todayDate)")
    }
}

//MARK: - 三、本地化时间格式的转换
extension DateExtensionViewController {
    
    // MARK: 3.4、date使用locale和formatter的形式格式化(传本地化Locale对象)
    @objc func test34() {
        // let date = Date()
        let timeStr = "2020-05-28"
        let timestamp1Fomatter = "yyyy-MM-dd"
        let date = Date.jk.formatterTimeStringToDate(timesString: timeStr, formatter: timestamp1Fomatter)
        JKPrint("当前的时间：\(date)", "date转 格式为：MMdd 本地化类型：en_US 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(locale: Locale(identifier: "en_US"), formatter: "MMdd"))", "date转 格式为：MMdd 本地化类型：zh_CN 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(locale: Locale(identifier: "zh_CN"), formatter: "MMdd"))")
    }
    
    // MARK: 3.3、date使用locale和formatter的形式格式化(传本地化字符串)
    @objc func test33() {
        // let date = Date()
        let timeStr = "2020-10-28 09:37:33"
        let timestamp1Fomatter = "yyyy-MM-dd HH:mm:ss"
        let date = Date.jk.formatterTimeStringToDate(timesString: timeStr, formatter: timestamp1Fomatter)
        JKPrint("当前的时间：\(date)", "date转 格式为：MMdd 本地化类型：en_US 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(localIdentifier: "en_US", formatter: "MMdd"))", "date转 格式为：MMdd 本地化类型：zh_CN 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(localIdentifier: "zh_CN", formatter: "MMdd"))")
    }
    
    // MARK: 3.2、date使用DateFormatter.Style的形式格式化(传本地化字符串)
    @objc func test32() {
        let timeStr = "2020-02-28"
        let timestamp1Fomatter = "yyyy-MM-dd"
        let date = Date.jk.formatterTimeStringToDate(timesString: timeStr, formatter: timestamp1Fomatter)
        JKPrint("当前的时间：\(date)", "date转 格式为：MMdd 本地化类型：en_US 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(locale: Locale(identifier: "en_US"), formatter: "MMdd", dateStyle: .long, timeStyle: .none))", "date转 格式为：MMdd 本地化类型：fr_FR 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(locale: Locale(identifier: "fr_FR"), formatter: "MMdd", dateStyle: .long, timeStyle: .none))")
    }
    
    // MARK: 3.1、date使用DateFormatter.Style的形式格式化(传本地化字符串)
    @objc func test31() {
        let timeStr = "2020-10-28 09:37:33"
        let timestamp1Fomatter = "yyyy-MM-dd HH:mm:ss"
        let date = Date.jk.formatterTimeStringToDate(timesString: timeStr, formatter: timestamp1Fomatter)
        JKPrint("当前的时间：\(date)", "date转 格式为：yyyyMMMdd 本地化类型：en_US 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(localIdentifier: "en_US", formatter: "yyyyMMMdd", dateStyle: .long, timeStyle: .none))", "date转 格式为：yyyyMMMdd 本地化类型：fr_FR 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(localIdentifier: "fr_FR", formatter: "yyyyMMMdd", dateStyle: .long, timeStyle: .none))", "date转 格式为：yyyyMMMdd 本地化类型：zh-CN 格式化后的时间为：\(date.jk.toLocalDateFormatterStyleString(localIdentifier: "zh-CN", formatter: "yyyyMMMdd", dateStyle: .full, timeStyle: .none))")
    }
}

// MARK: - 二、时间格式的转换
extension DateExtensionViewController {
    
    // MARK: 2.7、Date 转 时间戳
    @objc func test27() {
        let timeStr = "2020-10-28 09:37:33"
        let timestamp1Fomatter = "yyyy-MM-dd HH:mm:ss"
        let date = Date.jk.formatterTimeStringToDate(timesString: timeStr, formatter: timestamp1Fomatter)
        let timestamp = date.jk.dateFromGMT().jk.dateToTimeStamp(timestampType: .second)
        let newTimeStr = Date.jk.timestampToFormatterTimeString(timestamp: timestamp, format: "yyyy-MM-dd HH:mm:ss")
        print("Date 转 时间戳" ,"\(date)：转 时间戳：\(timestamp) -> \(newTimeStr)")
    }
    
    // MARK: 2.6、秒转换成播放时间条的格式
    @objc func test26() {
        let second: Int = 3726
        let second2: Int = 1928
        let second3: Int = 28
        JKPrint("秒转换成播放时间条的格式，\(second)秒 1时2分6秒", "秒类型：\(Date.jk.getFormatPlayTime(seconds: second, type: .second))", "分钟类型：\(Date.jk.getFormatPlayTime(seconds: second, type: .minute))", "小时类型：\(Date.jk.getFormatPlayTime(seconds: second, type: .hour))", "自动类型：\(Date.jk.getFormatPlayTime(seconds: second, type: .normal))", "秒转换成播放时间条的格式，\(second2)秒 32分8秒", "秒类型：\(Date.jk.getFormatPlayTime(seconds: second2, type: .second))", "分钟类型：\(Date.jk.getFormatPlayTime(seconds: second2, type: .minute))", "小时类型：\(Date.jk.getFormatPlayTime(seconds: second2, type: .hour))", "自动类型：\(Date.jk.getFormatPlayTime(seconds: second2, type: .normal))", "秒转换成播放时间条的格式，\(second3)秒 28秒", "秒类型：\(Date.jk.getFormatPlayTime(seconds: second3, type: .second))", "分钟类型：\(Date.jk.getFormatPlayTime(seconds: second3, type: .minute))", "小时类型：\(Date.jk.getFormatPlayTime(seconds: second3, type: .hour))", "自动类型：\(Date.jk.getFormatPlayTime(seconds: second3, type: .normal))")
    }
    
    // MARK: 2.5、带格式的时间转 Date
    @objc func test25() {
        let timesString1 = "2020-10-28"
        let timestamp1Fomatter = "yyyy-MM-dd"
        let date1 = Date.jk.formatterTimeStringToDate(timesString: timesString1, formatter: timestamp1Fomatter)
        let timestamp1 = date1.jk.dateToTimeStamp(timestampType: .second)
        
        let timesString2 = "2020年10月28日"
        let timestamp2Fomatter = "yyyy年MM月dd日"
        let date2 = Date.jk.formatterTimeStringToDate(timesString: timesString2, formatter: timestamp2Fomatter)
        let timestamp2 = date2.jk.dateToTimeStamp(timestampType: .second)
        
        let timesString3 = "2020-10-28 09:37:33"
        let timestamp3Fomatter = "yyyy-MM-dd HH:mm:ss"
        let date3 = Date.jk.formatterTimeStringToDate(timesString: timesString3, formatter: timestamp3Fomatter)
        let timestamp3 = date3.jk.dateToTimeStamp(timestampType: .second)
        
        JKPrint("带格式的时间转 Date", "\(timesString1) -> \(date1) -> \(timestamp1)", "\(timesString2) -> \(date2) -> \(timestamp2)","\(timesString3) -> \(date3) -> \(timestamp3)")
    }
    
    // MARK: 2.4、带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致
    @objc func test24() {
        let timeStr1 = "2020-10-28"
        let timestamp1Fomatter = "yyyy-MM-dd"
        let timestamp1 = Date.jk.formatterTimeStringToTimestamp(timesString: timeStr1, formatter: timestamp1Fomatter, timestampType: .second)
        let timeNewStr1 = Date.jk.timestampToFormatterTimeString(timestamp: timestamp1, format: "yyyy-MM-dd HH:mm:ss")
        
        let timeStr2 = "2020年10月28日"
        let timestamp2Fomatter = "yyyy年MM月dd日"
        let timestamp2 = Date.jk.formatterTimeStringToTimestamp(timesString: timeStr2, formatter: timestamp2Fomatter, timestampType: .millisecond)
        let timeNewStr2 = Date.jk.timestampToFormatterTimeString(timestamp: timestamp2, format: "yyyy-MM-dd HH:mm:ss")
        
        let timeStr3 = "2020-10-28 09:37:33"
        let timestamp3Fomatter = "yyyy-MM-dd HH:mm:ss"
        let timestamp3 = Date.jk.formatterTimeStringToTimestamp(timesString: timeStr3, formatter: timestamp3Fomatter, timestampType: .second)
        let timeNewStr3 = Date.jk.timestampToFormatterTimeString(timestamp: timestamp3, format: "yyyy-MM-dd HH:mm:ss")
        
        JKPrint("时间戳 转 Date, 支持 10 位 和 13 位：", "\(timeStr1) -> \(timestamp1) -> \(timeNewStr1)", "\(timeStr2) -> \(timestamp2) -> \(timeNewStr2)", "\(timeStr3) -> \(timestamp3) -> \(timeNewStr3)")
    }
    
    // MARK: 2.3、Date 转换为相应格式的字符串
    @objc func test23() {
        /// 2020-10-28 09:37:33+
        let timestamp = "1603849053"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp)
        JKPrint("时间戳：\(timestamp)(2020-10-28 09:37:33) 转为Date为：\(date)", "date 转 时间yyyy-MM-dd HH:mm:ss格式的时间为：\(date.jk.toformatterTimeString(formatter: "yyyy-MM-dd HH:mm:ss"))")
    }
    
    // MARK: 2.2、时间戳(支持 10 位 和 13 位) 转 Date
    @objc func test22() {
        let timestamp1 = "1603849053"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        let timestampStr1 = date1.jk.dateToTimeStamp(timestampType: .second)
        
        let timestamp2 = "1603849053000"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        let timestampStr2 = date2.jk.dateToTimeStamp(timestampType: .millisecond)
        
        JKPrint("时间戳(支持 10 位 和 13 位) 转 Date：", "\(timestamp1) -> \(date1) -> \(timestampStr1)", "\(timestamp2) -> \(date2) -> \(timestampStr2)")
    }
    
    // MARK: 2.1、时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串 如：1603849053 按照 "yyyy-MM-dd HH:mm:ss" 转化后为：2020-10-28 09:37:33
    @objc func test21() {
        let timestamp1 = "1603849053"
        let timestamp2 = "1603849053000"
        JKPrint("时间戳 按照对应的格式 转化为 对应时间的字符串，支持10位 和 13位 ：", "\(timestamp1) -> \(Date.jk.timestampToFormatterTimeString(timestamp: timestamp1, format: "yyyy-MM-dd HH:mm:ss"))", "\(timestamp2) -> \(Date.jk.timestampToFormatterTimeString(timestamp: timestamp2, format: "yyyy-MM-dd HH:mm:ss"))")
    }
}

// MARK: - 一、Date 基本的扩展
extension DateExtensionViewController {
    
    // MARK: 1.13、从日期获取 月(英文)
    @objc func test113() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 月(英文)", "\(date) 的 月 为：\(date.jk.monthAsString)")
    }
    
    // MARK: 1.12、从日期获取 星期(中文)
    @objc func test112() {
        let date = Date.jk.currentDate
        // 2021-08-18 16:53:30 星期三
        let timestamp1 = "1629276810"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("从日期获取 星期(中文)", "\(date) 的 星期 为：\(date.jk.weekdayStringFromDate)", "\(date2) 的 星期 为：\(date2.jk.weekdayStringFromDate)")
    }
    
    // MARK: 1.11、从日期获取 星期(英文)
    @objc func test111() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 星期", "\(date) 的 星期 为：\(date.jk.weekday)")
    }
    
    // MARK: 1.10、从 Date 获取 毫秒
    @objc func test110() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 毫秒", "\(date) 的 毫秒 为：\(date.jk.nanosecond)")
    }
    
    // MARK: 1.9、从 Date 获取 秒
    @objc func test19() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 秒", "\(date) 的 秒 为：\(date.jk.second)")
    }
    
    // MARK: 1.8、从 Date 获取 分钟
    @objc func test18() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 分钟", "\(date) 的 分钟 为：\(date.jk.minute)")
    }
    
    // MARK: 1.7、从 Date 获取 小时
    @objc func test17() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 小时", "\(date) 的 小时 为：\(date.jk.hour)")
    }
    
    // MARK: 1.6、从日期获取 日
    @objc func test16() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 日", "\(date) 的 日 为：\(date.jk.day)")
    }
    
    // MARK: 1.5、从 Date 获取月份
    @objc func test15() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 日", "\(date) 的 日 为：\(date.jk.day)")
    }
    
    // MARK: 1.4、从日期获取年份
    @objc func test14() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取年份位", "\(date) 的 年份为：\(date.jk.year)")
    }
    
    // MARK: 1.3、获取当前的时间 Date
    @objc func test13() {
        let date = Date.jk.currentDate
        JKPrint("获取当前的时间 Date位：\(date)","当前的 date 转 时间为：\(date.jk.toformatterTimeString(formatter: "yyyy-MM-dd"))")
    }
    
    // MARK: 1.2、获取当前 毫秒级 时间戳 - 13 位
    @objc func test12() {
        JKPrint("获取当前 毫秒级 时间戳 - 13 位：\(Date.jk.milliStamp)")
    }
    
    // MARK: 1.1、获取当前 秒级 时间戳 - 10 位
    @objc func test11() {
        JKPrint("获取当前 秒级 时间戳 - 10 位：\(Date.jk.secondStamp)")
    }
}
