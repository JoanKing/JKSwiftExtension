//
//  QRCodeImageFactory.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/25.
//

import UIKit

public struct QRCodeImageFactory {
    
    // MARK: 生成二维码中间有图片logo 并且指定大小
    /// 生成二维码中间有图片logo 并且指定大小
    /// - Parameters:
    ///   - content: 二维码内容 内容会自动被 urlencode
    ///   - size: 生成图片的大小
    ///   - logo: 二维码中间的logo
    ///   - logoSize: logo的大小
    ///   - logoRoundCorner: logo的圆角大小，设置则有，不设置则没有
    /// - Returns: UIImage
    public static func qrCodeImage(content: String,
                                   size: CGSize,
                                   isLogo: Bool = true,
                                   logo: UIImage? = nil,
                                   logoSize: CGSize? = nil, logoRoundCorner: CGFloat? = nil) -> UIImage? {
        guard size.width > 0, size.height > 0, let image = qrCodeImage(content: content, size: size) else {
            return nil
        }
        
        guard let logoSize = logoSize, let logo = logo, isLogo == true else {
            return image
        }
  
        var newLogo: UIImage = logo
        if let newLogoRoundCorner = logoRoundCorner, let roundCornerLogo = logo.jk.isRoundCorner(radius: newLogoRoundCorner, byRoundingCorners: .allCorners, imageSize: logoSize) {
            newLogo = roundCornerLogo
        }
        let logoFrame = CGRect(origin: CGPoint(x:  (size.width - logoSize.width) / 2 , y: (size.height - logoSize.height) / 2), size: logoSize)
        // 防止size：(0, 0)崩溃
        var drawSize = image.size
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        UIGraphicsBeginImageContextWithOptions(drawSize, false, UIScreen.main.scale)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        newLogo.draw(in: logoFrame)
        let resultImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImg
    }
    
    // MARK: 生成二维码
    /// 生成二维码
    /// - Parameters:
    ///   - content: 二维码内容
    ///   - isClear: 是否是清晰的二维码
    /// - Returns: 返回二维码
    private static func qrCodeImage(content: String, size: CGSize) -> UIImage? {
        // 1、创建名为"CIQRCodeGenerator"的CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        // 2、将filter所有属性设置为默认值
        qrFilter.setDefaults()
        // 3、将所需尽心转为UTF8的数据，并设置给filter
        guard let infoData = content.data(using: .utf8) else {
            return nil
        }
        qrFilter.setValue(infoData, forKey: "inputMessage")
        // 4、设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
        /*
         L: 7%
         M: 15%
         Q: 25%
         H: 30%
         */
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        // 5、拿到二维码图片，此时的图片不是很清晰，需要二次加工
        guard let outPutImage = qrFilter.outputImage else { return nil }

        // 6、取清晰的图片
        guard let clearImage = clearQrCodeImage(with: outPutImage, size: size) else {
            return nil
        }
        return clearImage
    }
    
    // MARK: 二维码清晰图片
    /// 清晰的图片
    private static func clearQrCodeImage(with image: CIImage, size: CGSize) -> UIImage? {
        let extent = image.extent.integral
        let scale = min(size.width / extent.width, size.height / extent.height)
        // 1.创建bitmap
        let width = extent.width * scale
        let height = extent.height * scale
        
        // 创建基于GPU的CIContext对象,性能和效果更好
        let context = CIContext(options: nil)
        // 创建CoreGraphics image
        guard let bitmapImage = context.createCGImage(image, from: extent) else { return nil }
        
        //创建一个DeviceGray颜色空间
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
        
        // 2.保存bitmap到图片
        guard let scaledImage = bitmapRef?.makeImage() else { return nil }
        
        // 清晰的二维码图片
        let outputImage = UIImage(cgImage: scaledImage)
        return outputImage
    }
    
    // MARK: 调整二维码清晰度，添加水印图片
    /// 调整二维码清晰度，添加水印图片
    /// - Parameters:
    ///   - image: 模糊的二维码图片
    ///   - size: 二维码的宽高
    ///   - logoSize: 水印图片的大小
    ///   - waterImg: 水印图片
    /// - Returns: 添加水印图片后，清晰的二维码图片
    static func getHDImgWithCIImage(with image: CIImage, size: CGSize, logoSize: CGSize?, waterImg: UIImage) -> UIImage? {
        let extent = image.extent.integral
        let scale = min(size.width / extent.width, size.height / extent.height)
        // 1.创建bitmap
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
        
        // 2.保存bitmap到图片
        guard let scaledImage = bitmapRef?.makeImage() else { return nil }
        
        // 清晰的二维码图片
        let outputImage = UIImage(cgImage: scaledImage)
        // 防止size：(0, 0)崩溃
        var drawSize = outputImage.size
        if drawSize.width <= 0 || drawSize.height <= 0 {
            drawSize = CGSize(width: 1, height: 1)
        }
        // 给二维码加 logo 图
        UIGraphicsBeginImageContextWithOptions(drawSize, false, UIScreen.main.scale)
        outputImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        /*
         把水印图片画到生成的二维码图片上，注意尺寸不要太大（根据上面生成二维码设置的纠错程度设置），否则有可能造成扫不出来
         */
        let waterImgW = logoSize?.width ?? waterImg.size.width
        let waterImgH = logoSize?.height ?? waterImg.size.height
        let waterImgX = (size.width - waterImgW) * 0.5
        let waterImgY = (size.height - waterImgH) * 0.5
        waterImg.draw(in: CGRect(x: waterImgX, y: waterImgY, width: waterImgW, height: waterImgH))
        let newPic = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newPic
    }
}
