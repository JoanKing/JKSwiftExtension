//
//  ArrayExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ArrayExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、数组 的基本扩展", "二、数组 有关索引 的扩展方法", "三、遵守 Equatable 协议的数组 (增删改查) 扩展", "四、遵守 NSObjectProtocol 协议对应数组的扩展方法", "五、针对数组元素是 String 的扩展"]
        dataArray = [["安全的取某个索引的值", "数组新增元素(可转入一个数组)", "数组 -> JSON字符串"], ["获取数组中的指定元素的索引值", "获取元素首次出现的位置", "获取元素最后出现的位置"], ["删除数组的中的元素(可删除第一个出现的或者删除全部出现的)", "从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素"], ["删除数组中遵守NSObjectProtocol协议的元素，是否删除重复的元素", "删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除"], ["数组转字符转（数组的元素是 字符串），如：[1, 2, 3] 连接器为 - ，那么转化后为 1-2-3"]]
        initUI()
    }
    
    /// 创建控件
    private func initUI() {
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 五、针对数组元素是 String 的扩展
extension ArrayExtensionViewController {
    
    // MARK: 5.1、 数组转字符转（数组的元素是 字符串），如：["1", "2", "3"] 连接器为 - ，那么转化后为 "1-2-3"
    @objc func test51() {
        let testArray = ["1", "2", "3", "4", "5", "6"]
        let testString = testArray.toStrinig(separator: "-")
        JKPrint("数组转字符转（数组的元素是 字符串）", "数组：\(testArray) 转为字符串为：\(testString)")
    }
}
// MARK: - 四、遵守 NSObjectProtocol 协议对应数组的扩展方法
extension ArrayExtensionViewController {
    
    // MARK: 4.1、删除数组中遵守NSObjectProtocol协议的元素，是否删除重复的元素
    @objc func test41() {
        var testArray = ["1".jk.toNSString, "2".jk.toNSString, "3".jk.toNSString, "2".jk.toNSString]
        let oldArray = testArray
        let element = "2".jk.toNSString
        let newArray = testArray.remove(object: element, isRepeat: false)
        JKPrint("删除数组中遵守NSObjectProtocol协议的元素，是否删除重复的元素)", "原数组为：\(oldArray) 删除其中的值：\(element) 后数组为：\(newArray)")
    }
    
    // MARK: 4.2、删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除
    @objc func test42() {
        var testArray = ["1".jk.toNSString, "2".jk.toNSString, "3".jk.toNSString, "2".jk.toNSString]
        let removeArray = ["2".jk.toNSString, "3".jk.toNSString]
        let oldArray = testArray
        let newArray = testArray.removeArray(objects: removeArray, isRepeat: true)
        JKPrint("删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除", "原数组为：\(oldArray) 删除的数组是：\(removeArray) 后数组为：\(newArray)")
    }
}

// MARK: - 三、遵守 Equatable 协议的数组 (增删改查) 扩展
extension ArrayExtensionViewController {
    
    // MARK: 3.1、删除数组的中的元素(可删除第一个出现的或者删除全部出现的)
    @objc func test31() {
        var testArray = ["1", "2", "3", "2"]
        let oldArray = testArray
        let element = "2"
        let newArray = testArray.remove(element, isRepeat: false)
        JKPrint("删除数组的中的元素(可删除第一个出现的或者删除全部出现的)", "原数组为：\(oldArray) 删除其中的值：\(element) 后数组为：\(newArray)")
    }
    
    // MARK: 3.2、从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素
    @objc func test32() {
        var testArray = ["1", "2", "3", "2"]
        let removeArray = ["2", "3"]
        let oldArray = testArray
        let newArray = testArray.removeArray(removeArray, isRepeat: false)
        JKPrint("从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素", "原数组为：\(oldArray) 删除的数组是：\(removeArray) 后数组为：\(newArray)")
    }
}
// MARK: - 二、数组 有关索引 的扩展方法
extension ArrayExtensionViewController {
    
    // MARK: 2.1、获取数组中的指定元素的索引值
    @objc func test21() {
        let testArray = ["1", "2", "3", "2"]
        let element = "2"
        JKPrint("获取数组中的指定元素的索引值", "查找 \(testArray) 中的 \(element) 的索引为：\(testArray.indexes(element))")
    }
    
    // MARK: 2.2、获取元素首次出现的位置
    @objc func test22() {
        let testArray = ["1", "2", "3", "2"]
        let element = "2"
        JKPrint("获取元素首次出现的位置", "\(element) 在数组：\(testArray) 首次出现的索引是：\(testArray.firstIndex(element) ?? 0)")
        // testArray.firstIndex(of: element) ?? 0
    }
    
    // MARK: 2.3、获取元素最后出现的位置
    @objc func test23() {
       let testArray = ["1", "2", "3", "2"]
       let element = "2"
       JKPrint("获取元素最后出现的位置", "\(element) 在数组：\(testArray) 最后出现的索引是：\(testArray.lastIndex(element) ?? 0)")
        // testArray.lastIndex(of: element) ?? 0
    }

}

// MARK: - 一、数组 的基本扩
extension ArrayExtensionViewController {
    
    // MARK: 1.1、安全的取某个索引的值
    @objc func test11() {
        let testArray = ["1", "2", "3", "2"]
        let index = 2
        guard let value = testArray.indexValue(safe: index) else {
            JKPrint("取数组 \(testArray) 索引为 \(index) 是没有值的")
            return
        }
        JKPrint("安全的取某个索引的值", "在数组 \(testArray) 中获取索引 \(index) 的值是 \(value)")
    }
    
    // MARK: 1.2、数组新增元素(可转入一个数组)
    @objc func test12() {
        var testArray = ["1", "2", "3"]
        let addArray = ["4", "5", "6"]
        let oldArray = testArray
        testArray.append(addArray)
        JKPrint("数组新增元素(可转入一个数组)", "原数组是： \(oldArray) 添加 \(addArray) 后为 \(testArray)")
    }
    
    // MARK: 1.3、数组 -> JSON字符串
    @objc func test13() {
        let array = [["a": "1"], "2"] as [Any]
        JKPrint("数组 -> JSON字符串", "数组：\(array) 转为JSON字符串为：\(array.toJSON() ?? "数组 ❌ JSON字符串")")
    }
}
