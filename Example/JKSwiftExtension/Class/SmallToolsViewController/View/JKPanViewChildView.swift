//
//  JKPanViewChildView.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/17.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class JKPanViewChildView: JKPanView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame:CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height), style:.grouped)
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
        // tableView.isUserInteractionEnabled = false
        tableView.isScrollEnabled = false
        tableView.jk.register(cellClass: JKPanViewCell.self)
        return tableView
    }()
    
    override func scrollViewDidToTop() {
        tableView.isScrollEnabled = true
    }
    
    override func scrollViewDidToBottom() {
        tableView.isScrollEnabled = false
    }
}

extension JKPanViewChildView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.jk.dequeueReusableCell(cellType: JKPanViewCell.self, cellForRowAt: indexPath)
        cell.setData(minute: "\(indexPath.row)", distance: "6", desc: "最快路线 2个路口")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 20))
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFootView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        return sectionFootView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectorName = "test\(indexPath.section + 1)\(indexPath.row + 1)"
        let selector = Selector("\(selectorName)")
        JKPrint("没有该方法：\(selector)")
    }
}

extension JKPanViewChildView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.stop_y = scrollView.contentOffset.y
        debugPrint("------stop_y-----")
    }
}
