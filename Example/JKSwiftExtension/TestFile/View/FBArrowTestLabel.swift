//
//  FBArrowTestLabel.swift
//  FutureBull
//
//  Created by IronMan on 2021/3/8.
//  Copyright © 2021 wuyanwei. All rights reserved.
//

import UIKit

class FBArrowTestLabel: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        commonUI()
        updateTheme()
    }
    
    /// 箭头背景框
    lazy var arrowBgView: UIView = {
        let label = UIView()
        label.layer.cornerRadius = 3
        label.clipsToBounds = false
        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    /// layer
    private var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    /// 文字内容
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创建控件
    private func initUI() {
        self.backgroundColor = .clear
        /**
         箭头的中中垂线的高度 6
         箭头底边的宽度 13
         内容的边距：上边 6 左边 10 下边 6 右边 10
         整体的高度：6 + 文本高度 + 6 + 箭头的中垂线6
         整体的宽度：10 + 文本宽度 + 10
         */
        self.addSubview(arrowBgView)
        arrowBgView.layer.addSublayer(shapeLayer)
        arrowBgView.addSubview(contentLabel)
    }
    
    /// 添加控件和设置约束
    private func commonUI() {
        arrowBgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10))
        }
    }
    
    /// 更新控件的颜色，字体，背景色等等
    private func updateTheme() {
        
        // 画三角
        let trianglePath = UIBezierPath()
        var point = CGPoint(x: 16, y: self.jk.height - 6)
        trianglePath.move(to: point)
        point = CGPoint(x: 22.5, y: self.jk.height)
        trianglePath.addLine(to: point)
        point = CGPoint(x: 29, y: self.jk.height - 6)
        trianglePath.addLine(to: point)
        trianglePath.close()
        
        shapeLayer.path = trianglePath.cgPath
        shapeLayer.fillColor = UIColor.yellow.cgColor
        arrowBgView.layer.addSublayer(shapeLayer)
        
    }
    
    func changeHeight() {
        updateTheme()
    }
}
