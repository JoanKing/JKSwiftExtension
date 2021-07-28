//
//  DescriptionCustomViewCell.swift
//  FutureBull
//
//  Created by IronMan on 2021/7/27.
//  Copyright © 2021 wuyanwei. All rights reserved.
//

import UIKit

class DescriptionCustomViewCell: UITableViewCell {

    /// 文本的展示
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.jk.textR(14)
        label.textColor = UIColor.cN3
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // self.selectionStyle = .none
        self.contentView.backgroundColor = .cBackViewColor
        self.contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 15, bottom: 12, right: 15))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
