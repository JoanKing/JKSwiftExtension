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

extension UIImage: JKPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JKPOP where Base: UIImage {
    
    // MARK: 1.1、设置图片的圆角
    /// 设置图片的圆角
    /// - Parameters:
    ///   - radius: 圆角大小 (默认:3.0,图片大小)
    ///   - corners: 切圆角的方式
    ///   - imageSize: 图片的大小
    /// - Returns: 剪切后的图片
    func isRoundCorner(radius: CGFloat = 3, byRoundingCorners corners: UIRectCorner = .allCorners, imageSize: CGSize?) -> UIImage? {
        var drawSize = imageSize ?? base.size
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = base.size
        }
        // 防止size：(0, 0)崩溃
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: drawSize)
        // 开始图形上下文
        UIGraphicsBeginImageContextWithOptions(drawSize, false, UIScreen.main.scale)
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
        base.draw(in: rect)
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
        return isRoundCorner(radius: (self.base.size.width < self.base.size.height ? self.base.size.width : self.base.size.height) / 2.0, byRoundingCorners: .allCorners, imageSize: self.base.size)
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
        // 防止size：(0, 0)崩溃
        var drawSize = layer.frame.size
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        UIGraphicsBeginImageContextWithOptions(drawSize, layer.isOpaque, scale)
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
        UIGraphicsBeginImageContext(base.size)
        let context = UIGraphicsGetCurrentContext()
        let area = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -area.height)
        context?.setBlendMode(.multiply)
        context?.setAlpha(alpha)
        context?.draw(self.base.cgImage!, in: area)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self.base
    }
    
    // MARK: 1.6、裁剪给定区域
    /// 裁剪给定区域
    /// - Parameter crop: 裁剪区域
    /// - Returns: 剪裁后的图片
    func cropWithCropRect( _ crop: CGRect) -> UIImage? {
        let cropRect = CGRect(x: crop.origin.x * self.base.scale, y: crop.origin.y * self.base.scale, width: crop.size.width * self.base.scale, height: crop.size.height *  self.base.scale)
        if cropRect.size.width <= 0 || cropRect.size.height <= 0 {
            return nil
        }
        var image: UIImage?
        autoreleasepool{
            if let cgImage = self.base.cgImage {
                let imageRef: CGImage? = cgImage.cropping(to: cropRect)
                if let imageRef = imageRef {
                    image = UIImage(cgImage: imageRef)
                }
            }
        }
        return image
    }
    
    // MARK: 1.7、裁剪中间的size图片
    /// 裁剪中间的size图片
    /// - Parameter crop: 中间裁剪的size
    /// - Returns: 剪裁后的图片
    func cropCenterSize( _ cropSize: CGSize) -> UIImage? {
        let cropRect = CGRect(x: (self.base.size.width - cropSize.width) * self.base.scale / 2.0, y: (self.base.size.height - cropSize.height) * self.base.scale / 2.0, width: cropSize.width * self.base.scale, height: cropSize.height *  self.base.scale)
        if cropRect.size.width <= 0 || cropRect.size.height <= 0 || cropRect.size.width > self.base.size.width || cropRect.size.height > self.base.size.height {
            return nil
        }
        var image: UIImage?
        autoreleasepool{
            if let cgImage = self.base.cgImage {
                let imageRef: CGImage? = cgImage.cropping(to: cropRect)
                if let imageRef = imageRef {
                    image = UIImage(cgImage: imageRef, scale: self.base.scale, orientation: self.base.imageOrientation)
                }
            }
        }
        return image
    }
    
    // MARK: 1.8、裁剪中间的px的size图片
    /// 裁剪中间的px的size图片
    /// - Parameter crop: 中间裁剪的size
    /// - Returns: 剪裁后的图片
    func cropCenterPxSize( _ cropPxSize: CGSize) -> UIImage? {
        let cropRect = CGRect(x: (self.base.size.width * self.base.scale  - cropPxSize.width) / 2.0, y: (self.base.size.height * self.base.scale - cropPxSize.height) / 2.0, width: cropPxSize.width, height: cropPxSize.height)
        if cropRect.size.width <= 0 || cropRect.size.height <= 0 || cropRect.size.width > self.base.size.width * self.base.scale || cropRect.size.height > self.base.size.height * self.base.scale {
            return nil
        }
        var image: UIImage?
        autoreleasepool{
            if let cgImage = self.base.cgImage {
                let imageRef: CGImage? = cgImage.cropping(to: cropRect)
                if let imageRef = imageRef {
                    image = UIImage(cgImage: imageRef, scale: self.base.scale, orientation: self.base.imageOrientation)
                }
            }
        }
        return image
    }
    
    // MARK: 1.9、给图片添加文字水印
    /// 给图片添加文字水印
    /// - Parameters:
    ///   - drawTextframe: 水印的 frame
    ///   - drawText: 水印文字
    ///   - withAttributes: 水印富文本
    /// - Returns: 返回水印图片
    func drawTextInImage(drawTextframe: CGRect, drawText: String, withAttributes: [NSAttributedString.Key : Any]? = nil) -> UIImage {
        // 开启图片上下文
        UIGraphicsBeginImageContext(self.base.size)
        // 图形重绘
        self.base.draw(in: CGRect(x: 0, y: 0, width: self.base.size.width, height: self.base.size.height))
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
    
    // MARK: 1.10、添加图片水印
    /// 添加图片水印
    /// - Parameters:
    ///   - rect: 水印图片的位置
    ///   - image: 水印图片
    /// - Returns: 带有水印的图片
    func addImageWatermark(rect: CGRect, image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContext(base.size)
        base.draw(in: CGRect.init(x: 0, y: 0, width: base.size.width, height: base.size.height))
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // MARK: 1.11、文字图片占位符
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
        
        let textsize = text.jk.rectSize(font: UIFont.systemFont(ofSize: fontSize), size: CGSize(width: jk_kScreenW, height: CGFloat(MAXFLOAT)))
        
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
    
    // MARK: 1.12、更改图片颜色
    /// 更改图片颜色
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - blendMode: 模式
    /// - Returns: 返回更改后的图片颜色
    func tint(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage? {
        /**
         有时我们的App需要能切换不同的主题和场景，希望图片能动态的改变颜色以配合对应场景的色调。虽然我们可以根据不同主题事先创建不同颜色的图片供调用，但既然用的图片素材都一样，还一个个转换显得太麻烦，而且不便于维护。使用blendMode变可以满足这个需求。
         */
        defer {
            UIGraphicsEndImageContext()
        }
        let drawRect = CGRect(x: 0, y: 0, width: self.base.size.width, height: self.base.size.height)
        // 防止size：(0, 0)崩溃
        var drawSize = self.base.size
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        UIGraphicsBeginImageContextWithOptions(drawSize, false, self.base.scale)
        color.setFill()
        UIRectFill(drawRect)
        self.base.draw(in: drawRect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        guard let tintedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        return tintedImage
    }
    
    // MARK: 1.13、获取图片某一个位置像素的颜色
    /// 获取图片某一个位置像素的颜色
    /// - Parameter point: 图片上某个点
    /// - Returns: 返回某个点的 UIColor
    func pixelColor(_ point: CGPoint) -> UIColor? {
        if point.x < 0 || point.x > base.size.width || point.y < 0 || point.y > base.size.height {
            return nil
        }
        
        let provider = self.base.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfComponents: CGFloat = 4.0
        let pixelData = (base.size.width * point.y + point.x) * numberOfComponents
        
        let r = CGFloat(data![Int(pixelData)]) / 255.0
        let g = CGFloat(data![Int(pixelData) + 1]) / 255.0
        let b = CGFloat(data![Int(pixelData) + 2]) / 255.0
        let a = CGFloat(data![Int(pixelData) + 3]) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: 1.14、保存图片到相册
    /// 保存图片到相册
    func saveImageToPhotoAlbum(_ result: ((Bool)->())?) {
        self.base.saveToPhotoAlbum(result)
    }
    
    // MARK: 1.16、图片的模糊效果（高斯模糊滤镜）
    /// 图片的模糊效果（高斯模糊滤镜）
    /// - Parameter fuzzyValue: 设置模糊半径值（越大越模糊）
    /// - Returns: 返回模糊后的图片
    func getGaussianBlurImage(fuzzyValue: CGFloat = 20) -> UIImage? {
        // 生成的高斯模糊滤镜图片
        return blurredPicture(fuzzyValue: fuzzyValue, filterName: "CIGaussianBlur")
    }
    
    // MARK: 1.17、像素化后的图片
    ///像素化后的图片
    /// - Parameter fuzzyValue: 设置模糊半径值（越大越模糊）
    /// - Returns: 返回像素化后的图片
    func getPixellateImage(fuzzyValue: CGFloat = 20) -> UIImage? {
        // 生成的高斯模糊滤镜图片
        return blurredPicture(fuzzyValue: fuzzyValue, filterName: "CIPixellate")
    }
    
    /// 图片模糊
    /// - Parameters:
    ///   - fuzzyValue: 设置模糊半径值（越大越模糊）
    ///   - filterName: 模糊类型
    /// - Returns: 返回模糊后的图片
    private func blurredPicture(fuzzyValue: CGFloat, filterName: String) -> UIImage? {
        guard let ciImage = CIImage(image: self.base) else { return nil }
        // 创建高斯模糊滤镜类
        guard let blurFilter = CIFilter(name: filterName) else { return nil }
        // 设置图片
        blurFilter.setValue(ciImage, forKey: kCIInputImageKey)
        // 设置模糊半径值（越大越模糊）
        blurFilter.setValue(fuzzyValue, forKey: filterName == "CIPixellate" ? kCIInputScaleKey : kCIInputRadiusKey)
        // 从滤镜中 取出图片
        guard let outputImage = blurFilter.outputImage else { return nil }
        // 创建上下文
        let context = CIContext(options: nil)
        // 根据滤镜中的图片 创建CGImage
        guard let cgImage = context.createCGImage(outputImage, from: ciImage.extent) else { return nil }
        // 生成的模糊图片
        return UIImage(cgImage: cgImage)
    }
    
    // MARK: 1.18、返回一个将白色背景变透明的UIImage
    /// 返回一个将白色背景变透明的UIImage
    /// - Returns: 白色背景变透明的UIImage
    func imageByRemoveWhiteBg() -> UIImage? {
        let colorMasking: [CGFloat] = [222, 255, 222, 255, 222, 255]
        return transparentColor(colorMasking: colorMasking)
    }
    
    // MARK: 1.19、返回一个将黑色背景变透明的UIImage
    /// 返回一个将黑色背景变透明的UIImage
    /// - Returns: 黑色背景变透明的UIImage
    func imageByRemoveBlackBg() -> UIImage? {
        let colorMasking: [CGFloat] = [0, 32, 0, 32, 0, 32]
        return transparentColor(colorMasking: colorMasking)
    }
    
    private func transparentColor(colorMasking: [CGFloat]) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        guard let rawImageRef = self.base.cgImage, let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking) else {
            return nil
        }
        UIGraphicsBeginImageContext(self.base.size)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.translateBy(x: 0.0, y: self.base.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(maskedImageRef, in: CGRect(x: 0, y: 0, width: self.base.size.width, height: self.base.size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        return result
    }
}

fileprivate extension UIImage {
    
    private struct JKRuntimeKey {
        static var saveBlockKey = UnsafeRawPointer("saveBlock".withCString { $0 })
    }
    private var saveBlock: ((Bool)->())? {
        set {
            objc_setAssociatedObject(self, &JKRuntimeKey.saveBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &JKRuntimeKey.saveBlockKey) as? (Bool) -> ()
        }
    }
    
    /// 保存图片到相册
    func saveToPhotoAlbum(_ result: ((Bool)->())?) {
        saveBlock = result
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil{
            saveBlock?(false)
        } else {
            saveBlock?(true)
        }
    }
}

// MARK: - 二、UIColor 生成的图片 和 生成渐变色图片
public enum JKImageGradientDirection {
    /// 水平从左到右
    case horizontal
    /// 垂直从上到下
    case vertical
    /// 左上到右下
    case leftOblique
    /// 右上到左下
    case rightOblique
    /// 自定义
    case other(CGPoint, CGPoint)
    
    public func point(size: CGSize) -> (CGPoint, CGPoint) {
        switch self {
        case .horizontal:
            return (CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: 0))
        case .vertical:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: size.height))
        case .leftOblique:
            return (CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: size.height))
        case .rightOblique:
            return (CGPoint(x: size.width, y: 0), CGPoint(x: 0, y: size.height))
        case .other(let stat, let end):
            return (stat, end)
        }
    }
}
public extension JKPOP where Base: UIImage {
    
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
        // 防止size：(0, 0)崩溃
        var drawSize = size
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        UIGraphicsBeginImageContextWithOptions(drawSize, false, UIScreen.main.scale)
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
    
    // MARK: 2.3、生成渐变色的图片 ["#B0E0E6", "#00CED1", "#2E8B57"]
    /// 生成渐变色的图片 ["#B0E0E6", "#00CED1", "#2E8B57"]
    /// - Parameters:
    ///   - hexsString: 十六进制字符数组
    ///   - size: 图片大小
    ///   - locations: locations 数组
    ///   - direction: 渐变的方向
    /// - Returns: 渐变的图片
    static func gradient(_ hexsString: [String], size: CGSize = CGSize(width: 1, height: 1), locations:[CGFloat]? = nil, direction: JKImageGradientDirection = .horizontal) -> UIImage? {
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
    static func gradient(_ colors: [UIColor], size: CGSize = CGSize(width: 10, height: 10), locations:[CGFloat]? = nil, direction: JKImageGradientDirection = .horizontal) -> UIImage? {
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
                         direction: JKImageGradientDirection = .horizontal) -> UIImage? {
        if colors.count == 0 { return nil }
        if colors.count == 1 {
            return image(color: colors[0])
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

// MARK: - 三、图片的拉伸和缩放
public extension JKPOP where Base: UIImage {
    
    // MARK: 3.1、获取固定大小的 image
    /// 获取固定大小的image
    /// - Parameter size: 图片尺寸
    /// - Returns: 固定大小的 image
    func solidTo(size: CGSize) -> UIImage? {
        let w = size.width
        let h = size.height
        if self.base.size.height <= self.base.size.width {
            if self.base.size.width >= w {
                let scaleImage = fixOrientation().jk.scaleTo(size: CGSize(width: w, height: w * self.base.size.height / self.base.size.width))
                return scaleImage
            } else {
                return fixOrientation()
            }
        } else {
            if self.base.size.height >= h {
                let scaleImage = fixOrientation().jk.scaleTo(size: CGSize(width: h * self.base.size.width / self.base.size.height, height: h))
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
        let reSize = CGSize(width: self.base.size.width * scale, height: self.base.size.height * scale)
        // UIGraphicsBeginImageContext(reSize)
        /**
         UIGraphicsBeginImageContext：在截图或者处理图片是会出现模糊的情况，可以使用以下函数代替         UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)
         size：缩放后的 size
         opaque：透明度，不透明设为true
         scale： 缩放因子，设0时系统自动设置缩放比例图片清晰；设1.0时模糊
         */
        // 防止size：(0, 0)崩溃
        var drawSize = reSize
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale);
        self.base.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    // MARK: 3.3、按指定尺寸等比缩放
    /// 按指定尺寸等比缩放
    /// - Parameter size: 要缩放的尺寸
    /// - Returns: 缩放后的图片
    func scaleTo(size: CGSize) -> UIImage? {
        if self.base.cgImage == nil { return nil }
        var w = CGFloat(self.base.cgImage!.width)
        var h = CGFloat(self.base.cgImage!.height)
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
        base.draw(in: CGRect(x: xPos, y: yPos, width: w, height: h))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    // MARK: 3.4、图片中间 1*1 拉伸——如气泡一般
    /// 图片中间1*1拉伸——如气泡一般
    /// - Returns: 拉伸后的图片
    func strechAsBubble() -> UIImage {
        let top = self.base.size.height * 0.5
        let left = self.base.size.width * 0.5
        let bottom = self.base.size.height * 0.5
        let right = self.base.size.width * 0.5
        let edgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        // 拉伸
        return self.base.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch)
    }
    
    // MARK: 3.5、图片设置拉伸
    /// 图片设置拉伸
    /// - Parameters:
    ///   - edgeInsets: 拉伸区域
    ///   - resizingMode: 拉伸模式
    /// - Returns: 返回拉伸后的图片
    func strechBubble(edgeInsets: UIEdgeInsets, resizingMode: UIImage.ResizingMode = .stretch) -> UIImage {
        // 拉伸
        return self.base.resizableImage(withCapInsets: edgeInsets, resizingMode: resizingMode)
    }
    
    // MARK: 3.6、调整图像方向 避免图像有旋转
    /// 调整图像方向 避免图像有旋转
    /// - Returns: 返正常的图片
    func fixOrientation() -> UIImage {
        if base.imageOrientation == .up {
            return self.base
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch base.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: base.size.width, y: base.size.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: base.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: base.size.height)
            transform = transform.rotated(by: -.pi / 2)
        default:
            break
        }
        switch base.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: base.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: base.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        let ctx: CGContext = CGContext(data: nil, width: Int(base.size.width), height: Int(base.size.height), bitsPerComponent: (self.base.cgImage?.bitsPerComponent)!, bytesPerRow: 0, space: (self.base.cgImage?.colorSpace)!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        ctx.concatenate(transform)
        switch base.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.base.cgImage!, in: CGRect(x: 0, y: 0, width: base.size.height, height: base.size.width))
        default:
            ctx.draw(self.base.cgImage!, in: CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height))
        }
        let cgImage: CGImage = ctx.makeImage()!
        return UIImage(cgImage: cgImage)
    }
}

// MARK: - 四、UIImage 压缩相关
public extension JKPOP where Base: UIImage {
    
    // MARK: 4.1、压缩图片
    /// 压缩图片
    /// - Parameter mode: 压缩模式
    /// - Returns: 压缩后Data
    func compress(mode: CompressionMode = .medium) -> Data? {
        return resizeIO(resizeSize: mode.resize(base.size))?.jk.compressDataSize(maxSize: mode.maxDataSize)
    }
    
    // MARK: 4.2、异步图片压缩
    /// 异步图片压缩
    /// - Parameters:
    ///   - mode: 压缩模式
    ///   - queue: 压缩队列
    ///   - complete: 完成回调(压缩后Data, 调整后分辨率)
    func asyncCompress(mode: CompressionMode = .medium, queue: DispatchQueue = DispatchQueue.global(), complete:@escaping (Data?, CGSize) -> Void) {
        queue.async {
            let data = resizeIO(resizeSize: mode.resize(self.base.size))?.jk.compressDataSize(maxSize: mode.maxDataSize)
            DispatchQueue.main.async {
                complete(data, mode.resize(self.base.size))
            }
        }
    }
    
    // MARK: 4.3、压缩图片质量
    /// 压缩图片质量
    /// - Parameter maxSize: 最大数据大小
    /// - Returns: 压缩后数据
    func compressDataSize(maxSize: Int = 1024 * 1024 * 2) -> Data? {
        var compression: CGFloat = 1
        guard var data = self.base.jpegData(compressionQuality: 1) else { return nil }
        if data.count < maxSize {
            return data
        }
        var max: CGFloat = 1
        var min: CGFloat = 0
        var count = 0
        for _ in 0..<6 {
            count = count + 1
            compression = (max + min) / 2
            data = self.base.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxSize) * 0.9 {
                min = compression
            } else if data.count > maxSize {
                max = compression
            } else {
                break
            }
        }
        if data.count < maxSize {
            return data
        }
        return cycleCompressDataSize(maxSize: maxSize)
    }
    
    /// 循环压缩
    /// - Parameter maxSize: 最大数据大小
    /// - Returns: 压缩后数据
    private func cycleCompressDataSize(maxSize: Int) -> Data? {
        guard let oldData = self.base.jpegData(compressionQuality: 1) else { return nil }
        if oldData.count < maxSize {
            return oldData
        }
        var compress: CGFloat = 0.9
        guard var data = self.base.jpegData(compressionQuality: compress) else { return nil }
        while data.count > maxSize && compress > 0.01 {
            compress -= 0.02
            data = self.base.jpegData(compressionQuality: compress)!
        }
        return data
    }
    
    // MARK: 4.4、ImageIO 方式调整图片大小
    /// ImageIO 方式调整图片大小
    /// - Parameter resizeSize: 图片调整Size
    /// - Returns: 调整后图片
    ///
    /// - ImageIO 是 iOS 平台上用于处理图像的框架，提供了对图像的读取、解码和编码功能。你可以使用 ImageIO 来读取和写入各种图片格式，并进行基本的图像处理操作，例如调整尺寸、裁剪和缩放。

    func resizeIO(resizeSize: CGSize) -> UIImage? {
        if base.size == resizeSize {
            return self.base
        }
        guard let imageData = base.pngData() else { return nil }
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        
        let maxPixelSize = max(resizeSize.width, resizeSize.height)
        let options = [kCGImageSourceCreateThumbnailWithTransform: true,
                   kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
                              kCGImageSourceThumbnailMaxPixelSize: maxPixelSize] as [CFString : Any]
        
        let resizedImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary).flatMap {
            UIImage(cgImage: $0)
        }
        return resizedImage
    }
    
    // MARK: 4.5、CoreGraphics 方式调整图片大小
    /// CoreGraphics 方式调整图片大小
    /// - Parameter resizeSize: 图片调整Size
    /// - Returns: 调整后图片
    ///
    /// - CoreGraphics 是 iOS 平台上的 2D 图形渲染引擎，提供了强大的绘图和图像处理能力。你可以使用 CoreGraphics 来绘制图形、操作位图和调整图片的尺寸。通过 CoreGraphics，你可以直接操作图像的像素数据，对图像进行自定义的绘制和转换
    func resizeCG(resizeSize: CGSize) -> UIImage? {
        if base.size == resizeSize {
            return self.base
        }
        guard  let cgImage = self.base.cgImage else { return nil }
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
                return CGSize(width: resizeWidth, height: resizeHeighth)
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

// MARK: - 五、二维码的处理
public extension JKPOP where Base: UIImage {
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
        if let newLogoRoundCorner = logoRoundCorner, let roundCornerLogo = logoImage.jk.isRoundCorner(radius: newLogoRoundCorner, byRoundingCorners: .allCorners, imageSize: logoSize) {
            newLogo = roundCornerLogo
        }
        // 防止size：(0, 0)崩溃
        var drawSize = outputImage.size
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        // 给二维码加 logo 图
        UIGraphicsBeginImageContextWithOptions(drawSize, false, UIScreen.main.scale)
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
    
    // MARK: 5.2、获取图片中二维码数组
    func getImageQRImage() -> [CIQRCodeFeature] {
        let qrcodeImg = self.base as UIImage
        let context = CIContext(options: nil)
        guard let ciImage: CIImage = CIImage(image:qrcodeImg),
              let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]),
              let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else {
                  return []
              }
        return features
    }
    
    // MARK: 5.3、获取图片每个二维码里面的信息数组
    func getImageQRImageInfo() -> [String] {
        // 遍历所有的二维码，并拿出二维码里面的信息
        return getImageQRImage().map { $0.messageString ?? ""}
    }
}

// MARK: - 六、gif 加载
public enum DataType: String {
    case gif    = "gif"
    case png    = "png"
    case jpeg   = "jpeg"
    case tiff   = "tiff"
    case defaultType
}
public extension JKPOP where Base: UIImage {
    
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
            JKPrint("SwiftGif: Source for the image does not exist")
            return nil
        }
        return animatedImageWithSource(source)
    }
    
    // MARK: 6.3、加载网络 url 的 gif 图片
    /// 加载网络 url 的 gif 图片
    /// - Parameter url: gif图片的网络地址
    static func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            JKPrint("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            JKPrint("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
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
                    JKPrint("SwiftGif: This image named \"\(name)\" does not exist")
                    return nil
                }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            JKPrint("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    // MARK: 6.5、加载 asset 里面的gif图片
    /// 加载 asset 里面的gif图片
    /// - Parameter asset: asset 里面的图片名字
    @available(iOS 9.0, *)
    static func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            JKPrint("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }
        return gif(data: dataAsset.data)
    }
    
    // MARK: 6.6、获取 asset 里面的gif图片的信息：包含分解后的图片和gif时间
    /// 获取 asset 里面的gif图片的信息：包含分解后的图片和gif时间
    /// - Parameter asset: asset 里面的图片名字
    /// - Returns: 分解后的图片和gif时间
    static func gifImages(asset: String) -> (gifImages: [UIImage]?, duration: TimeInterval?) {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            JKPrint("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return (nil, nil)
        }
        // Create source from data
        guard let source = CGImageSourceCreateWithData(dataAsset.data as CFData, nil) else {
            JKPrint("SwiftGif: Source for the image does not exist")
            return (nil, nil)
        }
        return animatedImageSources(source)
    }
    
    // MARK: 6.7、获取 加载本地的 的gif图片的信息：包含分解后的图片和gif时间
    /// 获取 加载本地的 的gif图片的信息：包含分解后的图片和gif时间
    /// - Parameter name:图片的名字
    /// - Returns: 分解后的图片和gif时间
    static func gifImages(name: String) -> (gifImages: [UIImage]?, duration: TimeInterval?) {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
                    JKPrint("SwiftGif: This image named \"\(name)\" does not exist")
                    return (nil, nil)
                }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            JKPrint("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return (nil, nil)
        }
        // Create source from data
        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else {
            JKPrint("SwiftGif: Source for the image does not exist")
            return (nil, nil)
        }
        return animatedImageSources(source)
    }
    
    // MARK: 6.8、获取 网络 url 的 gif 图片的信息：包含分解后的图片和gif时间
    /// 获取 网络 url 的 gif 图片的信息：包含分解后的图片和gif时间
    /// - Parameter url: gif图片的网络地址
    /// - Returns: 分解后的图片和gif时间
    static func gifImages(url: String) -> (gifImages: [UIImage]?, duration: TimeInterval?) {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            JKPrint("SwiftGif: This image named \"\(url)\" does not exist")
            return (nil, nil)
        }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            JKPrint("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return (nil, nil)
        }
        // Create source from data
        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else {
            JKPrint("SwiftGif: Source for the image does not exist")
            return (nil, nil)
        }
        return animatedImageSources(source)
    }
    
    // MARK: 获取gif图片转化为动画的Image
    private static func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let info = animatedImageSources(source)
        guard let frames = info.gifImages, let duration = info.duration else {
            return nil
        }
        let animation = UIImage.animatedImage(with: frames, duration: duration)
        return animation
    }
    
    // MARK: 获取gif图片的信息
    /// 获取gif图片的信息
    /// - Parameter source: CGImageSource 资源
    /// - Returns: gif信息
    private static func animatedImageSources(_ source: CGImageSource) -> (gifImages: [UIImage]?, duration: TimeInterval?) {
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
            let delaySeconds = delayForImageAtIndex(Int(index), source: source)
            // Seconds to ms
            delays.append(Int(delaySeconds * 1000.0))
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
        return (frames, Double(duration) / 1000.0)
    }
    
    private static func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
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
            CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            // Make sure they're not too fast
            delay = 0.1
        }
        return delay
    }
    
    private static func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }
        var gcd = array[0]
        for val in array {
            gcd = gcdForPair(val, gcd)
        }
        return gcd
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
}

// MARK: - 七、图片旋转的一些操作
public extension JKPOP where Base: UIImage {
    
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
        guard let weakCGImage = self.base.cgImage else {
            return nil
        }
        let rotateViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: self.base.size))
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
        let rect = CGRect(x: -self.base.size.width / 2, y: -self.base.size.height / 2, width: self.base.size.width, height: self.base.size.height)
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
        tempView.backgroundColor = UIColor(patternImage: self.base)
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
        guard let imageRef = self.base.cgImage else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: imageRef.width, height: imageRef.height)
        var bounds = rect
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch orientation {
        case .up:
            return self.base
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

// MARK: - 八、给图片添加滤镜效果（棕褐色老照片滤镜，黑白滤镜）
/**
 Core Image 是一个强大的滤镜处理框架。它除了可以直接给图片添加各种内置滤镜，还能精确地修改鲜艳程度, 色泽, 曝光等，下面通过两个样例演示如何给 UIImage 添加滤镜
 */
/// 检测图片中的类型
public enum JKDetectorType: Int {
    /// 二维码
    case qrCode
    /// 人脸
    case face
    
    /// 获取某个类型的DetectorType
    /// - Returns: DetectorType
    fileprivate func getDetectorTypeContent() -> String {
        switch self {
        case .qrCode:
            return CIDetectorTypeQRCode
        case .face:
            return CIDetectorTypeFace
        }
    }
}

public extension JKPOP where Base: UIImage {
    /// 滤镜类型
    enum JKImageFilterType: String {
        /// 棕褐色复古滤镜（老照片效果），有点复古老照片发黄的效果）
        case CISepiaTone = "CISepiaTone"
        /// 黑白效果滤镜
        case CIPhotoEffectNoir = "CIPhotoEffectNoir"
    }
    
    // MARK: 8.1、图片加滤镜
    /// 图片加滤镜
    /// - Parameters:
    ///   - filterType: 滤镜类型
    ///   - alpha: 透明度
    /// - Returns: 添加滤镜后的图片
    func filter(filterType: JKImageFilterType, alpha: CGFloat?) -> UIImage? {
        guard let imageData = self.base.pngData() else {
            return nil
        }
        let inputImage = CoreImage.CIImage(data: imageData)
        let context = CIContext(options: nil)
        guard let filter = CIFilter(name: filterType.rawValue) else {
            return nil
        }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        if alpha != nil {
            filter.setValue(alpha, forKey: "inputIntensity")
        }
        guard let outputImage = filter.outputImage, let outImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        return UIImage(cgImage: outImage)
    }
    
    // MARK: 8.2、全图马赛克
    /// 全图马赛克
    /// - Parameter value: 值越大马赛克就越大(使用默认)
    /// - Returns: 全图马赛克的图片
    func pixAll(value: Int? = nil) -> UIImage? {
        guard let filter = CIFilter(name: "CIPixellate") else {
            return nil
        }
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: self.base)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        if value != nil {
            // 值越大马赛克就越大(使用默认)
            filter.setValue(value, forKey: kCIInputScaleKey)
        }
        let fullPixellatedImage = filter.outputImage
        let cgImage = context.createCGImage(fullPixellatedImage!, from: fullPixellatedImage!.extent)
        return UIImage(cgImage: cgImage!)
    }
    
    // MARK: 8.3、检测人脸/二维码的frame
    // 检测人脸/二维码的frame
    func detectTypeRect(detectorType: JKDetectorType) -> [CGRect]? {
        guard let inputImage = CIImage(image: self.base) else {
            return nil
        }
        let context = CIContext(options: nil)
        // 人脸检测器
        // CIDetectorAccuracyHigh: 检测的精度高,但速度更慢些
        let detector = CIDetector(ofType: detectorType.getDetectorTypeContent(),
                                  context: context,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        var faceFeatures: [CIFeature] = []
        // 人脸检测需要图片方向(有元数据的话使用元数据,没有就调用featuresInImage)
        if let orientation = inputImage.properties[kCGImagePropertyOrientation as String] {
            faceFeatures = (detector!.features(in: inputImage, options: [CIDetectorImageOrientation: orientation]))
        } else {
            faceFeatures = (detector!.features(in: inputImage))
        }
        // 打印所有的面部特征
        // print(faceFeatures)
        let inputImageSize = inputImage.extent.size
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -inputImageSize.height)
        
        // 人脸位置的frame
        var rects: [CGRect] = []
        // 遍历所有的面部，并框出
        for faceFeature in faceFeatures {
            let faceViewBounds = faceFeature.bounds.applying(transform)
            rects.append(faceViewBounds)
        }
        return rects
    }
    
    // MARK: 8.4、检测人脸/二维码并打马赛克
    /// 检测人脸/二维码并打马赛克
    /// - Returns: 打马赛克后的人脸/二维码
    func detectAndPixFace(detectorType: JKDetectorType) -> UIImage? {
        guard let inputImage = CIImage(image: self.base) else {
            return nil
        }
        let context = CIContext(options: nil)
        
        // 用CIPixellate滤镜对原图先做个完全马赛克
        let filter = CIFilter(name: "CIPixellate")!
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let inputScale = max(inputImage.extent.size.width, inputImage.extent.size.height) / 80
        filter.setValue(inputScale, forKey: kCIInputScaleKey)
        let fullPixellatedImage = filter.outputImage
        // 检测人脸或者二维码，并保存在faceFeatures中
        guard let detector = CIDetector(ofType: detectorType.getDetectorTypeContent(),
                                        context: context,
                                        options: nil) else {
            return nil
        }
        let faceFeatures = detector.features(in: inputImage)
        // 初始化蒙版图，并开始遍历检测到的所有人脸
        var maskImage: CIImage!
        for faceFeature in faceFeatures {
            // JKPrint(faceFeature.bounds)
            // 基于人脸/二维码的位置，为每一张脸都单独创建一个蒙版，所以要先计算出脸的中心点，对应为x、y轴坐标，
            // 再基于人脸/二维码的宽度或高度给一个半径，最后用这些计算结果初始化一个CIRadialGradient滤镜
            let centerX = faceFeature.bounds.origin.x + faceFeature.bounds.size.width / 2
            let centerY = faceFeature.bounds.origin.y + faceFeature.bounds.size.height / 2
            let radius = min(faceFeature.bounds.size.width, faceFeature.bounds.size.height)
            guard let radialGradient = CIFilter(name: "CIRadialGradient",
                                                parameters: [
                                                    "inputRadius0" : radius,
                                                    "inputRadius1" : radius + 1,
                                                    "inputColor0" : CIColor(red: 0, green: 1, blue: 0, alpha: 1),
                                                    "inputColor1" : CIColor(red: 0, green: 0, blue: 0, alpha: 0),
                                                    kCIInputCenterKey : CIVector(x: centerX, y: centerY)
                                                ]) else {
                                                    return nil
                                                }
            // 由于CIRadialGradient滤镜创建的是一张无限大小的图，所以在使用之前先对它进行裁剪
            let radialGradientOutputImage = radialGradient.outputImage!.cropped(to: inputImage.extent)
            if maskImage == nil {
                maskImage = radialGradientOutputImage
            } else {
                maskImage = CIFilter(name: "CISourceOverCompositing",
                                     parameters: [
                                        kCIInputImageKey : radialGradientOutputImage,
                                        kCIInputBackgroundImageKey : maskImage as Any
                                     ])!.outputImage
            }
        }
        // 用CIBlendWithMask滤镜把马赛克图、原图、蒙版图混合起来
        let blendFilter = CIFilter(name: "CIBlendWithMask")!
        blendFilter.setValue(fullPixellatedImage, forKey: kCIInputImageKey)
        blendFilter.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
        blendFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)
        // 输出，在界面上显示
        guard let blendOutputImage = blendFilter.outputImage, let blendCGImage = context.createCGImage(blendOutputImage, from: blendOutputImage.extent) else {
            return nil
        }
        return UIImage(cgImage: blendCGImage)
    }
}

// MARK: - 九、动态图片的使用
public extension JKPOP where Base: UIImage {
    
    // MARK: 9.1、深色图片和浅色图片切换 （深色模式适配）
    /// 深色图片和浅色图片切换 （深色模式适配）
    /// - Parameters:
    ///   - light: 浅色图片
    ///   - dark: 深色图片
    /// - Returns: 最终图片
    static func image(light: UIImage?, dark: UIImage?) -> UIImage? {
        if #available(iOS 13.0, *) {
            guard let weakLight = light, let weakDark = dark, let config = weakLight.configuration else { return light }
            let lightImage = weakLight.withConfiguration(config.withTraitCollection(UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.light)))
            lightImage.imageAsset?.register(weakDark, with: config.withTraitCollection(UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.dark)))
            return lightImage.imageAsset?.image(with: UITraitCollection.current) ?? light
        } else {
            return light
        }
    }
}
