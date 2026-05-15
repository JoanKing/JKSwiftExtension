//
//  JKAsyncs.swift
//  JKSwiftDemo
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation

// 任务闭包
public typealias JKTask = () -> Void

// MARK: - GCD 异步任务工具
/// GCD 异步任务工具
///
/// 功能说明：
/// - 立即在后台异步执行任务
/// - 后台任务执行完成后回到主线程
/// - 延迟执行后台任务
/// - 延迟执行后台任务后，再回到主线程执行任务
public enum JKAsyncs {
    
    // MARK: 1.1、立即异步执行 （默认全局队列）
    /// 立即在默认全局队列中异步执行任务
    /// - Parameter task: 异步执行的任务
    /// - Returns: 当前任务对应的 `DispatchWorkItem`，可用于取消任务
    @discardableResult
    public static func async(on queue: DispatchQueue = .global(), _ task: @escaping JKTask) -> DispatchWorkItem {
        return schedule(after: 0, on: queue, task: task)
    }
    
    // MARK: 1.2、立即异步执行，完成后回主线程
    /// 立即在默认全局队列中异步执行任务，任务完成后回到主线程执行
    /// - Parameters:
    ///   - task: 后台异步任务
    ///   - mainTask: 后台任务完成后，在主线程执行的任务
    /// - Returns: 当前任务对应的 `DispatchWorkItem`，可用于取消任务
    @discardableResult
    public static func async(on queue: DispatchQueue = .global(),
                             _ task: @escaping JKTask,
                             mainTask: @escaping JKTask) -> DispatchWorkItem{
        return schedule(after: 0, on: queue, task: task, mainTask: mainTask)
    }
    
    // MARK: 1.3、异步延迟(子线程执行任务)
    /// 延迟一段时间后，在指定队列中异步执行任务
    /// - Parameters:
    ///   - seconds: 延迟执行的时间，单位：秒
    ///   - queue: 执行任务的队列（默认全局并发队列）
    ///   - task: 延迟后执行的任务
    /// - Returns: 当前任务对应的 `DispatchWorkItem`，可用于取消任务
    @discardableResult
    public static func asyncDelay(_ seconds: TimeInterval,
                                  on queue: DispatchQueue = .global(),
                                  _ task: @escaping JKTask) -> DispatchWorkItem {
        return schedule(after: seconds, on: queue, task: task)
    }
    
    // MARK: 1.4、异步延迟回到主线程（子线程执行任务，然后回到主线程执行任务）
    /// 延迟一段时间后，在指定队列中异步执行任务，任务完成后回到主线程执行
    /// - Parameters:
    ///   - seconds: 延迟执行的时间，单位：秒
    ///   - queue: 执行后台任务的队列（默认全局并发队列）
    ///   - task: 延迟后执行的后台任务
    ///   - mainTask: 后台任务完成后，在主线程执行的任务
    /// - Returns: 当前任务对应的 `DispatchWorkItem`，可用于取消任务
    @discardableResult
    public static func asyncDelay(_ seconds: TimeInterval,
                                  on queue: DispatchQueue = .global(),
                                  _ task: @escaping JKTask,
                                  mainTask: @escaping JKTask) -> DispatchWorkItem {
        return schedule(after: seconds, on: queue, task: task, mainTask: mainTask)
    }
    
    // MARK: 1.5、延迟一段时间后，直接在主线程执行任务
    /// 延迟一段时间后，直接在主线程执行任务
    /// - Parameters:
    ///   - seconds: 延迟执行的时间，单位：秒
    ///   - mainTask: 延迟后在主线程执行的任务
    /// - Returns: 当前任务对应的 `DispatchWorkItem`，可用于取消任务
    @discardableResult
    public static func asyncDelayMain(_ seconds: TimeInterval,
                                      _ mainTask: @escaping JKTask) -> DispatchWorkItem {
        return schedule(after: seconds, on: DispatchQueue.main, task: mainTask)
    }
}

// MARK: - 私有方法
extension JKAsyncs {
    
    /// 延迟任务
    /// - Parameters:
    ///   - seconds: 延迟的时间
    ///   - queue: 队列
    ///   - task: 队列任务
    ///   - mainTask: 主线程任务
    /// - Returns: description
    fileprivate static func schedule(after seconds: TimeInterval,
                                     on queue: DispatchQueue,
                                     task: @escaping JKTask,
                                     mainTask: JKTask? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        queue.asyncAfter(deadline: DispatchTime.now() + max(0, seconds),execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main) {[weak item] in
                // 如果 item 还在，且是被外部明确 cancel 的，则拦截；
                // 如果 item 是 nil (已被释放说明正常执行完毕) 或未被 cancel，则照常执行主线程回调！
                if item?.isCancelled == true { return }
                main()
            }
        }
        return item
    }
}
