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
        dataArray = [["立即异步执行 （默认全局队列）", "立即异步执行，完成后回主线程" , "异步延迟(子线程执行任务)", "异步延迟回到主线程（子线程执行任务，然后回到主线程执行任务）", "延迟一段时间后，直接在主线程执行任务"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、延迟事件
extension JKAsyncsViewController {
    
    // MARK: 1.05、延迟一段时间后，直接在主线程执行任务
    @objc func test105() {
        JKAsyncs.asyncDelayMain(3) {
            JKPrint("3秒到了，直接在主线程执行", "当前的线程是：\(Thread.current)", isWriteLog: true)
        }
    }
    
    // MARK: 1.04、异步延迟回到主线程（子线程执行任务，然后回到主线程执行任务）
    @objc func test104() {
        JKAsyncs.asyncDelay(2) {
            JKPrintBrief("子线程执行任务", "当前的线程是：\(Thread.current)",  isWriteLog: true)
        } mainTask: {
            JKPrint("异步延迟回到主线程", "当前的线程是：\(Thread.current)",  isWriteLog: true)
        }
    }
    
    // MARK: 1.03、异步延迟(子线程执行任务)
    @objc func test103() {
        JKAsyncs.asyncDelay(2) {
            JKPrint("异步延迟(子线程执行任务)", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.02、立即异步执行，完成后回主线程
    @objc func test102() {
        debugPrint("开始执行任务")
        JKAsyncs.async {
            JKPrint("子线程做任务", "当前的线程是：\(Thread.current)")
        } mainTask: {
            JKPrint("立即异步执行，完成后回主线程, 当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.01、立即异步执行 （默认全局队列）
    @objc func test101() {
        JKAsyncs.async {
            JKPrint("立即异步执行 （默认全局队列）", "当前的线程是：\(Thread.current)")
        }
    }
    
}
