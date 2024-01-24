//
//  CGPointExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2024/1/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class CGPointExtensionViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、CGPoint的基本扩展"]
        dataArray = [["两个CGPoint进行 - 运算", "计算两个 CGPoint 的中点"]]
    }
}

// MARK: - 一、CGPoint的基本扩展
extension CGPointExtensionViewController {
    
    // MARK: 1.02、计算两个 CGPoint 的中点
    @objc func test102() {
        let point1 = CGPoint(x: 20, y: 40)
        let point2 = CGPoint(x: 10, y: 90)
        JKPrint("点1：\(point1) 点2：\(point2) 之间的中间点是：\(point1.midPoint(by: point2))")
    }
    
    // MARK: 1.01、两个CGPoint进行 - 运算
    @objc func test101() {
        let point1 = CGPoint(x: 20, y: 40)
        let point2 = CGPoint(x: 10, y: 90)
        JKPrint("两个CGPoint进行 - 运算：点1：\(point1) 点2：\(point2) 进行 - 运算的结果是：\(point1 - point2)")
    }
}
