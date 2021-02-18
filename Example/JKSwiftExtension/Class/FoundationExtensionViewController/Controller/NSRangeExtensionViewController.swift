//
//  NSRangeExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/2/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class NSRangeExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["NSRange转换成Range的方法"]]
    }
}

// MARK:- 一、基本的扩展
extension NSRangeExtensionViewController {
    
    // MARK: 1.1、NSRange转换成Range的方法
    @objc func test11() {
        JKPrint("NSRange转换成Range的方法")
    }
}
    
