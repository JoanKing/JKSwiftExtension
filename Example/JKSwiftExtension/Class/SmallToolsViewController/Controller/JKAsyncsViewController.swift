//
//  JKAsyncsViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


class JKAsyncsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、延迟事件"]
        dataArray = [["异步做一些任务", "异步做任务后回到主线程做任务", "延迟执行(主线程执行任务)", "异步延迟(子线程执行任务)", "异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 一、延迟事件
extension JKAsyncsViewController {
    
    // MARK: 1.5、异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    @objc func test15() {
        JKAsyncs.asyncDelay(2) {
            JKPrint("异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)", "当前的线程是：\(Thread.current)")
        } _: {
            JKPrint("异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.4、异步延迟(子线程执行任务)
    @objc func test14() {
        JKAsyncs.asyncDelay(2) {
            JKPrint("异步延迟(子线程执行任务)", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.3、延迟执行(主线程执行任务)
    @objc func test13() {
        JKAsyncs.syncdelay(2) {
            JKPrint("延迟执行(主线程执行任务)", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.2、异步做任务后回到主线程做任务
    @objc func test12() {
        JKAsyncs.async {
            JKPrint("异步做任务后回到主线程做任务：子线程做任务", "当前的线程是：\(Thread.current)")
        } _: {
            JKPrint("异步做任务后回到主线程做任务：回到主线程", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.1、异步做一些任务
    @objc func test11() {
        JKAsyncs.async {
            JKPrint("异步做一些任务", "当前的线程是：\(Thread.current)")
        }
    }
    
}
