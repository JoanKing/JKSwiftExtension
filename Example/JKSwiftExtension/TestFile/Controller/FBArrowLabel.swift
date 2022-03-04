//
//  FBArrowLabel.swift
//  FutureBull
//
//  Created by IronMan on 2021/3/5.
//  Copyright © 2021 wuyanwei. All rights reserved.
//

// MARK: - 带箭头的Label
import UIKit
/*
 支持的配置化属性：
 
 1.箭头的大小和位置
 2.边框圆角、宽度、颜色和阴影
 3.文本内容的配置
 */
public class FBArrowLabel: UIView {
    /// 箭头位置
    public enum ArrowPosition {
        /// 底部
        case bottom
        /// 头部
        case top
        /// 左侧
        case left
        /// 右侧
        case right
    }

    /// 圆角尺寸
    public struct CornerSize {
        var topLeft: CGFloat
        var topRight: CGFloat
        var bottomLeft: CGFloat
        var bottomRight: CGFloat

        init(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
            self.topLeft     = topLeft
            self.topRight    = topRight
            self.bottomLeft  = bottomLeft
            self.bottomRight = bottomRight
        }
    }
    
    // MARK: 箭头相关的属性
    
    /// 箭头位置，默认箭头在底部
    public var arrowPosition: ArrowPosition = .bottom
    /// 箭头大小，默认(6, 14)【箭头高度，箭头宽度】，支持设置为(0, 0)
    public var arrowSize: (CGFloat, CGFloat) = (6, 14)
    /// 箭头偏移量，默认0（水平方向箭头，从左边开始计算，垂直方向箭头，则从上边开始计算），用UInt，避免做负值的判断
    public var arrowOffset: UInt = 0
    
    // MARK: 圆角相关的属性
        
    /// 圆角值（四个角的圆角一样的话，使用这个值），默认为 nil
    public var cornerRadius: CGFloat?
    /// 四个角圆角值，默认都是0
    public var cornerSize: CornerSize = CornerSize(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
    
    // MARK: 带三角的layer相关的属性
    
    /// 填充颜色，默认白色
    public var fillColor: UIColor = .white
    /// 线条颜色，默认淡灰
    public var strokeColor: UIColor = .lightGray
    /// 线条宽度，默认 1
    public var lineWidth: CGFloat = 1
    
    // MARK: 文本相关的属性
    
    /// 文本偏移（默认，上下左右的偏移均为 0）
    public var textOffset: UIEdgeInsets = .zero
    /// 文本颜色，默认淡灰
    public var textColor: UIColor = .lightGray
    /// 对齐方式，默认居左
    public var textAlignment: NSTextAlignment = .left
    /// 文本行数，默认多行自适应
    public var textNumberOfLines: Int = 0
    /// 文本字体，默认系统12号字体
    public var textFont: UIFont = UIFont.systemFont(ofSize: 12)
    
    // MARK: 阴影相关的属性
    
    /// 是否需要阴影，默认不需要
    public var isNeedShadow: Bool = false
    /// 阴影质量，默认1
    public var shadowOpacity: Float = 1
    /// 阴影颜色，默认淡灰
    public var shadowColor: UIColor = .lightGray
    /// 阴影圆角，默认6
    public var shadowRadius: CGFloat = 6
    /// 阴影偏移量，默认(0, 2)
    public var shadowOffset: CGSize = CGSize(width: 0, height: 2)
    
    /// 箭头开始的位置，默认0（水平方向箭头，从左边开始计算，垂直方向箭头，则从上边开始计算）
    private lazy var arrowStartPosition: CGFloat = CGFloat(arrowOffset)
    
    /// 容器
    private var contentView: UIView = UIView()
    /// 文本内容
    lazy var lblTips: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.backgroundColor = .blue
        return label
    }()
    /// layer
    private var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI
private extension FBArrowLabel {
    /// 设置UI
    func setupUI() {
        addSubview(contentView)
        contentView.layer.addSublayer(shapeLayer)
        contentView.addSubview(lblTips)
        
        layoutViews()
    }
    
    /// 布局
    func layoutViews() {
        contentView.backgroundColor = .red
        contentView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(lblTips.snp.bottom).offset(arrowSize.0 - textOffset.bottom)
        }
        
        lblTips.snp.makeConstraints {
            $0.top.equalToSuperview().offset(textOffset.top)
            $0.left.equalToSuperview().offset(textOffset.left)
            $0.right.equalToSuperview().offset(textOffset.right)
            $0.bottom.equalToSuperview().offset(-arrowSize.0)
        }
    }
    
    /// 配置 shapeLayer
    func configShapeLayer() {
        // 需要拿到具体bounds，才能画圆角
        layoutIfNeeded()
        
        if let radius = cornerRadius {
            cornerSize = CornerSize(topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius)
        }
        
        var borderBounds = contentView.bounds
        switch arrowPosition {
        case .top, .bottom:
            borderBounds.size.height -= arrowSize.0
        case .left, .right:
            borderBounds.size.width -= arrowSize.0
        }
        
        let path = fetchPathWithRect(bounds: borderBounds)
        
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = path.cgPath
        
        // 需要阴影的话
        if isNeedShadow {
            shapeLayer.shadowPath    = path.cgPath
            shapeLayer.shadowOpacity = shadowOpacity
            shapeLayer.shadowColor   = shadowColor.cgColor
            shapeLayer.shadowRadius  = shadowRadius
            shapeLayer.shadowOffset  = shadowOffset
        }
    }
}

// MARK: public method
public extension FBArrowLabel {
    /// 设置文本
    /// - Parameter text: 文本
    func setupText(_ text: String) {
        lblTips.text = text
        
        configView()
    }
    
    // TODO: 这个有个问题，设置了富文本之后，再设置普通文本，自适应不生效，暂时不知道什么原因 @山竹
    
    /// 设置富文本
    /// - Parameter text: 文本
    func setupAttributeText(_ attributeText: NSAttributedString) {
        lblTips.attributedText = attributeText
        
        configView()
    }
}

// MARK: private method
private extension FBArrowLabel {
    /// 配置view
    func configView() {
        updateTextProperty()
        updateSubViewConstraints()
        configShapeLayer()
    }
    
    /// 根据配置更新约束
    func updateSubViewConstraints() {
        contentView.snp.updateConstraints {
            $0.top.equalToSuperview().offset(arrowPosition == .top ? arrowSize.0 + textOffset.top : 0)
            $0.left.equalToSuperview().offset(arrowPosition == .left ? arrowSize.0 + textOffset.left : 0)
            $0.right.equalToSuperview().offset(arrowPosition == .right ? -arrowSize.0 + textOffset.right : 0)
            $0.bottom.equalTo(lblTips.snp.bottom).offset(arrowPosition == .bottom ? arrowSize.0 - textOffset.bottom : -textOffset.bottom)
            
            // $0.top.equalTo(lblTips.snp.top).offset(arrowPosition == .bottom ? arrowSize.0 - textOffset.top : -textOffset.top)
            // $0.bottom.equalToSuperview().offset(arrowPosition == .top ? arrowSize.0 + textOffset.top : 0)
        }
        
        lblTips.snp.updateConstraints {
            $0.top.equalToSuperview().offset(arrowPosition == .top ? arrowSize.0 + textOffset.top : textOffset.top)
            $0.left.equalToSuperview().offset(arrowPosition == .left ? arrowSize.0 + textOffset.left : textOffset.left)
            $0.right.equalToSuperview().offset(arrowPosition == .right ? -arrowSize.0 + textOffset.right : textOffset.right)
            $0.bottom.equalToSuperview().offset(arrowPosition == .bottom ? -arrowSize.0 + textOffset.bottom : textOffset.bottom)
        }
    }
    
    /// 更新文本属性
    func updateTextProperty() {
        lblTips.font          = textFont
        lblTips.textColor     = textColor
        lblTips.textAlignment = textAlignment
        lblTips.numberOfLines = textNumberOfLines
    }
    
    /// 根据contentView的bounds及配置属性画出贝泽尔曲线
    /// - Parameter bounds: contentView的bounds
    /// - Returns: 贝泽尔曲线
    func fetchPathWithRect(bounds: CGRect) -> UIBezierPath {
        let minX = bounds.minX + (arrowPosition == .left ? arrowSize.0 : 0)
        let minY = bounds.minY + (arrowPosition == .top ? arrowSize.0 : 0)
        let maxX = bounds.maxX + (arrowPosition == .left ? arrowSize.0 : 0)
        let maxY = bounds.maxY + (arrowPosition == .top ? arrowSize.0 : 0)
        
        calculateCorrectArrowStartPosition(maxX: maxX, maxY: maxY)

        // 左上圆心
        let topLeftCenterPoint = CGPoint(x: minX + cornerSize.topLeft,
                                         y: minY + cornerSize.topLeft)
        
        // 左下圆心
        let bottomLeftCenterPoint = CGPoint(x: minX + cornerSize.bottomLeft,
                                            y: maxY - cornerSize.bottomLeft)

        // 右上圆心
        let topRightCenterPoint = CGPoint(x: maxX - cornerSize.topRight,
                                          y: minY + cornerSize.topRight)
        
        // 右下圆心
        let bottomRightCenterPoint = CGPoint(x: maxX - cornerSize.bottomRight,
                                             y: maxY - cornerSize.bottomRight)

        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: topLeftCenterPoint.x, y: minY))
        // 左上圆角
        path.addArc(withCenter: CGPoint(x: topLeftCenterPoint.x, y: topLeftCenterPoint.y), radius: cornerSize.topLeft, startAngle: CGFloat.pi / 2 * 3, endAngle: CGFloat.pi, clockwise: false)
        
        // 左边箭头
        if arrowPosition == .left {
            path.addLine(to: CGPoint(x: minX, y: topLeftCenterPoint.y + arrowStartPosition))
            path.addLine(to: CGPoint(x: minX - arrowSize.0, y: topLeftCenterPoint.y + arrowStartPosition + arrowSize.1 / 2))
            path.addLine(to: CGPoint(x: minX, y: topLeftCenterPoint.y + arrowStartPosition + arrowSize.1))
        }
        
        path.addLine(to: CGPoint(x: minX, y: bottomLeftCenterPoint.y))
        // 左下圆角
        path.addArc(withCenter: CGPoint(x: bottomLeftCenterPoint.x, y: bottomLeftCenterPoint.y), radius: cornerSize.bottomLeft, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)
        
        // 底部箭头
        if arrowPosition == .bottom {
            path.addLine(to: CGPoint(x: bottomLeftCenterPoint.x + arrowStartPosition, y: maxY))
            path.addLine(to: CGPoint(x: bottomLeftCenterPoint.x + arrowStartPosition + arrowSize.1 / 2, y: maxY + arrowSize.0))
            path.addLine(to: CGPoint(x: bottomLeftCenterPoint.x + arrowStartPosition + arrowSize.1, y: maxY))
        }
        
        path.addLine(to: CGPoint(x: bottomRightCenterPoint.x, y: maxY))
        // 右下圆角
        path.addArc(withCenter: CGPoint(x: bottomRightCenterPoint.x, y: bottomRightCenterPoint.y), radius: cornerSize.bottomRight, startAngle: CGFloat.pi / 2, endAngle: 0, clockwise: false)
        
        // 右侧箭头
        if arrowPosition == .right {
            path.addLine(to: CGPoint(x: maxX, y: topRightCenterPoint.y + arrowStartPosition + arrowSize.1))
            path.addLine(to: CGPoint(x: maxX + arrowSize.0, y: topRightCenterPoint.y + arrowStartPosition + arrowSize.1 / 2))
            path.addLine(to: CGPoint(x: maxX, y: topRightCenterPoint.y + arrowStartPosition))
        }
        
        path.addLine(to: CGPoint(x: maxX, y: topRightCenterPoint.y))
        // 右上圆角
        path.addArc(withCenter: CGPoint(x: topRightCenterPoint.x, y: topRightCenterPoint.y), radius: cornerSize.topRight, startAngle: 0, endAngle: CGFloat.pi / 2 * 3, clockwise: false)
        
        // 顶部箭头
        if arrowPosition == .top {
            path.addLine(to: CGPoint(x: arrowStartPosition + bottomLeftCenterPoint.x + arrowSize.1, y: minY))
            path.addLine(to: CGPoint(x: arrowStartPosition + bottomLeftCenterPoint.x + arrowSize.1 / 2, y: minY - arrowSize.0))
            path.addLine(to: CGPoint(x: arrowStartPosition + bottomLeftCenterPoint.x, y: minY))
        }
        
        path.close()
        
        return path
    }
    
    /// 计算正确的开始箭头偏移值
    /// - Parameters:
    ///   - maxX: 最大x值
    ///   - maxY: 最大y值
    func calculateCorrectArrowStartPosition(maxX: CGFloat, maxY: CGFloat) {
        switch arrowPosition {
        case .bottom:
            if arrowStartPosition > maxX - cornerSize.bottomLeft - cornerSize.bottomRight - arrowSize.1 {
                arrowStartPosition = maxX - cornerSize.bottomLeft - cornerSize.bottomRight - arrowSize.1
            }
        case .top:
            if arrowStartPosition > maxX - cornerSize.topLeft - cornerSize.topRight - arrowSize.1 {
                arrowStartPosition = maxX - cornerSize.topLeft - cornerSize.topRight - arrowSize.1
            }
        case .left:
            if arrowStartPosition > maxY - cornerSize.topLeft - cornerSize.bottomLeft - arrowSize.1 {
                arrowStartPosition = maxY - cornerSize.topLeft - cornerSize.bottomLeft - arrowSize.1
            }
        case .right:
            if arrowStartPosition > maxY - cornerSize.topRight - cornerSize.bottomRight - arrowSize.1 {
                arrowStartPosition = maxY - cornerSize.topRight - cornerSize.bottomRight - arrowSize.1
            }
        }
    }
}
