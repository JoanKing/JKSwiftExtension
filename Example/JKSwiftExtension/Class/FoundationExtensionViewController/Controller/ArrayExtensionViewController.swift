//
//  ArrayExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

//class ArrayExtensionViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.title = "Array+Extension"
//        view.backgroundColor = .randomColor
//
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        test()
//    }
//
//    func test() {
//        var array = Array(["1","2","1","3"])
//        array.removeArr(["1","3"], isRepeat: true)
//        print(array,"5")
//        JKPrint("1", "3")
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}


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
        
        headDataArray = ["一、数组 的基本扩展", "二、数组 有关索引 的扩展方法"]
        dataArray = [["安全的取某个索引的值"], ["获取数组中的指定元素的索引值", "获取元素首次出现的位置", "获取元素最后出现的位置"]]
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
            return
        }
        JKPrint("安全的取某个索引的值", "在数组 \(testArray) 中获取索引 \(index) 的值是 \(value)")
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
