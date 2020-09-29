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
}

