//
//  JKImageButtonViewController.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

class JKImageButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageButtons()
    }
    
    private func setupImageButtons() {
        view.backgroundColor = .systemBackground
        
        // 图片在左侧的按钮
        let leftButton = JKImageButton(position: .left, spacing: 8)
        leftButton.setTitle("左侧图标", for: .normal)
        leftButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        leftButton.setTitleColor(.systemBlue, for: .normal)
        leftButton.tintColor = .systemRed
        leftButton.backgroundColor = .systemGray6
        leftButton.layer.cornerRadius = 8
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftButton)
        
        // 图片在上方的按钮
        let topButton = JKImageButton(position: .top, spacing: 12)
        topButton.setTitle("上方图标", for: .normal)
        topButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        topButton.setTitleColor(.systemBlue, for: .normal)
        topButton.tintColor = .systemYellow
        topButton.backgroundColor = .systemGray6
        topButton.layer.cornerRadius = 8
        topButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topButton)
        
        // 图片在右侧的按钮
        let rightButton = JKImageButton(position: .right, spacing: 10)
        rightButton.setTitle("右侧图标", for: .normal)
        rightButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        rightButton.setTitleColor(.systemBlue, for: .normal)
        rightButton.tintColor = .systemGreen
        rightButton.backgroundColor = .systemGray6
        rightButton.layer.cornerRadius = 8
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightButton)
        
        // 图片在下方的按钮
        let bottomButton = JKImageButton(position: .bottom, spacing: 8)
        bottomButton.setTitle("下方图标", for: .normal)
        bottomButton.setImage(UIImage(systemName: "gear.circle.fill"), for: .normal)
        bottomButton.setTitleColor(.systemBlue, for: .normal)
        bottomButton.tintColor = .systemPurple
        bottomButton.backgroundColor = .systemGray6
        bottomButton.layer.cornerRadius = 8
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomButton)
        
        // 添加点击事件
        leftButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        topButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        bottomButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        // 设置约束
        NSLayoutConstraint.activate([
            // 左侧按钮
            leftButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leftButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            leftButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 上方按钮
            topButton.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 30),
            topButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topButton.widthAnchor.constraint(equalToConstant: 120),
            topButton.heightAnchor.constraint(equalToConstant: 80),
            
            // 右侧按钮
            rightButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 30),
            rightButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rightButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 下方按钮
            bottomButton.topAnchor.constraint(equalTo: rightButton.bottomAnchor, constant: 30),
            bottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomButton.widthAnchor.constraint(equalToConstant: 120),
            bottomButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc private func buttonTapped(_ sender: JKImageButton) {
        var message = ""
        switch sender.imagePosition {
        case .left:
            message = "点击了左侧图标按钮"
        case .top:
            message = "点击了上方图标按钮"
        case .right:
            message = "点击了右侧图标按钮"
        case .bottom:
            message = "点击了下方图标按钮"
        }
        
        let alert = UIAlertController(title: "按钮点击", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
}

