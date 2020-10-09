//
//  SmallToolsViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class SmallToolsViewController: UIViewController {
    
    fileprivate static let smallToolsViewControllerCellIdentifier = "SmallToolsViewControllerCellIdentifier"
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
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: SmallToolsViewController.smallToolsViewControllerCellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "JKSwiftExtension"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        dataArray = ["ActionLabel", "GradientLabelView", "JKAsyncs", "JKCommonTool", "JKLoadingView", "JKPrint", "JKRuntime", "JKUserDefaults", "JKWaterFallLayout", "JKWidthHeight", "KeyboardAccessory", "MaskingManager", "MaskingManager+Extension", "ToastTexView", "QRCodeImageFactory", "SectorProgressView"]
        initUI()
    }
    
    /// 创建控件
    private func initUI() {
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        JKPrint("销毁")
    }
}

extension SmallToolsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SmallToolsViewController.smallToolsViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
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
        if cellName == "ActionLabel" {
         
        } else if cellName == "GradientLabelView" {
           
        } else if cellName == "JKAsyncs" {
           
        } else if cellName == "JKCommonTool" {
        
        } else if cellName == "JKLoadingView" {
            
        } else if cellName == "JKPrint" {
            
        } else if cellName == "JKRuntime" {
            
        } else if cellName == "JKUserDefaults" {
            
        } else if cellName == "JKWaterFallLayout" {
            
        } else if cellName == "JKWidthHeight" {
            
        } else if cellName == "KeyboardAccessory" {
            
        } else if cellName == "MaskingManager" {
            
        } else if cellName == "MaskingManager+Extension" {
            
        } else if cellName == "ToastTexView" {
            
        } else if cellName == "QRCodeImageFactory" {
            let qrCodeImageFactoryViewController = QRCodeImageFactoryViewController()
            self.navigationController?.pushViewController(qrCodeImageFactoryViewController, animated: true)
        } else if cellName == "SectorProgressView" {
            let sectorProgressViewController = SectorProgressViewController()
            self.navigationController?.pushViewController(sectorProgressViewController, animated: true)
        }else {
            
        }
    }
}
