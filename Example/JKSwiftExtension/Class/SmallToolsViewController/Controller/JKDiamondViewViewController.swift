//
//  JKDiamondViewController.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2025/11/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

class JKDiamondViewViewController: BaseViewController {
    
    let diamond = JKDiamondView()
    let angleSlider = UISlider()
    let cornerSlider = UISlider()
    let angleLabel = UILabel()
    let cornerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的使用"]
        dataArray = [["调节视图"]]
    }
}

// MARK: - 一、基本的工具
extension JKDiamondViewViewController {
    
    // MARK: 1.01、调节视图
    @objc func test101() {
        setupDiamond()
        setupSlidersAndLabels()
        setupConstraints()
    }
}

extension JKDiamondViewViewController {
    
    private func setupDiamond() {
        guard let image = UIImage(named: "ironman") else {
            return
        }
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 44))
        imageView2.image = image
        imageView2.clipsToBounds = true
        imageView2.contentMode = .scaleAspectFill
        
        diamond.translatesAutoresizingMaskIntoConstraints = false
        diamond.fillColor = .red
        diamond.strokeColor = UIColor.hexStringColor(hexString: "#426BF1")
        diamond.lineWidth = 3
        diamond.angleDegrees = 60
        // diamond.cornerRadius = 12 // 默认圆角
        diamond.cornerRadii = JKCornerRadii(topLeft: 10, bottomLeft: 25, bottomRight: 10, topRight: 25)
        
        // diamond.addSubview(imageView2)
        // 置背景图片
        diamond.backgroundImageView.image = image
        diamond.backgroundImageView.contentMode = .scaleAspectFill
        
        diamond.jk.addTapGestureRecognizerAction(self, #selector(testHa))
        
        view.addSubview(diamond)
        
        let imageView3 = UIImageView()
        imageView3.image = UIImage(named: "angle")
        diamond.addSubview(imageView3)
        
        let angele_right = UIImageView()
        angele_right.image = UIImage(named: "angele_right")
        imageView3.addSubview(angele_right)
        
        imageView3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(7)
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSizeMake(27, 18))
        }
        
        angele_right.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSizeMake(13, 8.5))
        }
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 120, height: 44))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        
        JKAsyncs.asyncDelay(3) {
        } _: {[weak self] in
            guard let self else { return }
            diamond.backgroundImageView.image =  UIImage(named: "pet_bg")
            imageView.image = image
            JKAsyncs.asyncDelay(3) {
            } _: {[weak self] in
                guard let self else { return }
                diamond.backgroundImageView.image = nil
                // 方式2：使用渐变色填充（会覆盖 fillColor）
                diamond.gradientColors = [.red, .orange, .yellow]
                
                // 自定义渐变方向（从左到右）
                diamond.gradientStartPoint = CGPoint(x: 0, y: 0.5)
                diamond.gradientEndPoint = CGPoint(x: 1, y: 0.5)
                
                // 自定义渐变位置（可选）
                diamond.gradientLocations = [0, 0.5, 1.0]  // 红色在0%，橙色在50%，黄色在100%
                JKAsyncs.asyncDelay(3) {
                } _: {[weak self] in
                    guard let self else { return }
                    // 方式2：使用渐变色填充（会覆盖 fillColor）
                    diamond.gradientColors = nil
                    
                }
            }
        }
    }
    
    @objc func testHa() {
        debugPrint("菱形点击")
    }
    
    private func setupSlidersAndLabels() {
        angleSlider.translatesAutoresizingMaskIntoConstraints = false
        angleSlider.minimumValue = 10
        angleSlider.maximumValue = 170
        angleSlider.value = Float(diamond.angleDegrees)
        angleSlider.addTarget(self, action: #selector(angleChanged(_:)), for: .valueChanged)
        view.addSubview(angleSlider)
        
        cornerSlider.translatesAutoresizingMaskIntoConstraints = false
        cornerSlider.minimumValue = 0
        cornerSlider.maximumValue = 60
        cornerSlider.value = Float(diamond.cornerRadius)
        cornerSlider.addTarget(self, action: #selector(cornerChanged(_:)), for: .valueChanged)
        view.addSubview(cornerSlider)
        
        angleLabel.translatesAutoresizingMaskIntoConstraints = false
        angleLabel.textAlignment = .center
        angleLabel.text = "\(Int(diamond.angleDegrees))°"
        view.addSubview(angleLabel)
        
        cornerLabel.translatesAutoresizingMaskIntoConstraints = false
        cornerLabel.textAlignment = .center
        cornerLabel.text = "r \(Int(diamond.cornerRadius))"
        view.addSubview(cornerLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            diamond.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diamond.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            diamond.widthAnchor.constraint(equalToConstant: 120),
            diamond.heightAnchor.constraint(equalToConstant: 44),
            
            angleSlider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            angleSlider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            angleSlider.topAnchor.constraint(equalTo: diamond.bottomAnchor, constant: 24),
            
            angleLabel.topAnchor.constraint(equalTo: angleSlider.bottomAnchor, constant: 8),
            angleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cornerSlider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cornerSlider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            cornerSlider.topAnchor.constraint(equalTo: angleLabel.bottomAnchor, constant: 12),
            
            cornerLabel.topAnchor.constraint(equalTo: cornerSlider.bottomAnchor, constant: 8),
            cornerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func angleChanged(_ s: UISlider) {
        let deg = CGFloat(s.value)
        angleLabel.text = "\(Int(deg))°"
        diamond.angleDegrees = deg
        diamond.updatePath(animated: true, animationDuration: 0.18)
    }
    
    @objc private func cornerChanged(_ s: UISlider) {
        let r = CGFloat(s.value)
        cornerLabel.text = "r \(Int(r))"
        diamond.cornerRadius = r
        diamond.updatePath(animated: true, animationDuration: 0.18)
    }
}
