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
    
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    public static func async(_ task: @escaping Task,
                             _ mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    private static func _async(_ task: @escaping Task,
                               _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    private static func _asyncDelay(_ seconds: Double,
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
