//
//  UIScrollView+Extension.swift
//  JKLive
//
//  Created by IronMan on 2020/8/28.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

public enum Edge {
    case top
    case left
    case bottom
    case right
}

// MARK: - 一、基本的扩展
public extension JKPOP where Base: UIScrollView {
    
    // MARK: 1.1、适配iOS 11
    /// 适配iOS 11
    func neverAdjustContentInset() {
        if #available(iOS 11.0, *), base.responds(to: #selector(setter: base.contentInsetAdjustmentBehavior)) {
            self.base.contentInsetAdjustmentBehavior = .never
        }
    }
    
    // MARK: 1.2、设置滚动到：上左下右
    /// 设置滚动到：上左下右
    /// - Parameters:
    ///   - edege: 滚动的位置
    ///   - animated: 是否要动画
    func scroll(edege: Edge, animated: Bool = true) {
        var offset = self.base.contentOffset
        switch edege {
        case .top:
            offset.y =  -self.base.contentInset.top
        case .left:
            offset.x = -self.base.contentInset.left
        case .bottom:
            offset.y = self.base.contentSize.height - self.base.bounds.size.height + self.base.contentInset.bottom
        case .right:
            offset.x = self.base.contentSize.width - self.base.bounds.size.width + self.base.contentInset.right
        }
        self.base.setContentOffset(offset, animated: animated)
    }
    
    // MARK: 1.3、获取 ScrollView 的 contentScroll 长图像
    /// 获取 ScrollView 的 contentScroll 长图像
    /// - Parameter completionHandler: 获取闭包
    func snapShotContentScroll(_ completionHandler: @escaping (_ screenShotImage: UIImage?) -> Void) {
        /// 放一个假的封面
        let snapShotView = self.base.snapshotView(afterScreenUpdates: true)
        snapShotView?.frame = CGRect(x: self.base.frame.origin.x, y: self.base.frame.origin.y, width: (snapShotView?.frame.size.width)!, height: (snapShotView?.frame.size.height)!)
        self.base.superview?.addSubview(snapShotView!)
        ///  基的原点偏移
        let originOffset = self.base.contentOffset
        /// 分页
        let page  = floorf(Float(self.base.contentSize.height / self.base.bounds.height))
        // 防止size：(0, 0)崩溃
        var contentSize = self.base.contentSize
        if contentSize.width <= 0 || contentSize.height <= 0 {
            contentSize = CGSize(width: 1, height: 1)
        }
        /// 打开位图上下文大小为截图的大小
        UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)
        /// 这个方法是一个绘图，里面可能有递归调用
        self.snapShotContentScrollPage(index: 0, maxIndex: Int(page), callback: { () -> Void in
            let screenShotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            /// 设置原点偏移
            self.base.setContentOffset(originOffset, animated: false)
            // 防止移除闪烁
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                snapShotView?.removeFromSuperview()
            }
            /// 获取 snapShotContentScroll 时的回调图像
            completionHandler(screenShotImage)
        })
    }
    
    /// 根据偏移量和页数绘制
    /// 此方法为绘图，根据偏移量和页数可能会递归调用insideraw
    private func snapShotContentScrollPage(index: Int, maxIndex: Int, callback: @escaping () -> Void) {
        self.base.setContentOffset(CGPoint(x: 0, y: CGFloat(index) * self.base.frame.size.height), animated: false)
        let splitFrame = CGRect(x: 0, y: CGFloat(index) * self.base.frame.size.height, width: base.bounds.size.width, height: base.bounds.size.height)
        JKAsyncs.asyncDelay(Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
        } _: {
            self.base.drawHierarchy(in: splitFrame, afterScreenUpdates: true)
            if index < maxIndex {
                self.snapShotContentScrollPage(index: index + 1, maxIndex: maxIndex, callback: callback)
            } else {
                callback()
            }
        }
    }
    
    //MARK: 1.4、获取内容截图
    /// 获取内容截图
    /// - Returns: 截图图片
    func captureLongScreenshot() -> UIImage {
        // 1、备份
        let savedContentOffset = self.base.contentOffset
        let savedFrame = self.base.frame
        
        // 2、修改frame
        self.base.contentOffset = CGPoint.zero
        self.base.frame = CGRect(x: 0, y: 0, width: self.base.contentSize.width, height: self.base.contentSize.height)
        self.base.layoutIfNeeded()

        defer {
            // 4、还原
            self.base.contentOffset = savedContentOffset
            self.base.frame = savedFrame
        }
        // 3、渲染图片
        return UIGraphicsImageRenderer(size: self.base.contentSize).image { context in
            self.base.layer.render(in: context.cgContext)
        }
    }
}

// MARK: - 二、链式编程
public extension UIScrollView {
    
    // MARK: 2.1、设置偏移量 CGPoint
    /// 设置偏移量
    /// - Parameter offset: 偏移量
    /// - Returns: 返回自身
    @discardableResult
    func contentOffset(_ offset: CGPoint) -> Self {
        contentOffset = offset
        return self
    }
    
    // MARK: 2.2、设置偏移量 x: CGFloat, y: CGFloat
    /// 设置偏移量 x: CGFloat, y: CGFloat
    /// - Parameters:
    ///   - x: x 偏移量
    ///   - y: y 偏移量
    /// - Returns: 返回自身
    @discardableResult
    func contentOffset(x: CGFloat, y: CGFloat) -> Self {
        contentOffset = CGPoint(x: x, y: y)
        return self
    }
    
    // MARK: 2.3、设置滑动区域大小(CGSize)，默认是CGSizeZero
    /// 设置滑动区域大小(width: CGFloat, height: CGFloat)，默认是CGSizeZero
    /// - Parameter size: 滑动区域大小
    /// - Returns: 返回自身
    @discardableResult
    func contentSize(_ size: CGSize) -> Self {
        contentSize = size
        return self
    }
    
    // MARK: 2.4、设置滑动区域大小(width: CGFloat, height: CGFloat)，默认是CGSizeZero
    /// 设置滑动区域大小(width: CGFloat, height: CGFloat)，默认是CGSizeZero
    /// - Parameters:
    ///   - width: width代表x方向滑动区域大小
    ///   - height: height代表竖向滑动区域大小
    /// - Returns: 返回自身
    @discardableResult
    func contentSize(width: CGFloat, height: CGFloat) -> Self {
        contentSize = CGSize(width: width, height: height)
        return self
    }
    
    // MARK: 2.5、设置边缘插入内容以外的可滑动区域，默认是UIEdgeInsetsZero(提示：必须设置contentSize后才有效)
    /// 边缘插入内容以外的可滑动区域，默认是UIEdgeInsetsZero(提示：必须设置contentSize后才有效)
    /// - Parameters:
    ///   - top:     代表 顶部 可滑动区域
    ///   - left:    代表 左边 可滑动区域
    ///   - bottom:  代表 底部 可滑动区域
    ///   - right:   代表 右边 可滑动区域
    /// - Returns: 返回自身
    @discardableResult
    func contentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    // MARK: 2.6、设置边缘插入内容以外的可滑动区域(UIEdgeInsets)，默认是UIEdgeInsetsZero(提示：必须设置contentSize后才有效)
    /// 设置边缘插入内容以外的可滑动区域(UIEdgeInsets)，默认是UIEdgeInsetsZero(提示：必须设置contentSize后才有效)
    /// - Parameter inset: UIEdgeInsets
    /// - Returns: 返回自身
    @discardableResult
    func contentInset(_ inset: UIEdgeInsets) -> Self {
        contentInset = inset
        return self
    }
    
    // MARK: 2.7、设置代理
    /// 设置代理
    /// - Parameter delegate: 代理
    /// - Returns: 返回自身
    @discardableResult
    func delegate(_ delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate 
        return self
    }
    
    // MARK: 2.8、设置弹性效果，默认是true, 如果设置成false，则当你滑动到边缘时将不具有弹性效果
    ///  设置弹性效果，默认是true, 如果设置成false，则当你滑动到边缘时将不具有弹性效果
    /// - Parameter bounces: 是否有弹性
    /// - Returns: 返回自身
    @discardableResult
    func bounces(_ bounces: Bool) -> Self {
        self.bounces = bounces
        return self
    }
    
    // MARK: 2.9、竖直方向 总是可以弹性滑动，默认是 false
    /// 竖直方向总是可以弹性滑动，默认是 false
    /// - Parameter bounces: 是否有弹性
    /// - Returns: 返回自身
    @discardableResult
    func alwaysBounceVertical(_ bounces: Bool) -> Self {
        /**
         提示：当设置为true（前提是属性bounces必须为true）的时候，即使contentSize设置的width 和 height都比UIScrollView的width 和 height小，在垂直方向上都可以有滑动效果,甚至即使我们不设置contentSize都可以产生滑动效果； 反之，如果设置alwaysBounceVertical为true， 那么当contentSize设置的width 和 height都比UIScrollView的width 和 height小的时候，即使bounces设置为true，那么不可能产生弹性效果
         */
        self.alwaysBounceVertical = bounces
        return self
    }
    
    // MARK: 2.10、水平方向 总是可以弹性滑动，默认是 false
    /// 水平方向 总是可以弹性滑动，默认是 false
    /// - Parameter bounces: 是否有弹性
    /// - Returns: 返回自身
    @discardableResult
    func alwaysBounceHorizontal(_ bounces: Bool) -> Self {
        self.alwaysBounceHorizontal = bounces
        return self
    }
    
    // MARK: 2.11、设置是否可分页，默认是false， 如果设置成true， 则可分页
    /// 设置是否可分页，默认是false， 如果设置成true， 则可分页
    /// - Parameter enabled: 是否可分页
    /// - Returns: 返回自身
    @discardableResult
    func isPagingEnabled(_ enabled: Bool) -> Self {
        self.isPagingEnabled = enabled
        return self
    }
    
    // MARK: 2.12、是否显示 水平 方向滑动条，默认是true, 如果设置为false，当滑动的时候则不会显示水平滑动条
    /// 是否显示 水平 方向滑动条，默认是true, 如果设置为false，当滑动的时候则不会显示水平滑动条
    /// - Parameter enabled: 是否显示水平方向滑动条
    /// - Returns: 返回自身
    @discardableResult
    func showsHorizontalScrollIndicator(_ enabled: Bool) -> Self {
        self.showsHorizontalScrollIndicator = enabled
        return self
    }
    
    // MARK: 2.13、是否显示 垂直 方向滑动条，默认是true, 如果设置为false，当滑动的时候则不会显示水平滑动条
    /// 是否显示 垂直 方向滑动条，默认是true, 如果设置为false，当滑动的时候则不会显示水平滑动条
    /// - Parameter enabled: 是否显示垂直方向滑动条
    /// - Returns: 返回自身
    @discardableResult
    func showsVerticalScrollIndicator(_ enabled: Bool) -> Self {
        self.showsVerticalScrollIndicator = enabled
        return self
    }
    
    // MARK: 2.14、设置偏移量(x,y)
    /// 设置偏移量
    /// - Parameters:
    ///   - horizontal: 水平方向的偏移量
    ///   - vertical: 垂直方向的偏移量
    ///   - animated: 是否有动画
    /// - Returns: 返回自身
    @discardableResult
    func setContentOffset(_ horizontal: CGFloat, _ vertical: CGFloat, animated: Bool = true) -> Self {
        setContentOffset(CGPoint(x: horizontal, y: vertical), animated: animated)
        return self
    }
    
    // MARK: 2.15、设置 水平方向(x) 偏移量
    /// 设置 水平方向(x) 偏移量
    /// - Parameters:
    ///   - horizontal: 水平方向(x) 偏移量
    ///   - animated: 是否有动画
    /// - Returns: 返回自身
    @discardableResult
    func setContentOffsetX(_ horizontal: CGFloat, animated: Bool = true) -> Self {
        setContentOffset(CGPoint(x: horizontal, y: self.contentOffset.y), animated: animated)
        return self
    }
    
    // MARK: 2.16、设置 垂直方向(y) 偏移量
    /// 设置 垂直方向(y) 偏移量
    /// - Parameters:
    ///   - vertical: 垂直方向(y) 偏移量
    ///   - animated: 是否有动画
    /// - Returns: 返回自身
    @discardableResult
    func setContentOffsetY( _ vertical: CGFloat, animated: Bool = true) -> Self {
        setContentOffset(CGPoint(x: self.contentOffset.x, y: vertical), animated: animated)
        return self
    }
    
    // MARK: 2.17、设置滑动条的边缘插入，即是距离上、左、下、右的距离，比如：top(20) 当向下滑动时，滑动条距离顶部的距离总是 20
    /// 设置滑动条的边缘插入，即是距离上、左、下、右的距离，比如：top(20) 当向下滑动时，滑动条距离顶部的距离总是 20
    /// - Parameter inset: UIEdgeInset
    /// - Returns: 返回自身
    @discardableResult
    func scrollIndicatorInsets(_ inset: UIEdgeInsets) -> Self {
        scrollIndicatorInsets = inset
        return self
    }
    
    // MARK: 2.18、是否可滑动，默认是true, 如果默认为false, 则无法滑动
    /// 是否可滑动，默认是true, 如果默认为false, 则无法滑动
    /// - Parameter enabled: 是否可滑动
    /// - Returns: 返回自身
    @discardableResult
    func isScrollEnabled(_ enabled: Bool) -> Self {
        isScrollEnabled = enabled
        return self
    }
    
    // MARK: 2.19、设置滑动条颜色，默认是灰白色
    /// 设置滑动条颜色，默认是灰白色
    /// - Parameter indicatorStyle: 滑动条颜色
    /// - Returns: 返回自身
    @discardableResult
    func indicatorStyle(_ style: UIScrollView.IndicatorStyle) -> Self {
        indicatorStyle = style
        return self
    }
    
    // MARK: 2.20、设置减速率，CGFloat类型，当你滑动松开手指后的减速速率， 但是尽管decelerationRate是一个CGFloat类型，但是目前系统只支持以下两种速率设置选择：fast 和 normal
    /// 设置减速率，CGFloat类型，当你滑动松开手指后的减速速率， 但是尽管decelerationRate是一个CGFloat类型，但是目前系统只支持以下两种速率设置选择：fast 和 normal
    /// - Parameter rate: 减速率
    /// - Returns: 返回自身
    @discardableResult
    func decelerationRate(_ rate: UIScrollView.DecelerationRate) -> Self {
        decelerationRate = rate
        return self
    }
    
    // MARK: 2.21、锁住水平或竖直方向的滑动， 默认为false，如果设置为TRUE，那么在推拖拽UIScrollView的时候，会锁住水平或竖直方向的滑动
    /// 锁住水平或竖直方向的滑动， 默认为false，如果设置为TRUE，那么在推拖拽UIScrollView的时候，会锁住水平或竖直方向的滑动
    /// - Parameter enabled: 是否锁住
    /// - Returns: 返回自身
    @discardableResult
    func isDirectionalLockEnabled(_ enabled: Bool) -> Self {
        isDirectionalLockEnabled = enabled
        return self
    }
}
