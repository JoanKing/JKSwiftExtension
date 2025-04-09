//
//  JKTaskManager.swift
//  JKSwiftExtension
//
//  Created by chongwang on 2025/2/5.
//  任务管理器类，用于调度和取消延迟任务。
import Foundation
import Dispatch
// MARK: - 任务管理器类，用于调度和取消延迟任务。
/// 通过 `DispatchWorkItem` 实现任务的延迟执行，并支持任务取消。
public class JKTaskManager {
    
    public init() { }
    
    // 存储任务标识符与对应的 DispatchWorkItem
    private var workItems: [String: DispatchWorkItem] = [:]

    /// 调度一个延迟任务。
    /// - Parameters:
    ///   - identifier: 任务的唯一标识符。如果已存在相同标识符的任务，则取消旧任务。
    ///   - delay: 任务的延迟时间（以秒为单位）。
    ///   - task: 需要执行的任务闭包。
    public func scheduleTask(identifier: String, delay: TimeInterval, task: @escaping () -> Void) {
        // 取消已存在的相同标识符的任务
        cancelTask(identifier: identifier)
        
        // 创建一个 DispatchWorkItem，封装任务闭包
        let workItem = DispatchWorkItem {
            task()
        }
        
        // 将任务存储到字典中，以便后续取消
        workItems[identifier] = workItem
        
        // 在主队列中延迟执行任务
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
    }

    /// 取消指定标识符的任务。
    /// - Parameter identifier: 需要取消的任务的唯一标识符。
    public func cancelTask(identifier: String) {
        // 检查是否存在对应标识符的任务
        if let workItem = workItems[identifier] {
            // 取消任务
            workItem.cancel()
            // 从字典中移除该任务
            workItems.removeValue(forKey: identifier)
        }
    }
}
