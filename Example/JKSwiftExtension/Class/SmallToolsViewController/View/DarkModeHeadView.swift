//
//  DarkModeHeadView.swift
//  FutureBull
//
//  Created by IronMan on 2021/7/28.
//  Copyright © 2021 wuyanwei. All rights reserved.
//

import UIKit

extension UIImage {
    /// 选中
    private(set) static var tradeValidperiodSelected = UIImage(named: "trade_validperiod_selected")
    /// 没有选中
    private(set) static var tradeValidperiod = UIImage(named: "trade_validperiod")
}

/// 暗黑模式
enum DarkMode {
    case light
    case dark
}

class DarkModeHeadView: UIView {
    private var currentMode: DarkMode?
    /// 模式选择
    var selectModeClosure: ((DarkMode) -> Void)?
    /// 顶部标题
    lazy var topLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 100, height: 55))
        label.text = "手动换肤"
        label.textAlignment = .left
        label.font = UIFont.jk.textR(16)
        label.textColor = .cN3
        return label
    }()
    /// 浅色图片
    lazy var lightImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: jk_kScreenW / 2.0 - 18 - 80, y: 76, width: 80, height: 150))
        imageView.image = UIImage.jk.image(color: UIColor.green)
        return imageView
    }()
    /// 深色图片
    lazy var darkImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: jk_kScreenW / 2.0 + 18, y: 76, width: 80, height: 150))
        imageView.image = UIImage.jk.image(color: UIColor.red)
        return imageView
    }()
    
    /// 浅色选中图片
    lazy var lightSelectedImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: lightImageView.jk.left + 6, y: lightImageView.jk.bottom + 14, width: 16, height: 16))
        return imageView
    }()
    
    /// 浅色选中的文字
    lazy var lightSelectedLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: lightSelectedImageView.jk.right + 10, y: lightImageView.jk.bottom + 14, width: 42, height: 19))
        label.text = "简洁白"
        label.textAlignment = .left
        label.font = UIFont.jk.textR(13)
        label.textColor = .cN3
        return label
    }()
    
    /// 深色选中图片
    lazy var darkSelectedImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: darkImageView.jk.left + 6, y: darkImageView.jk.bottom + 14, width: 16, height: 16))
        return imageView
    }()
    
    /// 深色选中的文字
    lazy var darkSelectedLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: darkSelectedImageView.jk.right + 10, y: lightImageView.jk.bottom + 14, width: 42, height: 19))
        label.text = "魅力黑"
        label.textAlignment = .left
        label.font = UIFont.jk.textR(13)
        label.textColor = .cN3
        return label
    }()
    
    /// 浅色的按钮
    lazy var lightSelectedButton: UIButton = {
        let button = UIButton(frame: CGRect(x: jk_kScreenW / 2.0 - 18 - 80, y: 76, width: 80, height: 185))
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.tag = 100
        return button
    }()
    
    /// 深色的按钮
    lazy var darkSelectedButton: UIButton = {
        let button = UIButton(frame: CGRect(x: jk_kScreenW / 2.0 + 18, y: 76, width: 80, height: 185))
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.tag = 101
        return button
    }()
    
    init(frame: CGRect, currentMode: DarkMode) {
        super.init(frame: frame)
        self.currentMode = currentMode
        initUI()
        commonUI()
        updateTheme()
    }
    
    /// 创建控件
    private func initUI() {
        addSubview(topLabel)
        addSubview(lightImageView)
        addSubview(darkImageView)
        addSubview(lightSelectedImageView)
        addSubview(lightSelectedLabel)
        addSubview(darkSelectedImageView)
        addSubview(darkSelectedLabel)
        addSubview(lightSelectedButton)
        addSubview(darkSelectedButton)
    }
    
    /// 添加控件和设置约束
    private func commonUI() {
        
    }
    
    /// 更新控件的颜色，字体，背景色等等
    private func updateTheme() {
        if currentMode == .light {
            lightSelectedImageView.image = UIImage.tradeValidperiodSelected
            darkSelectedImageView.image = UIImage.tradeValidperiod
        } else {
            lightSelectedImageView.image = UIImage.tradeValidperiod
            darkSelectedImageView.image = UIImage.tradeValidperiodSelected
        }
    }
    
    // MARK: 按钮的点击事件
    @objc func click(sender: UIButton) {
        if sender.tag == 100 {
            lightSelectedImageView.image = UIImage.tradeValidperiodSelected
            darkSelectedImageView.image = UIImage.tradeValidperiod
            selectModeClosure?(.light)
        } else {
            lightSelectedImageView.image = UIImage.tradeValidperiod
            darkSelectedImageView.image = UIImage.tradeValidperiodSelected
            selectModeClosure?(.dark)
        }
    }
    
    /// 更新选择
    func updateSelected() {
        if JKDarkModeUtil.isLight {
            lightSelectedImageView.image = UIImage.tradeValidperiodSelected
            darkSelectedImageView.image = UIImage.tradeValidperiod
        } else {
            lightSelectedImageView.image = UIImage.tradeValidperiod
            darkSelectedImageView.image = UIImage.tradeValidperiodSelected
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if JKDarkModeUtil.isFollowSystem, #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .light {
                lightSelectedImageView.image = UIImage.tradeValidperiodSelected
                darkSelectedImageView.image = UIImage.tradeValidperiod
            } else {
                lightSelectedImageView.image = UIImage.tradeValidperiod
                darkSelectedImageView.image = UIImage.tradeValidperiodSelected
            }
        }
    }
}
