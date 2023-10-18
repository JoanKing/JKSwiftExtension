//
//  CGFloatExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CGFloatExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、CGFloat 的基本转换", "二、角度和弧度相互转换", "三、基本的扩展"]
        dataArray = [["转 Int", "转 CGFloat", "转 Int64", "转 Float", "转 String", "转 NSNumber", "转 Double"], ["角度转弧度", "弧度转角度"], ["一个数字四舍五入返回"]]
    }
}

//MARK: -三、基本的扩展
extension CGFloatExtensionViewController {
    
    // MARK:3.01、一个数字四舍五入返回
    @objc func test301() {
        let value: CGFloat = 10.028384
        let scale: Int16 = 3
        let roundValue = value.jk.rounding(scale: scale)
        JKPrint("一个数字四舍五入返回", "\(value)四舍五入返回，保留\(scale)后为：\(roundValue)")
    }
}

// MARK: - 二、角度和弧度相互转换
extension CGFloatExtensionViewController {
    
    // MARK: 2.02、弧度转角度
    @objc func test202() {
        let radians: CGFloat = .pi
        JKPrint("角度转弧度", "弧度： \(radians) 转为角度后为：\(radians.jk.radiansToDegrees())")
    }
    
    // MARK: 2.01、角度转弧度
    @objc func test201() {
        let degrees: CGFloat = 90.0
        JKPrint("角度转弧度", "角度： \(degrees) 转为弧度后为：\(degrees.jk.degreesToRadians())")
    }
}

// MARK: - 一、基本的扩展
extension CGFloatExtensionViewController {
    
    // MARK: 1.07、转 Double
    @objc func test107() {
        let value: CGFloat = 0.2
        JKPrint("转 Double", "\(value) 转 Double 后为 \(value.jk.double)")
    }
    
    // MARK: 1.06、转 NSNumber
    @objc func test106() {
        let value: CGFloat = 0.2
        JKPrint("转 NSNumber", "\(value) 转 NSNumber 后为 \(value.jk.number)")
    }
    
    // MARK: 1.05、转 String
    @objc func test105() {
        let value: CGFloat = 0.2
        JKPrint("转 String", "\(value) 转 String 后为 \(value.jk.string)")
    }
    
    // MARK: 1.04、转 Float
    @objc func test104() {
        let value: CGFloat = 0.2
        JKPrint("转 Float", "\(value) 转 Float 后为 \(value.jk.float)")
    }
    
    // MARK: 1.03、转 Int64
    @objc func test103() {
        let value: CGFloat = 0.2
        JKPrint("转 Int64", "\(value) 转 Int64 后为 \(value.jk.int64)")
    }
    
    // MARK: 1.02、转 CGFloat
    @objc func test102() {
        let value: CGFloat = 0.2
        JKPrint("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jk.cgFloat)")
    }
    
    // MARK: 1.01、转 Int
    @objc func test101() {
        let value: CGFloat = 0.2
        JKPrint("转 Int", "\(value) 转 Int 后为 \(value.jk.int)")
    }
}
