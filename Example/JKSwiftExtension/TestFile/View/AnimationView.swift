//
//  AnimationView.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/21.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class AnimationView: UIView {
    /// 创建一个 Animator
    lazy var animator = UIDynamicAnimator(referenceView: self)
    var originalCenterY: CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        initUI()
        commonInit()
        changeTheme()
        loadData()
    }
    
    private func initUI() {
        addSubview(pointImageView)
        addSubview(animationImageView)
        pointImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    private func commonInit() {
        // 重力
        let gravity = UIGravityBehavior(items: [animationImageView])
        // 弹性
        let elastic = UIDynamicItemBehavior(items: [animationImageView])
        elastic.elasticity = 0.6
        // 边缘
        let collision = UICollisionBehavior(items: [animationImageView])
        // 记录animationImageView的底部坐标
        let endY = animationImageView.frame.origin.y + animationImageView.frame.height
        // 添加一个边界
        collision.addBoundary(withIdentifier: "floor" as NSCopying, from: CGPoint(x: 0, y: endY), to: CGPoint(x: self.frame.size.width, y: endY))
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
        animator.addBehavior(elastic)
    }
    
    private func changeTheme() {
        originalCenterY = animationImageView.jk.centerY
    }
    
    private func loadData() {
        
    }
    
    /// 气泡
    lazy var animationImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: (self.bounds.size.width - 54) / 2.0, y: self.bounds.size.height / 2.0 - 20 - 68 + 34, width: 54, height: 68))
        imageView.image = UIImage(named: "selected_point_animation")
        //imageView.backgroundColor = .yellow
        return imageView
    }()
    /// 点
    lazy var pointImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "selected_point_circle")
        //imageView.backgroundColor = .green
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -Event
extension AnimationView {
    //MARK: 开始动画
    /// 开始动画
    func startAnimation() {
        UIView.animate(withDuration: 0.2) {[weak self]  in
            guard let weakSelf = self else {
                return
            }
            weakSelf.animationImageView.layer.position.y = weakSelf.originalCenterY - 10
        } completion: { _ in
        }
    }
    
    //MARK: 结束动画
    /// 结束动画
    func endAnimation() {
        UIView.animate(withDuration: 0.2) {[weak self]  in
            guard let weakSelf = self else {
                return
            }
            weakSelf.animationImageView.layer.position.y = weakSelf.originalCenterY + 6
        } completion: {[weak self] result in
            guard let weakSelf = self else {
                return
            }
            //如果不update，则animator不知道它的位置被移动过了})
            weakSelf.animator.updateItem(usingCurrentState: weakSelf.animationImageView)
        }
    }
    
    func checkPositiony() {
        debugPrint("positionY\(animationImageView.layer.position.y)")
        debugPrint("中心点\(animationImageView.jk.centerY)")
    }
    
    func resetPositiony() {
        animationImageView.layer.position.y = originalCenterY
        debugPrint("positionY\(animationImageView.layer.position.y)")
    }
}
