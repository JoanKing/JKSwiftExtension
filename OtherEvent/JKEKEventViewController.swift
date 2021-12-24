//
//  JKEKEventViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/3/15.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class JKEKEventViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、日历基本的使用", "二、提醒事件的基本的使用"]
        dataArray = [["根据时间段获取日历事件", "添加日历事件", "修改日历事件", "删除日历事件"], ["查询出所有提醒事件", "添加提醒事件", "修改提醒事件", "移除提醒事件"]]
    }
}

// MARK:- 二、提醒事件的基本的使用
extension JKEKEventViewController {
    
    // MARK: 2.4、移除提醒事件(提示：先执行：2.1获取一个eventIdentifier)
    @objc func test24() {
        JKEKEvent.removeEvent(eventIdentifier: "1691CA27-63F4-4E7A-8CB7-DD7B6D1A48AF") { (result) in
            JKPrint("线程：\(Thread.current) 移除的结果：\(result)")
        }
    }
    
    // MARK: 2.3、修改提醒事件(提示：先执行：2.1获取一个eventIdentifier)
    @objc func test23() {
        let timestamp1 = "2021-3-19 8:30"
        let timestampFomatter1 = "yyyy-MM-dd HH:mm"
        let date1 = Date.jk.formatterTimeStringToDate(timesString: timestamp1, formatter: timestampFomatter1)
        let timestamp2 = "2021-3-19 9:30"
        let timestampFomatter2 = "yyyy-MM-dd HH:mm"
        let date2 = Date.jk.formatterTimeStringToDate(timesString: timestamp2, formatter: timestampFomatter2)
            
        JKEKEvent.updateEvent(eventIdentifier: "1691CA27-63F4-4E7A-8CB7-DD7B6D1A48AF", title: "这是修改的标题", startDate: date1, endDate: date2, notes: "这是修改后的备注") { (result) in
            JKPrint("线程：\(Thread.current) 结果是：\(result)")
        }
    }
    
    // MARK: 2.2、添加提醒事件
    @objc func test22() {
        let timestamp1 = "2021-3-19 8:30"
        let timestampFomatter1 = "yyyy-MM-dd HH:mm"
        let date1 = Date.jk.formatterTimeStringToDate(timesString: timestamp1, formatter: timestampFomatter1)
        let timestamp2 = "2021-3-19 9:30"
        let timestampFomatter2 = "yyyy-MM-dd HH:mm"
        let date2 = Date.jk.formatterTimeStringToDate(timesString: timestamp2, formatter: timestampFomatter2)
            
        JKEKEvent.addReminder(title: "测试添加事件", startDate: date1, endDate: date2, notes: "这是备注") { (result, calendarItemIdentifier)  in
            if result {
                JKPrint("线程：\(Thread.current) 添加成功 标识符：\(calendarItemIdentifier ?? "")")
            } else {
                JKPrint("线程：\(Thread.current) 添加失败")
            }
        }
    }
    
    // MARK: 2.1、查询出所有提醒事件
    @objc func test21() {
        
        JKEKEvent.selectReminder { (reminders) in
            guard let weakReminders = reminders else {
                return
            }
            for (_, reminder)  in weakReminders.enumerated() {
                JKPrint("线程：\(Thread.current) 提醒事件的名字：\(reminder.title ?? "")", "提醒事件的标识：\(reminder.calendarItemIdentifier)")
            }
        }
    }
}

// MARK:- 一、日历基本的使用
extension JKEKEventViewController {
    
    // MARK: 1.4、删除日历事件
    @objc func test14() {
        JKEKEvent.removeCalendarsEvent(eventIdentifier: "AD65E718-5F5B-46DA-9E12-5D30C37096C1") { (result) in
            print("线程：\(Thread.current) 删除结果：\(result)")
        }
    }
    
    // MARK: 1.3、修改日历事件
    @objc func test13() {
        let timestamp1 = "2021-1-19 8:30"
        let timestampFomatter1 = "yyyy-MM-dd HH:mm"
        let date1 = Date.jk.formatterTimeStringToDate(timesString: timestamp1, formatter: timestampFomatter1)
        let timestamp2 = "2021-3-19 9:30"
        let timestampFomatter2 = "yyyy-MM-dd HH:mm"
        let date2 = Date.jk.formatterTimeStringToDate(timesString: timestamp2, formatter: timestampFomatter2)
        JKEKEvent.updateCalendarsEvents(eventIdentifier: "AD65E718-5F5B-46DA-9E12-5D30C37096C1", title: "修改后游乐园", startDate: date1, endDate: date2, notes: "修改后的备注") { (result) in
            JKPrint("线程：\(Thread.current) 结果是：\(result)")
        }
    }
    
    // MARK: 1.2、添加日历事件
    @objc func test12() {
        let timestamp1 = "2021-3-19 8:30"
        let timestampFomatter1 = "yyyy-MM-dd HH:mm"
        let date1 = Date.jk.formatterTimeStringToDate(timesString: timestamp1, formatter: timestampFomatter1)
        let timestamp2 = "2021-3-19 9:30"
        let timestampFomatter2 = "yyyy-MM-dd HH:mm"
        let date2 = Date.jk.formatterTimeStringToDate(timesString: timestamp2, formatter: timestampFomatter2)
        JKEKEvent.addCalendarsEvents(title: "日历事件", startDate: date1, endDate: date2, notes: "备注") { (result, calendarItemIdentifier) in
            if result {
                JKPrint("线程：\(Thread.current) 添加成功 标识符：\(calendarItemIdentifier ?? "")")
            } else {
                JKPrint("线程：\(Thread.current) 添加失败")
            }
        }
    }
    
    // MARK: 1.1、根据时间段获取日历事件
    @objc func test11() {
        
        let timestamp1 = "2021-03-01 8:30"
        let timestampFomatter1 = "yyyy-MM-dd HH:mm"
        let date1 = Date.jk.formatterTimeStringToDate(timesString: timestamp1, formatter: timestampFomatter1)
        let timestamp2 = "2021-04-19 9:30"
        let timestampFomatter2 = "yyyy-MM-dd HH:mm"
        let date2 = Date.jk.formatterTimeStringToDate(timesString: timestamp2, formatter: timestampFomatter2)
        
        JKEKEvent.selectCalendarsEvents(startDate: date1, endDate: date2) { (events) in
            JKPrint("事件数量是：\(events.count)")
            for (_, event) in events.enumerated() {
                print("线程：\(Thread.current) 标题是：\(event.title ?? "") 事件的标识：\(event.calendarItemIdentifier)")
            }
        }
    }
}

