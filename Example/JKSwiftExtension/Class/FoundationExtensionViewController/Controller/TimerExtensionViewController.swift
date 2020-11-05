//
//  TimerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TimerExtensionViewController: BaseViewController {

    private var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["构造器创建定时器", "类方法创建定时器", "C语言的形式创建定时器(创建后立即执行一次)", "销毁定时器"]]
    }
}

// MARK:- 一、基本的扩展
extension TimerExtensionViewController {
    
    // MARK: 1.1、构造器创建定时器
    @objc func test11() {
        timer = Timer(safeTimerWithTimeInterval: 1, repeats: true) { (timer) in
            print("构造器创建定时器", "a--\(timer)")
        }
    }
    
    // MARK: 1.2、类方法创建定时器
    @objc func test12() {
        
        timer = Timer.scheduledSafeTimer(timeInterval: 5, repeats: true) { (timer) in
            print("类方法创建定时器", "b--\(timer)")
        }
    }
    
    // MARK: 1.3、C语言的形式创建定时器(创建后立即执行一次)
    @objc func test13() {
        
        timer = Timer.runThisEvery(timeInterval: 5) {[weak self] (timer1) in
            guard let _ = self, let tr = timer1 else { return }
            print("C语言的形式创建定时器(创建后立即执行一次)", "c--\(tr)")
        }
    }
    
    // MARK: 1.4、销毁定时器
    @objc func test14() {
        
        timer?.invalidate()
    }
}
