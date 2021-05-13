//
//  ProtocolViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ProtocolViewController: UIViewController {
    
    fileprivate static let ProtocolViewControllerCellIdentifier = "ProtocolViewControllerCellIdentifier"
    /// 资源数组
    fileprivate var dataArray = [Any]()
    /// 完成的类
    fileprivate var finishedDataArray: [String] = []
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
        tableView.register(BaseViewCell.self, forCellReuseIdentifier: ProtocolViewController.ProtocolViewControllerCellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
  
        dataArray = ["JKEmitterable", "NibLoadable", "JKJSON"]
        finishedDataArray = ["JKEmitterable", "NibLoadable", "JKJSON"]
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

extension ProtocolViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProtocolViewController.ProtocolViewControllerCellIdentifier, for: indexPath) as! BaseViewCell
        let cellName = dataArray[indexPath.row] as! String
        cell.contentLabel.text = "\(indexPath.row + 1)：\(cellName)"
        cell.contentLabel.textColor = finishedDataArray.contains(cellName) ? UIColor.hexStringColor(hexString: "#006400") : UIColor.hexStringColor(hexString: "#444444")
        // cell.lineView.isHidden = indexPath.row == dataArray.count - 1 ? true : false
        return cell
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
        let vcName = cellName.jk.removeSomeStringUseSomeString(removeString: "+") + "ViewController"
        guard let vc = vcName.jk.toViewController() else {
            return
        }
        vc.title = cellName
        navigationController?.pushViewController(vc, animated: true)
    }
}
