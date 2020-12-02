//
//  NSDecimalNumberHandlerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NSDecimalNumberHandlerExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["向下取整取倍数", "一个数字能否整除另外一个数字"]]
    }
}

// MARK:- 一、基本的扩展
extension NSDecimalNumberHandlerExtensionViewController {
    
    // MARK: 1.2、一个数字能否整除另外一个数字
    @objc func test12() {
        let value1: Double = 12.44
        let value2: Double = 10.0
        let value3: Double = 0.02
        JKPrint("一个数字能否整除另外一个数字", "\(Float(value1 - value2)) 除以 \(value3) 能否整除：\(NSDecimalNumberHandler.isDivisible(value1: Float(value1 - value2), value2: Float(value3)))")
    }
    
    // MARK: 1.1、向下取整取倍数
    @objc func test11() {
        let value1: Double = 12.46
        let value2: Double = 10.0
        let value3: Double = 0.02
        JKPrint("向下取整取倍数", "\(Float(value1 - value2)) 除以 \(value3) 取整为：\(NSDecimalNumberHandler.getFloorIntValue(value1: Float(value1 - value2), value2: Float(value3)))")
    }
}

