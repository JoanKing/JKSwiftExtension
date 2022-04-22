//
//  WeakTimerViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKWeakTimerViewController: BaseViewController {
    
    var timer: JKWeakTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、初始化定时器方法(普通方式)", "二、延迟执行的定时器", "定时器的其他操作"]
        dataArray = [["便利初始化器：初始化定时器", "类方法初始化定时器 - 自动开启定时器", "便利初始化定时器（有队列）", "类方法初始化定时器（有队列）- 自动开启定时器"], ["便利初始化定时器(可设置延迟执行日期)", "便利初始化定时器(有队列，可设置延迟执行日期)"], ["定时器销毁", "定时器暂停", "定时器开始"]]
    }
    
    @objc func click() {
        print("定时器打印中：🚀🚀🚀🚀🚀🚀", "当前的线程：\(Thread.current)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 定时器的其他操作
extension JKWeakTimerViewController {
    
    // MARK: 3.3、定时器暂停
    @objc func test33() {
        timer?.fire()
    }
    
    // MARK: 3.2、定时器暂停
    @objc func test32() {
        timer?.pause()
    }
    
    // MARK: 3.1、定时器销毁
    @objc func test31() {
        timer?.invalidate()
    }
}

// MARK: - 二、延迟执行的定时器
extension JKWeakTimerViewController {
    
    // MARK: 2.2、便利初始化定时器(有队列，可设置延迟执行日期)
    @objc func test22() {
        let secondStamp = Int(Date.jk.secondStamp)! + 5
        let date = Date.jk.timestampToFormatterDate(timestamp: "\(secondStamp)")
        print("--------5秒后开启定时器----------")
        timer = JKWeakTimer(fire: date, interval: 1, repeats: true, queue: DispatchQueue.global(), block: { timer in
            print("定时器打印中：🚀🚀🚀🚀🚀🚀", "当前的线程：\(Thread.current)")
        })
    }
    
    // MARK: 2.1、便利初始化定时器(可设置延迟执行日期)
    @objc func test21() {
        let secondStamp = Int(Date.jk.secondStamp)! + 10
        let date = Date.jk.timestampToFormatterDate(timestamp: "\(secondStamp)")
        print("--------10秒后开启定时器----------")
        timer = JKWeakTimer(fireAt: date, interval: 1, target: self, selector: #selector(click), userInfo: nil, repeats: true)
    }
}

// MARK: - 一、初始化定时器方法(普通方式)
extension JKWeakTimerViewController {
    
    // MARK: 1.4、类方法初始化定时器（有队列）- 自动开启定时器
    @objc func test14() {
        timer = JKWeakTimer.scheduledTimer(timeInterval: 1, repeats: true, queue: DispatchQueue.global(), block: { _ in
            print("定时器打印中：🚀🚀🚀🚀🚀🚀", "当前的线程：\(Thread.current)")
        })
    }
    
    // MARK: 1.3、便利初始化定时器（有队列）
    @objc func test13() {
        timer = JKWeakTimer(timeInterval: 1, repeats: true, queue: DispatchQueue.global(), block: { _ in
            print("定时器打印中：🚀🚀🚀🚀🚀🚀", "当前的线程：\(Thread.current)")
        })
        timer?.fire()
    }
    
    // MARK: 1.2、类方法初始化定时器 - 自动开启定时器
    @objc func test12() {
        timer = JKWeakTimer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(click), userInfo: nil, repeats: true)
    }
    
    // MARK: 1.1、便利初始化器：初始化定时器
    @objc func test11() {
        timer = JKWeakTimer(timeInterval: 1, target: self, selector: #selector(click), userInfo: nil, repeats: true)
        timer?.fire()
    }
}
