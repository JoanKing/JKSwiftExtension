//
//  JKEKEvent.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/3/15.
//
// MARK:- 日历和提醒事件的基本使用
import Foundation
import EventKit

public class JKEKEvent: NSObject {}

// MARK:- 一、日历基本的使用
public extension JKEKEvent {
    
    // MARK: 1.1、根据时间段获取日历事件
    /// 根据时间段获取日历事件
    /// - Parameters:
    ///   - startDate: 开始时间
    ///   - endDate: 结束时间
    ///   - eventsClosure: 事件闭包
    static func selectCalendarsEvents(startDate: Date, endDate: Date, eventsClosure: @escaping (([EKEvent]) -> Void)) {
        let eventStore = EKEventStore()
        // 请求日历事件
        eventStore.requestAccess(to: .event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                // 获取本地日历（剔除节假日，生日等其他系统日历）
                let calendars = eventStore.calendars(for: .event).filter({
                    (calender) -> Bool in
                    return calender.type == .local || calender.type == .calDAV
                })
                let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
                let eV = eventStore.events(matching: predicate)
                resultMain(parameter: eV, eventsClosure: eventsClosure)
            } else {
                resultMain(parameter: [], eventsClosure: eventsClosure)
            }
        })
    }
    
    // MARK: 1.2、添加日历事件
    /// 添加日历事件
    /// - Parameters:
    ///   - title: 提醒的标题
    ///   - startDate: 开始时间
    ///   - endDate: 结束时间
    ///   - notes: 备注
    ///   - eventsClosure: 事件闭包
    static func addCalendarsEvents(title: String, startDate: Date, endDate: Date, notes: String, eventsClosure: @escaping ((Bool, String?) -> Void)) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                let event: EKEvent = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = notes
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    resultMain(parameter: (true, event.calendarItemIdentifier), eventsClosure: eventsClosure)
                } catch {
                    resultMain(parameter: (false, nil), eventsClosure: eventsClosure)
                }
            } else {
                resultMain(parameter: (false, nil), eventsClosure: eventsClosure)
            }
        })
    }
    
    // MARK: 1.3、修改日历事件
    /// 修改日历事件
    /// - Parameters:
    ///   - eventIdentifier: 唯一标识符区分某个事件
    ///   - title: 提醒的标题
    ///   - startDate: 开始时间
    ///   - endDate: 结束时间
    ///   - notes: 备注
    ///   - eventsClosure: 事件闭包
    static func updateCalendarsEvents(eventIdentifier: String, title: String, startDate: Date, endDate: Date, notes: String, eventsClosure: @escaping ((Bool) -> Void)) {
        let eventStore = EKEventStore()
        // 请求日历事件
        eventStore.requestAccess(to: .event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                // 获取本地日历（剔除节假日，生日等其他系统日历）
                let calendars = eventStore.calendars(for: .event).filter({
                    (calender) -> Bool in
                    return calender.type == .local || calender.type == .calDAV
                })
                let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
                let events = eventStore.events(matching: predicate)
                let eventArray = events.filter { $0.calendarItemIdentifier == eventIdentifier }
                guard eventArray.count > 0 else {
                    resultMain(parameter: false, eventsClosure: eventsClosure)
                    return
                }
                let event = eventArray[0]
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = notes
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    resultMain(parameter: true, eventsClosure: eventsClosure)
                } catch {
                    resultMain(parameter: false, eventsClosure: eventsClosure)
                }
            } else {
                resultMain(parameter: false, eventsClosure: eventsClosure)
            }
        })
    }
    
    // MARK: 1.4、删除日历事件
    /// 删除日历事件
    /// - Parameters:
    ///   - eventIdentifier: 唯一标识符区分某个事件
    ///   - eventsClosure: 事件闭包
    static func removeCalendarsEvent(eventIdentifier: String, eventsClosure: @escaping ((Bool) -> Void)) {
        let eventStore = EKEventStore()
        // 请求日历事件
        eventStore.requestAccess(to: .event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                // 获取本地日历（剔除节假日，生日等其他系统日历）
                let calendars = eventStore.calendars(for: .event).filter({
                    (calender) -> Bool in
                    return calender.type == .local || calender.type == .calDAV
                })
                // 获取当前年
                let com = Calendar.current.dateComponents([.year], from: Date())
                let currentYear = com.year!
                var events: [EKEvent] = []
                // 获取所有的事件（前后20年）
                for i in -20...20 {
                    let startDate = startOfMonth(year: currentYear + i, month:1)
                    let endDate = endOfMonth(year: currentYear + i, month: 12, returnEndTime: true)
                    let predicate = eventStore.predicateForEvents(
                        withStart: startDate, end: endDate, calendars: calendars)
                    let eV = eventStore.events(matching: predicate)
                    events.append(eV)
                }
                let event = events.filter { return $0.calendarItemIdentifier == eventIdentifier }
                guard event.count > 0 else {
                    resultMain(parameter: false, eventsClosure: eventsClosure)
                    return
                }
                do {
                    try eventStore.remove(event[0], span: .thisEvent, commit: true)
                    resultMain(parameter: true, eventsClosure: eventsClosure)
                } catch {
                    resultMain(parameter: false, eventsClosure: eventsClosure)
                }
            } else {
                resultMain(parameter: false, eventsClosure: eventsClosure)
            }
        })
    }
}

// MARK:- 二、提醒事件的基本的使用
public extension JKEKEvent {
    
    // MARK: 2.1、查询出所有提醒事件
    static func selectReminder(remindersClosure: @escaping (([EKReminder]?) -> Void)) {
        // 在取得提醒之前，需要先获取授权
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .reminder) {
            (granted: Bool, error: Error?) in
            if (granted) && (error == nil) {
                // 获取授权后，我们可以得到所有的提醒事项
                let predicate = eventStore.predicateForReminders(in: nil)
                eventStore.fetchReminders(matching: predicate, completion: {
                    (reminders: [EKReminder]?) -> Void in
                    resultMain(parameter: reminders, eventsClosure: remindersClosure)
                })
            } else {
                resultMain(parameter: nil, eventsClosure: remindersClosure)
            }
        }
    }
    
    // MARK: 2.2、添加提醒事件
    /// 添加提醒事件
    /// - Parameters:
    ///   - title: 提醒的标题
    ///   - startDate: 开始时间
    ///   - endDate: 结束时间
    ///   - notes: 备注
    ///   - eventsClosure: 事件闭包
    static func addReminder(title: String, startDate: Date, endDate: Date, notes: String, eventsClosure: @escaping ((Bool, String?) -> Void)) {
        let eventStore = EKEventStore()
        // 获取"提醒"的访问授权
        eventStore.requestAccess(to: .reminder) {(granted, error) in
            if (granted) && (error == nil) {
                // 创建提醒条目
                let reminder = EKReminder(eventStore: eventStore)
                reminder.title = title
                reminder.notes = notes
                reminder.startDateComponents = dateComponentFrom(date: startDate)
                reminder.dueDateComponents = dateComponentFrom(date: endDate)
                reminder.calendar = eventStore.defaultCalendarForNewReminders()
                // 保存提醒事项
                do {
                    try eventStore.save(reminder, commit: true)
                    resultMain(parameter: (true, reminder.calendarItemIdentifier), eventsClosure: eventsClosure)
                } catch {
                    resultMain(parameter: (false, nil), eventsClosure: eventsClosure)
                }
            } else {
                resultMain(parameter: (false, nil), eventsClosure: eventsClosure)
            }
        }
    }
    
    // MARK: 2.3、修改提醒事件
    /// 修改提醒事件
    /// - Parameters:
    ///   - eventIdentifier: 唯一标识符区分某个事件
    ///   - title: 提醒的标题
    ///   - startDate: 开始时间
    ///   - endDate: 结束时间
    ///   - notes: 备注
    ///   - eventsClosure: 事件闭包
    static func updateEvent(eventIdentifier: String, title: String, startDate: Date, endDate: Date, notes: String, eventsClosure: @escaping ((Bool) -> Void)) {
        let eventStore = EKEventStore()
        // 获取"提醒"的访问授权
        eventStore.requestAccess(to: .reminder) {(granted, error) in
            if (granted) && (error == nil) {
                // 获取授权后，我们可以得到所有的提醒事项
                let predicate = eventStore.predicateForReminders(in: nil)
                eventStore.fetchReminders(matching: predicate, completion: {
                    (reminders: [EKReminder]?) -> Void in
                    guard let weakReminders = reminders else {
                        resultMain(parameter: false, eventsClosure: eventsClosure)
                        return
                    }
                    let weakReminder = weakReminders.filter { $0.calendarItemIdentifier == eventIdentifier }
                    guard weakReminder.count > 0 else {
                        resultMain(parameter: false, eventsClosure: eventsClosure)
                        return
                    }
                    let reminder = weakReminder[0]
                    reminder.title = title
                    reminder.notes = notes
                    reminder.startDateComponents = dateComponentFrom(date: startDate)
                    reminder.dueDateComponents = dateComponentFrom(date: endDate)
                    reminder.calendar = eventStore.defaultCalendarForNewReminders()
                    // 修改提醒事项
                    do {
                        try eventStore.save(reminder, commit: true)
                        resultMain(parameter: true, eventsClosure: eventsClosure)
                    } catch {
                        resultMain(parameter: false, eventsClosure: eventsClosure)
                    }
                })
            }
        }
    }
    
    // MARK: 2.4、移除提醒事件
    /// 移除提醒事件
    /// - Parameters:
    ///   - eventIdentifier: 唯一标识符区分某个事件
    ///   - title: 提醒的标题
    ///   - startDate: 开始时间
    ///   - endDate: 结束时间
    ///   - notes: 备注
    ///   - eventsClosure: 事件闭包
    static func removeEvent(eventIdentifier: String, eventsClosure: @escaping ((Bool) -> Void)) {
        let eventStore = EKEventStore()
        // 获取"提醒"的访问授权
        eventStore.requestAccess(to: .reminder) {(granted, error) in
            if (granted) && (error == nil) {
                // 获取授权后，我们可以得到所有的提醒事项
                let predicate = eventStore.predicateForReminders(in: nil)
                eventStore.fetchReminders(matching: predicate, completion: {
                    (reminders: [EKReminder]?) -> Void in
                    guard let weakReminders = reminders else {
                        resultMain(parameter: false, eventsClosure: eventsClosure)
                        return
                    }
                    let reminderArray = weakReminders.filter { $0.calendarItemIdentifier == eventIdentifier }
                    guard reminderArray.count > 0 else {
                        resultMain(parameter: false, eventsClosure: eventsClosure)
                        return
                    }
                    // 移除提醒事项
                    do {
                        try eventStore.remove(reminderArray[0], commit: true)
                        resultMain(parameter: true, eventsClosure: eventsClosure)
                    } catch {
                        resultMain(parameter: false, eventsClosure: eventsClosure)
                    }
                })
            }
        }
    }
}

// MARK:- private
private extension JKEKEvent {
    
    /// 根据NSDate获取对应的DateComponents对象
    static func dateComponentFrom(date: Date) -> DateComponents {
        let cal = Calendar.current
        let dateComponents = cal.dateComponents([.minute, .hour, .day, .month, .year], from: date)
        return dateComponents
    }
    
    /// 指定年月的开始日期
    static func startOfMonth(year: Int, month: Int) -> Date {
        let calendar = Calendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps)!
        return startDate
    }
    
    /// 指定年月的结束日期
    static func endOfMonth(year: Int, month: Int, returnEndTime: Bool = false) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        let tem = startOfMonth(year: year, month: month)
        let endOfYear =  calendar.date(byAdding: components, to: tem)!
        return endOfYear
    }
    
    /// 事件主线程
    /// - Parameters:
    ///   - parameter: 返回的参数
    ///   - eventsClosure: 闭包
    private static func resultMain<T>(parameter: T, eventsClosure: @escaping ((T) -> Void)) {
        DispatchQueue.main.async {
            eventsClosure(parameter)
        }
    }
}
