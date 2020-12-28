//
//  BundleExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class BundleExtensionViewController: UIViewController {
    fileprivate static let BundleExtensionViewControllerCellIdentifier = "BundleExtensionViewControllerCellIdentifier"
    /// 资源数组
    fileprivate var dataArray = [Any]()
    /// 资源数组
    fileprivate var headDataArray = [Any]()
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
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: BundleExtensionViewController.BundleExtensionViewControllerCellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、Bundle 的基本扩展"]
        dataArray = [["从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）", "从其他的 Bundle 通过 bundlename 获取 bundle", "加载"]]
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

// MARK:- 一、Bundle 的基本扩展
extension BundleExtensionViewController {
    
    // MARK: 1.1、从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）
    @objc func test11() {
        // 当前 moudle 下的 bundle 图片
        let imagePath1 = Bundle.getBundlePathResource(bundName: "JKBaseKit", resourceName: "icon_scan@2x.png", bundleType: .currentBundle)
        // 其他 moudle 下的 bundle 图片
        let imagePath2 = Bundle.getBundlePathResource(bundName: "MJRefresh", resourceName: "trail_arrow", bundleType: .otherBundle)
       
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        imageView1.jk.centerX = self.view.jk.centerX
        imageView1.backgroundColor = .red
        imageView1.image = UIImage(named: imagePath1)

        var imageView2 = UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        imageView2.jk.centerX = self.view.jk.centerX
        imageView2.backgroundColor = .red
        imageView2.image = UIImage(named: imagePath2)
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }

    }
    
    // MARK: 1.2、从其他的 Bundle 通过 bundlename 获取 bundle
    @objc func test12() {
        
        // 当前 moudle 下的 bundle 图片
        let imagePath1 = Bundle.getBundleResource(bundName: "JKBaseKit", resourceName: "icon_scan@2x", ofType: "png", bundleType: .currentBundle)
        // 其他 moudle 下的 bundle 图片
        let imagePath2 = Bundle.getBundleResource(bundName: "MJRefresh", resourceName: "trail_arrow@2x", ofType: "png", bundleType: .otherBundle)
        
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        imageView1.jk.centerX = self.view.jk.centerX
        imageView1.backgroundColor = .red
        imageView1.image = UIImage(named: imagePath1 ?? "")

        var imageView2 = UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        imageView2.jk.centerX = self.view.jk.centerX
        imageView2.backgroundColor = .red
        imageView2.image = UIImage(named: imagePath2 ?? "")
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 1.3、
    @objc func test13() {
       
    }
}

extension BundleExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BundleExtensionViewController.BundleExtensionViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
        let singleDataArray = dataArray[indexPath.section] as! [String]
        cell.contentLabel.text = "\(indexPath.row + 1)：\((singleDataArray[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let str = headDataArray[section] as! String
        let size = str.jk.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: kScreenW - 20, height: CGFloat(MAXFLOAT)))
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height:size.height + 20))
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: kScreenW - 20, height: size.height))
        label.text = str
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        sectionView.addSubview(label)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let str = headDataArray[section] as! String
        let size = str.jk.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: kScreenW - 20, height: CGFloat(MAXFLOAT)))
        return size.height + 20
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
        let selectorName = "test\(indexPath.section + 1)\(indexPath.row + 1)"
        let selector = Selector("\(selectorName)")
        guard self.responds(to: selector) else {
            JKPrint("没有该方法：\(selector)")
            return
        }
        perform(selector)
    }
}
