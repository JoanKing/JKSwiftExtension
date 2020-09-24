//
//  UIImage+Compression.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

// MARK:- UIImage的处理
public extension UIImage {
    
    // MARK: 压缩图片
    /// 压缩图片
    /// - Parameter mode:  压缩模式
    /// - Returns: 压缩后Data
    func compress(mode: CompressionMode = .medium) -> Data? {
        return resizeIO(resizeSize: mode.resize(size))?.compressDataSize(maxSize: mode.maxDataSize)
    }
    
    // MARK: 异步图片压缩
    /// 异步图片压缩
    /// - Parameters:
    ///   - mode: 压缩模式
    ///   - queue: 压缩队列
    ///   - complete: 完成回调(压缩后Data, 调整后分辨率)
    func asyncCompress(mode: CompressionMode = .medium, queue: DispatchQueue = DispatchQueue.global(), complete:@escaping (Data?, CGSize) -> Void) {
        queue.async {
            let data = self.resizeIO(resizeSize: mode.resize(self.size))?.compressDataSize(maxSize: mode.maxDataSize)
            complete(data, mode.resize(self.size))
        }
    }
    
    // MARK: 压缩图片质量
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
    
    // MARK: ImageIO 方式调整图片大小 性能很好
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
    
    // MARK: UIKit  会占用大量内存 方式调整图片大小
    /// UIKit  会占用大量内存 方式调整图片大小
    /// - Parameter resizeSize: 图片调整Size
    /// - Returns: 调整后图片
    func resizeUI(resizeSize: CGSize) -> UIImage? {
        if size == resizeSize {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: resizeSize))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    // MARK: CoreGraphics 方式调整图片大小 性能很好
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

// MARK:- 压缩模式
/// 压缩模式
/// - low: 低质量
/// - medium: 中等质量 默认
/// - high: 高质量
/// - other: 自定义(最大分辨率, 最大输出数据大小)
public enum CompressionMode {
    
    /// 分辨率规则
    private static let resolutionRule: (min: CGFloat, max: CGFloat, low: CGFloat, default: CGFloat, high: CGFloat) = (10, 4096, 512, 1024, 2048)
    
    /// 数据大小规则
    private static let  dataSizeRule: (min: Int, max: Int, low: Int, default: Int, high: Int) = (1024 * 10, 1024 * 1024 * 20, 1024 * 512, 1024 * 1024 * 2, 1024 * 1024 * 10)
    
    case low
    case medium //默认
    case high
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
