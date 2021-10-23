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
        dataArray = [["交换两个值"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、基本的方法
extension JKCommonToolViewController {
    
    // MARK: 1.1、交换两个值
    @objc func test11() {
        var a = 1
        var b = 2
        JKCommonTool.swapMe(value1: &a, value2: &b)
        JKPrint("交换两个值", "a = \(a) b = \(b)")
    }
   
}
