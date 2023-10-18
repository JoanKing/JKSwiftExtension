//
//  RangeExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/3/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class RangeExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["Range转换成NSRange的方法"]]
    }
}

// MARK: - 一、基本的扩展
extension RangeExtensionViewController {
    
    // MARK: 1.01、Range转换成NSRange的方法
    @objc func test101() {
        let string = "123456Hello World !!!"
        let subString = "Hello World"
        
        if let range = string.range(of: subString) {
            let nsRange = range.jk.toNSRange(in: string)
            JKPrint("Range转换成NSRange的方法", "父字符串为：\(string) 子字符串为：\(subString)", "子字符串在父字符串里面的range为 \(range) 转NSRange后为：\(nsRange)")
        }
    }
}
    
