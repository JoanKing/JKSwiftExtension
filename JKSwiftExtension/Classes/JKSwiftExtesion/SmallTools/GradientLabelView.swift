//
//  GradientLabelView.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/25.
//

import UIKit
import SnapKit

// MARK:-  利用layer的mask属性做的渐变色labelView
public class GradientLabelView: UIView {
    private let gradientLayer = CAGradientLayer()
    public let label = UILabel()
    private let innerLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        addSubview(label)
        addSubview(innerLabel)
        innerLabel.isHidden = true
        
        innerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        label.frame = bounds
    }
    
    // MARK: 设置label字体以及渐变颜色
    @discardableResult
    /// 设置label字体以及渐变颜色
    ///
    /// - Parameters:
    ///   - text: 文字字体 要求是 NSAttributedString
    ///   - colors: 渐变色数组
    ///   - startEnd: 渐变色的变化范围
    ///   - locations:  (I.e. [0,0] is the bottom-left
    ///   corner of the layer, [1,1] is the top-right corner.) The default values
    ///   are [.5,0] and [.5,1] respectively. Both are animatable. */
    /// - Returns: view本身方便使用链式语法
    public func gradient(text: NSAttributedString? = nil,
                       colors: [UIColor]? = nil,
                     startEnd: (CGPoint, CGPoint)? = (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1)),
                  locations _: [NSNumber]? = nil) -> Self {
        label.attributedText = text
        innerLabel.attributedText = text
        guard let aColors = colors?.map({ $0.cgColor }), !aColors.isEmpty else {
            return self
        }
        gradientLayer.colors = aColors
        
        if let se = startEnd {
            gradientLayer.startPoint = se.0
            gradientLayer.endPoint = se.1
        }
        gradientLayer.mask = label.layer
        setNeedsLayout()
        layoutIfNeeded()
        return self
    }
}

