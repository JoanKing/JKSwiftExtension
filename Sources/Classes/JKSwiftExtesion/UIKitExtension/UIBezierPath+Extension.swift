//
//  UIBezierPath+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/9.
//

import UIKit
extension UIBezierPath: JKPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JKPOP where Base: UIBezierPath {
    
    // MARK: 1.1、根据圆上任意三个点添加圆弧
    /// 根据圆上任意三个点添加圆弧
    /// - Parameters:
    ///   - startPoint: 起点
    ///   - centerPoint: 中间任意一点
    ///   - endPoint: 结束点
    ///   - clockwise: 顺时针方向
    func addArc(startPoint: CGPoint, centerPoint: CGPoint, endPoint: CGPoint, clockwise: Bool) {
        // 求圆心
        let arcCenter = getCircleCenter(pontA: startPoint, pontB: centerPoint, pontC: endPoint)
        // 求半径
        let radius = getRadius(center: arcCenter, point: startPoint)
        // 求角度
        let startAngle = getAngle(center: arcCenter, point: startPoint)
        let endAngle = getAngle(center: arcCenter, point: endPoint)
        base.addArc(withCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
    
    // MARK: 1.2、根据圆心和任意2个点添加圆弧
    /// 根据圆心和任意2个点添加圆弧
    /// - Parameters:
    ///   - arcCenter: 圆心
    ///   - startPoint: 起点
    ///   - endPoint: 结束点
    ///   - clockwise: 顺时针，逆时针 这个决定这哪一个半圆
    func addArc(arcCenter: CGPoint, startPoint: CGPoint, endPoint: CGPoint, clockwise: Bool) {
        // 求半径
        let radius = getRadius(center: arcCenter, point: startPoint)
        // 求角度
        let startAngle = getAngle(center: arcCenter, point: startPoint)
        let endAngle = getAngle(center: arcCenter, point: endPoint)
        base.addArc(withCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
}

// MARK: - fileprivate 方法
fileprivate extension JKPOP where Base: UIBezierPath {
    
    // 计算圆心类
    // MARK:  计算出圆心
    /**
     求圆心思路
     0. 设置原先坐标为(centerX，centerY)
     1.求出AB线的斜率，根据AB线的斜率 * AB垂线的斜率 = -1 得出 AB垂线的斜率: shapeABVertical
     2.求出AB的中点，即AB垂线上的点。abCenter
     3.根据斜率 = （y1-y2）/ (x1-x2)
     得出方程：shapeABVertical = (abCenter.y - centerY) / (abCenter.x - centerX)
     同理得出：shapeBCVertical = (bcCenter.y - centerY) / (bcCenter.x - centerX)
     */
    func getCircleCenter(pontA: CGPoint, pontB: CGPoint, pontC: CGPoint) -> CGPoint {
        let abCenter = getCenterPoint(pontA: pontA, pontB: pontB)
        let slopeAB = getSlope(pontA: pontA, pontB: pontB)
        let slopeABVertical = -1 / slopeAB
        
        let bcCenter = getCenterPoint(pontA: pontB, pontB: pontC)
        let slopeBC = getSlope(pontA: pontB, pontB: pontC)
        let slopeBCVertical = -1 / slopeBC
        
        return getCircleCenter(slopeA: slopeABVertical, pointA: abCenter, slopeB: slopeBCVertical, pointB: bcCenter)
    }
    
    func getCircleCenter(slopeA: CGFloat, pointA: CGPoint, slopeB: CGFloat, pointB: CGPoint) -> CGPoint {
        let centerX = -(pointA.y - slopeA * pointA.x - pointB.y + slopeB * pointB.x)/(slopeA - slopeB)
        let centerY = pointA.y - slopeA * (pointA.x - centerX)
        return CGPoint(x: centerX, y: centerY)
    }
    
    // MARK: 获取两点之间中间点
    /// 获取两点之间中间点
    /// - Parameters:
    ///   - pontA: A 点
    ///   - pontB: B 点
    /// - Returns: 两点之间中间点
    func getCenterPoint(pontA: CGPoint, pontB: CGPoint) -> CGPoint {
        return CGPoint(x: (pontA.x + pontB.x) / 2, y: (pontA.y + pontB.y) / 2)
    }
    
    // MARK: 获取某条线的斜率
    /// 获取某条线的斜率
    /// - Parameters:
    ///   - pontA: A 点
    ///   - pontB: B 点
    /// - Returns: 某条线的斜率
    func getSlope(pontA: CGPoint, pontB: CGPoint) -> CGFloat {
        return (pontB.y - pontA.y) / (pontB.x - pontA.x)
    }
    
    // MARK: 计算出半径
    /// 计算出半径
    /// - Parameters:
    ///   - center: 中心点
    ///   - point: 圆上的某点
    /// - Returns: 圆的半径
    func getRadius(center: CGPoint, point: CGPoint) -> CGFloat {
        // 求半径
        let a :Double = Double(abs(point.x - center.x))
        let b :Double = Double(abs(point.y - center.y))
        let radius = sqrtf(Float(a * a + b * b))
        return CGFloat(radius)
    }
    
    // MARK: 获取圆心角的方法
    /**
     根据圆心和圆上的点，求出圆角
     ------------------------------------------>
     |                  |
     |                  |
     |     第 三 象 限    |    第四象限
     |                  |
     |                  |
     |                  |
     |                  |
     |------------------------------------------
     |                  |
     |                  |
     |      第 二 象 限   |   第一象限
     |                  |
     |                  |
     */
    /// 获取圆心角的方法
    /// - Parameters:
    ///   - center: 圆心
    ///   - point: 点
    /// - Returns: 圆角
    func getAngle(center: CGPoint, point: CGPoint) -> CGFloat {
        let pointX = point.x
        let pointY = point.y
        
        let centerX = center.x
        let centerY = center.y
        
        let a = abs(pointX - centerX)
        let b = abs(pointY - centerY)
        
        var angle :Double = 0
        if (angle > Double.pi / 2) {
            return CGFloat(angle)
        }
        if (pointX > centerX && pointY >= centerY) {//第一象限
            angle = Double(atan(b / a))
        } else if (pointX <= centerX && pointY > centerY){////第二象限
            angle =  Double(atan(a / b))
            if (a == 0) {
                angle = 0
            }
            angle = angle + Double.pi / 2
        } else if (pointX < centerX && pointY <= centerY){//第三象限
            angle = Double(atan(b / a))
            if (a == 0) {
                angle = 0
            }
            angle = angle + Double.pi
            
        } else if (pointX >= centerX && pointY < centerY){//第四象限
            angle = Double(atan(a / b))
            if (a == 0) {
                angle = 0
            }
            angle = angle + Double.pi / 2 * 3
        }
        return CGFloat(angle)
    }
}
