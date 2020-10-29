//
//  JKEmitterable.swift
//  粒子动画
//
//  Created by 王冲 on 2020/7/23.
//  Copyright © 2020 王冲. All rights reserved.
//

import Foundation
import UIKit
/// 粒子发射器
public protocol JKEmitterable {
    
}

public class JKEmitterStyle: NSObject {
    /// 开启三维效果
    var preservesDepth: Bool = true
    /// 设置发射器位置
    var emitterPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height - 30)
}

// 只有 控制器才可以遵守协议 extension JKEmitterable where Self : UIViewController
public extension JKEmitterable where Self : UIViewController {
    
    /// 启动发射器
    /// - Parameters:
    ///   - emitterImageName: 发射器图片的名字
    ///   - style: 发射器的样式
    public func startEmitter(emitterImageName: String, style: JKEmitterStyle = JKEmitterStyle()) {
        // 1、发射器的设置
        // 1.1、创建发射器
        let emitter = CAEmitterLayer()
        // 1.2、设置发射器位置
        emitter.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: view.bounds.height - 30)
        // 1.3、开启三维效果
        emitter.preservesDepth = style.preservesDepth
        // 创造3d粒子
        // emitter.emitterShape = CAEmitterLayerEmitterShape.line;
        
        // 2、创建例子，并且设置例子相关的属性
        // 2.1、创建例子 cell
        let cell = CAEmitterCell()
        // 2.2、设置粒子速度(velocity-velocityRange 到 velocity+velocityRange)
        // 50 - 250
        cell.velocity = 150
        cell.velocityRange = 100
        // 2.3、创建粒子的大小
        cell.scale = 0.7
        cell.scaleRange = 0.3
        // 2.4、设置粒子的方向
        cell.emissionLongitude = CGFloat(-Double.pi/2)
        cell.emissionRange = CGFloat(Double.pi/5)
        // 2.5、设置粒子旋转
        cell.spin = CGFloat(Double.pi/2)
        cell.spinRange = CGFloat(Double.pi/4)
        // 2.6、设置粒子存活的时间
        cell.lifetime = 3
        cell.lifetimeRange = 1.5
        // 2.7、设置例子每秒弹出的个数
        cell.birthRate = 10
        // 2.8、设置粒子展示的图片
        cell.contents = UIImage(named: emitterImageName)?.cgImage
        // 设置粒子的颜色
        cell.color = UIColor.randomColor.cgColor
        
        // 3、将粒子设置到发射器中
        emitter.emitterCells = [cell]
        
        // 4.将发射器的Layer添加到父Layer中
        view.layer.addSublayer(emitter)
    }
    
    /// 停止发射器
    public func stopEmitter() {
        // 方式一
        let layers = view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self)})
        guard let weaklayers = layers else {
            return
        }
        for layer in weaklayers {
            layer.removeFromSuperlayer()
        }
        // 方式二
        /*
         for layer in view.layer.sublayers! {
         if layer.isKind(of: CAEmitterLayer.self) {
         layer.removeFromSuperlayer()
         }
         }
         */
    }
}
