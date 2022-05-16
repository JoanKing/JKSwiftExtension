//
//  JKRollingNoticeViewViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/5/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SnapKit
import UIKit
import JKSwiftExtension

class JKRollingNoticeViewViewController: UIViewController {
    var labelColor: UIColor = .white
    var dataArray: [String] = []
    var dataArray2: [String] = []
    var dataArray3: [String] = []
    var noticeView1LabLeading: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        commonInit()
        loadData()
    }
    
    private func loadData() {
        dataArray = ["1-1-1--1-1-", "2-2-2--2-2-2--2"]
        dataArray2 = ["我", "爱", "你"]
        dataArray3 = ["xib自定义1", "xib自定义2"]
        JKAsyncs.asyncDelay(1) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.rollingNoticeView.reloadDataAndStartRoll()
            weakSelf.rollingNoticeView2.reloadDataAndStartRoll()
            weakSelf.rollingNoticeView3.reloadDataAndStartRoll()
        }
    }
    
    //MARK: 暂停和开始
    @objc func click1(sender: UIButton) {
        if rollingNoticeView.status == .working {
            rollingNoticeView.pause()
            sender.setTitle("开始", for: .normal)
        }else if rollingNoticeView.status != .working {
            rollingNoticeView.resume()
            sender.setTitle("暂停", for: .normal)
        }
    }
    
    //MARK: 刷新数据一和数据二
    @objc func click2(sender: UIButton) {
        if sender.tag == 100 {
            dataArray = ["1111111111111", "222222222222"]
            rollingNoticeView.reloadDataAndStartRoll()
        } else {
            dataArray = ["aaaaaaaaaa", "bbbbbbbbbbbb"]
            rollingNoticeView.reloadDataAndStartRoll()
        }
    }
    
    lazy var rollingNoticeView3: JKRollingNoticeView = {
        let noticeView = JKRollingNoticeView()
        noticeView.backgroundColor = .brown
        noticeView.stayInterval = 3
        noticeView.dataSource = self
        noticeView.delegate = self
        noticeView.register(UINib.init(nibName: "JKRollingNoticeViewCell2", bundle: nil), forCellReuseIdentifier: "JKNoticeViewCell3")
        return noticeView
    }()
    
    /// 自定义cell的提示
    lazy var tipThirdLabel: UILabel = {
        let label = UILabel()
        label.text = "3、Xib自定义cell"
        return label
    }()
    
    lazy var rollingNoticeView2: JKRollingNoticeView = {
        let noticeView = JKRollingNoticeView()
        noticeView.backgroundColor = .brown
        noticeView.stayInterval = 3
        noticeView.dataSource = self
        noticeView.delegate = self
        noticeView.register(JKRollingNoticeViewCell1.self, forCellReuseIdentifier: "JKNoticeViewCell2")
        return noticeView
    }()
    
    /// 自定义cell的提示
    lazy var tipSecondLabel: UILabel = {
        let label = UILabel()
        label.text = "2、纯代码自定义cell的提示"
        return label
    }()
    
    lazy var rollingNoticeView: JKRollingNoticeView = {
        let noticeView = JKRollingNoticeView()
        noticeView.backgroundColor = .brown
        noticeView.stayInterval = 3
        noticeView.dataSource = self
        noticeView.delegate = self
        noticeView.register(JKNoticeViewCell.self, forCellReuseIdentifier: "JKNoticeViewCell")
        return noticeView
    }()
    
    /// 纯文本的cell提示
    lazy var tipTopLabel: UILabel = {
        let label = UILabel()
        label.text = "1、纯文本的cell滚动"
        return label
    }()
    
    lazy var testButton1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("暂停", for: .normal)
        button.addTarget(self, action: #selector(click1), for: .touchUpInside)
        return button
    }()
    
    lazy var testButton2: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.tag = 100
        button.setTitle("刷新数据一", for: .normal)
        button.addTarget(self, action: #selector(click2), for: .touchUpInside)
        return button
    }()
    
    lazy var testButton3: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.tag = 101
        button.setTitle("刷新数据二", for: .normal)
        button.addTarget(self, action: #selector(click2), for: .touchUpInside)
        return button
    }()
    
    /// 自定义Cell提示提示
    lazy var useTipLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .red
        label.text = "自定义Cell提示：如果自己自定义滚动的cell：xib或者纯代码，当前类需要继承于：JKNoticeViewCell，具体的可以看：JKRollingNoticeViewCell1(纯代码) 和 JKRollingNoticeViewCell2(Xib)的使用"
        return label
    }()
}

extension JKRollingNoticeViewViewController: JKRollingNoticeViewDelegate, JKRollingNoticeViewDataSource {
    func numberOfRowsFor(roolingView: JKRollingNoticeView) -> Int {
        if roolingView == rollingNoticeView2 {
            return dataArray2.count
        }
        if roolingView == rollingNoticeView3 {
            return dataArray3.count
        }
        return dataArray.count
    }
    
    func rollingNoticeView(roolingView: JKRollingNoticeView, cellAtIndex index: Int) -> JKNoticeViewCell {
        
        if roolingView == rollingNoticeView2 {
            let cell = roolingView.dequeueReusableCell(withIdentifier: "JKNoticeViewCell2") as! JKRollingNoticeViewCell1
            cell.contentLabel.text = dataArray2[index]
            return cell
        }
        
        if roolingView == rollingNoticeView3 {
            let cell = roolingView.dequeueReusableCell(withIdentifier: "JKNoticeViewCell3") as! JKRollingNoticeViewCell2
            cell.noticeCellData(name: dataArray3[index])
            return cell
        }
        
        let cell = roolingView.dequeueReusableCell(withIdentifier: "JKNoticeViewCell")
        cell!.textLabel.text = dataArray[index]
        cell!.textLabel.textColor = labelColor
        cell!.textLabel.font = UIFont.systemFont(ofSize: 12)
        cell!.contentView.backgroundColor = UIColor.brown
        cell?.textLabelLeading = noticeView1LabLeading
        
        return cell!
    }
    
    func rollingNoticeView(_ roolingView: JKRollingNoticeView, didClickAt index: Int) {
        print("did click index: \(roolingView.currentIndex)")
    }
}

extension JKRollingNoticeViewViewController {
    private func initUI() {
        view.backgroundColor = .white
        view.addSubview(useTipLabel)
        
        view.addSubview(tipTopLabel)
        view.addSubview(rollingNoticeView)
        view.addSubview(testButton1)
        view.addSubview(testButton2)
        view.addSubview(testButton3)
        
        view.addSubview(tipSecondLabel)
        view.addSubview(rollingNoticeView2)
        
        view.addSubview(tipThirdLabel)
        view.addSubview(rollingNoticeView3)
    }
    
    private func commonInit() {
        useTipLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(jk_kNavFrameH + 15)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        tipTopLabel.snp.makeConstraints { make in
            make.top.equalTo(useTipLabel.snp.bottom).offset(20)
            make.left.equalTo(16)
            make.height.equalTo(20)
            make.right.equalTo(-16)
        }
        rollingNoticeView.snp.makeConstraints { (make) in
            make.top.equalTo(tipTopLabel.snp.bottom).offset(10)
            make.left.equalTo(16)
            make.height.equalTo(40)
            make.right.equalTo(-16)
        }
        testButton1.snp.makeConstraints { make in
            make.top.equalTo(rollingNoticeView.snp.bottom).offset(20)
            make.left.equalTo(16)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        testButton2.snp.makeConstraints { make in
            make.top.equalTo(rollingNoticeView.snp.bottom).offset(20)
            make.left.equalTo(testButton1.snp.right).offset(16)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        testButton3.snp.makeConstraints { make in
            make.top.equalTo(rollingNoticeView.snp.bottom).offset(20)
            make.left.equalTo(testButton2.snp.right).offset(16)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        tipSecondLabel.snp.makeConstraints { make in
            make.top.equalTo(testButton1.snp.bottom).offset(20)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        rollingNoticeView2.snp.makeConstraints { make in
            make.top.equalTo(tipSecondLabel.snp.bottom).offset(50)
            make.height.equalTo(80)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        tipThirdLabel.snp.makeConstraints { make in
            make.top.equalTo(rollingNoticeView2.snp.bottom).offset(20)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        rollingNoticeView3.snp.makeConstraints { make in
            make.top.equalTo(tipThirdLabel.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
    }
}
