//
//  JKPanViewViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class JKPanViewViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(panView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        }
    }
    
    lazy var panView: JKPanViewChildView = {
        let panview = JKPanViewChildView(frame: CGRect(x: 0, y: jk_kScreenH * 3 / 4.0, width: jk_kScreenW, height: jk_kScreenH / 2.0))
        panview.jk.addViewCornerAndShadow(conrners: [.topLeft, .topRight], radius: 21, shadowColor: UIColor.black.withAlphaComponent(0.05), shadowOffset: CGSize(width: 0, height: -4), shadowOpacity: 1.0, shadowRadius: 20)
        panview.topMaxHeight = jk_kScreenH * 3 / 4.0
        panview.topMinHeight = jk_kScreenH * 1 / 2.0
        return panview
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame:CGRect.zero, style:.grouped)
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.jk.addViewCornerAndShadow(conrners: [.topLeft, .topRight], radius: 21, shadowColor: UIColor.black.withAlphaComponent(0.05), shadowOffset: CGSize(width: 0, height: -4), shadowOpacity: 1.0, shadowRadius: 20)
        tableView.backgroundColor = UIColor.cBackViewColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        // 设置一个默认高度
        tableView.estimatedRowHeight = 80.0
        tableView.bounces = false
        // 开启自适应
        tableView.rowHeight = UITableView.automaticDimension
        tableView.jk.register(cellClass: UITableViewCell.self)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension JKPanViewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.jk.dequeueReusableCell(cellType: UITableViewCell.self, cellForRowAt: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.contentView.backgroundColor = .randomColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 20))
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFootView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        return sectionFootView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectorName = "test\(indexPath.section + 1)\(indexPath.row + 1)"
        let selector = Selector("\(selectorName)")
        JKPrint("没有该方法：\(selector)")
    }
}
