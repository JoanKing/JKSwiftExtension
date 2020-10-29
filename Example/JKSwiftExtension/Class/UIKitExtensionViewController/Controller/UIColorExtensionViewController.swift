//
//  UIColorExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/29.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIColorExtensionViewController: UIViewController {
    fileprivate static let UIColorExtensionViewControllerCellIdentifier = "UIColorExtensionViewControllerCellIdentifier"
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
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: UIColorExtensionViewController.UIColorExtensionViewControllerCellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、构造器设置颜色", "二、使用方法设置颜色", "三、UIColor的一些方法", "四、UIColor 的一些属性"]
        dataArray = [["根据 RGBA 设置颜色", "十六进制字符串设置颜色", "十六进制 Int 设置颜色"], ["根据 RGBA 设置颜色(方法)", "十六进制字符串设置颜色(方法)", "十六进制 Int 颜色的使用(方法)"], ["根据 十六进制字符串 获取 RGB，如：#3CB371 或者 ##3CB371 -> 60,179,113", "根据 十六进制值 颜色获取 RGB， 如：0x3CB371 -> 60,179,113", "color 转 RGBA"], ["UIColor 转十六进制颜色的字符串", "随机色"]]
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

// MARK:- 四、UIColor 的一些属性
extension UIColorExtensionViewController {
    
    // MARK: 4.1、UIColor 转十六进制颜色的字符串
    @objc func test30() {
        // 纯蓝：#0000FF -> 0,0,255
        let color = UIColor(hexString: "#0000FF", alpha: 0.8)
        let hesString = color?.hexString ?? "颜色有问题"
        JKPrint("UIColor 转十六进制颜色的字符串", "原始颜色：纯蓝：#0000FF -> 0,0,255", "color 转化为 十六进制字符串为：\(hesString)", "透明度为：\(0.9)")
    }
    
    // MARK: 4.1、随机色
    @objc func test31() {
        self.navigationController?.navigationBar.barTintColor = UIColor.randomColor
    }
    
}

// MARK:- 三、UIColor的一些方法
extension UIColorExtensionViewController {
    
    // MARK: 3.1、根据 十六进制字符串颜色 获取 RGB
    @objc func test20() {
        // 春天的绿色：60,179,113 -> #3CB371
        let rgb = UIColor.hexStringToColorRGB(hexString: "#3CB371")
        guard let r = rgb.r, let g = rgb.g, let b = rgb.b else {
            JKPrint("颜值值有问题")
            return
        }
        JKPrint("根据 十六进制颜色获取 RGB", "原始的十六进制颜色为：#3CB371", "原始的RGB为：60,179,113", "r = \(r)", "g = \(g)", "b = \(b)" )
    }
    
    // MARK: 3.2、根据 十六进制值 颜色获取 RGB， 如：0x3CB371 -> 60,179,113
    @objc func test21() {
        // 春天的绿色：60,179,113 -> #3CB371
        let rgb = UIColor.hexIntToColorRGB(hexInt: 0x3CB371)
        let r = rgb.r
        let g = rgb.g
        let b = rgb.b
        JKPrint("根据 十六进制值 颜色获取 RGB， 如：0x3CB371 -> 60,179,113", "原始的RGB为：60,179,113", "r = \(r)", "g = \(g)", "b = \(b)" )
    }
    
    // MARK: 3.3、color 转 RGBA
    @objc func test22() {
        // 热情的粉红：#FF69B4 -> 255,105,180
        guard let color = UIColor(hexString: "#FF69B4", alpha: 0.6) else {
            return
        }
        self.navigationController?.navigationBar.barTintColor = color
        let rgba = color.colorToRGBA()
        guard let r = rgba.r, let g = rgba.g, let b = rgba.b, let a = rgba.a else {
            return
        }
        JKPrint("color 转 RGBA", "原始颜色：热情的粉红：#FF69B4 -> 255,105,180 透明度 0.6", "color 转化为 RGBA为：r = \(r)", "g = \(g)", "b = \(b)", "a = \(a)")
    }
}

// MARK:- 二、使用方法设置颜色
extension UIColorExtensionViewController {
    
    // MARK: 2.1、根据 RGBA 设置颜色颜色
    @objc func test10() {
        // 春天的绿色：60,179,113 -> #3CB371
         self.navigationController?.navigationBar.barTintColor = UIColor.color(r: 60, g: 179, b: 113, alpha: 1)
    }
    
    // MARK: 2.2、十六进制字符串设置颜色(方法)
    @objc func test11() {
        // 橙色：255,165,0 -> #FFA500
        self.navigationController?.navigationBar.barTintColor = UIColor.hexStringColor(hexString: "#FFA500", alpha: 1.0)
    }
    
    // MARK: 2.3、十六进制 Int 颜色的使用(方法)
    @objc func test12() {
        // 适中的板岩暗蓝灰色：123,104,238 -> #7B68EE
        self.navigationController?.navigationBar.barTintColor = UIColor.hexIntColor(hexInt: 0x7B68EE, alpha: 1.0)
    }
    
    
}

// MARK:- 一、构造器设置颜色
extension UIColorExtensionViewController {
    
    // MARK: 1.1、根据 RGBA 设置颜色颜色
    @objc func test00() {
        // 春天的绿色：60,179,113 -> #3CB371
        self.navigationController?.navigationBar.barTintColor = UIColor(r: 60, g: 179, b: 113, alpha: 1)
    }
    
    // MARK: 1.2、十六进制字符串设置颜色
    @objc func test01() {
        // 深橙色：255,140,0 -> #FF8C00
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#FF8C00", alpha: 1.0)
    }
    
    // MARK: 1.3、十六进制 Int 设置颜色
    @objc func test02() {
        // 淡珊瑚色：240,128,128 -> #F08080
        self.navigationController?.navigationBar.barTintColor = UIColor(hexInt: 0xF08080, alpha: 1.0)
    }
    
    // MARK: 1.4、从日期获取年份
    @objc func test03() {
        let date = Date.currentDate
        JKPrint("从日期获取年份位", "\(date) 的 年份为：\(date.year)")
    }
    
    // MARK: 1.5、从日期获取月份
    @objc func test04() {
        let date = Date.currentDate
        JKPrint("从日期获取月份", "\(date) 的 月份为：\(date.month)")
    }
    
    // MARK: 1.5、从日期获取 日
    @objc func test05() {
        let date = Date.currentDate
        JKPrint("从日期获取 日", "\(date) 的 日 为：\(date.day)")
    }
    
    // MARK: 1.6、从 Date 获取 小时
    @objc func test06() {
        let date = Date.currentDate
        JKPrint("从日期获取 小时", "\(date) 的 小时 为：\(date.hour)")
    }
    
    // MARK: 1.7、从 Date 获取 分钟
    @objc func test07() {
        let date = Date.currentDate
        JKPrint("从日期获取 分钟", "\(date) 的 分钟 为：\(date.minute)")
    }
    
    // MARK: 1.8、从 Date 获取 秒
    @objc func test08() {
        let date = Date.currentDate
        JKPrint("从日期获取 秒", "\(date) 的 秒 为：\(date.second)")
    }
    
    // MARK: 1.9、从 Date 获取 毫秒
    @objc func test09() {
        let date = Date.currentDate
        JKPrint("从日期获取 毫秒", "\(date) 的 毫秒 为：\(date.nanosecond)")
    }
    
    // MARK: 1.10、从日期获取 星期
    @objc func test010() {
        let date = Date.currentDate
        JKPrint("从日期获取 星期", "\(date) 的 星期 为：\(date.weekday)")
    }
    
    // MARK: 1.11、从日期获取 月(英文)
    @objc func test011() {
        let date = Date.currentDate
        JKPrint("从日期获取 月(英文)", "\(date) 的 月 为：\(date.monthAsString)")
    }
    
}

extension UIColorExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIColorExtensionViewController.UIColorExtensionViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
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
