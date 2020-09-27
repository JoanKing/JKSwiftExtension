//
//  SectorProgressView.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/27.
//

import UIKit

/// 一个扇形的进度条
public final class SectorProgressView: UIView {
    public var progress: Double = 0.25 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    public var lineWidth: CGFloat = 1 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    public var lineColor: UIColor = UIColor.white { didSet { configLayer() } }
    public var bgColor: UIColor = UIColor.clear { didSet { configLayer() } }
    public var progressColor = UIColor.white { didSet { configLayer() } }
    public var progressBorderColor = UIColor.clear { didSet { configLayer() } }

    public let lineLayer = CAShapeLayer()

    public let progressLayer = CAShapeLayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    private func makeUI() {
        layer.addSublayer(lineLayer)
        layer.addSublayer(progressLayer)
        configLayer()
    }

    private func configLayer() {
        progressLayer.fillColor = progressColor.withAlphaComponent(0.9).cgColor
        progressLayer.strokeColor = progressBorderColor.withAlphaComponent(0.9).cgColor
        progressLayer.lineWidth = 0
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 1
        
        lineLayer.fillColor = bgColor.cgColor
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.lineWidth = 1
        lineLayer.strokeStart = 0
        lineLayer.strokeEnd = 1
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.size.width
        let height = bounds.size.height
        let lineX = lineWidth / 2
        let lineY = lineWidth / 2
        let circlePath = UIBezierPath(ovalIn: CGRect(x: lineWidth / 2, y: lineWidth / 2, width: width - lineWidth, height: height - lineWidth))
        lineLayer.path = circlePath.cgPath

        let center = CGPoint(x: lineX + width / 2, y: lineY + height / 2)
        let startAngle = -CGFloat(Double.pi * 0.5)
        let endAngle = startAngle + CGFloat(2 * progress * Double.pi)
        let progressPath = UIBezierPath(arcCenter: center, radius: width * 0.5, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressPath.addLine(to: center)
        progressPath.close()
        progressLayer.path = progressPath.cgPath
    }
}
