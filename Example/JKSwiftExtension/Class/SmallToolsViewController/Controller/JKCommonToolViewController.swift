//
//  JKCommonToolViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKCommonToolViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的方法"]
        dataArray = [["交换两个值", "模型对比返回差异"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、基本的方法
extension JKCommonToolViewController {
    
    // MARK: 1.2、模型对比返回差异
    @objc func test12() {
        let person1 = Person()
        person1.name = "A"
        person1.age = 20
        
        let person2 = Person()
        person2.name = "B"
        person2.age = 1
        let params = JKCommonTool.diffBetween(firstModel: person1, secondModel: person2, ignores: ["name"])
        debugPrint("param：\(params)")
        // self.navigationController?.pushViewController(NotificationTetstViewController(), animated: true)
    }
    
    // MARK: 1.1、交换两个值
    @objc func test11() {
        var a = 1
        var b = 2
        JKCommonTool.swapMe(value1: &a, value2: &b)
        JKPrint("交换两个值", "a = \(a) b = \(b)")
    }
}
