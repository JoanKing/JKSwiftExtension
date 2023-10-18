//
//  Int64ExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class Int64ExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、Int64 的基本转换"]
        dataArray = [["转 Int", "转 CGFloat", "转 Float", "转 Double", "转 String", "转 NSNumber", "转 Int64"]]
    }
}

// MARK: - 一、基本的扩展
extension Int64ExtensionViewController {
    
    // MARK: 1.07、转 Int64
    @objc func test107() {
        let value: Int64 = 2345
        JKPrint("转 Int64", "\(value) 转 Int64 后为 \(value.jk.int64ToInt64)")
    }
    
    // MARK: 1.06、转 NSNumber
    @objc func test106() {
        let value: Int64 = 2345
        JKPrint("转 NSNumber", "\(value) 转 NSNumber 后为 \(value.jk.int64ToNumber)")
    }
    
    // MARK: 1.05、转 String
    @objc func test105() {
        let value: Int64 = 2345
        JKPrint("转 String", "\(value) 转 String 后为 \(value.jk.int64ToString)")
    }
    
    // MARK: 1.04、转 Double
    @objc func test104() {
        let value: Int64 = 2345
        JKPrint("转 Double", "\(value) 转 Double 后为 \(value.jk.int64ToDouble)")
    }
    
    // MARK: 1.03、转 Float
    @objc func test103() {
        let value: Int64 = 2345
        JKPrint("转 Float", "\(value) 转 Float 后为 \(value.jk.int64ToFloat)")
    }
    
    // MARK: 1.02、转 CGFloat
    @objc func test102() {
        let value: Int64 = 2345
        JKPrint("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jk.int64ToCGFloat)")
    }
    
    // MARK: 1.01、转 Int
    @objc func test101() {
        let value: Int64 = 2345
        JKPrint("转 Int", "\(value) 转 Int 后为 \(value.jk.int64ToInt)")
    }
}
