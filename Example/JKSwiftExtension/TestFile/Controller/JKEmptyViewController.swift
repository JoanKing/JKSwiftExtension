//
//  JKEmptyViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/7/3.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

@objcMembers class JKEmptyViewController: BaseViewController {

    /// 是否使用Go骑行颜色模式
    private var isUseGoColorMode: Bool
    
    init(isUseGoColorMode: Bool = false) {
        self.isUseGoColorMode = isUseGoColorMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItems = [button1, button2, button3]
        initUI()
        commonInit()
        changeTheme()
        loadData()
    }
    
    private func initUI() {
        self.tableView.backgroundColor = .white
        self.tableView.addSubview(empty)
    }
    
    private func commonInit() {
        empty.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
    }
    
    private func changeTheme() {
        
    }
    
    private func loadData() {
        
    }
    
    lazy var button1: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.backgroundColor = .brown
        button.tag = 101
        button.addTarget(self, action: #selector(click1), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var button2: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.backgroundColor = .gray
        button.tag = 102
        button.addTarget(self, action: #selector(click1), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var button3: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.backgroundColor = .randomColor
        button.tag = 103
        button.addTarget(self, action: #selector(click1), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    /// 空白视图
    lazy var empty: JKEmptyView = {
        let emptyView = JKEmptyView()
        emptyView.refreshClosure = {
            print("刷新------")
        }
        return emptyView
    }()
}

extension JKEmptyViewController {
    
    @objc func click1(sender: UIButton) {
        if sender.tag == 101 {
            // empty.emptyViewType = .noData
            self.dismiss(animated: true, completion: nil)
        } else if sender.tag == 102 {
            empty.emptyViewType = .noNetWork
        } else {
            empty.emptyViewType = .normal
        }
    }
}

