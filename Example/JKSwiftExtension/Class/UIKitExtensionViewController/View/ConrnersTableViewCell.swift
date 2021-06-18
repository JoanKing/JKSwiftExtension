//
//  ConrnersTableViewCell.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/6/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ConrnersTableViewCell: UITableViewCell {
    
    lazy var testLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .randomColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        commonUI()
        updateTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创建控件
    private func initUI() {
        self.contentView.addSubview(testLabel)
    }
    
    /// 添加控件和设置约束
    private func commonUI() {
        testLabel.snp.makeConstraints { make in
            make.left.top.equalTo(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        self.layoutIfNeeded()
        testLabel.jk.addCorner(conrners: .bottomLeft, radius: 8)
    }
    
    /// 更新控件的颜色，字体，背景色等等
    private func updateTheme() {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
