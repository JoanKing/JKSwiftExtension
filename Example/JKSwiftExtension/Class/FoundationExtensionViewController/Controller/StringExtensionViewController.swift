//
//  StringExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class StringExtensionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        JKPrint(String.PreferencesDirectory())
  
        headDataArray = ["一、沙盒路径的获取", "二、字符串的空格和特殊字符的处理", "三、字符串的转换", "四、字符串UI的处理"]
        dataArray = [["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"],["去除字符串前后的 空格", "去除字符串前后的 换行", "去除字符串前后的 换行和换行", "去掉所有 空格", "去掉所有 换行", "去掉所有空格 和 换行"], ["字符串 转 CGFloat", "字符串转bool", "字符串转 Int", "字符串转 Double", "字符串转 Float", "字符串转 Bool", "字符串转 NSString"], ["对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)", "对字符串(多行)指定字体及Size，获取 (高度)", "对字符串(多行)指定字体及Size，获取 (宽度)", "对字符串(单行)指定字体，获取 (Size)"]]
        initUI()
    }
    
    /// 创建控件
    private func initUI() {
        view.addSubview(tableView)
    }
    
    fileprivate static let StringExtensionViewControllerCellIdentifier = "StringExtensionViewControllerCellIdentifier"
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
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: StringExtensionViewController.StringExtensionViewControllerCellIdentifier)
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 1、沙盒路径的获取
extension StringExtensionViewController {
    // MARK: 获取Home的完整路径名
    @objc func test00() {
        JKPrint("获取 Home 的完整路径名:\(String.homeDirectory())")
    }
    // MARK: 获取Documnets的完整路径名
    @objc func test01() {
        JKPrint("获取 Documnets 的完整路径名:\(String.DocumnetsDirectory())")
    }
    // MARK: "获取Library的完整路径名"
    @objc func test02() {
        JKPrint("获取 Library 的完整路径名:\(String.LibraryDirectory())")
    }
    // MARK: 获取/Library/Cache的完整路径名
    @objc func test03() {
        JKPrint("获取 /Library/Cache 的完整路径名:\(String.CachesDirectory())")
    }
    // MARK: 获取/Library/Preferences的完整路径名
    @objc func test04() {
        JKPrint("获取 /Library/Preferences 的完整路径名:\(String.PreferencesDirectory())")
    }
    // MARK: "获取Tmp的完整路径名"
    @objc func test05() {
        JKPrint("获取 Tmp 的完整路径名:\(String.TmpDirectory())")
    }
}

// MARK:- 字符串空格的处理
extension StringExtensionViewController {
    
    // MARK: 去除字符串前后的 空格
    /// 去除字符串前后的 空格
    @objc func test10() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str) \n处理后的字符串=\(str.removeBeginEndAllSapcefeed)")
    }
    
    // MARK: 去除字符串前后的 换行
    /// 去除字符串前后的 换行
    @objc func test11() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str) \n处理后的字符串=\(str.removeBeginEndAllLinefeed)")
    }
    
    // MARK: 去除字符串前后的 换行和换行
    /// 去除字符串前后的 换行和换行
    @objc func test12() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.removeBeginEndAllSapceAndLinefeed)")
    }
    
    // MARK: 去掉所有 空格
    /// 去掉所有 空格
    @objc func test13() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.removeAllSapce)")
    }
    
    // MARK: 去掉所有 换行
    /// 去掉所有 换行
    @objc func test14() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.removeAllLinefeed)")
    }
    
    // MARK: 去掉所有空格 和 换行
    /// 去掉所有空格 和 换行
    @objc func test15() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.removeAllLineAndSapcefeed)")
    }
}

// MARK:- 三、字符串的转换
extension StringExtensionViewController {
    
    // MARK: 3.1、字符串 转 CGFloat
    /// 字符串 转 CGFloat
    @objc func test20() {
        let str = "3.2"
        guard let value = str.toCGFloat() else {
            return
        }
        JKPrint(value)
    }
    
    // MARK: 3.2、字符串转 bool
    /// 字符串转 bool
    @objc func test21() {
        
    }
    
    // MARK: 3.3、字符串转 Int
    /// 字符串转 Int
    @objc func test22() {
        
    }
    
    // MARK: 3.4、字符串转 Double
    /// 字符串转 Double
    @objc func test23() {
        
    }
    
    // MARK: 3.5、字符串转 Float
    /// 字符串转 Float
    @objc func test24() {
        
    }
    
    // MARK: 3.6、字符串转 Bool
    /// 字符串转 Bool
    @objc func test25() {
        
    }
    
    // MARK: 3.7、字符串转 NSString
    /// 字符串转 NSString
    @objc func test26() {
        
    }
}

// MARK:- 4、字符串UI的处理
extension StringExtensionViewController {
    // MARK: 4.1、对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    /// 对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    @objc func test30() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let size = testString.rectSize(font: font, size: CGSize(width: 200, height: CGFloat(MAXFLOAT)))
        print("对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)：\(size)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 100, width: size.width, height: size.height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor()
        self.view.addSubview(testLabel)
        
    }

    // MARK: 4.2、对字符串(多行)指定字体及Size，获取 (高度)
    /// 对字符串(多行)指定字体及Size，获取 (高度)
    @objc func test31() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        print("对字符串(多行)指定字体及Size，获取 (高度)：\(testString.rectHeight(font: UIFont.systemFont(ofSize: 22), size: CGSize(width: 200, height: CGFloat(MAXFLOAT))))")
    }
    
    // MARK: 4.3、对字符串(多行)指定字体及Size，获取 (宽度)
    /// 对字符串(多行)指定字体及Size，获取 (宽度)
    @objc func test32() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        print("对字符串(多行)指定字体及Size，获取 (宽度)：\(testString.rectWidth(font: UIFont.systemFont(ofSize: 22), size: CGSize(width: 200, height: CGFloat(MAXFLOAT))))")
    }
    
    // MARK: 4.4、对字符串(单行)指定字体，获取 (Size)
    /// 对字符串(单行)指定字体，获取 (Size)
    @objc func test33() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        print("对字符串(单行)指定字体，获取 (Size)：\(testString.singleLineSize(font: UIFont.systemFont(ofSize: 22)))")
    }
}

// MARK:- 方法使用的展示区
extension StringExtensionViewController {
    // MARK: 去除 数字字符串 后面的 0
    @objc func test50() {
        let a = "1.00".cutLastZeroAfterDot()
        JKPrint(a)
    }
    // MARK: 去除 数字字符串 后面的 0
    @objc func test5() {
        
        JKPrint("哈哈")
    }
    
}

extension StringExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StringExtensionViewController.StringExtensionViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
        let singleDataArray = dataArray[indexPath.section] as! [String]
        cell.contentLabel.text = "\(indexPath.row + 1)：\((singleDataArray[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height:50))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: kScreenW, height: 50))
        label.text = (headDataArray[section] as! String)
        label.textAlignment = .left
        sectionView.addSubview(label)
        return sectionView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
        let selectorName = "test\(indexPath.section)\(indexPath.row)"
        let selector = Selector("\(selectorName)")
        guard self.responds(to: selector) else {
            JKPrint("没有该方法：\(selector)")
            return
        }
        perform(selector)
    }
}

