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
        dataArray = [["向下取整取倍数"]]
    }

}

// MARK:- 一、基本的扩展
extension NSDecimalNumberHandlerExtensionViewController {
    
    // MARK: 1.1、向下取整取倍数
    @objc func test11() {
        
        print("结果：\(NSDecimalNumberHandler.getFloorValue(value1: 47.05, value2: 0.05))")
        
    }
}

