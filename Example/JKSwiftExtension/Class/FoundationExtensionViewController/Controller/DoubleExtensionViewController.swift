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
        dataArray = [["转 Int", "Double 四舍五入转 Int", "转 CGFloat", "转 Int64", "转 Float", "转 String", "转 NSNumber", "转 Double", "Double转十六进制字符串"], ["浮点数四舍五入", "数字金额转换成大写人民币金额"]]
    }
}

// MARK: - 二、其他常用的方法
extension DoubleExtensionViewController {
    
    // MARK: 2.2、数字金额转换成大写人民币金额
    @objc func test202() {
        
        let scale0: Int16 = 1
        let money0: Double = 0.0
        let price0 = money0.jk.convertToRMB(scale: scale0)
        
        let scale1: Int16 = 4
        let money1: Double = 0.10045
        let price1 = money1.jk.convertToRMB(scale: scale1)
        
        let scale2: Int16 = 3
        let money2: Double = 10100.102
        let price2 = money2.jk.convertToRMB(scale: scale2)
        
        let scale3: Int16 = 4
        let money3: Double = 12002302234.00345
        let price3 = money3.jk.convertToRMB(scale: scale3)
        
        let scale4: Int16 = 1
        let money4: Double = 12003423412234.8
        let price4 = money4.jk.convertToRMB(scale: scale4)
        
        let scale5: Int16 = 1
        let money5: Double = 1234001234
        let price5 = money5.jk.convertToRMB(scale: scale5)
        
        let scale6: Int16 = 3
        let money6: Double = 123000000234.02
        let price6 = money6.jk.convertToRMB(scale: scale6)
        
        JKPrint("数字金额转换成大写人民币金额", "\(money0) 保留\(scale0)位 转换成大写人民币金额 后为：\(price0)", "\(money1) 保留\(scale1)位 转换成大写人民币金额 后为：\(price1)", "\(money2) 保留\(scale2)位 转换成大写人民币金额 后为：\(price2)", "\(money3) 保留\(scale3)位 转换成大写人民币金额 后为：\(price3)", "\(money4) 保留\(scale4)位 转换成大写人民币金额 后为：\(price4)", "\(money5) 保留\(scale5)位 转换成大写人民币金额 后为：\(price5)", "\(money6) 保留\(scale6)位 转换成大写人民币金额 后为：\(price6)")
        
        JKPrint("\(price0) 反向转换为：\(price0.jk.rMBConvertChineseNumber() ?? "")", "\(price1) 反向转换为：\(price1.jk.rMBConvertChineseNumber() ?? "")", "\(price2) 反向转换为：\(price2.jk.rMBConvertChineseNumber() ?? "")", "\(price3) 反向转换为：\(price3.jk.rMBConvertChineseNumber() ?? "")", "\(price4) 反向转换为：\(price4.jk.rMBConvertChineseNumber() ?? "")", "\(price5) 反向转换为：\(price5.jk.rMBConvertChineseNumber() ?? "")", "\(price6) 反向转换为：\(price6.jk.rMBConvertChineseNumber() ?? "")")
    }
    
    // MARK: 2.01、浮点数四舍五入
    @objc func test201() {
        let money: Double = 56789.65499999
        let price = money.jk.roundTo(places: 3)
        JKPrint("浮点数四舍五入", "\(money) 浮点数四舍五入 后为：\(price)")
    }
}

// MARK: - 一、基本的扩展
extension DoubleExtensionViewController {
    
    // MARK: 1.9、Double转十六进制字符串
    @objc func test109() {
        let value: Double = 1.290
        JKPrint("Double转十六进制字符串", "\(value) 转 十六进制字符串 后为 \(value.jk.doubleToHexString)")
    }
    
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
