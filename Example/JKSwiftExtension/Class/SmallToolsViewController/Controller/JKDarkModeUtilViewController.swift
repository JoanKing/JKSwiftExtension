//
//  JKDarkModeUtilViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/7/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class JKDarkModeUtilViewController: UIViewController {
    
    lazy var label1: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 150, width: 100, height: 50))
        label.text = JKDarkModeUtil.isLight ? "浅色模式" : "深色模式"
        label.backgroundColor = .randomColor
        return label
    }()
    
    lazy var switch1: UISwitch = {
        var testSwitch = UISwitch(frame: CGRect(x: label1.jk.right + 20, y: 0, width: 100, height: 50))
        testSwitch.jk.centerY = label1.jk.centerY
        testSwitch.isOn = !JKDarkModeUtil.isLight
        testSwitch.addTarget(self, action: #selector(switchClick1), for: .touchUpInside)
        return testSwitch
    }()
    
    lazy var label2: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: label1.jk.bottom + 20, width: 100, height: 50))
        label.text = "跟随系统"
        label.backgroundColor = .randomColor
        return label
    }()
    
    lazy var switch2: UISwitch = {
        var testSwitch = UISwitch(frame: CGRect(x: label2.jk.right + 20, y: 0, width: 100, height: 50))
        testSwitch.isOn = JKDarkModeUtil.isFloorSystem
        testSwitch.jk.centerY = label2.jk.centerY
        testSwitch.addTarget(self, action: #selector(switchClick2), for: .touchUpInside)
        return testSwitch
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: label2.jk.bottom + 50, width: 100, height: 50))
        button.setTitle("边框", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.darkModeColor(lightColor: .green, darkColor: .brown).cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "暗黑模式适配"
        self.view.backgroundColor = JKDarkModeUtil.colorLightDark(light: UIColor.yellow, dark: UIColor.green)
        
        initUI()
    }
    
    /// 创建控件
    private func initUI() {
        self.view.addSubview(label1)
        self.view.addSubview(switch1)
        
        self.view.addSubview(label2)
        self.view.addSubview(switch2)
        
        self.view.addSubview(button)
        
        label1.isHidden = JKDarkModeUtil.isFloorSystem
        switch1.isHidden = JKDarkModeUtil.isFloorSystem
        if #available(iOS 13.0, *) {
            // 获取当前模式
            let currentMode = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle
            if (currentMode == .dark) {
                print("window模式---深色模式")
            } else if (currentMode == .light) {
                print("window模式---浅色模式")
            } else {
                print("window模式---未知模式")
            }
        }
        
        themeProvider.register(observer: self)
    }
}

extension JKDarkModeUtilViewController {
    
    @objc func switchClick1(sender: UISwitch) {
        // print("开关的状态：\(sender.isOn)")
        
        JKDarkModeUtil.setDarkModeCustom(isLight: !sender.isOn)
        if (sender.isOn) {
            label1.text = "黑暗模式"
        } else {
            label1.text = "浅色模式"
        }
    }
    
    @objc func switchClick2(sender: UISwitch) {
        print(sender.isOn)
        JKDarkModeUtil.setDarkModeFollowSystem(isFollowSystem: sender.isOn)
        label1.isHidden = sender.isOn
        switch1.isHidden = sender.isOn
        switch1.setOn(!JKDarkModeUtil.isLight, animated: false)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            print("模式：\(UITraitCollection.current.userInterfaceStyle.rawValue)")
        }
        button.layer.borderColor = JKDarkModeUtil.colorLightDark(light: .green, dark: .brown).cgColor
    }
}

// MARK:- iOS 13 以下主题色的更新
extension JKDarkModeUtilViewController: JKThemeable {
    func apply() {
        self.view.backgroundColor = JKDarkModeUtil.colorLightDark(light: UIColor.yellow, dark: UIColor.green)
    }
}
