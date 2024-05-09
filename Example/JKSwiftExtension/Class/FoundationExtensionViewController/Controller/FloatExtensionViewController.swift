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
        dataArray = [["转 Int", "Float四舍五入转Int", "转 CGFloat", "转 Int64", "转 Double", "转 String", "转 NSNumber", "转 Float", "Float转十六进制字符串"], ["浮点数四舍五入", "一个数字四舍五入返回(建议使用这个)"]]
    }
}

// MARK: - 二、其他常用的方法
extension FloatExtensionViewController {
    
    // MARK: 2.02、一个数字四舍五入返回(建议使用这个)
    @objc func test202() {
        let value: Float = 10.028384
        let scale: Int16 = 3
        let roundValue = value.jk.rounding(scale: scale)
        JKPrint("一个数字四舍五入返回", "\(value)四舍五入返回，保留\(scale)后为：\(roundValue)")
    }
    
    // MARK: 2.01、浮点数四舍五入
    @objc func test201() {
        let money: Float = 0.37
        let price = money.jk.roundTo(places: 2)
        JKPrint("浮点数四舍五入", "\(money) 浮点数四舍五入 后为：\(price)")
    }
}

// MARK: - 一、基本的扩展
extension FloatExtensionViewController {
    
    // MARK: 1.9、Float转十六进制字符串
    @objc func test109() {
        let value: Float = 3.1836
        JKPrint("Float转十六进制字符串", "\(value) 转 十六进制字符串 后为 \(value.jk.floatToHexString)")
    }
    
    // MARK: 1.08、转 Float
    @objc func test108() {
        let value: Float = 0.2
        JKPrint("转 Float", "\(value) 转 Float 后为 \(value.jk.float)")
    }
    
    // MARK: 1.07、转 NSNumber
    @objc func test107() {
        let value: Float = 0.2
        JKPrint("转 NSNumber", "\(value) 转 NSNumber 后为 \(value.jk.number)")
    }
    
    // MARK: 1.06、转 String
    @objc func test106() {
        let value: Float = 0.2
        JKPrint("转 String", "\(value) 转 String 后为 \(value.jk.string)")
    }
    
    // MARK: 1.05、转 Double
    @objc func test105() {
        let value: Float = 0.2
        JKPrint("转 Double", "\(value) 转 Double 后为 \(value.jk.double)")
    }
    
    // MARK: 1.04、转 Int64
    @objc func test104() {
        let value: Float = 0.2
        JKPrint("转 Int64", "\(value) 转 Int64 后为 \(value.jk.int64)")
    }
    
    // MARK: 1.03、转 CGFloat
    @objc func test103() {
        let value: Float = 0.2
        JKPrint("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jk.cgFloat)")
    }
    
    // MARK: 1.02、Float四舍五入转Int
    @objc func test102() {
        let value: Float = 23.46
        JKPrint("Float四舍五入转Int", "\(value) Float四舍五入转Int后为 \(value.jk.lroundfToInt)")
    }
    
    // MARK: 1.01、转 Int
    @objc func test101() {
        let value: Float = 0.2
        JKPrint("转 Int", "\(value) 转 Int 后为 \(value.jk.int)")
    }
}
