//
//  TestFileViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Dispatch
import JKSwiftExtension
class TestFileViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestFile"
        
        headDataArray = ["一、基本的使用"]
        dataArray = [["设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "数组测试", "struct", "test"]]
    }
    
    deinit {
        print("----------")
    }
}

extension TestFileViewController {
    
    /// 计算x的n次方
    /// - Parameters:
    ///   - x: 值
    ///   - n: 次方
    /// - Returns: 结果
    func sum(x: Double, n: Int) -> Double {
        if (n == 0) {
            return 1
        }
        // 这里重复利用了t的资源
        let t = sum(x: x, n: n / 2)
        if (n % 2 == 1) {
            // 如果n是奇数
            // 这里多了一个x，因为：如果n是17，t的结果是8次后的，2个t就是16次，少了一次
            return t * t * x
        } else {
            // n是偶数
            // 如果n是16,t的结果是8次后的，2个t也就是16次，刚刚好
            return t * t
        }
    }
 
    @objc func test18() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    @objc func test17() {
        
    }
    
    @objc func test16() {
        self.navigationController?.pushViewController(JKVVViewController(), animated: true)
    }
    
    @objc func test15() {
        self.navigationController?.pushViewController(NineViewController(), animated: true)
    }
    
    @objc func test14() {
        self.navigationController?.pushViewController(NotificationTetstViewController(), animated: true)
    }
    
    @objc func test13() {
       self.navigationController?.pushViewController(JKEmptyViewController(), animated: true)
    }
    
    @objc func test12() {
        let a: Double = 0
        if a == 0.0 {
            print("true")
        } else {
            print("false")
        }
    }
    
    @objc func test11() {
        // self.navigationController?.pushViewController(RadiusViewController(), animated: true)
        print("开始")
        DispatchQueue.global().async {
            /// 初始化值 S = 0
            let semaphore = DispatchSemaphore(value: 0)
            for index in 0..<4 {
                /// S = 0 - 1，S = -1, 进程阻塞并进入等待队列
                DispatchQueue.global().async {
                    print(index)
                    Thread.sleep(forTimeInterval: 3)
                    DispatchQueue.main.async {
                        /// S = -1 + 1，S = 0, 唤醒对应的等待进程，并继续执行
                        semaphore.signal()
                    }
                }
                semaphore.wait()
            }
            DispatchQueue.main.async {
                print("全部执行完毕")
            }
        }
        print("结束")
    }
    
    //MARK: 上传图片
    /// 上传图片，压缩在内部统一处理
    //MARK: 上传图片
    /// 上传图片，压缩在内部统一处理
    func uploadImageResurce() {
        
        // 创建调度组
        let workingGroup = DispatchGroup()
        // 创建多列
        let workingQueue = DispatchQueue.global()
        let images = [1, 2, 3, 4, 5, 6]
        var imageUrls = images.map { _ in
            ""
        }
        // 最初的url数组
        debugPrint("最初的url数组：\(imageUrls)")
        // var a: Int = 0
        for (index, image) in images.enumerated() {
           
            workingGroup.enter()
            JKAsyncs.asyncDelay(index == 2 ? 5 : 1) {
            } _: {
                print("接口 \(index) 数据请求完成 值：\(image)")
                imageUrls[index] = "\(image)"
                workingGroup.leave()
            }
//            a = a + 1
//            // 入组
//            if a == 2 {
//                break
//            }
        }
        // 调度组里的任务都执行完毕
        workingGroup.notify(queue: workingQueue, execute: {
            // 全部
            debugPrint("全部结束, 生成的url：\(imageUrls)")
        })
    }
    
    //MARK: 上传图片
    /// 上传图片，压缩在内部统一处理
    //MARK: 上传图片
    /// 上传图片，压缩在内部统一处理
    func uploadImageResurce1() {
        
        // 创建调度组
        let workingGroup = DispatchGroup()
        // 创建多列
        let workingQueue = DispatchQueue.global()

        debugPrint("开始执行的代码")
        
        workingGroup.enter()
        JKAsyncs.asyncDelay(5) {
        } _: {
            print("接口1执行结束")
            workingGroup.leave()
        }

        workingGroup.enter()
        JKAsyncs.asyncDelay(2) {
            print("")
        } _: {
            print("接口2执行结束")
            workingGroup.leave()
        }

        // 调度组里的任务都执行完毕
        workingGroup.notify(queue: workingQueue, execute: {
            // 全部
            debugPrint("全部结束")
        })
        debugPrint("最后的代码")
    }
    
    func uploadImageResurce2() {
        
        // 创建调度组
        let workingGroup = DispatchGroup()
        // 创建多列
        let workingQueue = DispatchQueue.global()

        var result: Bool = false
        debugPrint("开始执行的代码")
        workingGroup.enter()
        netWork1 {
            print("接口1执行结束")
            result = false
            workingGroup.leave()
        }

        workingGroup.enter()
        netWork2 {
            result = true
            print("接口2执行结束")
            workingGroup.leave()
        }

        // 调度组里的任务都执行完毕
        workingGroup.notify(queue: workingQueue, execute: {
            // 全部
            debugPrint("全部结束: \(result)")
        })
        debugPrint("最后的代码")
    }
    
    func netWork1(finishClosure: @escaping (() -> Void)) {
        JKAsyncs.asyncDelay(10) {
        } _: {
            finishClosure()
        }
    }
    
    func netWork2(finishClosure: @escaping (() -> Void)) {
        JKAsyncs.asyncDelay(3) {
        } _: {
            finishClosure()
        }
    }
}

extension String {
    // 添加千分位，小数点后面保留三位，默认四舍五入
    func tradeAmountAddCommaString(maximumFractionDigits: Int = 2, minimumFractionDigits: Int = 2, roundingModel: NumberFormatter.RoundingMode = .up, numberStyle: NumberFormatter.Style = .none) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = roundingModel
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.minimumFractionDigits = minimumFractionDigits
        if self.contains(".") {
            // 整数位最少位数
            formatter.minimumIntegerDigits = 1
        }
        var num = NSDecimalNumber(string: self)
        if num.doubleValue.isNaN {
            num = NSDecimalNumber(string: "0")
        }
        if let result = formatter.string(from: num) {
            return result
        }
        return self
    }
}
