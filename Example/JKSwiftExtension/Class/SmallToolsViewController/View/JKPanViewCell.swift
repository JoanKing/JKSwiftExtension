//
//  JKPanViewCell.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class JKPanViewCell: UITableViewCell {

    /// 顶部距离和时间的展示
    var topTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    /// 方案的描述
    var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.hexStringColor(hexString: "#7C828C")
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // self.selectionStyle = .none
        self.contentView.addSubview(topTitleLabel)
        self.contentView.addSubview(descLabel)
        
        topTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(34)
        }
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topTitleLabel.snp.bottom).offset(2)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(20)
            make.bottom.equalTo(-13)
        }
    }
    
    func setData(minute: String, distance: String, desc: String) {
        let content = "\(minute)分钟 \(distance)公里"
        let attributedString = NSMutableAttributedString(string: content)

        attributedString.addAttributes([.foregroundColor : UIColor.brown, .font : UIFont.systemFont(ofSize: 17, weight: .medium)], range: NSRange(location: 0, length: content.count))
        if let range = content.jk.nsRange(of: minute) {
            attributedString.addAttributes([.foregroundColor : UIColor.red, .font : UIFont.systemFont(ofSize: 28, weight: .bold), NSAttributedString.Key.obliqueness: 0.2], range: range)
        }
        if let range = content.jk.nsRange(of: distance) {
            attributedString.addAttributes([.foregroundColor : UIColor.red, .font : UIFont.systemFont(ofSize: 28, weight: .bold), .obliqueness: 0.2], range: range)
        }
        
        topTitleLabel.attributedText = attributedString
        descLabel.text = desc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
