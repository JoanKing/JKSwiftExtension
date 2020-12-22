//
//  UIImage+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit
import AVFoundation
import Dispatch

// MARK:- 一、基本的扩展
public extension UIImage {
    
    // MARK: 1.1、设置图片的圆角
    /// 设置图片的圆角
    /// - Parameters:
    ///   - radius: 圆角大小 (默认:3.0,图片大小)
    ///   - corners: 切圆角的方式
    ///   - imageSize: 图片的大小
    /// - Returns: 剪切后的图片
    func isRoundCorner(radius: CGFloat = 3, byRoundingCorners corners: UIRectCorner = .allCorners, imageSize: CGSize?) -> UIImage? {
        let weakSize = imageSize ?? size
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: weakSize)
        // 开始图形上下文
        UIGraphicsBeginImageContextWithOptions(weakSize, false, UIScreen.main.scale)
        guard let contentRef: CGContext = UIGraphicsGetCurrentContext() else {
            // 关闭上下文
            UIGraphicsEndImageContext()
            return nil
        }
        // 绘制路线
        contentRef.addPath(UIBezierPath(roundedRect: rect,
                                        byRoundingCorners: UIRectCorner.allCorners,
                                        cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        // 裁剪
        contentRef.clip()
        // 将原图片画到图形上下文
        draw(in: rect)
        contentRef.drawPath(using: .fillStroke)
        guard let output = UIGraphicsGetImageFromCurrentImageContext() else {
            // 关闭上下文
            UIGraphicsEndImageContext()
            return nil
        }
        // 关闭上下文
        UIGraphicsEndImageContext()
        return output
    }
    
    // MARK: 1.2、设置圆形图片
    /// 设置圆形图片
    /// - Returns: 圆形图片
    func isCircleImage() -> UIImage? {
        return isRoundCorner(radius: (self.size.width < self.size.height ? self.size.width : self.size.height) / 2.0, byRoundingCorners: .allCorners, imageSize: self.size)
    }
    
    // MARK: 1.3、获取视频的第一帧
    /// 获取视频的第一帧
    /// - Parameters:
    ///   - videoUrl: 视频 url
    ///   - maximumSize: 图片的最大尺寸
    /// - Returns: 视频的第一帧
    static func getVideoFirstImage(videoUrl: String, maximumSize: CGSize = CGSize(width: 1000, height: 1000), closure: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: videoUrl) else {
            closure(nil)
            return
        }
        DispatchQueue.global().async {
            let opts = [AVURLAssetPreferPreciseDurationAndTimingKey: false]
            let avAsset = AVURLAsset(url: url, options: opts)
            let generator = AVAssetImageGenerator(asset: avAsset)
            generator.appliesPreferredTrackTransform = true
            generator.maximumSize = maximumSize
            var cgImage: CGImage? = nil
            let time = CMTimeMake(value: 0, timescale: 600)
            var actualTime : CMTime = CMTimeMake(value: 0, timescale: 0)
            do {
                try cgImage = generator.copyCGImage(at: time, actualTime: &actualTime)
            } catch {
                DispatchQueue.main.async {
                    closure(nil)
                }
                return
            }
            guard let image = cgImage else {
                DispatchQueue.main.async {
                    closure(nil)
                }
                return
            }
            DispatchQueue.main.async {
                closure(UIImage(cgImage: image))
            }
        }
    }
    
    // MARK: 1.4、layer 转 image
    /// layer 转 image
    /// - Parameters:
    ///   - layer: layer 对象
    ///   - scale: 缩放比例
    /// - Returns: 返回转化后的 image
    static func image(from layer: CALayer, scale: CGFloat = 0.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    // MARK: 1.5、设置图片透明度
    /// 设置图片透明度
    /// alpha: 透明度
    /// - Returns: newImage
    func imageByApplayingAlpha(_ alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -area.height)
        context?.setBlendMode(.multiply)
        context?.setAlpha(alpha)
        context?.draw(self.cgImage!, in: area)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }

    // MARK: 1.6、裁剪给定区域
    /// 裁剪给定区域
    /// - Parameter crop: 裁剪区域
    /// - Returns: 剪裁后的图片
     func cropWithCropRect( _ crop: CGRect) -> UIImage? {
        let cropRect = CGRect(x: crop.origin.x * self.scale, y: crop.origin.y * self.scale, width: crop.size.width * self.scale, height: crop.size.height *  self.scale)
        if cropRect.size.width <= 0 || cropRect.size.height <= 0 {
            return nil
        }
        var image:UIImage?
        autoreleasepool{
            let imageRef: CGImage?  = self.cgImage!.cropping(to: cropRect)
            if let imageRef = imageRef {
                image = UIImage(cgImage: imageRef)
            }
        }
        return image
    }
    
    // MARK: 1.7、给图片添加文字水印
    /// 给图片添加文字水印
    /// - Parameters:
    ///   - drawTextframe: 水印的 frame
    ///   - drawText: 水印文字
    ///   - withAttributes: 水印富文本
    /// - Returns: 返回水印图片
    func drawTextInImage(drawTextframe: CGRect, drawText: String, withAttributes: [NSAttributedString.Key : Any]? = nil) -> UIImage {
        // 开启图片上下文
        UIGraphicsBeginImageContext(self.size)
        // 图形重绘
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        // 水印文字属性
        let attributes = withAttributes
        // 水印文字和大小
        let text = NSString(string: drawText)
        // 获取富文本的 size
        // let size = text.size(withAttributes: attributes)
        // 绘制文字
        text.draw(in: drawTextframe, withAttributes: attributes)
        // 从当前上下文获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    // MARK: 1.8、文字图片占位符
    /// 文字图片占位符
    /// - Parameters:
    ///   - text: 图片上的文字
    ///   - size: 图片的大小
    ///   - backgroundColor: 图片背景色
    ///   - textColor: 文字颜色
    ///   - isCircle: 是否要圆角
    ///   - isFirstChar: 是否展示第一个字符
    /// - Returns: 返回图片
    static func textImage(_ text: String, fontSize: CGFloat = 16, size: (CGFloat, CGFloat), backgroundColor: UIColor = UIColor.orange, textColor: UIColor = UIColor.white, isCircle: Bool = true, isFirstChar: Bool = false) -> UIImage? {
        // 过滤空内容
        if text.isEmpty { return nil }
        // 取第一个字符(测试了,太长了的话,效果并不好)
        let letter = isFirstChar ? (text as NSString).substring(to: 1) : text
        let sise = CGSize(width: size.0, height: size.1)
        let rect = CGRect(origin: CGPoint.zero, size: sise)
        
        let textsize = text.rectSize(font: UIFont.systemFont(ofSize: fontSize), size: CGSize(width: kScreenW, height: CGFloat(MAXFLOAT)))
        
        // 开启上下文
        UIGraphicsBeginImageContext(sise)
        // 拿到上下文
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        // 取较小的边
        let minSide = min(size.0, size.1)
        // 是否圆角裁剪
        if isCircle {
            UIBezierPath(roundedRect: rect, cornerRadius: minSide * 0.5).addClip()
        }
        // 设置填充颜色
        ctx.setFillColor(backgroundColor.cgColor)
        // 填充绘制
        ctx.fill(rect)
        let attr = [NSAttributedString.Key.foregroundColor : textColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)]
        // 写入文字
        // 文字写入的起点
        let pointX: CGFloat = textsize.width > minSide ? 0 : (minSide - textsize.width) / 2.0
        let pointY: CGFloat = (minSide - fontSize - 4) / 2.0
        (letter as NSString).draw(at: CGPoint(x: pointX, y: pointY), withAttributes: attr)
        // 得到图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: 1.9、更改图片颜色
    /// 更改图片颜色
    /// - Parameter color: 图片颜色
    /// - Returns: 返回更改后的图片颜色
    func imageWithColor(color : UIColor) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        guard let tintedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        return tintedImage
    }
}

// MARK:- 二、UIColor 生成的图片 和 生成渐变色图片
public extension UIImage {
    
    // MARK: 2.1、生成指定尺寸的纯色图像
    /// 生成指定尺寸的纯色图像
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片尺寸
    /// - Returns: 返回对应的图片
    static func image(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) -> UIImage? {
        return image(color: color, size: size, corners: .allCorners, radius: 0)
    }
    
    // MARK: 2.2、生成指定尺寸和圆角的纯色图像
    /// 生成指定尺寸和圆角的纯色图像
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片尺寸
    ///   - corners: 剪切的方式
    ///   - round: 圆角大小
    /// - Returns: 返回对应的图片
    static func image(color: UIColor, size: CGSize, corners: UIRectCorner, radius: CGFloat) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        if radius > 0 {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            color.setFill()
            path.fill()
        } else {
            context?.setFillColor(color.cgColor)
            context?.fill(rect)
        }
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
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
    
    // MARK: 2.3、生成渐变色的图片 ["#B0E0E6", "#00CED1", "#2E8B57"]
    /// 生成渐变色的图片 ["#B0E0E6", "#00CED1", "#2E8B57"]
    /// - Parameters:
    ///   - hexsString: 十六进制字符数组
    ///   - size: 图片大小
    ///   - locations: locations 数组
    ///   - direction: 渐变的方向
    /// - Returns: 渐变的图片
    static func gradient(_ hexsString: [String], size: CGSize = CGSize(width: 1, height: 1), locations:[CGFloat]? = nil, direction: GradientDirection = .horizontal) -> UIImage? {
        return gradient(hexsString.map{ UIColor.hexStringColor(hexString: $0) }, size: size, locations: locations, direction: direction)
    }
    
    // MARK: 2.4、生成渐变色的图片 [UIColor, UIColor, UIColor]
    /// 生成渐变色的图片 [UIColor, UIColor, UIColor]
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: 图片大小
    ///   - locations: locations 数组
    ///   - direction: 渐变的方向
    /// - Returns: 渐变的图片
    static func gradient(_ colors: [UIColor], size: CGSize = CGSize(width: 10, height: 10), locations:[CGFloat]? = nil, direction: GradientDirection = .horizontal) -> UIImage? {
        return gradient(colors, size: size, radius: 0, locations: locations, direction: direction)
    }
    
    // MARK: 2.5、生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]
    /// 生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: 图片大小
    ///   - radius: 圆角
    ///   - locations: locations 数组
    ///   - direction: 渐变的方向
    /// - Returns: 带圆角的渐变的图片
    static func gradient(_ colors: [UIColor],
                         size: CGSize = CGSize(width: 10, height: 10),
                         radius: CGFloat,
                         locations:[CGFloat]? = nil,
                         direction: GradientDirection = .horizontal) -> UIImage? {
        if colors.count == 0 { return nil }
        if colors.count == 1 {
            return UIImage.image(color: colors[0])
        }
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius)
        path.addClip()
        context?.addPath(path.cgPath)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map{$0.cgColor} as CFArray, locations: locations?.map { CGFloat($0) }) else { return nil
        }
        let directionPoint = direction.point(size: size)
        context?.drawLinearGradient(gradient, start: directionPoint.0, end: directionPoint.1, options: .drawsBeforeStartLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK:- 三、图片的拉伸和缩放
public extension UIImage {
    
    // MARK: 3.1、获取固定大小的 image
    /// 获取固定大小的image
    /// - Parameter size: 图片尺寸
    /// - Returns: 固定大小的 image
    func solidTo(size: CGSize) -> UIImage? {
        let w = size.width
        let h = size.height
        if self.size.height <= self.size.width {
            if self.size.width >= w {
                let scaleImage = fixOrientation().scaleTo(size: CGSize(width: w, height: w * self.size.height / self.size.width))
                return scaleImage
            } else {
                return fixOrientation()
            }
        } else {
            if self.size.height >= h {
                let scaleImage = fixOrientation().scaleTo(size: CGSize(width: h * self.size.width / self.size.height, height: h))
                return scaleImage
            } else {
                return fixOrientation()
            }
        }
    }
    
    // MARK: 3.2、按宽高比系数：等比缩放
    /// 按宽高比系数：等比缩放
    /// - Parameter scale: 要缩放的 宽高比 系数
    /// - Returns: 等比缩放 后的图片
    func scaleTo(scale: CGFloat) -> UIImage? {
        let w = self.size.width
        let h = self.size.height
        let scaledW = w * scale
        let scaledH = h * scale
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: scaledW, height: scaledH))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // MARK: 3.3、按指定尺寸等比缩放
    /// 按指定尺寸等比缩放
    /// - Parameter size: 要缩放的尺寸
    /// - Returns: 缩放后的图片
    func scaleTo(size: CGSize) -> UIImage? {
        if self.cgImage == nil { return nil }
        var w = CGFloat(self.cgImage!.width)
        var h = CGFloat(self.cgImage!.height)
        let verticalRadio = size.height / h
        let horizontalRadio = size.width / w
        var radio: CGFloat = 1
        if verticalRadio > 1 && horizontalRadio > 1 {
            radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio
        } else {
            radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio
        }
        w = w * radio
        h = h * radio
        let xPos = (size.width - w) / 2
        let yPos = (size.height - h) / 2
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: xPos, y: yPos, width: w, height: h))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    // MARK: 3.4、图片中间 1*1 拉伸——如气泡一般
    /// 图片中间1*1拉伸——如气泡一般
    /// - Returns: 拉伸后的图片
    func strechAsBubble() -> UIImage {
        let top = self.size.height * 0.5
        let left = self.size.width * 0.5
        let bottom = self.size.height * 0.5
        let right = self.size.width * 0.5
        let edgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        // 拉伸
        return self.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch)
    }
    
    // MARK: 3.5、调整图像方向 避免图像有旋转
    /// 调整图像方向 避免图像有旋转
    /// - Returns: 返正常的图片
    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -.pi / 2)
        default:
            break
        }
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: (self.cgImage?.bitsPerComponent)!, bytesPerRow: 0, space: (self.cgImage?.colorSpace)!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        ctx.concatenate(transform)
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        let cgImage: CGImage = ctx.makeImage()!
        return UIImage(cgImage: cgImage)
    }
}

// MARK:- 四、UIImage 压缩相关
public extension UIImage {
    
    // MARK: 4.1、压缩图片
    /// 压缩图片
    /// - Parameter mode: 压缩模式
    /// - Returns: 压缩后Data
    func compress(mode: CompressionMode = .medium) -> Data? {
        return resizeIO(resizeSize: mode.resize(size))?.compressDataSize(maxSize: mode.maxDataSize)
    }
    
    // MARK: 4.2、异步图片压缩
    /// 异步图片压缩
    /// - Parameters:
    ///   - mode: 压缩模式
    ///   - queue: 压缩队列
    ///   - complete: 完成回调(压缩后Data, 调整后分辨率)
    func asyncCompress(mode: CompressionMode = .medium, queue: DispatchQueue = DispatchQueue.global(), complete:@escaping (Data?, CGSize) -> Void) {
        queue.async {
            let data = self.resizeIO(resizeSize: mode.resize(self.size))?.compressDataSize(maxSize: mode.maxDataSize)
            DispatchQueue.main.async {
                complete(data, mode.resize(self.size))
            }
        }
    }
    
    // MARK: 4.3、压缩图片质量
    /// 压缩图片质量
    /// - Parameter maxSize: 最大数据大小
    /// - Returns: 压缩后数据
    func compressDataSize(maxSize: Int = 1024 * 1024 * 2) -> Data? {
        let maxSize = maxSize
        var quality: CGFloat = 0.8
        var data = self.jpegData(compressionQuality: quality)
        var dataCount = data?.count ?? 0
        
        while (data?.count ?? 0) > maxSize {
            if quality <= 0.6 {
                break
            }
            quality  = quality - 0.05
            data = self.jpegData(compressionQuality: quality)
            if (data?.count ?? 0) <= dataCount {
                break
            }
            dataCount = data?.count ?? 0
        }
        return data
    }
    
    // MARK: 4.4、ImageIO 方式调整图片大小 性能很好
    /// ImageIO 方式调整图片大小 性能很好
    /// - Parameter resizeSize: 图片调整Size
    /// - Returns: 调整后图片
    func resizeIO(resizeSize: CGSize) -> UIImage? {
        if size == resizeSize {
            return self
        }
        guard let imageData = pngData() else { return nil }
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        
        let maxPixelSize = max(size.width, size.height)
        let options = [kCGImageSourceCreateThumbnailWithTransform: true,
                       kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
                       kCGImageSourceThumbnailMaxPixelSize: maxPixelSize]  as CFDictionary
        
        let resizedImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options).flatMap{
            UIImage(cgImage: $0)
        }
        
        return resizedImage
    }
    
    // MARK: 4.5、CoreGraphics 方式调整图片大小 性能很好
    /// CoreGraphics 方式调整图片大小 性能很好
    /// - Parameter resizeSize: 图片调整Size
    /// - Returns: 调整后图片
    func resizeCG(resizeSize: CGSize) -> UIImage? {
        if size == resizeSize {
            return self
        }
        guard  let cgImage = self.cgImage else { return nil }
        guard  let colorSpace = cgImage.colorSpace else { return nil }
        guard let context = CGContext(data: nil,
                                      width: Int(resizeSize.width),
                                      height: Int(resizeSize.height),
                                      bitsPerComponent: cgImage.bitsPerComponent,
                                      bytesPerRow: cgImage.bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: cgImage.bitmapInfo.rawValue) else { return nil }
        context.interpolationQuality = .high
        context.draw(cgImage, in: CGRect(origin: .zero, size: resizeSize))
        let resizedImage = context.makeImage().flatMap {
            UIImage(cgImage: $0)
        }
        return resizedImage
    }
}

// MARK: 压缩模式
public enum CompressionMode {
    /// 分辨率规则
    private static let resolutionRule: (min: CGFloat, max: CGFloat, low: CGFloat, default: CGFloat, high: CGFloat) = (10, 4096, 512, 1024, 2048)
    /// 数据大小规则
    private static let  dataSizeRule: (min: Int, max: Int, low: Int, default: Int, high: Int) = (1024 * 10, 1024 * 1024 * 20, 1024 * 512, 1024 * 1024 * 2, 1024 * 1024 * 10)
    // 低质量
    case low
    // 中等质量 默认
    case medium
    // 高质量
    case high
    // 自定义(最大分辨率, 最大输出数据大小)
    case other(CGFloat, Int)
    
    fileprivate var maxDataSize: Int {
        switch self {
        case .low:
            return CompressionMode.dataSizeRule.low
        case .medium:
            return CompressionMode.dataSizeRule.default
        case .high:
            return CompressionMode.dataSizeRule.high
        case .other(_, let dataSize):
            if dataSize < CompressionMode.dataSizeRule.min {
                return CompressionMode.dataSizeRule.default
            }
            if dataSize > CompressionMode.dataSizeRule.max {
                return CompressionMode.dataSizeRule.max
            }
            return dataSize
        }
    }
    
    fileprivate func resize(_ size: CGSize) -> CGSize {
        if size.width < CompressionMode.resolutionRule.min || size.height < CompressionMode.resolutionRule.min {
            return size
        }
        let maxResolution = maxSize
        let aspectRatio = max(size.width, size.height) / maxResolution
        if aspectRatio <= 1.0 {
            return size
        } else {
            let resizeWidth = size.width / aspectRatio
            let resizeHeighth = size.height / aspectRatio
            if resizeHeighth < CompressionMode.resolutionRule.min || resizeWidth < CompressionMode.resolutionRule.min {
                return size
            } else {
                return CGSize.init(width: resizeWidth, height: resizeHeighth)
            }
        }
    }
    
    fileprivate var maxSize: CGFloat {
        switch self {
        case .low:
            return CompressionMode.resolutionRule.low
        case .medium:
            return CompressionMode.resolutionRule.default
        case .high:
            return CompressionMode.resolutionRule.high
        case .other(let size, _):
            if size < CompressionMode.resolutionRule.min {
                return CompressionMode.resolutionRule.default
            }
            if size > CompressionMode.resolutionRule.max {
                return CompressionMode.resolutionRule.max
            }
            return size
        }
    }
}


// MARK:- 五、二维码的处理
public extension UIImage {
    
    // MARK: 5.1、生成二维码图片
    /// 生成二维码图片
    /// - Parameters:
    ///   - content: 二维码里面的内容
    ///   - size: 二维码的大小
    ///   - logoSize: logo的大小
    ///   - logoImage: logo图片
    /// - Returns: 返回生成二维码图片
    static func QRImage(with content: String, size: CGSize, isLogo: Bool = true, logoSize: CGSize?, logoImage: UIImage? = nil, logoRoundCorner: CGFloat? = nil) -> UIImage? {
        // 1、创建名为"CIQRCodeGenerator"的CIFilter
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 2、将filter所有属性设置为默认值
        filter?.setDefaults()
        // 3、将所需尽心转为UTF8的数据，并设置给filter
        let data = content.data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        // 4、设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
        /*
         L: 7%
         M: 15%
         Q: 25%
         H: 30%
         */
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        // 5、拿到二维码图片，此时的图片不是很清晰，需要二次加工
        guard let outPutImage = filter?.outputImage else { return nil }
        
        return getHDImgWithCIImage(with: outPutImage, size: size, isLogo: isLogo, logoSize: logoSize, logoImage: logoImage, logoRoundCorner: logoRoundCorner)
    }
    
    // MARK: 调整二维码清晰度，添加水印图片
    /// 调整二维码清晰度，添加水印图片
    /// - Parameters:
    ///   - image: 模糊的二维码图片
    ///   - size: 二维码的宽高
    ///   - logoSize: logo的大小
    ///   - logoImage: logo图片
    /// - Returns: 添加 logo 图片后，清晰的二维码图片
    private static func getHDImgWithCIImage(with image: CIImage, size: CGSize, isLogo: Bool = true, logoSize: CGSize?, logoImage: UIImage? = nil, logoRoundCorner: CGFloat? = nil) -> UIImage? {
        let extent = image.extent.integral
        let scale = min(size.width / extent.width, size.height / extent.height)
        //1.创建bitmap
        let width = extent.width * scale
        let height = extent.height * scale
        
        // 创建基于GPU的CIContext对象,性能和效果更好
        let context = CIContext(options: nil)
        // 创建CoreGraphics image
        guard let bitmapImage = context.createCGImage(image, from: extent) else { return nil }
        
        // 创建一个DeviceGray颜色空间
        let cs = CGColorSpaceCreateDeviceGray()
        // CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
        // width：图片宽度像素
        // height：图片高度像素
        // bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
        // bitmapInfo：指定的位图应该包含一个alpha通道
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue) //图形上下文，画布
        bitmapRef?.interpolationQuality = CGInterpolationQuality.none //写入质量
        bitmapRef?.scaleBy(x: scale, y: scale) //调整“画布”的缩放
        bitmapRef?.draw(bitmapImage, in: extent) //绘制图片
        
        //2.保存bitmap到图片
        guard let scaledImage = bitmapRef?.makeImage() else { return nil }
        
        // 清晰的二维码图片
        let outputImage = UIImage(cgImage: scaledImage)
        
        guard isLogo == true, let logoSize = logoSize, let logoImage = logoImage else {
            return outputImage
        }
        
        var newLogo: UIImage = logoImage
        if let newLogoRoundCorner = logoRoundCorner, let roundCornerLogo = logoImage.isRoundCorner(radius: newLogoRoundCorner, byRoundingCorners: .allCorners, imageSize: logoSize) {
            newLogo = roundCornerLogo
        }
        
        // 给二维码加 logo 图
        UIGraphicsBeginImageContextWithOptions(outputImage.size, false, UIScreen.main.scale)
        outputImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        // 把水印图片画到生成的二维码图片上，注意尺寸不要太大（根据上面生成二维码设置的纠错程度设置），否则有可能造成扫不出来
        let waterImgW = logoSize.width
        let waterImgH = logoSize.height
        let waterImgX = (size.width - waterImgW) * 0.5
        let waterImgY = (size.height - waterImgH) * 0.5
        newLogo.draw(in: CGRect(x: waterImgX, y: waterImgY, width: waterImgW, height: waterImgH))
        let newPicture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newPicture
    }
}

// MARK:- 六、gif 加载
public enum DataType: String {
    case gif    = "gif"
    case png    = "png"
    case jpeg   = "jpeg"
    case tiff   = "tiff"
    case defaultType
}
public extension UIImage {
    
    // MARK: 6.1、验证资源的格式，返回资源格式（png/gif/jpeg...）
    /// 验证资源的格式，返回资源格式（png/gif/jpeg...）
    /// - Parameter data: 资源
    /// - Returns: 返回资源格式（png/gif/jpeg...）
    static func checkImageDataType(data: Data?) -> DataType {
        guard data != nil else {
            return .defaultType
        }
        let c = data![0]
        switch (c) {
        case 0xFF:
            return .jpeg
        case 0x89:
            return .png
        case 0x47:
            return .gif
        case 0x49, 0x4D:
            return .tiff
        default:
            return .defaultType
        }
    }
    
    // MARK: 6.2、加载 data 数据的 gif 图片
    /// 加载 data 数据的 gif 图片
    /// - Parameter data: data 数据
    static func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }
        return UIImage.animatedImageWithSource(source)
    }
    
    // MARK: 6.3、加载网络 url 的 gif 图片
    /// 加载网络 url 的 gif 图片
    /// - Parameter url: gif图片的网络地址
    static func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    // MARK: 6.4、加载本地的gif图片
    /// 加载本地的gif图片
    /// - Parameter name:图片的名字
    static func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    // MARK: 6.5、加载 asset 里面的图片
    /// 加载 asset 里面的图片
    /// - Parameter asset: asset 里面的图片名字
    @available(iOS 9.0, *)
    static func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }
        return gif(data: dataAsset.data)
    }
    
    private class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
            return delay
        }
        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            // Make sure they're not too fast
            delay = 0.1
        }
        return delay
    }
    
    private static func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
        var lhs = lhs
        var rhs = rhs
        // Check if one of them is nil
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            } else if lhs != nil {
                return lhs!
            } else {
                return 0
            }
        }
        // Swap for modulo
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }
        // Get greatest common divisor
        var rest: Int
        while true {
            rest = lhs! % rhs!
            if rest == 0 {
                return rhs!
            } else {
                lhs = rhs
                rhs = rest
            }
        }
    }
    
    private static func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }
        var gcd = array[0]
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        return gcd
    }
    
    private static func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        // Fill arrays
        for index in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }
            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        // Calculate full duration
        let duration: Int = {
            var sum = 0
            for val: Int in delays {
                sum += val
            }
            return sum
        }()
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        return animation
    }
}

// MARK:- 七、图片旋转的一些操作
public extension UIImage {
    
    // MARK: 7.1、图片旋转 (角度)
    /// 图片旋转 (角度)
    /// - Parameter degree: 角度 0 -- 360
    /// - Returns: 旋转后的图片
    func imageRotated(degree: CGFloat) -> UIImage? {
        let radians = Double(degree) / 180 * Double.pi
        return imageRotated(radians: CGFloat(radians))
    }
    
    // MARK: 7.2、图片旋转 (弧度)
    /// 图片旋转 (弧度)
    /// - Parameter radians: 弧度 0 -- 2π
    /// - Returns: 旋转后的图片
    func imageRotated(radians: CGFloat) -> UIImage? {
        guard let weakCGImage = self.cgImage else {
            return nil
        }
        let rotateViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: self.size))
        let transform: CGAffineTransform = CGAffineTransform(rotationAngle: radians)
        rotateViewBox.transform = transform
        UIGraphicsBeginImageContext(rotateViewBox.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.translateBy(x: rotateViewBox.frame.width / 2, y: rotateViewBox.frame.height / 2)
        context.rotate(by: radians)
        context.scaleBy(x: 1, y: -1)
        let rect = CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height)
        context.draw(weakCGImage, in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // MARK: 7.3、水平翻转
    /// 水平翻转
    /// - Returns: 返回水平翻转的图片
    func flipHorizontal() -> UIImage? {
        return self.rotate(orientation: .upMirrored)
    }
    
    // MARK: 7.4、垂直翻转
    /// 垂直翻转
    /// - Returns: 返回垂直翻转的图片
    func flipVertical() -> UIImage? {
        return self.rotate(orientation: .downMirrored)
    }

    // MARK: 7.5、向下翻转
    /// 向下翻转
    /// - Returns: 向下翻转后的图片
    func flipDown() -> UIImage? {
        return self.rotate(orientation: .down)
    }

    // MARK: 7.6、向左翻转
    /// 向左翻转
    /// - Returns: 向左翻转后的图片
    func flipLeft() -> UIImage? {
        return self.rotate(orientation: .left)
    }

    // MARK: 7.7、镜像向左翻转
    /// 镜像向左翻转
    /// - Returns: 镜像向左翻转后的图片
    func flipLeftMirrored() -> UIImage? {
        return self.rotate(orientation: .leftMirrored)
    }
    
    // MARK: 7.8、向右翻转
    /// 向右翻转
    /// - Returns: 向右翻转后的图片
    func flipRight() -> UIImage? {
        return self.rotate(orientation: .right)
    }
    
    // MARK: 7.9、镜像向右翻转
    /// 镜像向右翻转
    /// - Returns: 镜像向右翻转后的图片
    func flipRightMirrored() -> UIImage? {
        return self.rotate(orientation: .rightMirrored)
    }
    
    // MARK: 7.10、图片平铺区域
    /// 图片平铺区域
    /// - Parameter size: 平铺区域的大小
    /// - Returns: 平铺后的图片
    func imageTile(size: CGSize) -> UIImage? {
        let tempView = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        tempView.backgroundColor = UIColor(patternImage: self)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        tempView.layer.render(in: context)
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return bgImage
    }
    
    // MARK: 图片翻转(base)
    /// 图片翻转(base)
    /// - Parameter orientation: 翻转类型
    /// - Returns: 翻转后的图片
    private func rotate(orientation: UIImage.Orientation) -> UIImage? {
        guard let imageRef = self.cgImage else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: imageRef.width, height: imageRef.height)
        var bounds = rect
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch orientation {
        case .up:
            return self
        case .upMirrored:
            // 图片左平移width个像素
            transform = CGAffineTransform(translationX: rect.size.width, y: 0)
            // 缩放
            transform = transform.scaledBy(x: -1, y: 1)
        case .down:
            transform = CGAffineTransform(translationX: rect.size.width, y: rect.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0, y: rect.size.height)
            transform = transform.scaledBy(x: 1, y: -1)
        case .left:
            swapWidthAndHeight(rect: &bounds)
            transform = CGAffineTransform(translationX:0 , y: rect.size.width)
            transform = transform.rotated(by: CGFloat(Double.pi * 1.5))
        case .leftMirrored:
            swapWidthAndHeight(rect: &bounds)
            transform = CGAffineTransform(translationX:rect.size.height , y: rect.size.width)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: CGFloat(Double.pi * 1.5))
        case .right:
            swapWidthAndHeight(rect: &bounds)
            transform = CGAffineTransform(translationX:rect.size.height , y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .rightMirrored:
            swapWidthAndHeight(rect: &bounds)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        default:
            return nil
        }
        
        UIGraphicsBeginImageContext(bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        //图片绘制时进行图片修正
        switch orientation {
        case .left:
            fallthrough
        case .leftMirrored:
            fallthrough
        case .right:
            fallthrough
        case .rightMirrored:
            context.scaleBy(x: -1.0, y: 1.0)
            context.translateBy(x: -bounds.size.width, y: 0.0)
        default:
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: 0.0, y: -rect.size.height)
        }
        context.concatenate(transform)
        context.draw(imageRef, in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 交换宽高
    /// - Parameter rect: image 的 frame
    private func swapWidthAndHeight(rect: inout CGRect) {
        let swap = rect.size.width
        rect.size.width = rect.size.height
        rect.size.height = swap
    }
}
