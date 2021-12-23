//
//  TestFileViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else { return nil }
        return self[idx]
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

class TestFileViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestFile"
        
        headDataArray = ["一、基本的使用"]
        dataArray = [["设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "数组测试", "123", "新的", "集合", "range", "Optional", "12", "func", "func返回值", "115", "116"]]
    }
}

extension Dictionary {
    
}


extension TestFileViewController {
    @objc func test116() {
        var japan: [String: Any] = [
            "name": "Japan",
            "capital": "Tokyo",
            "population": 126_740_000,
            "coordinates": [
                "latitude": 35.0,
                "longitude": 139.0,
                "name": [
                    "W": "w",
                    "A": "a"
                ]
            ]
        ]
        japan["name"] = "名字改了"
        // japan["coordinate"]?["latitude"] = 36.0
        // (japan["coordinates"] as? [String: Double])?["coordinate"] = 36.0
        // japan["coordinates", as: [String: Double].self]?["latitude"] = 29
        japan["coordinates", as: [String: Any].self]?["name", as: [String: Any].self]?["W"] = "小王"
        // japan["coordinates", as: [String: Any].self]?["latitude"] = 36.0
        print(japan)
    }
    
    func incref(pointer: UnsafeMutablePointer<Int>) -> () -> Int {
        // 将指针的的复制存储在闭包中
        return {
            pointer.pointee += 1
            return pointer.pointee
        }
    }
    
    @objc func test115() {
        let fun: () -> Int
        do {
            var array = [0]
            fun = incref(pointer: &array)
        }
        print(fun())
    }
    
    func counterFunc() -> (Int) -> String {
        var counter = 0
        func innerFunc(i: Int) -> String {
            counter += i
            return "\(counter)"
        }
        return innerFunc
    }
    
    @objc func test114() {
        let f = counterFunc()
        print(f(3))
        print(f(4))
        let g = counterFunc()
        print(g(2))
        print(g(3))
        print(f(5))
    }
    
    func printInt(i: Int) {
        print("You passed \(i).")
    }
    
    @objc func test113() {
        
        printInt(i: 20)

        let funVar = printInt
        funVar(20)
       
    }
    
    @objc func test112() {

        var dictWithNils: [String: Int?] = ["one": 1, "two": 2, "none": nil]
        // dictWithNils["two"] = Optional(Optional(nil))
//        dictWithNils["two"] = .some(nil)
//        dictWithNils["two"]? = nil
        
        dictWithNils["three"]? = .some(2345)
        // dictWithNils.index(forKey: "three") // nil
        print(dictWithNils)
    }
    
    @objc func test111() {
        var a: Int? = 5
        a? = 10
        print("a=\(a ?? 0)")
        var b: Int? = nil
        b? = 10
        print("b=\(b ?? 0)")
    }
    
    @objc func test110() {
        let arr = [1, 2, 3, 4]
        // [3, 4] arr[..<1] // [1] arr[1...2] // [2, 3]
        print(arr[2...])
    }
    
    @objc func test19() {
        let iPods: Set = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffe", "iPod Classic"]
        let discontinuedIPods: Set = ["iPod mini", "iPod Classic", "iPod nano", "iPod shuffe"]
        let currentIPods = iPods.subtracting(discontinuedIPods) // ["iPod touch"]
        print(currentIPods)
    }
    
   @objc func test18() {
       let defaultSettings: [String: Any] = ["name": "王冲"]
        var userSettings = defaultSettings
        userSettings["name"] = "小可爱"
        userSettings.updateValue(20, forKey: "age")
        print("原数组：\(defaultSettings)")
        print("新数组：\(userSettings)")
    }
    
    @objc func test17() {
        (1..<10).forEach { number in
            print(number)
            if number == 2 {
                print("暂停")
                return
            }
        }
        print("---------------")
        for number in 1..<10 {
            print(number)
            if number == 2 {
                print("暂停")
                return
            }
        }
       
    }
    
    @objc func test16() {
      let result = [1,2,3,4].accumulate(0, +) // [1, 3, 6, 10]
        print("结果：\(result)")
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
        self.navigationController?.pushViewController(EightViewController(), animated: true)
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



