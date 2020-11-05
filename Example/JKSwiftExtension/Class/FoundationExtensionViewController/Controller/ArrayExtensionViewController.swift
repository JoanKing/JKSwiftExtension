//
//  ArrayExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ArrayExtensionViewController: UIViewController {
    fileprivate static let ArrayExtensionViewControllerCellIdentifier = "ArrayExtensionViewControllerCellIdentifier"
    /// 资源数组
    fileprivate var dataArray = [Any]()
    /// 资源数组
    fileprivate var headDataArray = [Any]()
    lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame:CGRect(x:0, y: 0, width: kScreenW, height: kScreenH - CGFloat(kNavFrameH)), style:.grouped)
        if #available(iOS 11, *) {
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.01))
        // 设置行高为自动适配
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: ArrayExtensionViewController.ArrayExtensionViewControllerCellIdentifier)
        return tableView
    }()
    
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

// MARK:- 五、针对数组元素是 String 的扩展
extension ArrayExtensionViewController {
    
    // MARK: 5.1、 数组转字符转（数组的元素是 字符串），如：["1", "2", "3"] 连接器为 - ，那么转化后为 "1-2-3"
    @objc func test51() {
        let testArray = ["1", "2", "3", "4", "5", "6"]
        let testString = testArray.toStrinig(separator: "-")
        JKPrint("数组转字符转（数组的元素是 字符串）", "数组：\(testArray) 转为字符串为：\(testString)")
    }
}
// MARK:- 四、遵守 NSObjectProtocol 协议对应数组的扩展方法
extension ArrayExtensionViewController {
    
    // MARK: 4.1、删除数组中遵守NSObjectProtocol协议的元素，是否删除重复的元素
    @objc func test41() {
        var testArray = ["1".toNSString, "2".toNSString, "3".toNSString, "2".toNSString]
        let oldArray = testArray
        let element = "2".toNSString
        let newArray = testArray.remove(object: element, isRepeat: false)
        JKPrint("删除数组中遵守NSObjectProtocol协议的元素，是否删除重复的元素)", "原数组为：\(oldArray) 删除其中的值：\(element) 后数组为：\(newArray)")
    }
    
    // MARK: 4.2、删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除
    @objc func test42() {
        var testArray = ["1".toNSString, "2".toNSString, "3".toNSString, "2".toNSString]
        let removeArray = ["2".toNSString, "3".toNSString]
        let oldArray = testArray
        let newArray = testArray.removeArray(objects: removeArray, isRepeat: true)
        JKPrint("删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除", "原数组为：\(oldArray) 删除的数组是：\(removeArray) 后数组为：\(newArray)")
    }
}

// MARK:- 三、遵守 Equatable 协议的数组 (增删改查) 扩展
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
// MARK:- 二、数组 有关索引 的扩展方法
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
        JKPrint("获取元素首次出现的位置", "\(element) 在数组：\(testArray) 首次出现的索引是：\(testArray.firstIndex(of: element) ?? 0)")
    }
    
    // MARK: 2.3、获取元素最后出现的位置
    @objc func test23() {
       let testArray = ["1", "2", "3", "2"]
       let element = "2"
       JKPrint("获取元素最后出现的位置", "\(element) 在数组：\(testArray) 最后出现的索引是：\(testArray.lastIndex(of: element) ?? 0)")
    }

}

// MARK:- 一、数组 的基本扩
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

extension ArrayExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArrayExtensionViewController.ArrayExtensionViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
        let singleDataArray = dataArray[indexPath.section] as! [String]
        cell.contentLabel.text = "\(indexPath.row + 1)：\((singleDataArray[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let str = headDataArray[section] as! String
        let size = str.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: kScreenW - 20, height: CGFloat(MAXFLOAT)))
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height:size.height + 20))
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: kScreenW - 20, height: size.height))
        label.text = str
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        sectionView.addSubview(label)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let str = headDataArray[section] as! String
        let size = str.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: kScreenW - 20, height: CGFloat(MAXFLOAT)))
        return size.height + 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFootView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.01))
        return sectionFootView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectorName = "test\(indexPath.section + 1)\(indexPath.row + 1)"
        let selector = Selector("\(selectorName)")
        guard self.responds(to: selector) else {
            JKPrint("没有该方法：\(selector)")
            return
        }
        perform(selector)
    }
}
