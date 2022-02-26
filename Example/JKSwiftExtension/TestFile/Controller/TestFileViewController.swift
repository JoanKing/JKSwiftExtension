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
    var onRotate: (() -> ())? = nil
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
    
    @objc func test18() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    @objc func test17() {
        
    }
    
    func test1(a: Int) {
        
    }
    
    func test1(a: String) {
        
    }
    
    func scoreGuest(_ score: inout ScoreStruct) {
        score.guest += 1
        score.guest += 4
        //print("guest：\(score.guest)")
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
//        let person = Person()
//        person.number = 20
//        print("number：\(person.number) 父类：\(person.superclass)")
        let son = SonSon()
        print("父类：\(son.age)")
        
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



