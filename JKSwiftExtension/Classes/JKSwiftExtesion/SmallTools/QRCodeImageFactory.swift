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
    ///   - content: 二维码内容 内容会自动被urlencode
    ///   - size: 生成图片的大小
    ///   - logo: 二维码中间的logo
    ///   - logoSize: logo的大小
    /// - Returns: UIImage
    public static func qrCodeImage(content: String,
                                   size: CGSize,
                                   logo: UIImage? = nil,
                                   logoSize: CGSize? = nil) -> UIImage? {
        guard size.width > 0, size.height > 0, let originImage = qrCodeImage(content: content) else {
            return nil
        }
        let scaleX = size.width / originImage.extent.size.width;
        let scaleY = size.height / originImage.extent.size.height;
        let transformedImage = originImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        let image = UIImage(ciImage: transformedImage)
        
        guard let logo = logo, let logoSize = logoSize else {
            return image
        }
        let logoFrame = CGRect.init(origin: CGPoint.init(x:  (size.width - logoSize.width) / 2 , y: (size.height - logoSize.height) / 2), size: logoSize)
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        logo.draw(in: logoFrame)
        let resultImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImg
    }
    
    /// 生成二维码
    ///
    /// - Parameter content: 二维码内容
    /// - Returns:  CIImage?
    private static func qrCodeImage(content: String) -> CIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator"),
            let infoData = content.data(using: .utf8) else {
                return nil
        }
        qrFilter.setValue(infoData, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        
        return qrFilter.outputImage
    }
}
