//
//  JKTaskManagerViewController.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2025/2/5.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

class JKTaskManagerViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本使用"]
        dataArray = [["延迟任务"]]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、基本使用
extension JKTaskManagerViewController {
    
    // MARK: 1.01、延迟任务
    @objc func test101() {
        let taskManager = JKTaskManager()

        // 调度一个延迟任务
        taskManager.scheduleTask(identifier: "task1", delay: 5) {
            print("任务 1 执行")
        }

        // 取消任务
        // taskManager.cancelTask(identifier: "task1")
    }
}
