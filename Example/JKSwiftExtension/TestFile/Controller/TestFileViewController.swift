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
import CoreTelephony

class TestFileViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestFile"
        
        headDataArray = ["一、基本的使用"]
        dataArray = [["设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "数组测试", "struct", "test", "9", "网络权限的判断"]]
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let topPadding = window?.safeAreaInsets.top
            
            //状态栏高度
            let statusBarHeight = UIApplication.shared.statusBarFrame.height;
            debugPrint("顶部距离：\(topPadding ?? 0) 状态栏高度：\(statusBarHeight)")
        }
        
        /*
         var userInfo: [String: Any] = ["firstName": "大帅",
         "school": "St. Primary School"]
         print("Original User Info: \(userInfo)")
         // creating a new dictionary with other info
         let otherInfo: [String: Any] = ["country": "USA",
         "school": "河南",
         "pincode": 6783456]
         userInfo = userInfo.merging(otherInfo, uniquingKeysWith: { current, _ in
         return current
         })
         print("Updated User Info: \(userInfo)")
         */
    }
    
    deinit {
        debugPrint("----------")
    }
}

enum Rank: String, CaseIterable {
    case One = "11"
    case Two = "22"
    static let allValues = Rank.allCases.map { $0.rawValue }
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
    
    func isMultiple(_ a: Int, of b: Int) -> Bool {
        return a.isMultiple(of: b)
    }
    
    
    @objc func test110() {
        /*
        debugPrint("开始----")
        let isNetworkPermissions = isNetworkPermissions()
        debugPrint("是否有网络的权限：\(isNetworkPermissions)")
        debugPrint("结束----")
         */
        let text = "哈哈 😄"
        var count = 0
        var endString: String = ""
        for i in 0...text.count - 1 {
            let c: unichar = (text as NSString).character(at: i)
            var cLength = 0
            endString = endString + "\(c)"
            debugPrint("c：\(c)")
        }

        for character in text {
            print("character:\(character)")
        }
        debugPrint("endString：\(endString)")
    }
    
    /// 判断网络是否有权限
    private func isNetworkPermissions() -> Bool {
        var isNetworkPermissions:Bool = false
        let cellularData = CTCellularData()
        /// 线程信号量
        let semaphore = DispatchSemaphore(value: 0)
        cellularData.cellularDataRestrictionDidUpdateNotifier = { state in
            if state == .notRestricted {
                isNetworkPermissions = true
            } else  {
                isNetworkPermissions = false
            }
            semaphore.signal()
        }
        semaphore.wait()
        return isNetworkPermissions
    }
    
    @objc func test19() {
        /*
        debugPrint(isMultiple(10, of: 5))
        debugPrint(isMultiple(0, of: 1))
        debugPrint(isMultiple(1, of: 3))
        debugPrint(isMultiple(5, of: 10))
        debugPrint(isMultiple(8, of: 16))
         */
        if #available(iOS 13, *) {
            self.navigationController?.pushViewController(SegmentViewController(), animated: true)
        }
    }
    
    
    @objc func test18() {
        self.navigationController?.pushViewController(FiveViewController(), animated: true)
    }
    
    @objc func test17() {
        //var array1 = ["a", "b", "c"]
        // 也不可以越界
        //array1.insert("yy", at: 0)
        //print(array1)
        //let oldString = "12345678"
        
        //
        //        let value1 = 2 << 0b0001 // 0100
        //        let value2 = 4 << 0b0001 // 1000
        //        let value3 = value1 & value2
        //        let value4 = value1 | value2
        //        let value5 = 0o120
        //        debugPrint("value5:\(value5)")
        
        //        let value1 = 0b0001 << 1 //  0010
        //        let value2 = 0b0001 << 2 //  0100
        //        let value3 = 0b0001 << 3 //  1000
        //        let value4 = 0b0001 << 4 // 10000
        
        //        let value1 = 3 << 1 //  0010  0011 -> 0110    = 6
        //        let value2 = 3 << 2 //  0100       -> 1100    = 12
        //        let value3 = 3 << 3 //  1000       -> 11000   = 24
        //        let value4 = 3 << 4 // 10000       -> 110000  = 48
        
        // debugPrint("value1: \(value1)", "value2: \(value2)", "value3: \(value3)", "value4: \(value4)")
        //        let numberData = 4096
        //        let value = numberData & 0x1100
        //        debugPrint("结果：\(value)")
        let status: UInt8 = ~(1 << 3)         // 00001000 11110111
        let x: Int = 0b10001001 & Int(status) // 10001001 10001001  10000001
        // 1101  841
        print("x:\(x) status:\(status)")
    }
    
    @objc func test16() {
        // self.navigationController?.pushViewController(JKVVViewController(), animated: true)
        let array1 = [1, 2, 2, 5]
        let array2 = [1, 6, 2]
        print("-1--start-:\(CFAbsoluteTimeGetCurrent())")
        var dict1: [String:Int] = [:]
        array1.forEach({
            dict1["\($0)"] = 1
        })
        array2.forEach({
            if 1 == dict1["\($0)"] {
                //此处便可取到相同元素
                debugPrint("相同的元素：\($0)")
            }
        })
        print("-1--end-:\(CFAbsoluteTimeGetCurrent())")
        
    }
    
    @objc func test15() {
        let numbers1 = ["1", "2", "4"]
        let numbers2 = ["1", "2", "3"]
        let numbers3 = ["1", "2", "3"]
        debugPrint("numbers1是否等于numbers2：\(numbers1 == numbers2)\n numbers2是否等于numbers3：\(numbers2 == numbers3)")
        self.navigationController?.pushViewController(NineViewController(), animated: true)
    }
    
    @objc func test14() {
        let numbers = [1,2, nil,4]
        let result = numbers.compactMap{ $0 } //[16, 64, 4]
        print(result)  // [3,4,5,6]
    }
    
    @objc func test13() {
        self.navigationController?.pushViewController(NotificationTetstViewController(), animated: true)
    }
    
    @objc func test12() {
        // showAlertAgreement()
        /*
         var sectionModels = [[11, 12, 13], [21, 22, 23]]
         print("数组：\(sectionModels)")
         //var items = sectionModels[0]
         // items.remove(at: 1)
         sectionModels[0].removeAll(where: { $0  == 12 })
         print("移除后数组：\(sectionModels)")
         */
        //        let colors = Rank.allValues
        //        print(colors)
        let value1 = 0b0
        let value2 = 0b10 << 1
        let value3 = 0b10 << 3
        let value4 = value1 | value2 | value3
        debugPrint("value4：\(value4)")
    }
    
    @objc func test11() {
        /*
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
         */
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

extension TestFileViewController {
    @objc func showAlertAgreement() {
        let title = "用户协议和隐私政策"
        
        let linkDic = ["《用户协议》": "http://*",
                       "《隐私政策》": "http://*",]
        
        let protocolPolicyContent = "\t用户协议和隐私政策请您务必审值阅读、充分理解 “用户协议” 和 隐私政策, 各项条款，包括但不限于：为了向您提供即时通讯、内容分享等服务，我们需要收集您的设备信息、操作日志等个人信息。\n\t您可阅读《用户协议》和《隐私政策》了解详细信息。如果您同意，请点击 “同意” 开始接受我们的服务;"
        
        let paraStyle = NSMutableParagraphStyle()
        // 右对齐
        paraStyle.alignment = .left
        let attributedText = NSMutableAttributedString.createHighlightRichText(content: protocolPolicyContent, highlightRichTexts: linkDic.allKeys(), contentTextColor: UIColor.brown, contentFont: UIFont.systemFont(ofSize: 15), highlightRichTextColor: UIColor.blue, highlightRichTextFont: UIFont.systemFont(ofSize: 15), paraStyle: paraStyle)
        
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            .addActionTitles(["取消", "同意"]) { vc, action in
                print(action.title)
            }
        
        alertVC.setValue(attributedText, forKey: "attributedMessage")
        alertVC.messageLabel?.jk.addGestureTap { reco in
            (reco as? UITapGestureRecognizer)?.didTapLabelAttributedText(linkDic) {[weak self] text, url in
                guard let weakSelf = self else {
                    return
                }
                print("\(text), \(url ?? "_")")
                alertVC.dismiss(animated: true, completion: nil)
                let vc = JKVVViewController()
                vc.backClosure = {
                    weakSelf.present(alertVC, animated: true, completion: nil)
                }
                // vc.modalPresentationStyle = .overFullScreen
                weakSelf.navigationController?.pushViewController(vc, animated: true)
                //alertVC.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            }
        }
        self.present(alertVC, animated: true, completion: nil)
    }
}


