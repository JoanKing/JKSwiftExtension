//
//  CALayerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CALayerExtensionViewController: BaseViewController, CAAnimationDelegate {

    var translatonAnimation: CABasicAnimation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、自定义链式编程", "二、有关动画的扩展"]
        dataArray = [["设置圆角", "设置背景色", "设置背景色 (十六进制字符串)", "设置frame", "添加到父视图(UIView)", "添加到父视图(CALayer)", "是否隐藏", "设置边框宽度", "设置边框颜色", "是否开启光栅化", "设置光栅化比例", "设置阴影颜色", "设置阴影的透明度", "设置阴影的偏移量", "设置阴影圆角", "高性能添加阴影 Shadow Path"], ["移动到另外一个 点(point)", "移动X", "移动Y", "圆角动画", "缩放动画", "旋转动画", "test"]]
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        print("animationDidStart:")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop")
    }
}

// MARK:- 一、基本的扩展
extension CALayerExtensionViewController {
    
     @objc func test27() {
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        //旋转动画
        let rotationAnimation: CABasicAnimation = CABasicAnimation()
        rotationAnimation.keyPath = "transform.rotation"
        rotationAnimation.toValue = Double.pi
        rotationAnimation.duration = 2.0
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        testLayer.add(rotationAnimation, forKey: nil)
    }
    
    // MARK: 2.6、旋转动画
    @objc func test26() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        testLayer.animationRotation(rotation: Double.pi)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.5、缩放动画
    @objc func test25() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
       
        testLayer.animationScale(scaleValue: 2)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.4、圆角动画
    @objc func test24() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
       
        testLayer.animationCornerRadius(cornerRadius: 50)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.3、移动Y
    @objc func test23() {
        let testLayer1 = CALayer()
        testLayer1.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        testLayer1.corner(12)
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer2 = CALayer()
        testLayer2.frame = CGRect(x: 200, y: 300, width: 100, height: 100)
        testLayer2.backgroundColor = UIColor.yellow.cgColor
        testLayer2.corner(12)
        self.view.layer.addSublayer(testLayer2)
        
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        testLayer.corner(12)
        self.view.layer.addSublayer(testLayer)
        
        testLayer.animationMoveY(moveValue: 100)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.2、移动X
    @objc func test22() {
        let testLayer1 = CALayer()
        testLayer1.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        testLayer1.corner(12)
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer2 = CALayer()
        testLayer2.frame = CGRect(x: 200, y: 300, width: 100, height: 100)
        testLayer2.backgroundColor = UIColor.yellow.cgColor
        testLayer2.corner(12)
        self.view.layer.addSublayer(testLayer2)
        
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        testLayer.corner(12)
        self.view.layer.addSublayer(testLayer)
        
        testLayer.animationMoveX(moveValue: 100)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.1、移动到另外一个 点(point)
    @objc func test21() {
        let testLayer1 = CALayer()
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        testLayer1.corner(12)
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer2 = CALayer()
        testLayer2.frame = CGRect(x: 200, y: 300, width: 100, height: 100)
        testLayer2.backgroundColor = UIColor.yellow.cgColor
        testLayer2.corner(12)
        self.view.layer.addSublayer(testLayer2)
        
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 200, y: 300, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        testLayer.corner(12)
        self.view.layer.addSublayer(testLayer)
        testLayer.animationMovePoint(to: CGPoint(x: 100, y: 100), duration: 5, delay: 1, repeatNumber: 1, removedOnCompletion: false, option: .default)
        JKAsyncs.asyncDelay(6) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
}

// MARK:- 一、基本的扩展
extension CALayerExtensionViewController {
    
    // MARK: 1.1、设置圆角
    @objc func test11() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        testLayer.corner(12)
        self.view.layer.addSublayer(testLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.2、设置背景色
    @objc func test12() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor(UIColor.randomColor)
        self.view.layer.addSublayer(testLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.3、设置背景色 (十六进制字符串)
    @objc func test13() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor("#7B68EE")
        self.view.layer.addSublayer(testLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.4、设置frame
    @objc func test14() {
        let testLayer = CALayer()
        testLayer.frame(CGRect(x: 100, y: 100, width: 100, height: 100))
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        self.view.layer.addSublayer(testLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.5、添加到父视图
    @objc func test15() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.6、添加到父视图(CALayer)
    @objc func test16() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.7、是否隐藏
    @objc func test17() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.isHidden(false)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.8、设置边框宽度
    @objc func test18() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.borderWidth(16)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.9、设置边框颜色
    @objc func test19() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.borderWidth(16)
        testLayer.borderColor(.yellow)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.10、是否开启光栅化
    @objc func test110() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shouldRasterize(true)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.11、设置光栅化比例
    @objc func test111() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shouldRasterize(true)
        testLayer.rasterizationScale(0.8)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.12、设置阴影颜色
    @objc func test112() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.13、设置阴影的透明度
    @objc func test113() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.shadowOpacity(0.68)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.14、设置阴影的偏移量
    @objc func test114() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.shadowOpacity(0.68)
        testLayer.shadowOffset(CGSize(width: 1, height: 1))
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.15、设置阴影圆角
    @objc func test115() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.shadowOpacity(0.68)
        testLayer.shadowOffset(CGSize(width: 1, height: 1))
        testLayer.shadowRadius(6)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.16、高性能添加阴影 Shadow Path
    @objc func test116() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.shadowOpacity(0.68)
        testLayer.shadowRadius(6)
        // testLayer.shadowPath(UIBezierPath.init(rect: testLayer.bounds).cgPath)
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
}
