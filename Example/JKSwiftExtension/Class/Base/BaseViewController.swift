//
//  BaseViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension
@objc class BaseViewController: UIViewController {
    static let BaseViewControllerCellIdentifier = "BaseViewControllerCellIdentifier"
    /// 资源数组
    var dataArray = [Any]()
    /// 资源数组
    var headDataArray = [Any]()
    lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame:CGRect(x:0, y: 0, width: jk_kScreenW, height: jk_kScreenH - CGFloat(jk_kNavFrameH)), style:.grouped)
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.backgroundColor = UIColor.cBackViewColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kTabbarBottom))
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        // 设置一个默认高度
        tableView.estimatedRowHeight = 80.0
        // 开启自适应
        tableView.rowHeight = UITableView.automaticDimension
        tableView.jk.register(cellClass: BaseViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.cBackViewColor
        
        headDataArray = []
        dataArray = []
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

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.jk.dequeueReusableCell(cellType: BaseViewCell.self, cellForRowAt: indexPath)
        let singleDataArray = dataArray[indexPath.section] as! [String]
        cell.contentLabel.text = "\(indexPath.row + 1)：\((singleDataArray[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let str = headDataArray[section] as! String
        let size = str.jk.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: jk_kScreenW - 20, height: CGFloat(MAXFLOAT)))
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height:size.height + 20))
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: jk_kScreenW - 20, height: size.height))
        label.text = str
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        sectionView.addSubview(label)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let str = headDataArray[section] as! String
        let size = str.jk.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: jk_kScreenW - 20, height: CGFloat(MAXFLOAT)))
        return size.height + 20
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
        let rowString = "\(indexPath.row + 1)".jk.prefixAddZero(2)
        let selectorName = "test\(indexPath.section + 1)\(rowString)"
        let selector = Selector("\(selectorName)")
        guard self.responds(to: selector) else {
            JKPrint("没有该方法：\(selector)")
            return
        }
        perform(selector)
    }
    
    // 设置cell的显示 3D缩放动画
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 设置cell的显示动画为3D缩放
        // xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        // 设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
    }
}
