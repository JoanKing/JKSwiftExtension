//
//  CALayer+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit
extension CALayer: JKPOPCompatible {}
// MARK: - 一、自定义链式编程
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

// MARK: - 二、有关 CABasicAnimation 动画的扩展
public extension JKPOP where Base: CALayer {
    
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
        baseBasicAnimation(keyPath: "position", startValue: base.position, endValue: endPoint, duration: duration, delay: delay, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.2、移动X
    /// 移动X
    /// - Parameters:
    ///   - moveValue: 移动到的X值
    ///   - duration:  动画持续的时间
    ///   - delay: 几秒后执行
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationMoveX(moveValue: Any?,
                        duration: TimeInterval = 2.0,
                        delay: TimeInterval = 0,
                        repeatNumber: Float = 1,
                        removedOnCompletion: Bool = false,
                        option: CAMediaTimingFunctionName = .default) {
        baseBasicAnimation(keyPath: "transform.translation.x", startValue: base.position, endValue: moveValue, duration: duration, delay: delay, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.3、移动Y
    /// 移动Y
    /// - Parameters:
    ///   - moveValue: 移动到的Y值
    ///   - duration:  动画持续的时间
    ///   - delay: 几秒后执行
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationMoveY(moveValue: Any?,
                        duration: TimeInterval = 2.0,
                        delay: TimeInterval = 0,
                        repeatNumber: Float = 1,
                        removedOnCompletion: Bool = false,
                        option: CAMediaTimingFunctionName = .default) {
        baseBasicAnimation(keyPath: "transform.translation.y", startValue: base.position, endValue: moveValue, duration: duration, delay: delay, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.4、圆角动画
    /// 圆角动画
    /// - Parameters:
    ///   - cornerRadius: 圆角大小
    ///   - duration:  动画持续的时间
    ///   - delay: 几秒后执行
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationCornerRadius(cornerRadius: Any?,
                               duration: TimeInterval = 2.0,
                               delay: TimeInterval = 0,
                               repeatNumber: Float = 1,
                               removedOnCompletion: Bool = false,
                               option: CAMediaTimingFunctionName = .default) {
        baseBasicAnimation(keyPath: "cornerRadius", startValue: base.position, endValue: cornerRadius, duration: duration, delay: delay, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.5、缩放动画
    /// 缩放动画
    /// - Parameters:
    ///   - scaleValue: 放大的倍数
    ///   - duration:  动画持续的时间
    ///   - delay: 几秒后执行
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func animationScale(scaleValue: Any?,
                        duration: TimeInterval = 2.0,
                        delay: TimeInterval = 0,
                        repeatNumber: Float = 1,
                        removedOnCompletion: Bool = true,
                        option: CAMediaTimingFunctionName = .default) {
        baseBasicAnimation(keyPath: "transform.scale", startValue: 1, endValue: scaleValue, duration: duration, delay: delay, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 2.6、旋转动画
    /// 缩放动画
    /// - Parameters:
    ///   - rotation: 旋转的角度
    ///   - duration: 动画持续的时间
    ///   - delay: 几秒后执行
    ///   - repeatNumber: 重复的次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制方式
    func animationRotation(rotation: Any?,
                           duration: TimeInterval = 2.0,
                           delay: TimeInterval = 0,
                           repeatNumber: Float = 1,
                           removedOnCompletion: Bool = true,
                           option: CAMediaTimingFunctionName = .default) {
        baseBasicAnimation(keyPath: "transform.rotation", startValue: nil, endValue: rotation, duration: duration, delay: delay, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: CABasicAnimation 动画的基础方法
    /// 动画的 X/Y 移动
    /// - Parameters:
    ///   - keyPath: 动画的类型
    ///   - moveValue: 移动到的位置
    ///   - duration:  动画持续的时间
    ///   - delay: 几秒后执行
    ///   - repeatNumber: 重复的次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func baseBasicAnimation(keyPath: String,
                            startValue: Any?,
                            endValue: Any?,
                            duration: TimeInterval = 2.0,
                            delay: TimeInterval = 0,
                            repeatNumber: Float = 1,
                            removedOnCompletion: Bool = false,
                            option: CAMediaTimingFunctionName = .default) {
        let translatonAnimation: CABasicAnimation = CABasicAnimation()
        // 几秒后执行
        translatonAnimation.beginTime = CACurrentMediaTime() + delay
        // 动画的类型
        translatonAnimation.keyPath = keyPath
        // 起始的值
        if let weakStartValue = startValue {
            translatonAnimation.fromValue = weakStartValue
        }
        // 结束的值
        translatonAnimation.toValue = endValue
        // 重复的次数
        translatonAnimation.repeatCount = repeatNumber
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
        base.add(translatonAnimation, forKey: nil)
    }
}

// MARK: - 三、有关 CAKeyframeAnimation 动画的扩展
public extension JKPOP where Base: CALayer {
    
    // MARK: 3.1、设置values使其沿 position 运动 (这里移动是以 视图的 锚点移动的，默认是视图的 中心点)
    /// 设置values使其沿 position 运动 (这里移动是以 视图的 锚点移动的，默认是视图的 中心点)
    /// - Parameters:
    ///   - values: CGPoint 点
    ///   - keyTimes: 设置关键帧对应的时间点，范围：0-1。如果没有设置该属性，则每一帧的时间平分。
    ///   - duration: 动画持续的时间
    ///   - delay: 几秒后执行
    ///   - repeatNumber: 重复的次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func addKeyframeAnimationPosition(values: [Any],
                                      keyTimes: [NSNumber]?,
                                      duration: TimeInterval = 2.0,
                                      delay: TimeInterval = 0,
                                      repeatNumber: Float = 1,
                                      removedOnCompletion: Bool = false,
                                      option: CAMediaTimingFunctionName = .default) {
        baseKeyframeAnimation(keyPath: "position", values: values, keyTimes: keyTimes, duration: duration, delay: delay, repeatNumber: repeatNumber, path: nil, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 3.2、设置 角度值 抖动
    /// 设置 角度值 抖动
    /// - Parameters:
    ///   - values: CGPoint 点
    ///   - keyTimes: 设置关键帧对应的时间点，范围：0-1。如果没有设置该属性，则每一帧的时间平分。
    ///   - duration: 动画持续的时间
    ///   - delay: 几秒后执行
    ///   - repeatNumber: 重复的次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func addKeyframeAnimationRotation(values: [Any] = [CGFloat(-5).jk.degreesToRadians(), CGFloat(5).jk.degreesToRadians(), CGFloat(-5).jk.degreesToRadians()],
                                      keyTimes: [NSNumber]?,
                                      duration: TimeInterval = 1.0,
                                      delay: TimeInterval = 0,
                                      repeatNumber: Float = 1,
                                      removedOnCompletion: Bool = true,
                                      option: CAMediaTimingFunctionName = .default) {
        baseKeyframeAnimation(keyPath: "transform.rotation", values: values, keyTimes: keyTimes, duration: duration, delay: delay, repeatNumber: repeatNumber, path: nil, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 3.3、根据 CGPath 进行做 移动 动画
    /// 根据 CGPath 进行做 移动 动画
    /// - Parameters:
    ///   - path: CGPath 路径
    ///   - duration: 动画时长
    ///   - delay: 几秒后执行
    ///   - repeatNumber: 重复次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func addKeyframeAnimationPositionBezierPath(path: CGPath?,
                                                duration: TimeInterval = 2.0,
                                                delay: TimeInterval = 0,
                                                repeatNumber: Float = 1,
                                                removedOnCompletion: Bool = false,
                                                option: CAMediaTimingFunctionName = .default) {
        baseKeyframeAnimation(keyPath: "position", values: nil, keyTimes: nil, duration: duration,  delay: delay, repeatNumber: repeatNumber, path: path, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: CAKeyframeAnimation 动画的通用方法
    /// CAKeyframeAnimation 动画的通用方法
    /// - Parameters:
    ///   - keyPath: 动画路径对象，可以指定一个路径，在执行动画时路径会沿着路径移动，Path在动画中只会影响视图的Position。
    ///   - values: 关键帧数组对象，里面每一个元素即为一个关键帧，动画会在对应的时间段内，依次执行数组中每一个关键帧的动画
    ///   - keyTimes: 设置关键帧对应的时间点，范围：0-1。如果没有设置该属性，则每一帧的时间平分。
    ///   - duration: 动画持续的时间
    ///   - delay: 几秒后执行
    ///   - repeatNumber: 重复的次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func baseKeyframeAnimation(keyPath: String,
                               values: [Any]?,
                               keyTimes: [NSNumber]?,
                               duration: TimeInterval = 2.0,
                               delay: TimeInterval = 0,
                               repeatNumber: Float = 1,
                               path: CGPath?,
                               removedOnCompletion: Bool = false,
                               option: CAMediaTimingFunctionName = .default) {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: keyPath)
        keyframeAnimation.duration = duration
        // 几秒后执行
        keyframeAnimation.beginTime = CACurrentMediaTime() + delay
        keyframeAnimation.isRemovedOnCompletion = removedOnCompletion
        keyframeAnimation.fillMode = .forwards
        keyframeAnimation.repeatCount = repeatNumber
        // 传进来的值，可以是一组 CGPoint
        if let weakValues = values {
            keyframeAnimation.values = weakValues
        }
        if let weakKeyTimes = keyTimes {
            keyframeAnimation.keyTimes = weakKeyTimes
        }
        if let weakPath = path {
            keyframeAnimation.path = weakPath
            // 计算模式 -> 强制运动,匀速进行,不管路径有多远!否则一次动画结束会有短暂停顿
            keyframeAnimation.calculationMode = .cubicPaced
        }
        // 旋转模式 -> 沿着路径,自行旋转 转的时候需要沿着路径的切线!进行转动!
        // keyframeAnimation.rotationMode = .rotateAuto
        //  动画的时间节奏控制 方式
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: option)
        base.add(keyframeAnimation, forKey: nil)
    }
}

// MARK: - 四、有关 CATransition 动画的扩展
/**
 转场动画，比UIVIew转场动画具有更多的动画效果，比如Nav的默认Push视图的效果就是通过CATransition的kCATransitionPush类型来实现。
 */
public extension JKPOP where Base: CALayer {
    
    // MARK: 4.1、转场动画的使用
    /// 转场动画的使用
    /// - Parameters:
    ///   - type: 过渡动画的类型：
    ///   - subtype: 过渡动画的方向
    ///   - duration: 动画的时间
    ///   - delay: 几秒后执行
    func addTransition(type: CATransitionType,
                       subtype: CATransitionSubtype?,
                       duration: CFTimeInterval = 2.0,
                       delay: TimeInterval = 0) {
        let transition = CATransition()
        // 几秒后执行
        transition.beginTime = CACurrentMediaTime() + delay
        /**
         过渡动画的类型
         fade: 渐变
         moveIn: 覆盖
         push: 推出
         reveal: 揭开
         还有一些私有动画类型，效果很炫酷，不过不推荐使用。
         　　私有动画类型的值有："cube"、"suckEffect"、"oglFlip"、 "rippleEffect"、"pageCurl"、"pageUnCurl"等等
         */
        transition.type = type
        /**
         fromRight: 从右边
         fromLeft:  从左边
         fromTop: 从顶部
         fromBottom: 从底部
         */
        transition.subtype = .fromLeft
        transition.duration = 1
        base.add(transition, forKey: nil)
    }
}

// MARK: - 五、有关 CASpringAnimation 弹簧动画的扩展
/**
 CASpringAnimation是 iOS9 新加入动画类型，是CABasicAnimation的子类，用于实现弹簧动画
 CASpringAnimation和UIView的SpringAnimation对比：
 1.CASpringAnimation 可以设置更多影响弹簧动画效果的属性，可以实现更复杂的弹簧动画效果，且可以和其他动画组合。
 2.UIView的SpringAnimation实际上就是通过CASpringAnimation来实现。
 */
public extension JKPOP where Base: CALayer {
    
    // MARK: 5.1、弹簧动画：Bounds 动画
    /// 弹簧动画：Bounds 动画
    /// - Parameters:
    ///   - toValue: 目标 CGRect
    ///   - delay: 几秒后执行
    ///   - mass: 质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大）
    ///   - stiffness: 弹性系数（弹性系数越大，弹簧的运动越快）
    ///   - damping: 阻尼系数（阻尼系数越大，弹簧的停止越快）
    ///   - initialVelocity: 初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）
    ///   - repeatNumber: 动画执行的次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func addSpringAnimationBounds(toValue: Any?,
                                  delay: TimeInterval = 0,
                                  mass: CGFloat = 10.0,
                                  stiffness: CGFloat = 5000,
                                  damping: CGFloat = 100.0,
                                  initialVelocity: CGFloat = 5,
                                  repeatNumber: Float = 1,
                                  removedOnCompletion: Bool = false,
                                  option: CAMediaTimingFunctionName = .default) {
        baseSpringAnimation(path: "bounds", toValue: toValue, mass: mass, stiffness: stiffness, damping: damping, initialVelocity: initialVelocity, repeatNumber: repeatNumber, removedOnCompletion: removedOnCompletion, option: option)
    }
    
    // MARK: 弹簧的基类动画
    ///  弹簧的基类动画
    /// - Parameters:
    ///   - path: 动画路径对象，可以指定一个路径，在执行动画时路径会沿着路径移动
    ///   - toValue: 目标值
    ///   - delay: 几秒后执行
    ///   - mass: 质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大）
    ///   - stiffness: 弹性系数（弹性系数越大，弹簧的运动越快）
    ///   - damping: 阻尼系数（阻尼系数越大，弹簧的停止越快）
    ///   - initialVelocity: 初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）
    ///   - repeatNumber: 动画执行的次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func baseSpringAnimation(path: String?,
                             toValue: Any?,
                             delay: TimeInterval = 0,
                             mass: CGFloat = 10.0,
                             stiffness: CGFloat = 5000,
                             damping: CGFloat = 100.0,
                             initialVelocity: CGFloat = 5,
                             repeatNumber: Float = 1,
                             removedOnCompletion: Bool = false,
                             option: CAMediaTimingFunctionName = .default) {
        let springAnimation = CASpringAnimation(keyPath: path)
        // 几秒后执行
        springAnimation.beginTime = CACurrentMediaTime() + delay
        // 质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
        springAnimation.mass = mass
        // 刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
        springAnimation.stiffness = stiffness
        // 阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
        springAnimation.damping = damping
        // 初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
        springAnimation.initialVelocity = initialVelocity
        // settlingDuration：结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）
        springAnimation.duration = springAnimation.settlingDuration
        springAnimation.toValue = toValue
        springAnimation.isRemovedOnCompletion = removedOnCompletion
        springAnimation.fillMode = CAMediaTimingFillMode.forwards
        // 动画的时间节奏控制 方式
        springAnimation.timingFunction = CAMediaTimingFunction(name: option)
        base.add(springAnimation, forKey: nil)
    }
}

// MARK: - 六、有关 CAAnimationGroup 动画组的扩展
/**
 使用Group可以将多个动画合并一起加入到层中，Group中所有动画并发执行，可以方便地实现需要多种类型动画的场景
 */
public extension JKPOP where Base: CALayer {
    
    // MARK: CAAnimationGroup 的基类动画
    /// CAAnimationGroup 的基类动画
    /// - Parameters:
    ///   - animations: 动画组
    ///   - duration: 动画时长
    ///   - delay: 几秒后执行
    ///   - repeatNumber: 重复次数
    ///   - removedOnCompletion: 运动后的位置保持不变（layer的最后位置是toValue）
    ///   - option: 动画的时间节奏控制 方式
    func baseAnimationGroup(animations: [CAAnimation]?,
                            duration: TimeInterval = 2.0,
                            delay: TimeInterval = 0,
                            repeatNumber: Float = 1,
                            removedOnCompletion: Bool = false,
                            option: CAMediaTimingFunctionName = .default) {
        let animationGroup = CAAnimationGroup()
        // 几秒后执行
        animationGroup.beginTime = CACurrentMediaTime() + delay
        animationGroup.animations = animations
        animationGroup.duration = duration
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = removedOnCompletion
        // 动画的时间节奏控制 方式
        animationGroup.timingFunction = CAMediaTimingFunction(name: option)
        base.add(animationGroup, forKey: nil)
    }
}
