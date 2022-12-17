//
//  JKDrawSignatureView.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/2/22.
//

import UIKit
 
public class JKDrawSignatureView: UIView {
     
    /// 公共属性
    public var lineWidth: CGFloat = 2.0 {
        didSet {
            self.path.lineWidth = lineWidth
        }
    }
    public var strokeColor: UIColor = UIColor.black
    public var signatureBackgroundColor: UIColor = UIColor.white
     
    /// 私有属性
    fileprivate var path = UIBezierPath()
    fileprivate var pts = [CGPoint](repeating: CGPoint(), count: 5)
    fileprivate var ctr = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.lineWidth
    }
     
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.lineWidth
    }
     
    /// Draw
    override open func draw(_ rect: CGRect) {
        self.strokeColor.setStroke()
        self.path.stroke()
    }
     
    /// 触摸签名相关方法
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first{
            let touchPoint = firstTouch.location(in: self)
            self.ctr = 0
            self.pts[0] = touchPoint
        }
    }
     
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first{
            let touchPoint = firstTouch.location(in: self)
            self.ctr += 1
            self.pts[self.ctr] = touchPoint
            if (self.ctr == 4) {
                self.pts[3] = CGPoint(x: (self.pts[2].x + self.pts[4].x) / 2.0, y: (self.pts[2].y + self.pts[4].y) / 2.0)
                self.path.move(to: self.pts[0])
                self.path.addCurve(to: self.pts[3], controlPoint1:self.pts[1],
                    controlPoint2:self.pts[2])
                self.setNeedsDisplay()
                self.pts[0] = self.pts[3]
                self.pts[1] = self.pts[4]
                self.ctr = 1
            }
            self.setNeedsDisplay()
        }
    }
     
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.ctr == 0{
            let touchPoint = self.pts[0]
            self.path.move(to: CGPoint(x: touchPoint.x-1.0,y: touchPoint.y))
            self.path.addLine(to: CGPoint(x: touchPoint.x+1.0,y: touchPoint.y))
            self.setNeedsDisplay()
        } else {
            self.ctr = 0
        }
    }
     
    /// 签名视图清空
    public func clearSignature() {
        self.path.removeAllPoints()
        self.setNeedsDisplay()
    }
     
    /// 将签名保存为UIImage
    public func getSignature() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return signature
    }
}
