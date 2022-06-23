//
//  RadiusViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/8.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

@objcMembers class RadiusViewController: UIViewController {
    lazy var dataArray: [[String]] = [["噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！尔来四万八千岁，不与秦塞通人烟。", "白云依静渚，春草闭闲门。", "予独爱莲之出淤泥而不染，濯清涟而不妖，中通外直，不蔓不枝，香远益清，亭亭净植，可远观而不可亵玩焉。"], ["一路经行处，莓苔见履痕。"], ["水陆草木之花，可爱者甚蕃。晋陶渊明独爱菊。自李唐来，世人甚爱牡丹。", "地崩山摧壮士死，然后天梯石栈相钩连。上有六龙回日之高标，下有冲波逆折之回川。"]]
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.estimatedRowHeight = 80.0
        tableView.estimatedSectionFooterHeight = 0.01
        tableView.estimatedSectionHeaderHeight = 0.01
        tableView.backgroundColor = UIColor.hexStringColor(hexString: "#000000").withAlphaComponent(0.1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.jk.register(cellClass: RadiusViewCell.self)
        return tableView
    }()
}

extension RadiusViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        initUI()
        commonInit()
        changeTheme()
        loadData()
    }
    
    private func initUI() {
        view.addSubview(tableView)
    }
    
    private func commonInit() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    private func changeTheme() {
        
    }
    
    private func loadData() {
        
    }
}

//MARK: - Event
extension RadiusViewController {
    //MARK: 关闭
    /// 关闭
    @objc func closeClick() {
        
    }
    
    //MARK: 确定绑定
    /// 确定绑定
    @objc func nextClick() {
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RadiusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = dataArray[section]
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.jk.dequeueReusableCell(cellType: RadiusViewCell.self, cellForRowAt: indexPath)
        cell.selectionStyle = .none
        let rows = dataArray[indexPath.section]
        cell.setData(brand: rows[indexPath.row], isLastCell: tableView.jk.isLastCell(cellForRowAt: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 50))
        sectionView.backgroundColor = UIColor.clear
        let label = UILabel(frame: CGRect(x: 16, y: 10, width: jk_kScreenW - 32, height: 30))
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "这是第 \(section) 段"
        sectionView.addSubview(label)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        footView.backgroundColor = UIColor.red
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.jk.addSectionCellCornerRadius(radius: 10, fillColor: UIColor.white, willDisplay: cell, forRowAt: indexPath, insetByDx: 16)
    }
}

