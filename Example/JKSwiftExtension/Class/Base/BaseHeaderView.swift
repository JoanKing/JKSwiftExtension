//
//  BaseHeaderView.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2025/3/12.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

class BaseHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initUI()
        commonInit()
        changeTheme()
        loadData()
    }
    
    // 提供一个方法来设置标题文本
    func setData(with title: String) {
        contentLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 文本的展示
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
}

// MARK: - 基本设置
extension BaseHeaderView {
    
    private func initUI() {
        self.contentView.addSubview(contentLabel)
    }
    
    private func commonInit() {
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    private func changeTheme() {
        self.contentView.backgroundColor = .cBackViewColor
    }
    
    /// 加载数据
    private func loadData() {
        
    }
}
