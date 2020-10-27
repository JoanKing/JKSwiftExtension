//
//  DateExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class DateExtensionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、沙盒路径的获取", "二、iOS CharacterSet（字符集）", "三、字符串的转换", "四、字符串UI的处理", "五、字符串有关数字方面的扩展", "六、苹果针对浮点类型计算精度问题提供出来的计算类", "七、字符串包含表情的处理", "八、字符串的一些正则校验", "九、字符串截取的操作"]
        dataArray = [["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"],["去除字符串前后的 空格", "去除字符串前后的 换行", "去除字符串前后的 换行和换行", "去掉所有 空格", "去掉所有 换行", "去掉所有空格 和 换行", "是否是 0-9的数字，也不包含小数点", "url进行编码"], ["字符串 转 CGFloat", "字符串转bool", "字符串转 Int", "字符串转 Double", "字符串转 Float", "字符串转 Bool", "字符串转 NSString"], ["对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)", "对字符串(多行)指定字体及Size，获取 (高度)", "对字符串(多行)指定字体及Size，获取 (宽度)", "对字符串(单行)指定字体，获取 (Size)", "对字符串(单行)指定字体，获取 (width)", "对字符串(单行)指定字体，获取 (Height)", "字符串通过 label 根据高度&字体—>Size", "字符串通过 label 根据高度&字体—>Width", "字符串通过 label 根据宽度&字体—>height", "字符串根据宽度 & 字体&行间距->Size", "字符串根据宽度 & 字体 & 行间距->width", "字符串根据宽度&字体&行间距->height"], ["将金额字符串转化为带逗号的金额 按照千分位划分，如 1234567 => 1,234,567", "字符串差不多精确转换成Double——之所以差不多，是因为有精度损失", "去掉小数点后多余的 0", "将数字的字符串处理成  几位 位小数的情况"], ["+", "-", "*", "/"], ["检查字符串是否包含 Emoji 表情", "去除字符串中的Emoji表情"], ["判断是否全是空白,包括空白字符和换行符号，长度为0返回true", "判断是否全十进制数字，长度为0返回false", "判断是否是整数", "判断是否是Float,此处Float是包含Int的，即Int是特殊的Float", "判断是否全是字母，长度为0返回false", "判断是否是中文, 这里的中文不包括数字及标点符号", "是否是有效昵称，即允许“中文”、“英文”、“数字”", "判断是否是有效的手机号码", "判断是否是有效的电子邮件地址", "判断是否有效的身份证号码，不是太严格", "严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码", "校验字符串位置是否合理，并返回String.Index"], ["截取字符串从开始到 index", "截取字符串从index到结束", "获取指定位置和长度的字符串", "切割字符串(区间范围 前闭后开)", "用整数返回子字符串开始的位置"]]
        initUI()
    }
    
    /// 创建控件
    private func initUI() {
        view.addSubview(tableView)
    }
    
    fileprivate static let DateExtensionViewControllerCellIdentifier = "DateExtensionViewControllerCellIdentifier"
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
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: DateExtensionViewController.DateExtensionViewControllerCellIdentifier)
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DateExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateExtensionViewController.DateExtensionViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
        let singleDataArray = dataArray[indexPath.section] as! [String]
        cell.contentLabel.text = "\(indexPath.row + 1)：\((singleDataArray[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let str = headDataArray[section] as! String
        let size = str.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: kScreenW - 20, height: CGFloat(MAXFLOAT)))
        
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
        let size = str.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: kScreenW - 20, height: CGFloat(MAXFLOAT)))
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
        let selectorName = "test\(indexPath.section)\(indexPath.row)"
        let selector = Selector("\(selectorName)")
        guard self.responds(to: selector) else {
            JKPrint("没有该方法：\(selector)")
            return
        }
        perform(selector)
    }
}

