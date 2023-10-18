//
//  DoubleExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class DoubleExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、Double 与其他类型的转换", "二、其他常用的方法"]
        dataArray = [["转 Int", "Double 四舍五入转 Int", "转 CGFloat", "转 Int64", "转 Float", "转 String", "转 NSNumber", "转 Double"], ["浮点数四舍五入"]]
    }
}

// MARK: - 二、其他常用的方法
extension DoubleExtensionViewController {
    
    // MARK: 2.01、浮点数四舍五入
    @objc func test201() {
        let money: Double = 56789.65499999
        let price = money.jk.roundTo(places: 3)
        JKPrint("浮点数四舍五入", "\(money) 浮点数四舍五入 后为：\(price)")
    }
}

// MARK: - 一、基本的扩展
extension DoubleExtensionViewController {
    
    // MARK: 1.08、转 Double
    @objc func test108() {
        let value: Double = 0.2
        JKPrint("转 Double", "\(value) 转 Double 后为 \(value.jk.double)")
    }
    
    // MARK: 1.07、转 NSNumber
    @objc func test107() {
        let value: Double = 0.2
        JKPrint("转 NSNumber", "\(value) 转 NSNumber 后为 \(value.jk.number)")
    }
    
    // MARK: 1.06、转 String
    @objc func test106() {
        let value: Double = 0.2
        JKPrint("转 String", "\(value) 转 String 后为 \(value.jk.string)")
    }
    
    // MARK: 1.05、转 Float
    @objc func test105() {
        let value: Double = 0.2
        JKPrint("转 Float", "\(value) 转 Float 后为 \(value.jk.float)")
    }
    
    // MARK: 1.04、转 Int64
    @objc func test104() {
        let value: Double = 0.2
        JKPrint("转 Int64", "\(value) 转 Int64 后为 \(value.jk.int64)")
    }
    
    // MARK: 1.03、转 CGFloat
    @objc func test103() {
        let value: Double = 0.2
        JKPrint("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jk.cgFloat)")
    }
    
    // MARK: 1.02、Double 四舍五入转 Int
    @objc func test102() {
        let value: Double = 23.50
        JKPrint("Double 四舍五入转 Int", "\(value) 四舍五入转 Int 后为 \(value.jk.lroundToInt)")
    }
    
    // MARK: 1.01、转 Int
    @objc func test101() {
        let value: Double = 0.2
        JKPrint("转 Int", "\(value) 转 Int 后为 \(value.jk.int)")
    }
}
