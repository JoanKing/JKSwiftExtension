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
    
    // MARK: 3.2、转换为大小单位：UInt64 -> "bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"
    @objc func test32() {

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
    
    // MARK: 3.1、转换万单位
    @objc func test31() {
        let value: Int = 1001100
        JKPrint("转换万单位", "\(value) 保留 1 为 转换后为：\(value.jk.toTenThousandString())")
    }
}

// MARK: - 一、基本的扩展
extension IntExtensionViewController {
    // MARK: 2.7、转 CountableRange(可数的开区间)
    @objc func test27() {
        let value: Int = 5
        guard let result = value.jk.intToCountableRange else {
            return
        }
        JKPrint("转 CountableRange(可数的开区间)", "\(value) 转 CountableRange(可数的开区间) 后为 \(result)")
    }
    
    // MARK: 2.6、转 UInt
    @objc func test26() {
        let value: Int = 2
        JKPrint("转 UInt", "\(value) 转 UInt 后为 \(value.jk.intToUInt)")
    }
    
    // MARK: 2.5、转 String
    @objc func test25() {
        let value: Int = 2
        JKPrint("转 String", "\(value) 转 String 后为 \(value.jk.intToString)")
    }
    
    // MARK: 2.4、转 CGFloat
    @objc func test24() {
        let value: Int = 2
        JKPrint("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jk.intToCGFloat)")
    }
    
    // MARK: 2.3、转 Int64
    @objc func test23() {
        let value: Int = 2
        JKPrint("转 Int64", "\(value) 转 Int64 后为 \(value.jk.intToInt64)")
    }
    
    // MARK: 2.2、转 Float
    @objc func test22() {
        let value: Int = 2
        JKPrint("转 Float", "\(value) 转 Float 后为 \(value.jk.intToFloat)")
    }
    
    // MARK: 2.1、转 Double
    @objc func test21() {
        let value: Int = 2
        JKPrint("转 Double", "\(value) 转 Double 后为 \(value.jk.intToFloat)")
    }
}

// MARK: - 一、基本的扩展方法
extension IntExtensionViewController {
    
    // MARK: 1.2、取区间内的随机数，如取  0..<10 之间的随机数
    @objc func test12() {
        let range = 1..<10
        JKPrint("\(Int.jk.random(within: range))")
    }
    
    // MARK: 1.1、是否是偶数
    @objc func test11() {
        let value1: Int = 5
        let value2: Int = 8
        JKPrint("\(value1) 是否是偶数：\(value1.jk.isEven())", "\(value2) 是否是偶数：\(value2.jk.isEven())")
    }
}
