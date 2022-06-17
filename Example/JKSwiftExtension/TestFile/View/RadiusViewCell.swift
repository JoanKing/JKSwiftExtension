//
//  RadiusViewCell.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/8.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class RadiusViewCell: UITableViewCell {
    
    /// VC
    weak var controller: UIViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        commonInit()
        changeTheme()
    }
    
    func initUI() {
        contentView.addSubview(topTitleLabel)
        contentView.addSubview(seperatorLine)
    }
    
    func commonInit() {
        topTitleLabel.snp.updateConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(32)
            make.right.equalTo(-32)
            make.bottom.equalTo(-10)
        }
        seperatorLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(32)
            make.right.equalTo(-32)
            make.height.equalTo(0.5)
        }
    }
    
    /// 赋值
    /// - Parameters:
    ///   - brand:品牌的名字
    ///   - sn: sn
    ///   - vehiclImageUrl: 车辆的图片
    func setData(brand: String, isLastCell: Bool) {
        topTitleLabel.text = brand
        seperatorLine.isHidden = isLastCell
    }
    
    func changeTheme() {
        contentView.backgroundColor = .clear
    }
    
    /// 标题
    var topTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hexStringColor(hexString: "#2C2D2E")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // 分割线
    private lazy var seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringColor(hexString: "#3C3C43").withAlphaComponent(0.36)
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
