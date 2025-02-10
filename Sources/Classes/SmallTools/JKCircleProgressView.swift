//
//  JKCircleProgressView.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2022/12/8.
//
import UIKit

public class JKCircleProgressView: UIView {
    // MARK: - Properties
    public var lineWidth: CGFloat = 10 {
        didSet {
            updatePath()
        }
    }

    public var trackColor = UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1) {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }

    public var progressColor = UIColor.orange {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }

    public var progress: Int {
        get { return currentProgress }
        set { setProgress(newValue, animated: false) }
    }

    private var currentProgress: Int = 0

    // MARK: - Layers
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
    }

    // MARK: - Layer Setup
    private func setupLayers() {
        // 设置进度槽
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)

        // 设置进度条
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)

        updatePath()
    }

    // MARK: - Path Update
    private func updatePath() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.size.width, bounds.size.height) / 2 - lineWidth / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: angleToRadian(-90), endAngle: angleToRadian(270), clockwise: true)

        trackLayer.path = path.cgPath
        trackLayer.lineWidth = lineWidth // 确保在这里也设置了lineWidth
        progressLayer.path = path.cgPath
        progressLayer.lineWidth = lineWidth // 确保在这里也设置了lineWidth
    }

    // MARK: - Progress Update
    public func setProgress(_ pro: Int, animated anim: Bool = false, withDuration duration: Double = 0.5) {
        currentProgress = max(0, min(pro, 100))

        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = CGFloat(currentProgress) / 100.0
        CATransaction.commit()
    }

    // MARK: - Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }

    // MARK: - Helper
    private func angleToRadian(_ angle: Double) -> CGFloat {
        return CGFloat(angle / 180.0 * Double.pi)
    }
}
