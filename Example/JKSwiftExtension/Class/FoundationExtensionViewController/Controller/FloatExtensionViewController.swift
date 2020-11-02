//
//  FloatExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FloatExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、Float 与其他类型的转换", "二、其他常用的方法"]
        dataArray = [["转 Int", "转 CGFloat", "转 Int64", "转 Double", "转 String", "转 NSNumber", "转 Float"], ["浮点数四舍五入"]]
    }
}

// MARK:- 二、其他常用的方法
extension FloatExtensionViewController {
    
    // MARK: 2.1、浮点数四舍五入
    @objc func test21() {
        let money: Float = 56789.654
        let price = money.roundTo(places: 3)
        JKPrint("浮点数四舍五入", "\(money) 浮点数四舍五入 后为：\(price)")
    }
}

// MARK:- 一、基本的扩展
extension FloatExtensionViewController {
    
    // MARK: 1.1、转 Int
    @objc func test11() {
        let value: Float = 0.2
        JKPrint("转 Int", "\(value) 转 Int 后为 \(value.int)")
    }
    
    // MARK: 1.2、转 CGFloat
    @objc func test12() {
        let value: Float = 0.2
        JKPrint("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.cgFloat)")
    }
    
    // MARK: 1.3、转 Int64
    @objc func test13() {
        let value: Float = 0.2
        JKPrint("转 Int64", "\(value) 转 Int64 后为 \(value.int64)")
    }
    
    // MARK: 1.4、转 Double
    @objc func test14() {
        let value: Float = 0.2
        JKPrint("转 Double", "\(value) 转 Double 后为 \(value.double)")
    }
    
    // MARK: 1.5、转 String
    @objc func test15() {
        let value: Float = 0.2
        JKPrint("转 String", "\(value) 转 String 后为 \(value.string)")
    }
    
    // MARK: 1.6、转 NSNumber
    @objc func test16() {
        let value: Float = 0.2
        JKPrint("转 NSNumber", "\(value) 转 NSNumber 后为 \(value.number)")
    }
    
    // MARK: 1.7、转 Float
    @objc func test17() {
        let value: Float = 0.2
        JKPrint("转 Float", "\(value) 转 Float 后为 \(value.float)")
    }
}
