//
//  JKDarkModeUtilViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/7/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

// MARK:- 业务颜色的使用
extension UIColor {
    /// 背景色
    private(set) static var cA1 = JKDarkModeUtil.colorLightDark(light: UIColor.yellow, dark: UIColor.green)
    /// B1-品牌橙色 #FF4600
    private(set) static var cB1_Orange: UIColor = JKDarkModeUtil.colorLightDark(light: UIColor.hexStringColor(hexString: "#FF4600"), dark: UIColor.hexStringColor(hexString: "#FF4600").withAlphaComponent(0.8))
}

class JKDarkModeUtilViewController: UIViewController {
    /// 顶部的视图
    lazy var topHeadView: DarkModeHeadView = {
        let headView = DarkModeHeadView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 285), currentMode: JKDarkModeUtil.isLight ? .light : .dark)
        headView.selectModeClosure = {[weak self] (mode) in
            guard let weakSelf = self else { return }
            JKDarkModeUtil.setDarkModeCustom(isLight: mode == .light ? true : false)
            // 更新选择
            weakSelf.topHeadView.updateSelected()
            weakSelf.tableView.reloadData()
        }
        return headView
    }()
    
    /// 黑色模式的时间
    private var darkTime: String = JKDarkModeUtil.SmartPeelingTimeIntervalValue
    
    lazy var dataArray: [String] = {
        var array: [String] = []
        if #available(iOS 13, *) {
            array = ["智能换肤", "跟随系统"]
        } else {
            array = ["智能换肤"]
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "皮肤设置"
        self.view.backgroundColor = .cBackViewColor
        initUI()
        commonUI()
        updateTheme()
    }
    
    /// 创建控件
    private func initUI() {
        self.view.addSubview(tableView)
    }
    
    /// 添加控件和设置约束
    private func commonUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: kNavFrameH, left: 0, bottom: 0, right: 0))
        }
    }
    
    /// 更新控件的颜色，字体，背景色等等
    private func updateTheme() {
        
    }
    
    lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame: CGRect(x:0, y: kNavFrameH, width: kScreenW, height: kScreenH - kNavFrameH), style:.grouped)
        if #available(iOS 11, *) {
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.backgroundColor = UIColor.cBackViewColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.01))
        tableView.tableHeaderView = topHeadView
        tableView.jk.register(cellClass: SettingCustomViewCell.self)
        tableView.jk.register(cellClass: DescriptionCustomViewCell.self)
        return tableView
    }()
    
    
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension JKDarkModeUtilViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = dataArray[section]
        if sectionName == "智能换肤" {
            return JKDarkModeUtil.isSmartPeeling ? 3 : 0
        } else if sectionName == "跟随系统" {
            return JKDarkModeUtil.isFollowSystem ? 1 : 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.jk.dequeueReusableCell(cellType: DescriptionCustomViewCell.self, cellForRowAt: indexPath)
                cell.contentLabel.text = "进入换肤时段后，App将自动切换至“魅力黑”夜间肤色，换肤时间结束，切换为原始肤色"
                return cell
            } else {
                let cell = tableView.jk.dequeueReusableCell(cellType: SettingCustomViewCell.self, cellForRowAt: indexPath)
                cell.contentLabel.text = indexPath.row == 1 ? "夜间肤色" : "换肤时间"
                cell.backgroundColor = .cBackViewColor
                cell.contentLabel.font = UIFont.jk.textR(15)
                cell.descriptionLabel.text = indexPath.row == 1 ? "魅力黑" : darkTime
                cell.redView.isHidden = true
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.jk.dequeueReusableCell(cellType: DescriptionCustomViewCell.self, cellForRowAt: indexPath)
            cell.contentLabel.text = "开启后将跟随系统打开或关闭夜间肤色"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let contentHeight = JKContentSize.textStringSize(string: "进入换肤时段后，App将自动切换至“魅力黑”夜间肤色，换肤时间结束，切换为原始肤色", size: CGSize(width: kScreenW - 30, height: CGFloat(MAXFLOAT)), font: UIFont.jk.textR(14)).height + 18
                return contentHeight
            } else {
                return 44.0
            }
        } else if indexPath.section == 1 {
            let contentHeight = JKContentSize.textStringSize(string: "开启后将跟随系统打开或关闭夜间肤色", size: CGSize(width: kScreenW - 30, height: CGFloat(MAXFLOAT)), font: UIFont.jk.textR(14)).height + 18
            return contentHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 55))
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: 100, height: 55))
        label.font = UIFont.jk.textR(16)
        label.textColor = UIColor.cN3
        label.textAlignment = .left
        label.text = section == 0 ? "智能换肤" : "跟随系统"
        sectionView.addSubview(label)
        
        var switchSetting = UISwitch(frame: CGRect(x: kScreenW - 15 - 51, y: 0, width: 51, height: 55))
        switchSetting.jk.centerY = label.jk.centerY
        switchSetting.isOn = section == 0 ? JKDarkModeUtil.isSmartPeeling : JKDarkModeUtil.isFollowSystem
        switchSetting.tag = section == 0 ? 100 : 101
        if section == 0 {
            switchSetting.onTintColor = JKDarkModeUtil.isSmartPeeling ? UIColor.cB1_Orange : UIColor.cN4
        } else {
            switchSetting.onTintColor = JKDarkModeUtil.isFollowSystem ? UIColor.cB1_Orange : UIColor.cN4
        }
        switchSetting.addTarget(self, action: #selector(switchClick), for: .touchUpInside)
        sectionView.addSubview(switchSetting)
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
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
        if indexPath.section == 0, indexPath.row == 2 {
            // 获取暗黑模式时间的区间，转为两个时间戳，取出当前的时间戳，看是否在区间内，在的话：黑色，否则白色
            let timeIntervalValue = JKDarkModeUtil.SmartPeelingTimeIntervalValue.jk.separatedByString(with: "~") as! [String]
            let darkModePickerView = DarkModePickerView(startTime: timeIntervalValue[0], endTime: timeIntervalValue[1]) {[weak self] (startTime, endTime) in
                guard let weakSelf = self else { return }
                JKDarkModeUtil.setSmartPeelingTimeChange(startTime: startTime, endTime: endTime)
                weakSelf.darkTime = startTime + "~" + endTime
                // 更新选择
                weakSelf.topHeadView.updateSelected()
                weakSelf.tableView.reloadData()
            }
            darkModePickerView.showTime()
        }
    }
}

// MARK:- 时间
extension JKDarkModeUtilViewController {
    // MARK: 开关
    @objc func switchClick(sender: UISwitch) {
        if sender.tag == 100 {
            // 智能换肤
            print("智能换肤-------\(sender.isOn)")
            JKDarkModeUtil.setSmartPeelingDarkMode(isSmartPeeling: sender.isOn)
            sender.setOn(JKDarkModeUtil.isSmartPeeling, animated: false)
            // 更新选择
            topHeadView.updateSelected()
            self.tableView.reloadData()
        } else {
            // 跟随系统
            print("跟随系统-------\(sender.isOn)")
            JKDarkModeUtil.setDarkModeFollowSystem(isFollowSystem: sender.isOn)
            //label1.isHidden = sender.isOn
            //switch1.isHidden = sender.isOn
            sender.setOn(JKDarkModeUtil.isFollowSystem, animated: false)
            // 更新选择
            topHeadView.updateSelected()
            self.tableView.reloadData()
        }
    }
}
