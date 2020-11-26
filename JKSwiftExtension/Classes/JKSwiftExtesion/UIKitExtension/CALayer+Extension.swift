//
//  CALayer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

// MARK:- 一、自定义链式编程
public extension CALayer {
    
    // MARK: 1.1、设置圆角
    /// 设置圆角
    /// - Parameter cornerRadius: 圆角
    /// - Returns: 返回自身
    @discardableResult
    func corner(_ cornerRadius: CGFloat) -> Self {
        self.cornerRadius = cornerRadius
        masksToBounds = true
        return self
    }
    
    // MARK: 1.2、设置背景色
    /// 设置背景色
    /// - Parameter color: 背景色
    /// - Returns: 返回自身
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color.cgColor
        return self
    }
    
    // MARK: 1.3、设置背景色 (十六进制字符串)
    /// 设置背景色 (十六进制字符串)
    /// - Parameter hex: 背景色 (十六进制字符串)
    /// - Returns: 返回自身
    @discardableResult
    func backgroundColor(_ hex: String) -> Self {
        backgroundColor = UIColor.hexStringColor(hexString: hex).cgColor
        return self
    }
    
    // MARK: 1.4、设置frame
    /// 设置frame
    /// - Parameter frame: frame
    /// - Returns: 返回自身
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    // MARK: 1.5、添加到父视图(UIView)
    /// 添加到父视图
    /// - Parameter superView: 父视图(UIView)
    /// - Returns: 返回自身
    @discardableResult
    func addTo(_ superView: UIView) -> Self {
        superView.layer.addSublayer(self)
        return self
    }
    
    // MARK: 1.6、添加到父视图(CALayer)
    /// 添加到父视图(CALayer)
    /// - Parameter superLayer: 父视图(CALayer)
    /// - Returns: 返回自身
    @discardableResult
    func addTo(_ superLayer: CALayer) -> Self {
        superLayer.addSublayer(self)
        return self
    }
    
    // MARK: 1.7、是否隐藏
    /// 是否隐藏
    /// - Parameter isHidden: 是否隐藏
    /// - Returns: 返回自身
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    // MARK: 1.8、设置边框宽度
    /// 设置边框宽度
    /// - Parameter width: 边框宽度
    /// - Returns: 返回自身
    @discardableResult
    func borderWidth(_ width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }
    
    // MARK: 1.9、设置边框颜色
    /// 设置边框颜色
    /// - Parameter color: 边框颜色
    /// - Returns: 返回自身
    @discardableResult
    func borderColor(_ color: UIColor) -> Self {
        self.borderColor = color.cgColor
        return self
    }
    
    // MARK: 1.10、是否开启光栅化
    /// 是否开启光栅化
    /// - Parameter rasterize: 是否开启光栅化
    /// - Returns: 返回自身
    @discardableResult
    func shouldRasterize(_ rasterize: Bool) -> Self {
        self.shouldRasterize = rasterize
        return self
    }
    
    // MARK: 1.11、设置光栅化比例
    /// 设置光栅化比例
    /// - Parameter scale: 光栅化比例
    /// - Returns: 返回自身
    @discardableResult
    func rasterizationScale(_ scale: CGFloat) -> Self {
        self.rasterizationScale = scale
        self.shouldRasterize = true
        return self
    }
    
    // MARK: 1.12、设置阴影颜色
    /// 设置阴影颜色
    /// - Parameter color: 阴影颜色
    /// - Returns: 返回自身
    @discardableResult
    func shadowColor(_ color: UIColor) -> Self {
        self.shadowColor = color.cgColor
        return self
    }
    
    // MARK: 1.13、设置阴影的透明度，取值范围：0~1
    /// 设置阴影的透明度，取值范围：0~1
    /// - Parameter opacity: 阴影的透明度
    /// - Returns: 返回自身
    @discardableResult
    func shadowOpacity(_ opacity: Float) -> Self {
        self.shadowOpacity = opacity
        return self
    }
    
    // MARK: 1.14、设置阴影的偏移量
    /// 设置阴影的偏移量
    /// - Parameter offset: 偏移量
    /// - Returns: 返回自身
    @discardableResult
    func shadowOffset(_ offset: CGSize) -> Self {
        self.shadowOffset = offset
        return self
    }
    
    // MARK: 1.15、设置阴影圆角
    /// 设置阴影圆角
    /// - Parameter radius: 圆角大小
    /// - Returns: 返回自身
    @discardableResult
    func shadowRadius(_ radius: CGFloat) -> Self {
        self.shadowRadius = radius
        return self
    }
    
    // MARK: 1.16、高性能添加阴影路径 Shadow Path，提示：当用bounds设置path时,看起来的效果与只设置了shadowOpacity一样，但是添加了shadowPath后消除了离屏渲染问题
    /// 高性能添加阴影 Shadow Path
    /// - Parameter path: 阴影Path
    /// - Returns: 返回自身
    @discardableResult
    func shadowPath(_ path: CGPath) -> Self {
        self.shadowPath = path
        return self
    }
}

// MARK:- 二、有关动画的扩展
public extension CALayer {
    
    // MARK: 2.1、移动到另外一个 点(point)
    /// 从一个 点(point) 移动到另外一个 点(poi
    /// - Parameters:
    ///   - endPoint: 终点
    ///   - duration: 持续时间
    ///   - delay: 几秒后执行
    ///   - repeatNumber: 重复次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationMovePoint(to endPoint: CGPoint,
                          duration: TimeInterval,
                          delay: TimeInterval = 0,
                          repeatNumber: Float = 1,
                          removedOnCompletion: Bool = false,
                          option: CAMediaTimingFunctionName = .default) {
        
        let basicAnimation = CABasicAnimation(keyPath: "position")
        // 起始位置
        basicAnimation.fromValue = position
        // 终止位置
        basicAnimation.toValue = CGPoint(x: endPoint.x + frame.size.width / 2.0, y:  endPoint.y + frame.size.height / 2.0)
        // 几秒后执行
        basicAnimation.beginTime = CACurrentMediaTime() + delay
        // 持续时间
        basicAnimation.duration = duration
        // 重复次数
        basicAnimation.repeatCount = repeatNumber
        // 运动后的位置保持不变（layer的最后位置是toValue）
        basicAnimation.isRemovedOnCompletion = removedOnCompletion
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        /**
         linear: 匀速
         easeIn: 慢进
         easeOut: 慢出
         easeInEaseOut: 慢进慢出
         default: 慢进慢出
         */
        basicAnimation.timingFunction = CAMediaTimingFunction(name: option)
        // 添加动画
        add(basicAnimation, forKey: "addLayerAnimationPosition")
    }
    
   // MARK: 2.2、移动X
    /// 移动X
    /// - Parameters:
    ///   - moveValue: 移动到的X值
    ///   - duration:  动画持续的时间
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationMoveX(moveValue: Any?,
                        duration: TimeInterval = 2.0,
                        repeatNumber: Float = 1,
                        removedOnCompletion: Bool = false,
                        option: CAMediaTimingFunctionName = .default) {
        _basicAnimation(keyPath: "transform.translation.x", startValue: position, endValue: moveValue, duration: duration, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.3、移动Y
    /// 移动Y
    /// - Parameters:
    ///   - moveValue: 移动到的Y值
    ///   - duration:  动画持续的时间
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationMoveY(moveValue: Any?,
                        duration: TimeInterval = 2.0,
                        repeatNumber: Float = 1,
                        removedOnCompletion: Bool = false,
                        option: CAMediaTimingFunctionName = .default) {
        _basicAnimation(keyPath: "transform.translation.y", startValue: position, endValue: moveValue, duration: duration, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.4、圆角动画
    /// 圆角动画
    /// - Parameters:
    ///   - cornerRadius: 圆角大小
    ///   - duration:  动画持续的时间
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationCornerRadius(cornerRadius: Any?,
                               duration: TimeInterval = 2.0,
                               repeatNumber: Float = 1,
                               removedOnCompletion: Bool = false,
                               option: CAMediaTimingFunctionName = .default) {
        _basicAnimation(keyPath: "cornerRadius", startValue: position, endValue: cornerRadius, duration: duration, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.5、缩放动画
    /// 缩放动画
    /// - Parameters:
    ///   - scaleValue: 放大的倍数
    ///   - duration:  动画持续的时间
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationScale(scaleValue: Any?,
                        duration: TimeInterval = 2.0,
                        repeatNumber: Float = 1,
                        removedOnCompletion: Bool = true,
                        option: CAMediaTimingFunctionName = .default) {
        _basicAnimation(keyPath: "transform.scale", startValue: 1, endValue: scaleValue, duration: duration, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.6、旋转动画
    /// 缩放动画
    /// - Parameters:
    ///   - rotation: 旋转的角度
    ///   - duration:  动画持续的时间
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationRotation(rotation: Any?,
                           duration: TimeInterval = 2.0,
                           repeatNumber: Float = 1,
                           removedOnCompletion: Bool = true,
                           option: CAMediaTimingFunctionName = .default) {
        _basicAnimation(keyPath: "transform.rotation", startValue: nil, endValue: rotation, duration: duration, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }

}

// 动画的私有方法
fileprivate extension CALayer {
    
    // MARK: 动画的基础方法
    /// 动画的 X/Y 移动
    /// - Parameters:
    ///   - keyPath: 动画的类型
    ///   - moveValue: 移动到的位置
    ///   - duration:  动画持续的时间
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func _basicAnimation(keyPath: String,
                         startValue: Any?,
                         endValue: Any?,
                         duration: TimeInterval = 2.0,
                         repeatNumber: Float = 1,
                         removedOnCompletion: Bool = false,
                         option: CAMediaTimingFunctionName = .default) {
        let translatonAnimation: CABasicAnimation = CABasicAnimation()
        // 动画的类型
        translatonAnimation.keyPath = keyPath
        // 起始的值
        if let weakStartValue = startValue {
            translatonAnimation.fromValue = weakStartValue
        }
        // 结束的值
        translatonAnimation.toValue = endValue
        // 动画持续的时间
        translatonAnimation.duration = duration
        // 运动后的位置保持不变（layer的最后位置是toValue）
        translatonAnimation.isRemovedOnCompletion = removedOnCompletion
        // 图层保持动画执行后的状态，前提是fillMode设置为kCAFillModeForwards
        translatonAnimation.fillMode = CAMediaTimingFillMode.forwards
        /**
         linear: 匀速
         easeIn: 慢进
         easeOut: 慢出
         easeInEaseOut: 慢进慢出
         default: 慢进慢出
         */
        translatonAnimation.timingFunction = CAMediaTimingFunction(name: option)
        add(translatonAnimation, forKey: nil)
    }
}
