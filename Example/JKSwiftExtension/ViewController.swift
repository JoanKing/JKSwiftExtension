//
//  ViewController.swift
//  JKSwiftExtension
//
//  Created by JoanKing on 08/31/2020.
//  Copyright (c) 2020 JoanKing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate static let ViewControllerCellIdentifier = "ViewControllerCellIdentifier"
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
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: ViewController.ViewControllerCellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "JKSwiftExtension"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        dataArray = ["FoundationExtension", "UIKitExtension", "Protocol", "SmallTools"]
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.ViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
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
            self.navigationController?.pushViewController(vc, animated: true)
        } else if cellName == "UIKitExtension" {
            let vc = UIKitExtensionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if cellName == "Protocol" {
            let vc = ProtocolViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if cellName == "SmallTools" {
            let vc = SmallToolsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
        }
    }
}


class HomeViewCell: UITableViewCell {

    var lineView: UIView = {
           let view = UIView()
        view.backgroundColor = UIColor.brown
           return view
       }()
    /// 文本的展示
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.c444444
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        // self.selectionStyle = .none
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(lineView)
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 1))
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
