//
//  Timer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/28.
//

import UIKit

public extension Timer {
    class func scheduledSafeTimer(timeInterval ti: TimeInterval, repeats yesOrNo: Bool, callBack cb: @escaping ((Timer) -> Void)) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: ti, repeats: yesOrNo, block: cb)
        }
        return Timer.scheduledTimer(timeInterval: ti, target: self, selector: #selector(timerCB(timer:)), userInfo: cb, repeats: yesOrNo)
    }

    @objc private class func timerCB(timer: Timer) {
        guard let cb = timer.userInfo as? ((Timer) -> Void) else {
            timer.invalidate()
            return
        }
        cb(timer)
    }

    convenience init(safeTimerWithTimeInterval ti: TimeInterval, repeats yesOrNo: Bool, callBack cb: @escaping ((Timer) -> Void)) {
        if #available(iOS 10.0, *) {
            self.init(timeInterval: ti, repeats: yesOrNo, block: cb)
            return
        }
        self.init(timeInterval: ti, target: Timer.self, selector: #selector(Timer.timerCB(timer:)), userInfo: cb, repeats: yesOrNo)
    }
    
    /// Runs every x seconds, to cancel use: timer.invalidate()
    static func runThisEvery(seconds: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }

    /// Run function after x seconds
    static func runThisAfterDelay(seconds: Double, after: @escaping () -> Void) {
        runThisAfterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }

    /// XCRKit - dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
    public static func runThisAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
}

