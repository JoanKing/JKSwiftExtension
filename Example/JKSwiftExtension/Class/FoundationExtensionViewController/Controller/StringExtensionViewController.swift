//
//  StringExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class StringExtensionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "JKSwiftExtension"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        JKPrint(String.PreferencesDirectory())
  
        headDataArray = ["沙盒路径的获取", "其他"]
        dataArray = [["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"],["去除 数字字符串 后面的 0", "第二个"]]
        initUI()
    }
    
    /// 创建控件
    private func initUI() {
        view.addSubview(tableView)
    }
    
    fileprivate static let StringExtensionViewControllerCellIdentifier = "StringExtensionViewControllerCellIdentifier"
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
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: StringExtensionViewController.StringExtensionViewControllerCellIdentifier)
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 1、沙盒路径的获取
extension StringExtensionViewController {
    // MARK: 获取Home的完整路径名
    @objc func test00() {
        JKPrint("获取 Home 的完整路径名:\(String.homeDirectory())")
    }
    // MARK: 获取Documnets的完整路径名
    @objc func test01() {
        JKPrint("获取 Documnets 的完整路径名:\(String.DocumnetsDirectory())")
    }
    // MARK: "获取Library的完整路径名"
    @objc func test02() {
        JKPrint("获取 Library 的完整路径名:\(String.LibraryDirectory())")
    }
    // MARK: 获取/Library/Cache的完整路径名
    @objc func test03() {
        JKPrint("获取 /Library/Cache 的完整路径名:\(String.CachesDirectory())")
    }
    // MARK: 获取/Library/Preferences的完整路径名
    @objc func test04() {
        JKPrint("获取 /Library/Preferences 的完整路径名:\(String.PreferencesDirectory())")
    }
    // MARK: "获取Tmp的完整路径名"
    @objc func test05() {
        JKPrint("获取 Tmp 的完整路径名:\(String.TmpDirectory())")
    }
}

// MARK:- 方法使用的展示区
extension StringExtensionViewController {
    // MARK: 去除 数字字符串 后面的 0
    @objc func test10() {
        let a = "1.00".cutLastZeroAfterDot()
        JKPrint(a)
    }
    // MARK: 去除 数字字符串 后面的 0
    @objc func test2() {
        
        JKPrint("哈哈")
    }
    
}

extension StringExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StringExtensionViewController.StringExtensionViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
        let singleDataArray = dataArray[indexPath.section] as! [String]
        cell.contentLabel.text = "\(indexPath.row + 1)：\((singleDataArray[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height:50))
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: kScreenW, height: 50))
        label.text = (headDataArray[section] as! String)
        label.textAlignment = .left
        sectionView.addSubview(label)
        return sectionView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
        let selectorName = "test\(indexPath.section)\(indexPath.row)"
        let selector = Selector("\(selectorName)")
        guard self.responds(to: selector) else {
            JKPrint("没有该方法：\(selector)")
            return
        }
        perform(selector)
    }
}

