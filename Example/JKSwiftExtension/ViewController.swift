//
//  ViewController.swift
//  JKSwiftExtension
//
//  Created by JoanKing on 08/31/2020.
//  Copyright (c) 2020 JoanKing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "JKSwiftExtension"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        dataArray = ["FoundationExtension", "UIKitExtension", "Protocol", "SmallTools", "TestFile(自己测试用的)"]
        initUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    /// 创建控件
    private func initUI() {
        view.addSubview(tableView)
    }

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
        tableView.jk.register(cellClass: BaseViewCell.self)
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.jk.dequeueReusableCell(cellType: BaseViewCell.self, cellForRowAt: indexPath)
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
        if cellName == "FoundationExtension" {
            let vc = FoundationExtensionViewController()
            vc.title = cellName
            self.navigationController?.pushViewController(vc, animated: true)
        } else if cellName == "UIKitExtension" {
            let vc = UIKitExtensionViewController()
            vc.title = cellName
            self.navigationController?.pushViewController(vc, animated: true)
        } else if cellName == "Protocol" {
            let vc = ProtocolViewController()
            vc.title = cellName
            self.navigationController?.pushViewController(vc, animated: true)
        } else if cellName == "SmallTools" {
            let vc = SmallToolsViewController()
            vc.title = cellName
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(TestFileViewController(), animated: true)
        }
    }
}
