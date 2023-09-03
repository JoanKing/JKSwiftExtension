//
//  UIBezierPathViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2023/8/14.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class UIBezierPathViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green
        
        let viewRect = CGRect(x: 10, y: 150, width: 300, height: 300)
        let view1 = MyCanvas(frame: viewRect)
        self.view.addSubview(view1)
        
        let viewRect1 = CGRect(x: 50, y: view1.jk.bottom + 30, width: 200, height: 200)
        let myEmptyView = MyView(frame:viewRect1)
        self.view.addSubview(myEmptyView)
    }
}

class MyCanvas: UIView {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.yellow
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let randus: CGFloat = 100
         
        //创建一个矩形，它的所有边都内缩5%
        let drawingRect = self.bounds.insetBy(dx: 0,
                                              dy: 0)
         
        //确定组成绘画的点
        let topRight = CGPoint(x: drawingRect.maxX, y: drawingRect.minY)
        let bottomLeft = CGPoint(x: drawingRect.minX, y: drawingRect.maxY)
        
        let center1 = CGPoint(x: drawingRect.maxX, y: drawingRect.minY + randus)
        let center2 = CGPoint(x: drawingRect.maxX, y: drawingRect.maxY - randus)
        let center3 = CGPoint(x: drawingRect.minX, y: drawingRect.maxY - randus)
        let center4 = CGPoint(x: drawingRect.minX, y: randus)
         
        // 创建一个贝塞尔路径
        let bezierPath = UIBezierPath()
        bezierPath.move(to: topRight)
        bezierPath.addArc(withCenter: center1, radius: randus, startAngle: -CGFloat(Double.pi / 2), endAngle: -CGFloat(Double.pi), clockwise: false)
        bezierPath.addLine(to: CGPoint(x: drawingRect.maxX - randus, y:  drawingRect.maxY - randus))
        bezierPath.addArc(withCenter: center2, radius: randus, startAngle: -CGFloat(Double.pi), endAngle: -CGFloat(Double.pi * 3 / 2), clockwise: false)
        bezierPath.addLine(to: bottomLeft)
        bezierPath.addArc(withCenter: center3, radius: randus, startAngle: -CGFloat(Double.pi * 3 / 2), endAngle: -CGFloat(Double.pi * 2), clockwise: false)
        bezierPath.addLine(to: CGPoint(x: randus, y: randus))
        bezierPath.addArc(withCenter: center4, radius: randus, startAngle: 0, endAngle: -CGFloat(Double.pi / 2), clockwise: false)
        bezierPath.addLine(to: topRight)
        // 使路径闭合，结束绘制
        bezierPath.close()
         
        // 设定颜色，并绘制它们
        UIColor.brown.setFill()
        UIColor.black.setStroke()
        bezierPath.fill()
        bezierPath.stroke()
    }
}

class MyView : UIView{
    override func draw(_ rect: CGRect) {
        //创建一条空Bezier路径
        let bezierPath = UIBezierPath()
        
        // 为两个组成部分定义矩形
        let squareRect = CGRectInset(rect, rect.size.width*0.45, rect.size.height*0.05)
        
        let circleRect = CGRectInset(rect, rect.size.width*0.3, rect.size.height*0.3)
        
        let cornerRadius : CGFloat = 20
        
        // 创建路径
        let circlePath = UIBezierPath(ovalIn: circleRect)
        let squarePath = UIBezierPath(roundedRect: squareRect, cornerRadius: cornerRadius)
        
        // 将它们添加到主路径
        squarePath.append(circlePath)
        bezierPath.append(squarePath)
        
        // 设定颜色并绘制它们
        UIColor.red.setFill()
        
        // 绘制路径
        bezierPath.fill()
    }
}

