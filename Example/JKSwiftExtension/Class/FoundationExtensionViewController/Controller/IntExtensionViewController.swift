//
//  IntExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class IntExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、CGFloat 的基本转换", "二、其他常用方法"]
        dataArray = [["转 Double", "转 Float", "转 Int64", "转 CGFloat", "转 String", "转 UInt", "转 range"], ["取区间内的随机数，如取  0..<10 之间的随机数", "转换万单位", "计算大小"]]
    }
}

// MARK: - 二、其他常用方法
extension IntExtensionViewController {
    
    // MARK: 2.3、计算大小
    @objc func test23() {

        guard let path = Bundle.main.path(forResource: "girl", ofType: "jpg") else {
            return
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return
        }
        let image = UIImage(data: data)
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
        let imageDataSize = data.count.jk.covertUInt64ToString()
        JKPrint("计算大小", "图片的大小为：\(imageDataSize)")
    }
    
    // MARK: 2.2、转换万单位
    @objc func test22() {
        let value: Int = 1001100
        JKPrint("转换万单位", "\(value) 保留 1 为 转换后为：\(value.jk.toTenThousandString())")
    }
    
    // MARK: 2.1、取区间内的随机数，如取  0..<10 之间的随机数"
    @objc func test21() {
        JKPrint("\(Int.jk.random(within: 0..<10))")
    }
}

// MARK: - 一、基本的扩展
extension IntExtensionViewController {
    
    // MARK: 1.1、转 Double
    @objc func test11() {
        let value: Int = 2
        JKPrint("转 Double", "\(value) 转 Double 后为 \(value.jk.intToFloat)")
    }
    
    // MARK: 1.2、转 Float
    @objc func test12() {
        let value: Int = 2
        JKPrint("转 Float", "\(value) 转 Float 后为 \(value.jk.intToFloat)")
    }
    
    // MARK: 1.3、转 Int64
    @objc func test13() {
        let value: Int = 2
        JKPrint("转 Int64", "\(value) 转 Int64 后为 \(value.jk.intToInt64)")
    }
    
    // MARK: 1.4、转 CGFloat
    @objc func test14() {
        let value: Int = 2
        JKPrint("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jk.intToCGFloat)")
    }
    
    // MARK: 1.5、转 String
    @objc func test15() {
        let value: Int = 2
        JKPrint("转 String", "\(value) 转 String 后为 \(value.jk.intToString)")
    }
    
    // MARK: 1.6、转 UInt
    @objc func test16() {
        let value: Int = 2
        JKPrint("转 UInt", "\(value) 转 UInt 后为 \(value.jk.intToUInt)")
    }
    
    // MARK: 1.7、转 range
    @objc func test17() {
        let value: Int = 2
        JKPrint("转 range", "\(value) 转 range 后为 \(value.jk.intToRange)")
    }
}
