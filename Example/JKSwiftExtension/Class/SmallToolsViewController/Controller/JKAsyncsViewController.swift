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
        dataArray = [["异步做一些任务", "异步做任务后回到主线程做任务" , "异步延迟(子线程执行任务)", "异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、延迟事件
extension JKAsyncsViewController {
    
    // MARK: 1.04、异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    @objc func test104() {
        JKAsyncs.asyncDelay(2) {
            JKPrint("异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)", "当前的线程是：\(Thread.current)")
        } _: {
            JKPrint("异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.03、异步延迟(子线程执行任务)
    @objc func test103() {
        JKAsyncs.asyncDelay(2) {
            JKPrint("异步延迟(子线程执行任务)", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.02、异步做任务后回到主线程做任务
    @objc func test102() {
        JKAsyncs.async {
            JKPrint("异步做任务后回到主线程做任务：子线程做任务", "当前的线程是：\(Thread.current)")
        } _: {
            JKPrint("异步做任务后回到主线程做任务：回到主线程", "当前的线程是：\(Thread.current)")
        }
    }
    
    // MARK: 1.01、异步做一些任务
    @objc func test101() {
        JKAsyncs.async {
            JKPrint("异步做一些任务", "当前的线程是：\(Thread.current)")
        }
    }
    
}
