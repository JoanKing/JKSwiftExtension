//
//  JKTransparentHitTestImageView.swift
//  JKSwiftExtension
//
//  Created by chongwang on 2025/12/8.
//

import UIKit

/// 一个会根据图片局部透明度决定是否响应点击事件的 `UIImageView`。
/// - 功能概述:
///   - 重写 `point(inside:with:)`，在命中测试阶段，根据触摸点对应像素的 alpha 值决定是否视为命中。
///   - 仅当该点对应的像素透明度大于 `alphaThreshold` 时才返回 `true`。
///   - 支持多种 `contentMode`，会将视图坐标准确映射到图片坐标再进行采样。
/// - 使用场景:
///   - 带有透明区域的 PNG 图片（例如不规则形状的按钮、icon 等），
///     希望“透明区域不响应点击，非透明区域才响应点击”。
final public class JKTransparentHitTestImageView: UIImageView {

    /// 透明度阈值（0.0 ~ 1.0）。
    /// - 当像素点的 alpha > `alphaThreshold` 时，认为此点“可点击”；
    ///   否则视为透明区域，不响应点击。
    /// - 默认值为 `0.01`，即只要不完全透明基本都算“命中”。
    var alphaThreshold: CGFloat = 0.01

    /// 是否开启基于透明度的命中测试。
    /// - 为 `true` 时：会根据像素 alpha 判断点击是否命中。
    /// - 为 `false` 时：行为等同于普通 `UIImageView` 的命中测试。
    var isTransparencyHitTestEnabled: Bool = true

    // MARK: - 像素数据缓存

    /// 当前图片的 RGBA 像素数据缓存（按行从左到右，从上到下排布）。
    private var pixelData: [UInt8]?

    /// 像素宽度（单位：像素，不是 point）。
    private var pixelWidth: Int = 0

    /// 像素高度（单位：像素，不是 point）。
    private var pixelHeight: Int = 0

    /// 每个像素占用的字节数（RGBA = 4 字节）。
    private let bytesPerPixel = 4

    /// 监听 `image` 变化，在图片被设置或替换时重新准备像素缓存。
    public override var image: UIImage? {
        didSet {
            preparePixelData()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        // 如果需要在 contentMode / bounds 改变时重新计算像素数据映射关系，
        // 可以在这里触发额外逻辑（当前实现中不必重算像素缓存本身）。
    }

    /// 重写命中测试方法，根据图片透明度决定是否命中。
    /// - 流程:
    ///   1. 先调用 `super.point(inside:with:)` 判断是否在视图 bounds 内；
    ///   2. 若透明度命中测试关闭，直接返回 `true`（与普通 UIImageView 一致）；
    ///   3. 若无图片，直接返回 `true`，避免影响默认行为；
    ///   4. 将触摸点从视图坐标系转换成图片坐标；
    ///   5. 读取该图片坐标对应像素的 alpha 值，与 `alphaThreshold` 做比较。
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // 先确保点在自身 bounds 内
        guard super.point(inside: point, with: event) else { return false }
        // 若未开启透明度命中测试，则直接认为命中
        guard isTransparencyHitTestEnabled else { return true }
        // 没有图片时不做透明度判断，保持命中，以免影响默认行为
        guard let image = image else { return true }

        // 将视图坐标转换到图片坐标（单位：点）
        guard let imagePoint = self.imagePoint(fromViewPoint: point, image: image) else {
            // 不在实际绘制区域内（例如 aspectFit 的空白区域），视为未命中
            return false
        }

        // 根据图片坐标获取该点像素的 alpha 值
        let alpha = alphaAtImagePoint(imagePoint)
        // debugPrint("透明度：\(alpha)")
        return alpha > alphaThreshold
    }

    // MARK: - 坐标转换（保持你原来的逻辑，但要注意 scale）

    /// 将视图坐标系中的点转换到图片坐标系中的点（单位：point，而非像素）。
    ///
    /// - 参数:
    ///   - point: 在 `JKTransparentHitTestImageView` 本地坐标系中的点（通常为触摸点）。
    ///   - image: 当前显示的图片。
    /// - 返回:
    ///   - 若该点落在图片“实际绘制区域”内（考虑 `contentMode`、等比缩放与居中/对齐偏移），
    ///     则返回对应的图片坐标（单位为图片的 point 坐标，即 `image.size` 空间）；
    ///   - 若该点落在视图的空白区域（例如 `aspectFit` 下的留白），则返回 `nil`。
    private func imagePoint(fromViewPoint point: CGPoint, image: UIImage) -> CGPoint? {
        guard bounds.width > 0, bounds.height > 0 else { return nil }

        let viewSize = bounds.size
        // image.size 已经是按 scale 除过的“点”单位尺寸
        let imageSize = image.size

        let scaleX = viewSize.width / imageSize.width
        let scaleY = viewSize.height / imageSize.height

        var drawSize: CGSize = .zero   // 图片实际绘制的大小（单位：point）
        var origin: CGPoint = .zero    // 图片绘制区域在视图坐标系中的原点（左上角）

        switch contentMode {
        case .scaleToFill:
            // 宽高分别独立缩放铺满，直接按比例反推即可
            let imgX = point.x / scaleX
            let imgY = point.y / scaleY
            return CGPoint(x: imgX, y: imgY)

        case .scaleAspectFit:
            // 等比例缩放，全部内容显示，有可能留白
            let scale = min(scaleX, scaleY)
            drawSize = CGSize(width: imageSize.width * scale,
                              height: imageSize.height * scale)
            origin = CGPoint(x: (viewSize.width - drawSize.width) / 2.0,
                             y: (viewSize.height - drawSize.height) / 2.0)

        case .scaleAspectFill:
            // 等比例缩放，填满整个 view，有可能裁剪
            let scale = max(scaleX, scaleY)
            drawSize = CGSize(width: imageSize.width * scale,
                              height: imageSize.height * scale)
            origin = CGPoint(x: (viewSize.width - drawSize.width) / 2.0,
                             y: (viewSize.height - drawSize.height) / 2.0)

        case .center:
            // 不缩放，居中显示
            drawSize = imageSize
            origin = CGPoint(x: (viewSize.width - drawSize.width) / 2.0,
                             y: (viewSize.height - drawSize.height) / 2.0)

        case .top:
            // 不缩放，顶部居中
            drawSize = imageSize
            origin = CGPoint(x: (viewSize.width - drawSize.width) / 2.0, y: 0)

        case .bottom:
            // 不缩放，底部居中
            drawSize = imageSize
            origin = CGPoint(x: (viewSize.width - drawSize.width) / 2.0,
                             y: viewSize.height - drawSize.height)

        case .left:
            // 不缩放，左侧垂直居中
            drawSize = imageSize
            origin = CGPoint(x: 0,
                             y: (viewSize.height - drawSize.height) / 2.0)

        case .right:
            // 不缩放，右侧垂直居中
            drawSize = imageSize
            origin = CGPoint(x: viewSize.width - drawSize.width,
                             y: (viewSize.height - drawSize.height) / 2.0)

        case .topLeft:
            // 不缩放，左上角对齐
            drawSize = imageSize
            origin = .zero

        case .topRight:
            // 不缩放，右上角对齐
            drawSize = imageSize
            origin = CGPoint(x: viewSize.width - drawSize.width, y: 0)

        case .bottomLeft:
            // 不缩放，左下角对齐
            drawSize = imageSize
            origin = CGPoint(x: 0,
                             y: viewSize.height - drawSize.height)

        case .bottomRight:
            // 不缩放，右下角对齐
            drawSize = imageSize
            origin = CGPoint(x: viewSize.width - drawSize.width,
                             y: viewSize.height - drawSize.height)

        default:
            // 其他未显式处理的 contentMode，退回到简单缩放逻辑
            let imgX = point.x / scaleX
            let imgY = point.y / scaleY
            return CGPoint(x: imgX, y: imgY)
        }

        // 将视图中的点（考虑偏移 origin）反推回图片坐标空间（单位：point）
        let imgX = (point.x - origin.x) * imageSize.width / drawSize.width
        let imgY = (point.y - origin.y) * imageSize.height / drawSize.height

        // 若超出图片逻辑范围，则认为没有命中图片绘制区域
        guard imgX >= 0, imgY >= 0, imgX < imageSize.width, imgY < imageSize.height else {
            return nil
        }

        // 此处返回的是图片坐标系中的“点”坐标（即未乘以 image.scale 的逻辑坐标），
        // 后续在读取像素数据时会再乘以 scale 转换为真实像素索引。
        return CGPoint(x: imgX, y: imgY)
    }

    // MARK: - 像素数据准备与读取

    /// 为当前 `image` 生成并缓存其像素数据。
    ///
    /// - 实现说明:
    ///   - 使用 `CGContext` 将 `CGImage` 绘制到一块内存中，得到连续的 RGBA 字节数组。
    ///   - 只在 `image` 被设置/替换时调用，以减少重复计算。
    private func preparePixelData() {
        pixelData = nil
        pixelWidth = 0
        pixelHeight = 0

        guard let cgImage = image?.cgImage else { return }

        let width = cgImage.width
        let height = cgImage.height
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        let byteCount = bytesPerRow * height

        // 预分配一块连续的内存来存储 RGBA 像素数据
        var data = [UInt8](repeating: 0, count: byteCount)

        // 若原始图片没有 colorSpace，则默认使用 sRGB
        guard let colorSpace = cgImage.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB),
              let context = CGContext(
                data: &data,
                width: width,
                height: height,
                bitsPerComponent: bitsPerComponent,
                bytesPerRow: bytesPerRow,
                space: colorSpace,
                // 使用 RGBA、预乘 alpha 的像素格式（premultipliedLast: RGBA）
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
              ) else {
            return
        }

        let rect = CGRect(x: 0, y: 0,
                          width: CGFloat(width),
                          height: CGFloat(height))
        // 将原始 CGImage 绘制到我们创建的上下文中，像素数据会写入 data
        context.draw(cgImage, in: rect)

        pixelData = data
        pixelWidth = width
        pixelHeight = height
    }

    /// 根据图片坐标（point 单位）读取该点对应像素的 alpha 值。
    ///
    /// - 参数:
    ///   - point: 图片坐标系中的点（单位：point，即 `image.size` 空间）。
    /// - 返回:
    ///   - 该点对应像素的 alpha 通道值，范围 `[0.0, 1.0]`。
    ///   - 若无像素数据，则返回 `1.0`，即视为不透明（避免“误判为点击无效”）。
    private func alphaAtImagePoint(_ point: CGPoint) -> CGFloat {
        guard let image = image,
              let pixelData = pixelData else {
            // 没有像素数据时，默认为完全不透明，避免错误拦截点击事件
            return 1
        }

        // 将图片坐标（point 单位）转换为像素坐标（整型）
        let scale = image.scale
        let x = Int(point.x * scale)
        let y = Int(point.y * scale)

        // 越界保护：若超出像素范围，则认为透明（不命中）
        guard x >= 0, y >= 0,
              x < pixelWidth, y < pixelHeight else {
            return 0
        }

        let bytesPerRow = bytesPerPixel * pixelWidth
        let index = y * bytesPerRow + x * bytesPerPixel
        // 像素格式为 RGBA（premultipliedLast），alpha 在 index + 3 位置
        let alpha = CGFloat(pixelData[index + 3]) / 255.0
        return alpha
    }
}
