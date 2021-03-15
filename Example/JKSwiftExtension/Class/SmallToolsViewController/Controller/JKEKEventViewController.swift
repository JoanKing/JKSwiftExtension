//
//  JKEKEventViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/3/15.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class JKEKEventViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的使用"]
        dataArray = [["查询所有的时间：前后十年"]]
    }
}

// MARK:- 一、基本的使用
extension JKEKEventViewController {

    // MARK: 1.1、获取前后十年的事件
    @objc func test11() {
    
        JKEKEvent.getCalendarsEvents { (events) in
            JKPrint("事件数量是：\(events.count)")
            for (_, event) in events.enumerated() {
                JKPrint("标题是：\(event.title ?? "") 时间：\(event.startDate ?? Date())")
            }
        }
    }
}

