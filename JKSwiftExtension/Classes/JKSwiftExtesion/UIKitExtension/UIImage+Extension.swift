//
//  UIImage+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher
public extension UIImage {
    
    // MARK: 生成指定尺寸的纯色图像
    /// 生成指定尺寸的纯色图像
    /// - Parameters:
    ///   - size: 图片尺寸
    ///   - color: 图片颜色
    /// - Returns: 返回对应的图片
    class func createImageWithSize(_ size: CGSize = CGSize(width: 1.0, height: 1.0), color: UIColor = UIColor.white) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

/// Image - Color Process
public extension UIImage {
    class func image(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func image(color: UIColor, size: CGSize, round: Float) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        if round > 0 {
            let path = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(round))
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
    
    class func image(color: UIColor, size: CGSize, corners: UIRectCorner, round: Float) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        if round > 0 {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: CGFloat(round), height: CGFloat(round)))
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
    
    
    /// layer to image
    class func image(from layer: CALayer, scale: CGFloat = 0.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}
/// Image - Size or Scale or Clip Process
public extension UIImage {
    /// 获取固定大小的image
    /// - Parameters:
    ///     - size:  尺寸
    func solidTo(size: CGSize) -> UIImage? {
        let w = size.width
        let h = size.height
        // 先不用UIView的Extension，以确保独立移植性
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
    
    /// 按宽高比系数——等比缩放
    /// - Parameters:
    ///     - scale: 要缩放的 宽高比 系数
    func scaleTo(scale: Float) -> UIImage? {
        let w = self.size.width
        let h = self.size.height
        let scaledW = w * CGFloat(scale)
        let scaledH = h * CGFloat(scale)
        UIGraphicsBeginImageContext(size); // this will crop
        self.draw(in: CGRect(x: 0, y: 0, width: scaledW, height: scaledH))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage;
    }
    
    /// 按指定尺寸——等比缩放
    /// - Parameters:
    ///     - size:  要缩放的尺寸
    func scaleTo(size: CGSize) -> UIImage? {
        if self.cgImage == nil {
            return nil
        }
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
        w = w * radio;
        h = h * radio;
        let xPos = (size.width - w) / 2;
        let yPos = (size.height - h) / 2;
        UIGraphicsBeginImageContext(size);
        draw(in: CGRect(x: xPos, y: yPos, width: w, height: h))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;
    }
    
    /// 图片中间1*1拉伸——如气泡一般
    func strechAsBubble() -> UIImage {
        // 设置端盖的值
        let top = self.size.height * 0.5;
        let left = self.size.width * 0.5;
        let bottom = self.size.height * 0.5;
        let right = self.size.width * 0.5;
        let edgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right);
        // 拉伸
        return self.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch)
    }
    
    /// UIImage图片对象切圆角——性能较好
    func cornerRadius(radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let path = UIBezierPath(roundedRect: rect , cornerRadius: radius).cgPath
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(path)
        context?.clip()
        draw(in: rect )
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 调整图像方向 避免图像有旋转
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
            transform = transform.rotated(by: .pi/2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -.pi/2)
        default: //.up, .upMirrored
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        default: //.up, .down, .left, .right
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
/// Image - Video Frame Process
public extension UIImage {
    convenience init?(named: String, bundleClass: AnyClass) {
        self.init(named: named, in: Bundle(for: bundleClass), compatibleWith: nil)
    }
    
    /// 获取视频的第一帧
    /// - Parameters:
    ///     - videoUrl:  视频url
    ///     - size:      尺寸
    convenience init?(videoUrl:URL, size:CGSize) {
        let opts = [AVURLAssetPreferPreciseDurationAndTimingKey:false]
        let generator = AVAssetImageGenerator(asset: AVURLAsset(url: videoUrl, options: opts))
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = size
        var img: CGImage? = nil
        do {
            try img = generator.copyCGImage(at: CMTimeMake(value: 0, timescale: 10), actualTime: nil)
        } catch {
            return nil
        }
        guard let image = img else {return nil}
        self.init(cgImage: image)
    }
}
/// Image - Pixel & Alpha & Blur Process
#warning("⚠️SB_ColorSpace_useless.png —— 类似这类图片的颜色空间，例如CMYK，iOS不支持显示！")
#warning("如果需要显示，必须先转化为RGB后，再显示！所以在构建bitmapCtx时，不能使用不支持的colorspace！")
// 两种解决方案：1.无论任何CS，都强制输出RGB；2.不支持的CS，才输出为RGB
public extension UIImage {
    /// alpha channel
    var hasAlpha: Bool {
        if let alpha = cgImage?.alphaInfo {
            return alpha == .first || alpha == .last || alpha == .premultipliedFirst || alpha == .premultipliedLast
        }
        return false
    }
    
    static let RGBColorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    /// 支持的有效ColorSpace
    var validColorSpace: CGColorSpace {
        guard let cgImg = cgImage, let colorSpace = cgImg.colorSpace else {
            return UIImage.RGBColorSpace
        }
        let colorSpaceModel = colorSpace.model
        let unsupportedCS = colorSpaceModel == .unknown || colorSpaceModel == .monochrome || colorSpaceModel == .cmyk || colorSpaceModel == .indexed
        return unsupportedCS ? UIImage.RGBColorSpace : colorSpace
    }
    
    /// gen new image with alpha channel
    var alphaImg: UIImage? {
        if hasAlpha {
            return self
        }
        let maxScale = max(scale, 1.0)
        //        print(cgImage?.colorSpace)
        if let cgImg = cgImage/*, let colorSpace = cgImg.colorSpace*/ {
            let w = Int(CGFloat(cgImg.width) * maxScale)
            let h = Int(CGFloat(cgImg.height) * maxScale)
            /// Apple建议用order32Host
            var bitmapInfo = CGImageByteOrderInfo.orderDefault.rawValue
            /// 使用alpha预乘可以减少每个颜色分量和alpha的乘积计算
            bitmapInfo |= hasAlpha ? CGImageAlphaInfo.premultipliedFirst.rawValue : CGImageAlphaInfo.noneSkipFirst.rawValue
            guard let bitmapCtx = CGContext.init(data: nil, width: w, height: h, bitsPerComponent: 8, bytesPerRow: 0, space: validColorSpace, bitmapInfo: bitmapInfo) else {
                return nil
            }
            bitmapCtx.draw(cgImg, in: CGRect(x: 0, y: 0, width: w, height: h))
            
            guard let outCGImg = bitmapCtx.makeImage() else {return nil}
            return UIImage(cgImage: outCGImg, scale: scale, orientation: .up)
        }
        return nil
    }
    
    /// 高斯模糊——高性能
    /// 类似PS——边缘羽化处理
    /// - Parameters:
    ///   - withRadius: 模糊半径
    ///   - transparentBorderSize: 四周羽化区域size
    /// - Returns: image
    func gaussBlur(withRadius radius: CGFloat, transparentBorderSize: CGFloat) -> UIImage? {
        return toTransparent(withBorderSize: transparentBorderSize)?.kf.blurred(withRadius: radius)
        /// sd和kf的blur效果基本无差别
        //        sd_blurredImage(withRadius: radius)
    }
    
    /// 羽化
    /// 类似PS
    /// - Parameter borderSize: 四周羽化区域size
    /// - Returns: image
    func toTransparent(withBorderSize borderSize: CGFloat) -> UIImage? {
        //        print(cgImage?.colorSpace)
        guard let img = alphaImg, let cgImg = cgImage/*, let colorSpace = cgImg.colorSpace*/ else {
            return nil
        }
        let maxScale = max(scale, 1.0)
        let scaledBorderSize = maxScale * borderSize
        let newRect = CGRect(x: 0, y: 0, width: img.size.width * maxScale + scaledBorderSize * 2, height: img.size.height * maxScale + scaledBorderSize * 2)
        var bitmapInfo = CGImageByteOrderInfo.orderDefault.rawValue
        bitmapInfo |= hasAlpha ? CGImageAlphaInfo.premultipliedFirst.rawValue : CGImageAlphaInfo.noneSkipFirst.rawValue
        guard let bitmapCtx = CGContext.init(data: nil, width: Int(newRect.width), height: Int(newRect.height), bitsPerComponent: cgImg.bitsPerComponent, bytesPerRow: 0, space: validColorSpace, bitmapInfo: bitmapInfo) else {
            return nil
        }
        let outImgExtentRect = CGRect(x: scaledBorderSize, y: scaledBorderSize, width: img.size.width * maxScale, height: img.size.height * maxScale)
        bitmapCtx.draw(cgImg, in: outImgExtentRect)
        guard let borderImg = bitmapCtx.makeImage() else {return nil}
        guard let maskCGImg = toBorderMask(with: scaledBorderSize, in: newRect.size) else {return nil}
        guard let maskedBorderCGImg = borderImg.masking(maskCGImg) else {return nil}
        return UIImage(cgImage: maskedBorderCGImg, scale: scale, orientation: .up)
    }
    
    /// 边缘mask
    /// 类似 PS 羽化
    /// - Parameters:
    ///   - borderSize: mask羽化区域size
    ///   - size: mask自身区域
    /// - Returns: cgImage
    private func toBorderMask(with borderSize: CGFloat, in size: CGSize) -> CGImage? {
        guard let maskCtx = CGContext.init(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageByteOrderInfo.orderDefault.rawValue | CGImageAlphaInfo.none.rawValue) else {return nil}
        maskCtx.setFillColor(UIColor.black.cgColor)
        maskCtx.fill(CGRect(origin: .zero, size: size))
        maskCtx.setFillColor(UIColor.white.cgColor)
        maskCtx.fill(CGRect(x: borderSize, y: borderSize, width: size.width - borderSize * 2, height: size.height - borderSize * 2))
        return maskCtx.makeImage()
    }
}

public extension UIImage {
    
    /// 通过bundle加载image
    ///
    /// - Parameters:
    ///   - imageName: imageName
    ///   - bundleName: image 所在的bundle名称
    ///   - aClass: 目标bundle所在的父bundle的class
    convenience init?(imageName: String, bundleName: String, forParent aClass: AnyClass) {
        self.init(named: imageName, in: Bundle(bundleName: bundleName, forParent: aClass), compatibleWith: nil)
    }
}

// MARK:- 图片圆角的设置
extension UIImage{
    
    // MARK: 设置是否是圆角(默认:3.0,图片大小)
    /// 设置是否是圆角(默认:3.0,图片大小)
    /// - Returns: UIImage
    func isRoundCorner() -> UIImage {
        return self.isRoundCorner(radius: 3.0, size: self.size)!
    }
    
    /// 设置是否是圆角
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - size: size
    /// - Returns: 带圆角的图片
    func isRoundCorner(radius:CGFloat,size:CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let contentRef:CGContext = UIGraphicsGetCurrentContext() else {
            //关闭上下文
            UIGraphicsEndImageContext();
            return nil
        }
        
        //绘制路线
        contentRef.addPath(UIBezierPath(roundedRect: rect,
                                        byRoundingCorners: UIRectCorner.allCorners,
                                        cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        //裁剪
        contentRef.clip()
        //将原图片画到图形上下文
        self.draw(in: rect)
        contentRef.drawPath(using: .fillStroke)
        guard let output = UIGraphicsGetImageFromCurrentImageContext() else {
            //关闭上下文
            UIGraphicsEndImageContext();
            return nil
        }
        //关闭上下文
        UIGraphicsEndImageContext();
        return output
    }
    
    // MARK: 设置圆形图片
    /// 设置圆形图片
    /// - Returns: 圆形图片
    func isCircleImage() -> UIImage? {
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        //获取图形上下文
        guard let contentRef:CGContext = UIGraphicsGetCurrentContext() else {
            //关闭上下文
            UIGraphicsEndImageContext();
            return nil
        }
        //设置圆形
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        //根据 rect 创建一个椭圆
        contentRef.addEllipse(in: rect)
        //裁剪
        contentRef.clip()
        //将原图片画到图形上下文
        self.draw(in: rect)
        //从上下文获取裁剪后的图片
        guard let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            //关闭上下文
            UIGraphicsEndImageContext();
            return nil
        }
        //关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
}

// MARK:- 改变图片颜色 传入图片和自定义颜色
extension UIImage {
    
    /// 改变图片颜色  传入图片和自定义颜色
    /// - Parameters:
    ///   - tintColor: 颜色
    ///   - rawImage: 图片
    /// - Returns: description
    public func tintedImage(withColor tintColor: UIColor, withImage rawImage: UIImage?) -> UIImage? {
        guard let image = rawImage else { return nil }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: 0, y: image.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            
            let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            context.setBlendMode(.normal)
            
            guard let cgImage = image.cgImage else { return nil }
            context.draw(cgImage, in: rect)
            
            context.setBlendMode(.sourceIn)
            tintColor.setFill()
            context.fill(rect)
        }
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return coloredImage
    }
}

// MARK:- 二维码的处理
public extension UIImage {

    // MARK: 生成二维码图片
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
        * L: 7%
        * M: 15%
        * Q: 25%
        * H: 30%
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
        if let newLogoRoundCorner = logoRoundCorner, let roundCornerLogo = logoImage.isRoundCorner(radius: newLogoRoundCorner, size: logoSize) {
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
