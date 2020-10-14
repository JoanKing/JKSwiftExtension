//
//  FoundationExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FoundationExtensionViewController: UIViewController {
    
    fileprivate static let FoundationExtensionViewControllerCellIdentifier = "FoundationExtensionViewControllerCellIdentifier"
    /// 资源数组
    fileprivate var dataArray = [Any]()
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
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: FoundationExtensionViewController.FoundationExtensionViewControllerCellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "JKSwiftExtension"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
  
        dataArray = ["Array+Extension", "BaseData+Extension", "Bundle+Extension", "CGRect+Extension", "Date+Extension", "Double+Divisible", "NSObject+Extension", "String+Extension", "UIColor+BaseExtension", "UIDevice+Extension", "UIFont+Extensin", "Timer+Extension", "Int+Extension", "UInt+Extension", "Float+Extension", "Bool+Extension", "CGFloat+Extension", "Character+Extension", "DateFormatter+Extension", "Dictionary+Extension", "FileManager+Extension", "URL+Extension", "NSDecimalNumberHandler+Extension"]
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

extension FoundationExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoundationExtensionViewController.FoundationExtensionViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
        cell.contentLabel.text = (dataArray[indexPath.row] as! String)
        // cell.lineView.isHidden = indexPath.row == dataArray.count - 1 ? true : false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height:0.01))
        return sectionView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
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
    
        let cellName = dataArray[indexPath.row] as! String
        if cellName == "Array+Extension" {
            navigationController?.pushViewController(ArrayExtensionViewController(), animated: true)
        } else if cellName == "BaseData+Extension" {
           
        } else if cellName == "Bundle+Extension" {
           
        } else if cellName == "CGRect+Extension" {
        
        } else if cellName == "Date+Extension" {
            
        } else if cellName == "Double+Divisible" {
            
        } else if cellName == "NSObject+Extension" {
            
        } else if cellName == "String+Extension" {
            navigationController?.pushViewController(StringExtensionViewController(), animated: true)
        } else if cellName == "UIColor+BaseExtension" {
            
        } else if cellName == "UIDevice+Extension" {
            
        } else if cellName == "UIFont+Extensin" {
           
        } else if cellName == "Timer+Extension" {
            
        } else if cellName == "Int+Extension" {
            
        } else if cellName == "UInt+Extension" {
            
        } else if cellName == "Float+Extension" {
            
        } else if cellName == "Bool+Extension" {
            
        } else if cellName == "CGFloat+Extension" {
            
        } else if cellName == "Character+Extension" {
            
        } else if cellName == "DateFormatter+Extension" {
            
        } else if cellName == "Dictionary+Extension" {
            
        } else if cellName == "FileManager+Extension" {
            
        } else if cellName == "URL+Extension" {
            
        } else if cellName == "NSDecimalNumberHandler+Extension" {
            navigationController?.pushViewController(NSDecimalNumberHandlerExtensionViewController(), animated: true)
        } else {
            
        }
    }
}
