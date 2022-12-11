//
//  JKCircleProgressView.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2022/12/8.
//
import Foundation
import UIKit

public class JKCircleProgressView: UIView {
    /// 进度条宽度
    public var lineWidth: CGFloat = 10
    /// 进度槽颜色
    public var trackColor = UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0,
        alpha: 1)
    /// 进度条颜色
    public var progressColoar = UIColor.orange
    /// 当前进度
    public var progress: Int {
        return currentProgress
    }
    private var currentProgress: Int = 0
    /// 进度槽
    private let trackLayer = CAShapeLayer()
    /// 进度条
    private let progressLayer = CAShapeLayer()
    /// 进度条路径（整个圆圈）
    private let path = UIBezierPath()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
     
    public override func draw(_ rect: CGRect) {
        // 获取整个进度条圆圈路径
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: bounds.size.width / 2 - lineWidth,
            startAngle: angleToRadian(-90), endAngle: angleToRadian(270), clockwise: true)
        // 绘制进度槽
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.path = path.cgPath
        layer.addSublayer(trackLayer)
        // 绘制进度条
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColoar.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = CGFloat(currentProgress) / 200.0
        layer.addSublayer(progressLayer)
    }
     
    /// 设置进度（可以设置是否播放动画，以及动画时间）
    public func setProgress(_ pro: Int, animated anim: Bool, withDuration duration: Double = 0.5) {
        if pro > 100 {
            currentProgress = 100
        } else if pro < 0 {
            currentProgress = 0
        } else {
            currentProgress = pro
        }
        // 进度条动画
        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = CGFloat(currentProgress) / 200.0
        CATransaction.commit()
    }
}

//MARK: -private
extension JKCircleProgressView {
    /// 将角度转为弧度
    fileprivate func angleToRadian(_ angle: Double)->CGFloat {
        return CGFloat(angle / Double(180.0) * Double.pi)
    }
}
