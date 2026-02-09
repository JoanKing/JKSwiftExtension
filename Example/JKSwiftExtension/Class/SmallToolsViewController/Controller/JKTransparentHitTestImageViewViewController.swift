//
//  UIImageAlphaViewController.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2025/12/8.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class JKTransparentHitTestImageViewViewController: UIViewController {

    private lazy var imageView: JKTransparentHitTestImageView = {
        let rabbitImageView = JKTransparentHitTestImageView()
        // rabbitImageView.backgroundColor = .randomColor
        rabbitImageView.contentMode = .scaleAspectFit
        rabbitImageView.isUserInteractionEnabled = true
        rabbitImageView.image = UIImage(named: "rabbit")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        rabbitImageView.addGestureRecognizer(tap)
        return rabbitImageView
    }()

    private lazy var imageView2: JKTransparentHitTestImageView = {
        let oxImageView = JKTransparentHitTestImageView()
        //  oxImageView.backgroundColor = .randomColor
        oxImageView.contentMode = .scaleAspectFit
        oxImageView.clipsToBounds = true
        oxImageView.isUserInteractionEnabled = true
        oxImageView.image = UIImage(named: "ox")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTap2))
        oxImageView.addGestureRecognizer(tap)
        return oxImageView
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        let desc = """
      一个会根据图片局部透明度决定是否响应点击事件的 `UIImageView`。
      功能概述:
      重写 `point(inside:with:)`，在命中测试阶段，根据触摸点对应像素的 alpha 值决定是否视为命中。
      - 仅当该点对应的像素透明度大于 `alphaThreshold` 时才返回 `true`。
      - 支持多种 `contentMode`，会将视图坐标准确映射到图片坐标再进行采样。
      - 使用场景:
      - 带有透明区域的 PNG 图片（例如不规则形状的按钮、icon 等），
      希望“透明区域不响应点击，非透明区域才响应点击”。
      """
        let attributedString = NSMutableAttributedString(string: desc).color(.black).font(12)
        label.attributedText = attributedString
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(imageView2)
        view.addSubview(descLabel)
        
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(50)
            make.size.equalTo(CGSizeMake(200, 200))
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.centerY)
            make.left.equalTo(imageView.snp.centerX)
            make.size.equalTo(CGSizeMake(100, 100))
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

    }

    @objc private func handleImageTap(_ gesture: UITapGestureRecognizer) {
        debugPrint("点击了【兔子】非透明区域，触发了 imageView 的点击事件")
    }
    
    @objc private func handleImageTap2(_ gesture: UITapGestureRecognizer) {
        debugPrint("点击了【牛牛】非透明区域，触发了 imageView 的点击事件")
    }
}
