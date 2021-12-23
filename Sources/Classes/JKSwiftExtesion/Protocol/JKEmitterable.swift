//
//  JKEmitterable.swift
//  粒子动画
//
//  Created by 王冲 on 2020/7/23.
//  Copyright © 2020 王冲. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 粒子发射器
/**
 两部分组成：粒子发射引擎 和 粒子单元
 1、粒子发射引擎(CAEmitterLayer)：负责粒子发射效果的宏观属性，例如粒子的发生速度、粒子的存活时间、粒子的发射位置等等
 CAEmitterLayer的属性：
 - emitterCells：CAEmitterCell对象的数组，用于把粒子投放到layer上
 - birthRate：粒子产生速度，默认1个每秒
 - lifetime：粒子纯在时间，默认1秒
 - emitterPosition：发射器在xy平面的中心位置
 - emitterZPosition：发射器在z平面的位置
 - preservesDepth：是否开启三维效果
 - velocity：粒子运动速度
 - scale：粒子的缩放比例
 - spin：自旋转速度
 - seed：用于初始化随机数产生的种子
 - emitterSize：发射器的尺寸
 - emitterDepth：发射器的深度
 - emitterShape：发射器的形状
 - point: 点的形状，粒子从一个点发出
 - line:  线的形状，粒子从一条线发出
 - rectangle: 矩形形状，粒子从一个矩形中发
 - cuboid: 立方体形状，会影响Z平面的效果
 - circle: 粒子发射器引擎为球圆形形状，粒子会在圆形范围发射
 - sphere:  粒子发射器引擎为球形形状
 - emitterMode：发射器发射模式
 - points 从发射器中发出
 - outline 从发射器边缘发出
 - surface 从发射器表面发出
 - volume 从发射器中点发出
 - renderMode：发射器渲染模式
 - unordered: 粒子无序出现，多个粒子单元发射器的粒子将混合
 - oldestFirst: 生命久的粒子会被渲染在最上层
 - oldestLast: 生命短的粒子会被渲染在最上层
 - backToFront: 粒子的渲染按照Z轴进行上下排序
 - additive: 粒子将被混合
 
 2、粒子单元(CAEmitterCell)：用来设置具体单位粒子的属性，例如粒子的运动速度、粒子的形变与颜色等等
 CAEmitterCell的属性：
 - name：粒子的名字
 - color：粒子的颜色
 - enabled：粒子是否渲染
 - contents：渲染粒子，是个CGImageRef的对象，即粒子要展示的图片
 - contentsRect：渲染范围
 - birthRate：粒子产生速度
 - lifetime：生命周期
 - lifetimeRange：生命周期增减范围
 - velocity：粒子运动速度
 - velocityRange：速度范围
 - spin：粒子旋转速度
 - spinrange：粒子旋转速度范围
 - scale：缩放比例
 - scaleRange：缩放比例范围
 - scaleSpeed：缩放比例速度
 - alphaRange:：一个粒子的颜色alpha能改变的范围
 - alphaSpeed:：粒子透明度在生命周期内的改变速度
 - redRange：一个粒子的颜色red能改变的范围
 - redSpeed：粒子red在生命周期内的改变速度
 - blueRange：一个粒子的颜色blue能改变的范围
 - blueSpeed：粒子blue在生命周期内的改变速度
 - greenRange：一个粒子的颜色green能改变的范围
 - greenSpeed：粒子green在生命周期内的改变速度
 - xAcceleration：粒子x方向的加速度分量
 - yAcceleration：粒子y方向的加速度分量
 - zAcceleration：粒子z方向的加速度分量
 - emissionRange：粒子发射角度范围
 - emissionLongitude：粒子在x-y平面的发射角度
 - emissionLatitude：发射的z轴方向的发射角度
 */

public protocol JKEmitterable {
}

public class JKEmitterStyle: NSObject {
    /************* 粒子发射器 ********************/
    /// 开启三维效果
    public var preservesDepth: Bool = true
    /// 设置发射器位置
    public var emitterPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height - 30)
    /// 发射器的形状，默认 球型
    public var emitterShape: CAEmitterLayerEmitterShape = CAEmitterLayerEmitterShape.sphere
    
    /************* 粒子单元 ********************/
    /// 缩放比例
    public var cellScale: CGFloat = 0.7
    /// 缩放比例范围
    public var cellScaleRange: CGFloat = 0.3
    /// 粒子存活的时间（指：粒子从创建出来展示在界面上到从界面上消失释放的整个过程）
    public var cellEmitterLifetime: Float = 3
    /// 生命周期增减范围
    public var cellLifetimeRange: Float = 3
    /// 设置例子每秒弹出的个数
    public var cellEmitterBirthRate: Float = 10
    /// 粒子的颜色
    public var cellColor: UIColor = .white
    /// 粒子旋转速度
    public var cellSpin: CGFloat = CGFloat(Double.pi/2)
    /// 粒子旋转速度范围
    public var cellSpinRange: CGFloat = CGFloat(Double.pi/4)
    /// 粒子运动速度
    public var cellVelocity: CGFloat = 150
    /// 速度范围
    public var cellVelocityRange: CGFloat = 100
    /// 设置粒子的方向
    public var cellEmissionLongitude: CGFloat = CGFloat(-Double.pi/2)
    /// 粒子发射角度范围
    public var cellEmissionRange: CGFloat = CGFloat(Double.pi/5)
    
    /// 粒子是否只发射一次
    public var cellFireOnce: Bool = false
}

// 只有 控制器才可以遵守协议 extension JKEmitterable where Self : UIViewController
public extension JKEmitterable where Self : UIViewController {
    
    // MARK: 启动 粒子发射器
    /// 启动 粒子发射器
    /// - Parameters:
    ///   - emitterImageNames: 粒子单元图片名
    ///   - style: 发射器和粒子的样式
    @discardableResult
    func startEmitter(emitterImageNames: [String], style: JKEmitterStyle = JKEmitterStyle()) -> CAEmitterLayer {
        // 1、发射器的设置
        // 1.1、创建发射器
        let emitter = CAEmitterLayer()
        emitter.backgroundColor = UIColor.brown.cgColor
        // 1.2、设置发射器位置
        emitter.emitterPosition = style.emitterPosition
        // 1.3、是否开启三维效果
        emitter.preservesDepth = style.preservesDepth
        // 1.4、发射器的形状
        // 2、创建例子，并且设置例子相关的属性
        let cells = createEmitterCell(emitterImageNames: emitterImageNames, style: style)
        // 3、将粒子设置到发射器中
        emitter.emitterCells = cells
        // 4.将发射器的Layer添加到父Layer中
        view.layer.addSublayer(emitter)
        
        JKAsyncs.asyncDelay(0.1) {
        } _: {
            guard style.cellFireOnce else { return }
            emitter.birthRate = 0
            JKAsyncs.asyncDelay(1) {
            } _: {[weak self] in
                guard let weakSelf = self else { return }
                weakSelf.stopEmitter()
            }
        }
        return emitter
    }
    
    // MARK: 停止 粒子发射器
    ///  停止 粒子发射器
    func stopEmitter() {
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
    
    /// 创建例子，并且设置例子相关的属性
    /// - Parameters:
    ///   - emitterImageNames: 粒子单元图片名
    ///   - style: 发射器和粒子的样式
    /// - Returns: 粒子数组
    private func createEmitterCell(emitterImageNames: [String], style: JKEmitterStyle) -> [CAEmitterCell] {
        // 粒子单元数组
        var cells: [CAEmitterCell] = []
        for emitterImageName in emitterImageNames {
            // 2、创建例子，并且设置例子相关的属性
            // 2.1、创建例子 cell
            let cell = CAEmitterCell()
            // 2.2、设置粒子速度(velocity-velocityRange 到 velocity+velocityRange)
            // 15.0 +- 200
            // 初始速度
            cell.velocity = style.cellVelocity
            // 速度范围
            cell.velocityRange = style.cellVelocityRange
            // x 轴上的加速度
            // cell.xAcceleration = 5.0
            // y 轴上的加速度
            // cell.yAcceleration = 30.0
            // 2.3、创建粒子的大小
            cell.scale = style.cellScale
            cell.scaleRange = style.cellScaleRange
            // 2.4、设置粒子的方向
            cell.emissionLongitude = style.cellEmissionLongitude
            // 周围发射角度
            cell.emissionRange = style.cellEmissionRange
            // 2.5、设置粒子旋转
            // 粒子旋转速度
            cell.spin = style.cellSpin
            // 粒子旋转速度范围
            cell.spinRange = style.cellSpinRange
            // 2.6、设置粒子存活的时间
            cell.lifetime = style.cellEmitterLifetime
            // 生命周期增减范围
            cell.lifetimeRange = style.cellLifetimeRange
            // 2.7、设置粒子每秒弹出的个数
            cell.birthRate = style.cellEmitterBirthRate
            // 2.8、设置粒子展示的图片
            cell.contents = UIImage(named: emitterImageName)?.cgImage
            // 2.9、设置粒子的颜色
            cell.color = style.cellColor.cgColor
            // 2.10、粒子透明度能改变的范围
            // cell.alphaRange = 0.3
            // 2.11、粒子透明度在生命周期内的改变速度
            // cell.alphaSpeed = 1
            // 2.12、添加粒子单元到数组
            cells.append(cell)
        }
        return cells
    }
}
