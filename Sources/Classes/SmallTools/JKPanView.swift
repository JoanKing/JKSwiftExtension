//
//  JKPanView.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
/**
 使用说明：JKPanView是一个用来处理滑动卡片的类，使用的时候自己创建一个类继承于它
 必须设置的是：topMinHeight、topMaxHeight
 如果卡片上放了一个 UITableView 或者 UICollectionView，需要做的如下
 1、重写 scrollViewDidToTop() 和 scrollViewDidToBottom() 两个方法
 2、在 UITableView 或者 UICollectionView 的- (void)scrollViewDidScroll:(UIScrollView *)scrollView;的方法里面设置 self.stop_y = scrollView.contentOffset.y
 }
 */
@objcMembers
open class JKPanView: UIView {
    /// 上滑后距离顶部的最小距离(相对父视图来说)
    public var topMinHeight: CGFloat = 0
    /// 上滑后距离顶部的最大距离(相对父视图来说)
    public var topMaxHeight: CGFloat = 0
    /// UITableView 或者 UICollectionView滑动停止的位置
    ///
    /// - Note: 需要在 UITableView 或者 UICollectionView 的- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
    public var stop_y: CGFloat = 0
    /// 回到顶部
    public var goTopClosure: (() -> ())?
    /// 回到底部
    public var goBackClosure: (() -> ())?
    /// 滑动中
    public var scrollViewDidClosure: ((_ contentOffsetY: CGFloat) -> ())?
    /// 自定义滑动临界高度
    public var customMiddleHeight: CGFloat?
    /// 最大距离和最小距离之间的距离(用来判断松后后卡片滑动的方向)
    private var middleHeight: CGFloat {
        return (topMinHeight + topMaxHeight) / 2.0
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        let panRecoginer = UIPanGestureRecognizer.init(target: self, action: #selector(panHandle))
        panRecoginer.delegate = self
        self.addGestureRecognizer(panRecoginer)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 滑动结束调用的方法
extension JKPanView {
    //MARK: 回到顶部
    /// 回到顶部
    open func scrollViewDidToTop() {
    }
    
    //MARK: 回到底部
    /// 回到底部
    open func scrollViewDidToBottom() {
    }
}

//MARK: - 滑动相关的处理
extension JKPanView {
    //MARK: 手势滑动代理
    /// 手势滑动代理
    /// - Parameter pan: 滑动手势
    @objc private func panHandle(pan: UIPanGestureRecognizer) {
        // 获取视图偏移量
        let translationPoint: CGPoint = pan.translation(in: self)
        let transY: CGFloat = translationPoint.y
        
        // stop_y是tableview的偏移量，当tableview的偏移量大于0时则不去处理视图滑动的事件
        if self.stop_y > 0 {
            // 将视频偏移量重置为0
            pan.setTranslation(CGPoint(x: 0, y: 0), in: self)
            return
        }
        
        self.frame.origin.y += transY
        
        if self.frame.origin.y < self.topMinHeight {
            self.frame.origin.y = self.topMinHeight
        }
        
        // self.topMaxHeight是视图在底部时距离顶部的距离
        if self.frame.origin.y > self.topMaxHeight {
            self.frame.origin.y = self.topMaxHeight
        }
        
        // 在滑动手势结束时判断滑动视图距离顶部的距离是否超过了屏幕的一半，如果超过了一半就往下滑到底部
        // 如果小于一半就往上滑到顶部
        if pan.state == .ended || pan.state == .cancelled {
            // 滑动速度
            let velocity: CGPoint = pan.velocity(in: self)
            let speed: CGFloat = 350
            if velocity.y < -speed {
                goTop()
                pan.setTranslation(CGPoint(x: 0, y: 0), in: self)
                return
            } else if velocity.y > speed {
                goBack()
                pan.setTranslation(CGPoint(x: 0, y: 0), in: self)
                return
            }
            if self.frame.origin.y >= (customMiddleHeight ?? middleHeight) {
                goBack()
            } else {
                goTop()
            }
        } else if pan.state == .changed {
            scrollViewDidClosure?(self.frame.origin.y)
        }
        pan.setTranslation(CGPoint(x: 0, y: 0), in: self)
    }
    
    //MARK: 回到顶部
    /// 回到顶部
    @objc private func goTop() {
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let weakSelf = self else { return }
            // weakSelf.jk.x = weakSelf.topH
            weakSelf.frame.origin.y = weakSelf.topMinHeight
        } completion: {[weak self] finish in
            guard let weakSelf = self else { return }
            // weakSelf.tableView.isUserInteractionEnabled = true
            weakSelf.scrollViewDidToTop()
            weakSelf.goTopClosure?()
        }
    }
    
    //MARK: 回到底部
    /// 回到底部
    @objc private func goBack() {
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let weakSelf = self else { return }
            // weakSelf.jk.x = weakSelf.topMaxHeight
            weakSelf.frame.origin.y = weakSelf.topMaxHeight
        } completion: {[weak self] finish in
            guard let weakSelf = self else { return }
            // weakSelf.tableView.isUserInteractionEnabled = false
            weakSelf.scrollViewDidToBottom()
            weakSelf.goBackClosure?()
        }
    }
}

//MARK: - UIGestureRecognizerDelegate
extension JKPanView: UIGestureRecognizerDelegate {
    
    /// 同时相应多个手势
    /// - Parameters:
    ///   - gestureRecognizer: gestureRecognizer description
    ///   - otherGestureRecognizer: otherGestureRecognizer description
    /// - Returns: description
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
