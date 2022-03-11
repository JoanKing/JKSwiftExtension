//
//  TestFileViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

enum Center: Int {
    case one = 1
    case two = 2
}

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else { return nil }
        return self[idx]
    }
}

class ScoreClass {
    var home: Int
    var guest: Int {
        willSet {
            print("willSet====")
        }
        didSet {
            print("didSet====")
        }
    }
    init(home: Int, guest: Int) {
        self.home = home
        self.guest = guest
    }
}

struct ScoreStruct {
    let home: Int
    var guest: Int {
        willSet {
            print("willSet====")
        }
        didSet {
            print("didSet====")
        }
    }
}

extension ScoreStruct {
    mutating func scoreGuest() {
        self.guest += 1
    }
}

extension Array {
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return self.map { next in running = nextPartialResult(running, next)
            return running
        }
    }
}

class Window {
    weak var rootView: View?
    var onRotate: (() -> Void)?
    deinit {
        print("Deinit Window")
    }
}

class View {
    var window: Window
    init(window: Window) {
        self.window = window
    }
    deinit {
        print("Deinit View")
    }
}

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
    
    func test1(number: Int) {
        
    }
    
    func test1(number: String) {
        
    }
    
    func scoreGuest(_ score: inout ScoreStruct) {
        score.guest += 1
        score.guest += 4
        // print("guest：\(score.guest)")
        // 错误：可变操作符的左边是不可变类型： // 'score' 是⼀个 'let' 常量。
    }
    
    @objc func test16() {
        
        
    }
    
    @objc func test15() {
        self.navigationController?.pushViewController(NineViewController(), animated: true)
    }
    
    @objc func test14() {
        
    }
    
    @objc func test13() {
        self.navigationController?.pushViewController(ThreeViewController(), animated: true)
    }
    
    @objc func test12() {
        self.navigationController?.pushViewController(TenViewController(), animated: true)
    }
    
    @objc func test11() {

        print(sum(x: 5, n: 3))
        // self.navigationController?.pushViewController(EightViewController(), animated: true)
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



