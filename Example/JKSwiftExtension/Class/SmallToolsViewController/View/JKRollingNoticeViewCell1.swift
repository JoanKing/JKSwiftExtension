//
//  JKRollingNoticeViewCell1.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/5/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class JKRollingNoticeViewCell1: JKNoticeViewCell {
    
    /// 左侧的View
    var testLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    /// 文本的展示
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.jk.textR(14)
        label.backgroundColor = .brown
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    /// 右侧的View
    var testRightView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    required init(reuseIdentifier: String?, textLabelLeading: CGFloat = 10, textLabelTrailing: CGFloat = 10) {
        super.init(reuseIdentifier: reuseIdentifier, textLabelLeading: textLabelLeading, textLabelTrailing: textLabelTrailing)
        self.backgroundColor = .yellow
        initUI()
        commonInit()
        changeTheme()
        loadData()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        addSubview(testLeftView)
        addSubview(contentLabel)
        addSubview(testRightView)
    }
    
    private func commonInit() {
        testLeftView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(testLeftView.snp.right).offset(20)
            make.right.equalTo(testRightView.snp.left).offset(-20)
            make.bottom.equalTo(-20)
        }
        testRightView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    private func changeTheme() {
        
    }
    
    private func loadData() {
        
    }
}
