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
    lazy var testButton: UIView = {
        let testView = UIView()
        testView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        testView.backgroundColor = UIColor.randomColor
        return testView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "测试", style: .plain, target: self, action: #selector(test602))
        
        headDataArray = ["一、自定义链式编程", "二、有关 CABasicAnimation 动画的扩展", "三、有关 CAKeyframeAnimation 动画的扩展", "四、有关 CATransition 动画的扩展", "五、有关 CASpringAnimation 弹簧动画的扩展", "六、有关 CAAnimationGroup 动画组的扩展"]
        dataArray = [["设置圆角", "设置背景色", "设置背景色 (十六进制字符串)", "设置frame", "添加到父视图(UIView)", "添加到父视图(CALayer)", "是否隐藏", "设置边框宽度", "设置边框颜色", "是否开启光栅化", "设置光栅化比例", "设置阴影颜色", "设置阴影的透明度", "设置阴影的偏移量", "设置阴影圆角", "高性能添加阴影 Shadow Path"], ["移动到另外一个 点(point)", "移动X", "移动Y", "圆角动画", "缩放动画", "旋转动画"], ["position移动动画", "设置 角度值 抖动", "根据 CGPath 进行做 移动 动画"], ["转场动画的使用"], ["弹簧动画：Bounds 动画"], ["CAAnimationGroup 的基类动画"]]
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        print("animationDidStart:")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop")
    }
}

// MARK: - 六、有关 CAAnimationGroup 动画组的扩展
extension CALayerExtensionViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        testButton.jk.x = scrollView.contentOffset.x + testButton.jk.x
        testButton.jk.y = scrollView.contentOffset.y + testButton.jk.y
        testButton.jk.width = 80
        testButton.jk.height = 80
        testButton.layer.cornerRadius = 40
        testButton.clipsToBounds = true
    }
    
    // MARK: CAAnimationGroup 动画
    @objc func test602() {
        self.view.addSubview(testButton)
    }
    // MARK: CAAnimationGroup 动画
    @objc func test601() {
        
        let testView = UIView()
        testView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        testView.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView)
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = UIImage(named: "ironman")
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        
        let posAni = CABasicAnimation(keyPath: "position")
        posAni.toValue = CGPoint(x: 100, y: 150)
        
        let opcAni = CABasicAnimation(keyPath: "opacity")
        opcAni.toValue = 1.0
        opcAni.toValue = 0.7
        
        let bodAni = CABasicAnimation(keyPath: "bounds")
        bodAni.toValue = CGRect(x: 100, y: 150, width: 100, height: 100)
        
        JKAsyncs.asyncDelay(1) {
        } _: {
            imageView.layer.jk.baseAnimationGroup(animations: [posAni, opcAni, bodAni], duration: 3, repeatNumber: 1, removedOnCompletion: false, option: .default)
            JKAsyncs.asyncDelay(4) {
            } _: {
                testView.removeFromSuperview()
                imageView.removeFromSuperview()
            }
        }
    }
}

// MARK: - 五、有关 CASpringAnimation 弹簧动画的扩展
extension CALayerExtensionViewController {
    
    // MARK: 5.01、 弹簧动画：Bounds 动画
    @objc func test501() {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = UIImage(named: "ironman")
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(1) {
        } _: {
            imageView.layer.jk.addSpringAnimationBounds(toValue: CGRect(x: 0, y: 150, width: 100, height: 100))
            JKAsyncs.asyncDelay(6) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
}

// MARK: - 四、有关 CATransition 动画的扩展
extension CALayerExtensionViewController {
    
    // MARK: 4.01、转场动画的使用
    @objc func test401() {
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = UIImage(named: "ironman")
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(2) {
        } _: {
            imageView.image = UIImage(named: "testicon")
            imageView.layer.jk.addTransition(type: .moveIn, subtype: .fromLeft, duration: 1.5)
            JKAsyncs.asyncDelay(2) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
}

// MARK: - 三、有关 CAKeyframeAnimation 动画的扩展
extension CALayerExtensionViewController {
    
    // MARK: 3.03、根据 CGPath 进行做 移动 动画
    @objc func test303() {
        
        let testLayer1 = CALayer().corner(100).borderWidth(2).borderColor(.randomColor)
        testLayer1.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        testLayer1.backgroundColor = UIColor.randomColor.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(10)
        testLayer.frame = CGRect(x: 80, y: 80, width: 20, height: 20)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        self.view.layer.addSublayer(testLayer)
        
        let path = UIBezierPath(ovalIn: CGRect(x: 100, y: 200, width: 200, height: 200)).cgPath
        
        testLayer.jk.addKeyframeAnimationPositionBezierPath(path: path, duration: 5, delay: 2, repeatNumber: 2, removedOnCompletion: false, option: .default)
        
        JKAsyncs.asyncDelay(15) {
            
        } _: {
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
            testLayer1.removeFromSuperlayer()
        }
    }
    
    // MARK: 3.02、设置 角度值 抖动
    @objc func test302() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 80, y: 80, width: 80, height: 80)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        testLayer.jk.addKeyframeAnimationRotation(keyTimes: nil)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 3.01、position移动动画
    @objc func test301() {
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 80, y: 80, width: 80, height: 80)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        let testView1 = UIView().corner(20)
        testView1.frame = CGRect(x: 100, y: 100, width: 40, height: 40)
        testView1.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView1)
        
        let testView2 = UIView().corner(20)
        testView2.frame = CGRect(x: 250, y: 100, width: 40, height: 40)
        testView2.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView2)
        
        let testView3 = UIView().corner(20)
        testView3.frame = CGRect(x: 100, y: 300, width: 40, height: 40)
        testView3.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView3)
        
        let testView4 = UIView().corner(20)
        testView4.frame = CGRect(x: 250, y: 300, width: 40, height: 40)
        testView4.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView4)
        
        let duration = 8
        let repeatNumber: Float = 2
        
        testLayer.jk.addKeyframeAnimationPosition(values: [testView1.jk.center, testView2.jk.center,  testView4.jk.center, testView3.jk.center, testView1.jk.center], keyTimes: nil, duration: TimeInterval(duration), repeatNumber: repeatNumber, removedOnCompletion: false, option: .default)
        
        JKAsyncs.asyncDelay(Double(duration) * Double(repeatNumber) + 2) {
            
        } _: {
            testView1.removeFromSuperview()
            testView2.removeFromSuperview()
            testView3.removeFromSuperview()
            testView4.removeFromSuperview()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
}

// MARK: - 二、有关 CABasicAnimation 动画的扩展
extension CALayerExtensionViewController {
    
    // MARK: 2.06、旋转动画
    @objc func test206() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        testLayer.jk.animationRotation(rotation: Double.pi)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.05、缩放动画
    @objc func test205() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        
        testLayer.jk.animationScale(scaleValue: 2)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.04、圆角动画
    @objc func test204() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        
        testLayer.jk.animationCornerRadius(cornerRadius: 50)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.03、移动Y
    @objc func test203() {
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
        
        testLayer.jk.animationMoveY(moveValue: 100)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.02、移动X
    @objc func test202() {
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
        
        testLayer.jk.animationMoveX(moveValue: 100)
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.01、移动到另外一个 点(point)
    @objc func test201() {
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
        testLayer.jk.animationCornerRadius(cornerRadius: 50)
        testLayer.jk.animationMovePoint(to: CGPoint(x: 150, y: 150), duration: 5, delay: 1, repeatNumber: 1, removedOnCompletion: false, option: .default)
        JKAsyncs.asyncDelay(6) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
}

// MARK: - 一、基本的扩展
extension CALayerExtensionViewController {
    
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
    
    // MARK: 1.09、设置边框颜色
    @objc func test109() {
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
    
    // MARK: 1.08、设置边框宽度
    @objc func test108() {
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
    
    // MARK: 1.07、是否隐藏
    @objc func test107() {
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
    
    // MARK: 1.06、添加到父视图(CALayer)
    @objc func test106() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.addTo(self.view.layer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.05、添加到父视图
    @objc func test105() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.04、设置frame
    @objc func test104() {
        let testLayer = CALayer()
        testLayer.frame(CGRect(x: 100, y: 100, width: 100, height: 100))
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        self.view.layer.addSublayer(testLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.03、设置背景色 (十六进制字符串)
    @objc func test103() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor("#7B68EE")
        self.view.layer.addSublayer(testLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.02、设置背景色
    @objc func test102() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor(UIColor.randomColor)
        self.view.layer.addSublayer(testLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.01、设置圆角
    @objc func test101() {
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
}
