//
//  UIImage+Gradient.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/28.
//

import UIKit

//生成渐变色图片
public extension UIImage {
    
    enum GradientDirection {
        case horizontal // 水平从左到右
        case vertical // 垂直从上到下
        case leftOblique // 左上到右下
        case rightOblique // 右上到左下
        case other(CGPoint, CGPoint)
        
        public func point(size: CGSize) -> (CGPoint, CGPoint) {
            switch self {
            case .horizontal:
                return (CGPoint.init(x: 0, y: 0), CGPoint.init(x: size.width, y: 0))
            case .vertical:
                return (CGPoint.init(x: 0, y: 0), CGPoint.init(x: 0, y: size.height))
            case .leftOblique:
                return (CGPoint.init(x: 0, y: 0), CGPoint.init(x: size.width, y: size.height))
            case .rightOblique:
                return (CGPoint.init(x: size.width, y: 0), CGPoint.init(x: 0, y: size.height))
            case .other(let stat, let end):
                return (stat, end)
            }
        }
        
    }
    
    class func gradient(_ hexsString: [String], size: CGSize = CGSize.init(width: 1, height: 1), locations:[CGFloat]? = nil, direction: GradientDirection = .horizontal) -> UIImage? {
        return gradient(hexsString.map{ UIColor.hexColor(hex: $0) }, size: size, locations: locations, direction: direction)
    }
    
    class func gradient(_ colors: [UIColor], size: CGSize = CGSize.init(width: 10, height: 10), locations:[CGFloat]? = nil, direction: GradientDirection = .horizontal) -> UIImage? {
        if colors.count == 0 {
            return nil
        }
        if colors.count == 1 {
            return UIImage.image(color: colors[0])
        }
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map{$0.cgColor} as CFArray, locations: locations?.map { CGFloat($0) }) else { return nil }
        
        let directionPoint = direction.point(size: size)
        context?.drawLinearGradient(gradient, start: directionPoint.0, end: directionPoint.1, options: .drawsBeforeStartLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func gradient(_ colors: [UIColor],
                        size: CGSize = CGSize.init(width: 10, height: 10),
                        round: CGFloat,
                        locations:[CGFloat]? = nil,
                        direction: GradientDirection = .horizontal) -> UIImage? {
        if colors.count == 0 {
            return nil
        }
        if colors.count == 1 {
            return UIImage.image(color: colors[0])
        }
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: round)
        path.addClip()
        context?.addPath(path.cgPath)
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map{$0.cgColor} as CFArray, locations: locations?.map { CGFloat($0) }) else { return nil }
        
        let directionPoint = direction.point(size: size)
        context?.drawLinearGradient(gradient, start: directionPoint.0, end: directionPoint.1, options: .drawsBeforeStartLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

