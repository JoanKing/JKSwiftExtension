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

// MARK: - 一、基本的扩展
extension NSRangeExtensionViewController {
    
    // MARK: 1.01、NSRange转换成Range的方法
    @objc func test101() {
        let string = "123456Hello World !!!"
        let nsRange = NSRange(location: 2, length: 2)
        
        if let range = nsRange.jk.toRange(string: string) {
            JKPrint("NSRange转换成Range的方法", "父字符串：\(string)", "\(nsRange) 转Range后为：\(range)")
        } else {
            print("没有拿到了range")
        }
    }
}
    
