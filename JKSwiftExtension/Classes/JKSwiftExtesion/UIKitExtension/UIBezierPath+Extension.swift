//
//  UIBezierPath+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/9.
//

import UIKit

/// 贝塞尔曲线扩展下，提供一个画弧线的简单方法，
public extension UIBezierPath {
    
    // MARK:- 根据圆上任意三个点添加圆弧
    /// 根据圆上任意三个点添加圆弧
    /// - Parameters:
    ///   - startPoint: 起点
    ///   - centerPoint: 中间任意一点
    ///   - endPoint: 结束点
    ///   - clockwise: 顺时针方向
    func addArc(startPoint: CGPoint, centerPoint: CGPoint, endPoint: CGPoint, clockwise: Bool) {
        
        //求圆心
        let arcCenter = getCircleCenter(pontA: startPoint, pontB: centerPoint, pontC: endPoint)
        //求半径
        let radius = getRadius(center: arcCenter, point: startPoint)
        //求角度
        let startAngle = getAngle(center: arcCenter, point: startPoint)
        let endAngle = getAngle(center: arcCenter, point: endPoint)
        
        addArc(withCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
    
    // MARK:- 根据圆心和任意2个点添加圆弧
    /// 根据圆心和任意2个点添加圆弧
    /// - Parameters:
    ///   - arcCenter: 圆心
    ///   - startPoint: 起点
    ///   - endPoint: 结束点
    ///   - clockwise: 顺时针，逆时针 这个决定这哪一个半圆
    func addArc(arcCenter: CGPoint, startPoint: CGPoint, endPoint: CGPoint, clockwise: Bool) {
        //求半径
        let radius = getRadius(center: arcCenter, point: startPoint)
        //求角度
        let startAngle = getAngle(center: arcCenter, point: startPoint)
        let endAngle = getAngle(center: arcCenter, point: endPoint)
        addArc(withCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
    
    
}
/// 计算圆心类
// MARK: - 计算出圆心
/**
 求圆心思路
 0. 设置原先坐标为(centerX，centerY)
 
 1.求出AB线的斜率，根据AB线的斜率 * AB垂线的斜率 = -1 得出 AB垂线的斜率: shapeABVertical
 2.求出AB的中点，即AB垂线上的点。abCenter
 3.根据斜率 = （y1-y2）/(x1-x2)
 得出方程：shapeABVertical = (abCenter.y-centerY)/(abCenter.x-centerX)
 
 同理得出 shapeBCVertical = (bcCenter.y-centerY)/(bcCenter.x-centerX)
 */

fileprivate func getCircleCenter(pontA: CGPoint, pontB: CGPoint, pontC: CGPoint) -> CGPoint {
    let abCenter = getCenterPoint(pontA: pontA, pontB: pontB)
    let slopeAB = getSlope(pontA: pontA, pontB: pontB)
    let slopeABVertical = -1 / slopeAB
    
    let bcCenter = getCenterPoint(pontA: pontB, pontB: pontC)
    let slopeBC = getSlope(pontA: pontB, pontB: pontC)
    let slopeBCVertical = -1 / slopeBC
    
    return getCircleCenter(slopeA: slopeABVertical, pointA: abCenter, slopeB: slopeBCVertical, pointB: bcCenter)
    /**
     (abCenter.y-centerY)/(abCenter.x-centerX) = slopeABVertical;
     centerY = abCenter.y - slopeABVertical*(abCenter.x-centerX)
     
     (bcCenter.y-centerY)/(bcCenter.x-centerX) = slopeBCVertical;
     centerY = bcCenter.y - slopeBCVertical*(bcCenter.x- centerX);
     
     abCenter.y - slopeABVertical*abCenter.x - slopeABVertical*centerX = bcCenter.y - slopeBCVertical*bcCenter.x - slopeBCVertical*centerX;
     abCenter.y - slopeABVertical*abCenter.x - bcCenter.y + slopeBCVertical*bcCenter.x = (slopeABVertical-slopeBCVertical)*centerX;
     */
}

fileprivate func getCircleCenter(slopeA: CGFloat, pointA: CGPoint, slopeB: CGFloat, pointB: CGPoint) -> CGPoint {
    let centerX = -(pointA.y - slopeA * pointA.x - pointB.y + slopeB * pointB.x)/(slopeA - slopeB)
    let centerY = pointA.y - slopeA * (pointA.x - centerX)
    return CGPoint(x: centerX, y: centerY)
}
/// 获取两点之间中间点
fileprivate func getCenterPoint(pontA: CGPoint, pontB: CGPoint) -> CGPoint {
    return CGPoint(x: (pontA.x + pontB.x) / 2, y: (pontA.y + pontB.y) / 2)
}

/// 获取某条线的斜率
fileprivate func getSlope(pontA: CGPoint, pontB: CGPoint) -> CGFloat {
    return (pontB.y - pontA.y) / (pontB.x - pontB.x)
}

// MARK: - 计算出半径
fileprivate func getRadius(center: CGPoint, point: CGPoint) -> CGFloat {
    //求半径
    
    let a :Double = Double(abs(point.x - center.x))
    let b :Double = Double(abs(point.y - center.y))
    
    let radius = sqrtf(Float(a * a + b * b))
    
    return CGFloat(radius)
}

// MARK: - 获取圆心角的方法
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
 |                  |
 @param center 圆心
 @param point 点
 @return 圆角
 */
fileprivate func getAngle(center: CGPoint, point: CGPoint) -> CGFloat {
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
    }else if (pointX <= centerX && pointY > centerY){////第二象限
        angle =  Double(atan(a / b))
        if (a == 0) {
            angle = 0
        }
        angle = angle + Double.pi / 2
    }else if (pointX < centerX && pointY <= centerY){//第三象限
        angle = Double(atan(b / a));
        if (a == 0) {
            angle = 0
        }
        angle = angle + Double.pi
        
    }else if (pointX >= centerX && pointY < centerY){//第四象限
        angle = Double(atan(a / b));
        if (a == 0) {
            angle = 0
        }
        angle = angle + Double.pi / 2 * 3
    }
    return CGFloat(angle)
}

