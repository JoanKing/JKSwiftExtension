//
//  JKEKEvent.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/3/15.
//
// MARK:- 日历的组件
import Foundation
import EventKit

// MARK:- 一、基本的使用
public class JKEKEvent: NSObject {
    
    // MARK: 1.1、获取前后十年的事件
    /// 获取前后十年的事件
    /// - Parameter eventsClosure: 时间闭包
    public static func getCalendarsEvents(eventsClosure: @escaping (([EKEvent]) -> Void)) {
        let eventStore = EKEventStore()
        // 事件集合
        var events: [EKEvent] = []
        // 请求日历事件
        eventStore.requestAccess(to: .event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                // 获取本地日历（剔除节假日，生日等其他系统日历）
                let calendars = eventStore.calendars(for: .event).filter({
                    (calender) -> Bool in
                    return calender.type == .local || calender.type == .calDAV
                })
                events = []
                // 获取当前年
                let com = Calendar.current.dateComponents([.year], from: Date())
                let currentYear = com.year!
                // 获取所有的事件（前后20年）
                for i in -10...10 {
                    let startDate = self.startOfMonth(year: currentYear + i, month: 1)
                    let endDate = self.endOfMonth(year: currentYear + i, month: 12, returnEndTime: true)
                    print("查询范围 开始:\(startDate) 结束:\(endDate)")
                    let predicate2 = eventStore.predicateForEvents(
                        withStart: startDate, end: endDate, calendars: calendars)
                    let eV = eventStore.events(matching: predicate2)
                    // 将获取到的日历事件添加到集合中
                    events.append(contentsOf: eV)
                }
                // 重新刷新表格数据
                DispatchQueue.main.async {
                    eventsClosure(events)
                }
            } else {
                eventsClosure([])
            }
        })
    }
    
    // 指定年月的开始日期
    private static func startOfMonth(year: Int, month: Int) -> Date {
        let calendar = Calendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps)!
        return startDate
    }
    
    // 指定年月的结束日期
    private static func endOfMonth(year: Int, month: Int, returnEndTime: Bool = false) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        let tem = startOfMonth(year: year, month:month)
        let endOfYear = calendar.date(byAdding: components, to: tem)!
        return endOfYear
    }
}
