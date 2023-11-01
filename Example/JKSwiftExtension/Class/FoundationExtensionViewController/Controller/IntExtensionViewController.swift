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

        headDataArray = ["一、基本的扩展方法", "二、Int 的基本转换", "三、转换为其他单位"]
        dataArray = [["是否是偶数", "取区间内的随机数，如取  0..<10 之间的随机数"], ["转 Double", "转 Float", "转 Int64", "转 CGFloat", "转 String", "转 UInt", "转 CountableRange(可数的开区间)"], ["转换万单位", "转换为大小单位：UInt64 -> bytes, KB, MB, GB, TB, PB, EB, ZB, YB"]]
    }
}

// MARK: - 二、其他常用方法
extension IntExtensionViewController {
    
    // MARK: 3.02、转换为大小单位：UInt64 -> "bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"
    @objc func test302() {

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
    
    // MARK: 3.01、转换万单位
    @objc func test301() {
        // 保留位数
        let scale: Int16 = 2
        // 值
        let value1: Int = -123
        let value2: Int = 0
        let value3: Int = 1234
        let value4: Int = 1001098
        let array: [Int] = [value1, value2, value3, value4]
        var resultString: String = "转换万单位"
        array.forEach { value in
            resultString = resultString + "\n\(value) 保留\(scale)位 转换后为：\(value.jk.toTenThousandString(scale: scale, roundingMode: .down, unit: "w", isNeedAddZero: true))"
        }
        JKPrint(resultString)
    }
}

// MARK: - 二、Int 的基本转换
extension IntExtensionViewController {
    // MARK: 2.07、转 CountableRange(可数的开区间)
    @objc func test207() {
        let value: Int = 5
        guard let result = value.jk.intToCountableRange else {
            return
        }
        JKPrint("转 CountableRange(可数的开区间)", "\(value) 转 CountableRange(可数的开区间) 后为 \(result)")
    }
    
    // MARK: 2.06、转 UInt
    @objc func test206() {
        let value: Int = 2
        JKPrint("转 UInt", "\(value) 转 UInt 后为 \(value.jk.intToUInt)")
    }
    
    // MARK: 2.05、转 String
    @objc func test205() {
        let value: Int = 2
        JKPrint("转 String", "\(value) 转 String 后为 \(value.jk.intToString)")
    }
    
    // MARK: 2.04、转 CGFloat
    @objc func test204() {
        let value: Int = 2
        JKPrint("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jk.intToCGFloat)")
    }
    
    // MARK: 2.03、转 Int64
    @objc func test203() {
        let value: Int = 2
        JKPrint("转 Int64", "\(value) 转 Int64 后为 \(value.jk.intToInt64)")
    }
    
    // MARK: 2.02、转 Float
    @objc func test202() {
        let value: Int = 2
        JKPrint("转 Float", "\(value) 转 Float 后为 \(value.jk.intToFloat)")
    }
    
    // MARK: 2.01、转 Double
    @objc func test201() {
        let value: Int = 2
        JKPrint("转 Double", "\(value) 转 Double 后为 \(value.jk.intToFloat)")
    }
}

// MARK: - 一、基本的扩展方法
extension IntExtensionViewController {
    
    // MARK: 1.02、取区间内的随机数，如取  0..<10 之间的随机数
    @objc func test102() {
        let range = 1..<10
        JKPrint("\(Int.jk.random(within: range))")
    }
    
    // MARK: 1.01、是否是偶数
    @objc func test101() {
        let value1: Int = 5
        let value2: Int = 8
        JKPrint("\(value1) 是否是偶数：\(value1.jk.isEven())", "\(value2) 是否是偶数：\(value2.jk.isEven())")
    }
}
