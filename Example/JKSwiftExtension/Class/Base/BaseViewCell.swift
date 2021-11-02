//
//  BaseViewCell.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

class BaseViewCell: UITableViewCell {

    var lineView: UIView = {
           let view = UIView()
        view.backgroundColor = UIColor.cN4
           return view
       }()
    /// 文本的展示
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.cN1
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        // self.selectionStyle = .none
        self.backgroundColor = .cBackViewColor
        self.contentView.backgroundColor = .cBackViewColor
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(lineView)
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 1))
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
            make.height.equalTo(jk_kPixel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
