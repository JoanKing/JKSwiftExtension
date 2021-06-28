//
//  DispatchQueueExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/6/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class DispatchQueueExtensionViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、DispatchQueue 基本的扩展", "二、延迟事件"]
        dataArray = [["函数只被执行一次"], ["异步做一些任务", "异步做任务后回到主线程做任务" , "异步延迟(子线程执行任务)", "异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)"]]
    }
}

// MARK:- 二、延迟事件
extension DispatchQueueExtensionViewController {
    // MARK: 2.4、异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    @objc func test24() {
        JKAsyncs.asyncDelay(2) {
            JKPrint("异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)", "当前的线程是：\(Thread.current)")
        } _: {
            JKPrint("异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 2.3、异步延迟(子线程执行任务)
    @objc func test13() {
        JKAsyncs.asyncDelay(2) {
            JKPrint("异步延迟(子线程执行任务)", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 2.2、异步做任务后回到主线程做任务
    @objc func test22() {
        JKAsyncs.async {
            JKPrint("异步做任务后回到主线程做任务：子线程做任务", "当前的线程是：\(Thread.current)")
        } _: {
            JKPrint("异步做任务后回到主线程做任务：回到主线程", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 2.1、异步做一些任务
    @objc func test21() {
        JKAsyncs.async {
            JKPrint("异步做一些任务", "当前的线程是：\(Thread.current)")
        }
    }
}

// MARK:- 一、DispatchQueue 基本的扩展
extension DispatchQueueExtensionViewController {
    
    // MARK: 1.1、函数只被执行一次
    @objc func test11() {
        DispatchQueue.jk.once(token: "执行一次") {
            print("执行一次-----")
        }
    }
}
