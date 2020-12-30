//
//  DateExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class DateExtensionViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、Date 基本的扩展", "二、时间格式的转换", "三、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断", "四、相对的时间变化"]
        dataArray = [["获取当前 秒级 时间戳 - 10 位", "获取当前 毫秒级 时间戳 - 13 位", "获取当前的时间 Date", "从 Date 获取年份", "从 Date 获取月份", "从 Date 获取 日", "从 Date 获取 小时", "从 Date 获取 分钟", "从 Date 获取 秒", "从 Date 获取 毫秒", "从日期获取 星期(英文)", "从日期获取 月(英文)"], ["时间戳 按照对应的格式 转化为 对应时间的字符串，支持10位 和 13位", "时间戳 转 Date, 支持 10 位 和 13 位", "Date 转换为相应格式的字符串", "带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳", "带格式的时间转 Date，支持返回 13位 和 10位的时间戳"], ["今天的日期", "昨天的日期", "明天的日期", "前天的日期", "后天的日期", "是否为今天（只比较日期，不比较时分秒）", "是否为昨天", "是否为前天", "是否为今年", "是否为 同一年 同一月 同一天"], ["取得与当前时间的间隔差"]]
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

// MARK:- 四、相对的时间变化
extension DateExtensionViewController {
    
    // MARK: 4.1、取得与当前时间的间隔差
    @objc func test30() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("取得与当前时间的间隔差", "\(date1) 与当前时间的间隔差：\(date1.jk.callTimeAfterNow())")
    }
}

// MARK:- 三、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断
extension DateExtensionViewController {
    
    // MARK: 3.1、今天的日期
    @objc func test20() {
        JKPrint("今天的日期：\(Date().jk.todayDate)")
    }
    
    // MARK: 3.2、昨天的日期
    @objc func test21() {
        guard let date = Date().jk.yesterDayDate else {
            return
        }
        JKPrint("昨天的日期：\(date)")
    }
    
    // MARK: 3.3、明天的日期
    @objc func test22() {
        guard let date = Date().jk.tomorrowDate else {
            return
        }
        JKPrint("明天的日期：\(date)")
    }
    
    // MARK: 3.4、前天的日期
    @objc func test23() {
        guard let date = Date().jk.theDayBeforYesterDayDate else {
            return
        }
        JKPrint("前天的日期：\(date)")
    }
    
    // MARK: 3.5、后天的日期
    @objc func test24() {
        guard let date = Date().jk.theDayAfterYesterDayDate else {
            return
        }
        JKPrint("后天的日期：\(date)")
    }
    
    // MARK: 3.6、是否为今天（只比较日期，不比较时分秒）
    @objc func test25() {
        let timestamp1 = "1603849053"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("是否为今天（只比较日期，不比较时分秒）", "\(date) 是否为今天 \(date.jk.isToday)")
    }
    
    // MARK: 3.7、是否为昨天
    @objc func test26() {
        let timestamp1 = "1603762653"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("是否为昨天", "\(date) 是否为昨天 \(date.jk.isYesterday)")
    }
    
    // MARK: 3.8、是否为前天
    @objc func test27() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        JKPrint("今天：\(date)", "是否为前天：\(date.jk.isTheDayBeforeYesterday)")
    }
    
    // MARK: 3.9、是否为今年
    @objc func test28() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2019-10-26 09:37:33
        let timestamp2 = "1572053853"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("是否为今年的判断", "\(date1) 是否为今年：\(date1.jk.isThisYear)", "\(date2) 是否为今年：\(date2.jk.isThisYear)")
    }
    
    // MARK: 3.10、是否为 同一年 同一月 同一天
    @objc func test29() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603869908"
        let date1 = Date.jk.timestampToFormatterDate(timestamp: timestamp1)
        // 2019-10-26 09:37:33
        let timestamp2 = "1572053853"
        let date2 = Date.jk.timestampToFormatterDate(timestamp: timestamp2)
        JKPrint("是否为 同一年 同一月 同一天", "\(date1) 是否为今年：\(date1.jk.isSameYearMonthDayWithToday)", "\(date2) 是否为今年：\(date2.jk.isSameYearMonthDayWithToday)")
    }
}

// MARK:- 二、时间格式的转换
extension DateExtensionViewController {
    
    // MARK: 2.1、时间戳 按照对应的格式 转化为 对应时间的字符串
    @objc func test10() {
        let timestamp1 = "1603849053"
        let timestamp2 = "1603849053000"
        JKPrint("时间戳 按照对应的格式 转化为 对应时间的字符串，支持10位 和 13位 ：", "\(timestamp1) -> \(Date.jk.timestampToFormatterTimeString(timestamp: timestamp1, format: "yyyy-MM-dd HH:mm:ss"))", "\(timestamp2) -> \(Date.jk.timestampToFormatterTimeString(timestamp: timestamp2, format: "yyyy-MM-dd HH:mm:ss"))")
    }
    
    // MARK: 2.2、时间戳 转 Date, 支持 10 位 和 13 位
    @objc func test11() {
        let timestamp1 = "1603849053"
        let timestamp2 = "1603849053000"
        JKPrint("时间戳 转 Date, 支持 10 位 和 13 位：", "\(timestamp1) -> \(Date.jk.timestampToFormatterDate(timestamp: timestamp1))", "\(timestamp2) -> \(Date.jk.timestampToFormatterDate(timestamp: timestamp2))")
    }
    
    // MARK: 2.3、Date 转换为相应格式的字符串
    @objc func test12() {
        let date = Date.jk.currentDate
        JKPrint("Date 转换为相应格式的字符串", "获取当前的时间 Date位：\(date)","当前的 date 转 时间为：\(date.jk.toformatterTimeString(formatter: "yyyy-MM-dd"))")
    }
    
    // MARK: 2.4、带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳
    @objc func test13() {
        let timestamp1 = "2020-10-28"
        let timestamp1Fomatter = "yyyy-MM-dd"
        let timestamp2 = "2020年10月28日"
        let timestamp2Fomatter = "yyyy年MM月dd日"
        let timestamp3 = "2020-10-28 09:37:33"
        let timestamp3Fomatter = "yyyy-MM-dd HH:mm:ss"
        
        JKPrint("时间戳 转 Date, 支持 10 位 和 13 位：", "\(timestamp1) -> \(Date.jk.formatterTimeStringToTimestamp(timesString: timestamp1, formatter: timestamp1Fomatter, timestampType: .second))", "\(timestamp2) -> \(Date.jk.formatterTimeStringToTimestamp(timesString: timestamp2, formatter: timestamp2Fomatter, timestampType: .millisecond))", "\(timestamp3) -> \(Date.jk.formatterTimeStringToTimestamp(timesString: timestamp3, formatter: timestamp3Fomatter, timestampType: .millisecond))")
    }
    
    // MARK: 2.5、带格式的时间转 Date，支持返回 13位 和 10位的时间戳
    @objc func test14() {
        let timestamp1 = "2020-10-28"
        let timestamp1Fomatter = "yyyy-MM-dd"
        let timestamp2 = "2020年10月28日"
        let timestamp2Fomatter = "yyyy年MM月dd日"
        let timestamp3 = "2020-10-28 09:37:33"
        let timestamp3Fomatter = "yyyy-MM-dd HH:mm:ss"
        
        JKPrint("带格式的时间转 Date，支持返回 13位 和 10位的时间戳", "\(timestamp1) -> \(Date.jk.formatterTimeStringToDate(timesString: timestamp1, formatter: timestamp1Fomatter))", "\(timestamp2) -> \(Date.jk.formatterTimeStringToDate(timesString: timestamp2, formatter: timestamp2Fomatter))","\(timestamp3) -> \(Date.jk.formatterTimeStringToDate(timesString: timestamp3, formatter: timestamp3Fomatter))")
    }
}

// MARK:- 一、Date 基本的扩展
extension DateExtensionViewController {
    
    // MARK: 1.1、获取当前 秒级 时间戳 - 10 位
    @objc func test00() {
        JKPrint("获取当前 秒级 时间戳 - 10 位：\(Date.jk.secondStamp)")
    }
    
    // MARK: 1.2、获取当前 毫秒级 时间戳 - 13 位
    @objc func test01() {
        JKPrint("获取当前 毫秒级 时间戳 - 13 位：\(Date.jk.milliStamp)")
    }
    
    // MARK: 1.3、获取当前的时间 Date
    @objc func test02() {
        let date = Date.jk.currentDate
        JKPrint("获取当前的时间 Date位：\(date)","当前的 date 转 时间为：\(date.jk.toformatterTimeString(formatter: "yyyy-MM-dd"))")
    }
    
    // MARK: 1.4、从日期获取年份
    @objc func test03() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取年份位", "\(date) 的 年份为：\(date.jk.year)")
    }
    
    // MARK: 1.5、从日期获取月份
    @objc func test04() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取月份", "\(date) 的 月份为：\(date.jk.month)")
    }
    
    // MARK: 1.5、从日期获取 日
    @objc func test05() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 日", "\(date) 的 日 为：\(date.jk.day)")
    }
    
    // MARK: 1.6、从 Date 获取 小时
    @objc func test06() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 小时", "\(date) 的 小时 为：\(date.jk.hour)")
    }
    
    // MARK: 1.7、从 Date 获取 分钟
    @objc func test07() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 分钟", "\(date) 的 分钟 为：\(date.jk.minute)")
    }
    
    // MARK: 1.8、从 Date 获取 秒
    @objc func test08() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 秒", "\(date) 的 秒 为：\(date.jk.second)")
    }
    
    // MARK: 1.9、从 Date 获取 毫秒
    @objc func test09() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 毫秒", "\(date) 的 毫秒 为：\(date.jk.nanosecond)")
    }
    
    // MARK: 1.10、从日期获取 星期
    @objc func test010() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 星期", "\(date) 的 星期 为：\(date.jk.weekday)")
    }
    
    // MARK: 1.11、从日期获取 月(英文)
    @objc func test011() {
        let date = Date.jk.currentDate
        JKPrint("从日期获取 月(英文)", "\(date) 的 月 为：\(date.jk.monthAsString)")
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
        let selectorName = "test\(indexPath.section)\(indexPath.row)"
        let selector = Selector("\(selectorName)")
        guard self.responds(to: selector) else {
            JKPrint("没有该方法：\(selector)")
            return
        }
        perform(selector)
    }
}

