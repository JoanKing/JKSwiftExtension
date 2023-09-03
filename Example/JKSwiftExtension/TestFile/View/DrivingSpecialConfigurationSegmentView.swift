//
//  DrivingSpecialConfigurationSegmentView.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2023/8/30.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class DrivingSpecialConfigurationSegmentView: UIView {
    
    var segmentedControl: UISegmentedControl!
    /// 试图组合
    var items: [DrivingSpecialConfigurationButton] = []
    
    var titles: [String] = []
    // 图片的名字
    var imageNames: [String] = []
    
    var buttons: [DrivingSpecialConfigurationButton] = []
    
    var selectedIndex: Int = 0
    convenience init(frame: CGRect, titles: [String], imageNames: [String], selectedIndex: Int) {
        self.init(frame: frame)
        self.titles = titles
        self.imageNames = imageNames
        self.selectedIndex = selectedIndex
        let segmentedControlTitles = titles.map({ item in
            return ""
        })
        segmentedControl = UISegmentedControl(items: segmentedControlTitles)
        // light：#E6EAEF dark：#131313
        segmentedControl.backgroundColor = UIColor.hexStringColor(hexString: "#E6EAEF")
        segmentedControl.layer.cornerRadius = 50
        segmentedControl.clipsToBounds = true
        segmentedControl.selectedSegmentIndex = selectedIndex
        if #available(iOS 13, *) {
            /*
             segmentedControl.tintColor = .blue
             segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
             segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], for: .normal)
             */
            segmentedControl.selectedSegmentTintColor = UIColor.hexStringColor(hexString: "#FFFFFF")
        }

        segmentedControl.addTarget(self, action: #selector(segmentDidchange), for: .valueChanged)
        self.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
     
        for (index, title) in titles.enumerated() {
           let button = DrivingSpecialConfigurationButton()
            // button.backgroundColor = .red
            if selectedIndex == index {
                button.nameLabel.textColor = .red
                button.nameLabel.font = UIFont.jk.textM(15)
            } else {
                button.nameLabel.textColor = .gray
                button.nameLabel.font = UIFont.jk.textR(15)
            }
            segmentedControl.addSubview(button)
            buttons.append(button)
            button.nameLabel.text = title
            button.bluetoothImageView.image = UIImage(named: imageNames[index])
            button.snp.makeConstraints { make in
                let spli = 1.0 / CGFloat(titles.count)
                debugPrint("测试：\(1.0 / CGFloat(titles.count))")
                make.width.lessThanOrEqualToSuperview().multipliedBy(spli)
                make.centerX.equalToSuperview().multipliedBy(CGFloat(2 * (index + 1) - 1) / CGFloat(titles.count))
                make.top.bottom.equalToSuperview()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func segmentDidchange(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                // light：#2C2D2E dark：#FFFFFF
                button.nameLabel.textColor = UIColor.hexStringColor(hexString: "#2C2D2E")
                button.nameLabel.font = UIFont.jk.textM(15)
            } else {
                // #7C828C
                button.nameLabel.textColor = UIColor.hexStringColor(hexString: "#7C828C")
                button.nameLabel.font = UIFont.jk.textR(15)
            }
        }
    }
}

class DrivingSpecialConfigurationButton: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        commonInit()
        changeTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 蓝牙图标
    lazy var bluetoothImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    /// 安全辅助雷达
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = ""
        label.font = UIFont.jk.textB(16)
        label.backgroundColor = .randomColor
        return label
    }()
    /// 中间视图
    lazy var bgView: UIView = {
        let view = UIView()
        return view
    }()
}

extension DrivingSpecialConfigurationButton {
    private func initUI() {
        addSubview(bgView)
        bgView.jk.addSubviews([nameLabel, bluetoothImageView])
    }
    
    private func commonInit() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        bluetoothImageView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 24, height: 24))
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    private func changeTheme() {
        
    }
}
