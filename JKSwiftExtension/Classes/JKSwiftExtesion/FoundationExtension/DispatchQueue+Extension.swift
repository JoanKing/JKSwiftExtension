//
//  DispatchQueue+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/6.
//

import Foundation

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    /// 函数只被执行一次
    static func once(token: String, block: () -> ()) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return;
        }
        _onceTracker.append(token)
        block()
    }
    
    /// 延迟 delay 秒 执行
    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
