//
//  WeakTimerViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class WeakTimerViewController: BaseViewController {
    
    var timer: WeakTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、定时器 Timer 的封装"]
        dataArray = [["类方法创建定时器"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 一、定时器 Timer 的封装
extension WeakTimerViewController {
    
    // MARK: 1.1、
    @objc func test11() {
        timer = WeakTimer.scheduledTimer(timeInterval: 2, repeats: true, queue: DispatchQueue.global()) { (timer) in
            print("定时器打印中：🚀🚀🚀🚀🚀🚀", "当前的线程：\(Thread.current)")
        }

        JKAsyncs.asyncDelay(10) {
        } _: { [weak self] in
            guard let weakSelf = self, let weakTimer = weakSelf.timer else { return }
            print("10秒 定时器-------销毁")
            weakTimer.invalidate()
        }
    }
    
}

