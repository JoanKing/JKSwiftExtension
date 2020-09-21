//
//  JKAsyncs.swift
//  JKSwiftDemo
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit

public typealias Task = () -> Void

public struct JKAsyncs {
    // MARK:- 异步做一些任务
    // MARK: 异步做一些任务
    /// 异步做一些任务
    /// - Parameter task: 任务
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    
    // MARK: 异步做任务后回到主线程做任务
    /// 异步做任务后回到主线程做任务
    /// - Parameters:
    ///   - task: 异步任务
    ///   - mainTask: 主线程任务
    public static func async(_ task: @escaping Task,
                             _ mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    
    // MARK:- 延迟任务
    // MARK: 延迟执行
    /// 延迟执行
    /// - Parameter seconds: 延迟秒数
    /// - Parameter block: 延迟的block
    @discardableResult
    public static func delay(_ seconds: Double,
                             _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds,
                                      execute: item)
        return item
    }
    
    // MARK: 异步延迟
    /// 异步延迟
    /// - Parameter seconds: 延迟秒数
    /// - Parameter task: 延迟的block
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }
    
    // MARK: 异步延迟回到主线程
    /// 异步延迟回到主线程
    /// - Parameter seconds: 延迟秒数
    /// - Parameter task: 延迟的block
    /// - Parameter mainTask: 延迟的主线程block
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task,
                                  _ mainTask: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task, mainTask)
    }
}

// MARK:- 私有的方法
extension JKAsyncs {
    
    /// 异步任务
    /// - Parameters:
    ///   - task: 任务
    ///   - mainTask: 任务
    fileprivate static func _async(_ task: @escaping Task,
                                   _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    /// 延迟任务
    /// - Parameters:
    ///   - seconds: 延迟时间
    ///   - task: 任务
    ///   - mainTask: 任务
    /// - Returns: DispatchWorkItem
    fileprivate static func _asyncDelay(_ seconds: Double,
                                        _ task: @escaping Task,
                                        _ mainTask: Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                          execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}
