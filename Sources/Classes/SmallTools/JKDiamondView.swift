//
//  JKDiamondView.swift
//  JKSwiftExtension
//
//  Created by chongwang on 2025/11/7.
//

import UIKit

/// CornerRadii 表示四个顶点的圆角半径，按视觉位置命名
public struct JKCornerRadii {
    public var topLeft: CGFloat
    public var bottomLeft: CGFloat
    public var bottomRight: CGFloat
    public var topRight: CGFloat

    /// 构造器参数顺序：左上、左下、右下、右上
    public init(topLeft: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat, topRight: CGFloat) {
        self.topLeft = max(0, topLeft)
        self.bottomLeft = max(0, bottomLeft)
        self.bottomRight = max(0, bottomRight)
        self.topRight = max(0, topRight)
    }

    /// 便捷初始化：全部相同
    public init(all: CGFloat) {
        self.init(topLeft: all, bottomLeft: all, bottomRight: all, topRight: all)
    }

    static let zero = JKCornerRadii(all: 0)
}

/// 指定要修改的顶点（用于 setCornerRadius）
public enum JKDiamondCorner {
    case topRight, topLeft, bottomLeft, bottomRight
}

/// 纯代码的 DiamondView：
/// - 菱形的"面/边"为水平（即上/下两条边水平）
/// - 支持通过 angleDegrees 设置相邻两边的夹角（度）
/// - 支持为四个顶点单独设置圆角（cornerRadii），并保留兼容的 cornerRadius 快捷属性
/// - 支持背景图片和填充色共存，图片在上，填充色在下
/// - 支持渐变色填充
public class JKDiamondView: UIView {
    
    // MARK: - 背景图片视图
    
    /// 背景图片视图（暴露给外部使用）
    /// 可以直接设置 image, contentMode 等属性
    /// 图片会自动裁剪为菱形形状（包括圆角），显示在填充色上方、边框下方
    public private(set) lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    // MARK: - Layers
    
    /// 填充层（用于纯色填充，在最底层）
    private let fillLayer = CAShapeLayer()
    
    /// 渐变填充层（用于渐变色填充）
    private let gradientLayer = CAGradientLayer()
    
    /// 渐变遮罩层（用于裁剪渐变层为菱形）
    private let gradientMaskLayer = CAShapeLayer()
    
    /// 边框层（用于描边，在最上层）
    private let strokeLayer = CAShapeLayer()

    /// 矩形左下角的角度，相邻两边的锐角 (degrees)。范围 (0.1, 179.9)
    public var angleDegrees: CGFloat = 120 {
        didSet {
            angleDegrees = clampAngle(angleDegrees)
            updatePath(animated: false)
        }
    }

    /// 填充色 / 描边 / 线宽
    public var fillColor: UIColor = .systemBlue {
        didSet {
            fillLayer.fillColor = fillColor.cgColor
            // 如果设置了纯色，隐藏渐变层
            if gradientColors == nil {
                gradientLayer.isHidden = true
                fillLayer.isHidden = false
            }
        }
    }
    
    /// 渐变色数组（设置后会使用渐变色填充，覆盖 fillColor）
    /// 设置为 nil 则恢复使用 fillColor
    public var gradientColors: [UIColor]? = nil {
        didSet {
            updateGradient()
        }
    }
    
    /// 渐变起始点（0-1 范围，相对于 bounds）
    /// 默认 (0.5, 0) 表示顶部中心
    public var gradientStartPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet {
            gradientLayer.startPoint = gradientStartPoint
        }
    }
    
    /// 渐变结束点（0-1 范围，相对于 bounds）
    /// 默认 (0.5, 1) 表示底部中心
    public var gradientEndPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet {
            gradientLayer.endPoint = gradientEndPoint
        }
    }
    
    /// 渐变位置（可选，对应 gradientColors 中每个颜色的位置，范围 0-1）
    /// 如果不设置，颜色会均匀分布
    public var gradientLocations: [CGFloat]? = nil {
        didSet {
            updateGradient()
        }
    }
    
    public var strokeColor: UIColor = .clear {
        didSet { strokeLayer.strokeColor = strokeColor.cgColor }
    }
    public var lineWidth: CGFloat = 0 {
        didSet {
            strokeLayer.lineWidth = lineWidth
            // 线宽改变时需要更新背景图片的遮罩
            updateImageViewMask()
        }
    }

    ///（向后兼容）单一半径，设置会把四个角都设置为相同值
    public var cornerRadius: CGFloat {
        get { cornerRadii.topLeft }
        set {
            let v = max(0, newValue)
            cornerRadii = JKCornerRadii(all: v)
        }
    }

    /// 四个顶点的圆角（可分别设置）
    /// 注意：每个圆角会被限制为不超过其相邻两条边长度的一半。
    public var cornerRadii: JKCornerRadii = .zero {
        didSet {
            cornerRadii.topLeft = max(0, cornerRadii.topLeft)
            cornerRadii.bottomLeft = max(0, cornerRadii.bottomLeft)
            cornerRadii.bottomRight = max(0, cornerRadii.bottomRight)
            cornerRadii.topRight = max(0, cornerRadii.topRight)
            updatePath(animated: false)
        }
    }

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        
        // 图层顺序（从下到上）：
        // 1. fillLayer（纯色填充，最底层）- 作为 sublayer
        // 2. gradientLayer（渐变填充，填充层上方）- 作为 sublayer
        // 3. backgroundImageView（背景图片，中间层）- 作为 subview
        // 4. strokeLayer（边框，最上层）- 作为 sublayer
        
        // 添加填充层到 layer（最底层）
        fillLayer.fillColor = fillColor.cgColor
        layer.insertSublayer(fillLayer, at: 0)
        
        // 添加渐变层
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint
        gradientLayer.mask = gradientMaskLayer
        gradientLayer.isHidden = true  // 默认隐藏，只有设置了渐变色才显示
        layer.insertSublayer(gradientLayer, above: fillLayer)
        
        // 添加背景图片视图到 subview（中间层）
        addSubview(backgroundImageView)
        
        // 添加边框层到 layer（最上层）
        strokeLayer.fillColor = nil
        strokeLayer.strokeColor = strokeColor.cgColor
        strokeLayer.lineWidth = lineWidth
        strokeLayer.lineCap = .round
        strokeLayer.lineJoin = .round
        layer.addSublayer(strokeLayer)
        
        angleDegrees = clampAngle(angleDegrees)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // 背景图片视图占满整个 bounds
        backgroundImageView.frame = bounds
        
        // 渐变层占满整个 bounds
        gradientLayer.frame = bounds
        
        // 确保图层顺序正确
        if let fillIndex = layer.sublayers?.firstIndex(where: { $0 === fillLayer }) {
            if fillIndex != 0 {
                fillLayer.removeFromSuperlayer()
                layer.insertSublayer(fillLayer, at: 0)
            }
        }
        
        if let gradientIndex = layer.sublayers?.firstIndex(where: { $0 === gradientLayer }),
           let fillIndex = layer.sublayers?.firstIndex(where: { $0 === fillLayer }) {
            if gradientIndex <= fillIndex {
                gradientLayer.removeFromSuperlayer()
                layer.insertSublayer(gradientLayer, above: fillLayer)
            }
        }
        
        if let strokeIndex = layer.sublayers?.firstIndex(where: { $0 === strokeLayer }) {
            if strokeIndex != (layer.sublayers?.count ?? 1) - 1 {
                strokeLayer.removeFromSuperlayer()
                layer.addSublayer(strokeLayer)
            }
        }
        
        updatePath(animated: false)
        updateImageViewMask()
    }

    private func clampAngle(_ deg: CGFloat) -> CGFloat {
        min(max(deg, 0.1), 179.9)
    }
    
    /// 更新渐变设置
    private func updateGradient() {
        if let colors = gradientColors, !colors.isEmpty {
            // 显示渐变层，隐藏纯色层
            gradientLayer.isHidden = false
            fillLayer.isHidden = true
            
            // 设置渐变颜色
            gradientLayer.colors = colors.map { $0.cgColor }
            
            // 设置渐变位置
            if let locations = gradientLocations {
                gradientLayer.locations = locations.map { NSNumber(value: Float($0)) }
            } else {
                gradientLayer.locations = nil
            }
        } else {
            // 隐藏渐变层，显示纯色层
            gradientLayer.isHidden = true
            fillLayer.isHidden = false
        }
    }

    /// 更新所有路径（填充、边框、背景图片遮罩）
    public func updatePath(animated: Bool = false, animationDuration: CFTimeInterval = 0.25) {
        guard bounds.width > 0 && bounds.height > 0 else { return }
        
        // 主路径（用于填充和边框）
        let mainPath = makeDiamondPathWithHorizontalSides(
            in: bounds,
            angleDegrees: angleDegrees,
            cornerRadii: cornerRadii
        )
        let mainCGPath = mainPath.cgPath

        if animated {
            // 填充层动画
            let fillAnim = CABasicAnimation(keyPath: "path")
            fillAnim.fromValue = fillLayer.path
            fillAnim.toValue = mainCGPath
            fillAnim.duration = animationDuration
            fillAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            fillLayer.add(fillAnim, forKey: "path")
            
            // 渐变遮罩层动画
            let gradientMaskAnim = CABasicAnimation(keyPath: "path")
            gradientMaskAnim.fromValue = gradientMaskLayer.path
            gradientMaskAnim.toValue = mainCGPath
            gradientMaskAnim.duration = animationDuration
            gradientMaskAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            gradientMaskLayer.add(gradientMaskAnim, forKey: "path")
            
            // 边框层动画
            let strokeAnim = CABasicAnimation(keyPath: "path")
            strokeAnim.fromValue = strokeLayer.path
            strokeAnim.toValue = mainCGPath
            strokeAnim.duration = animationDuration
            strokeAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            strokeLayer.add(strokeAnim, forKey: "path")
            
            // 背景图片遮罩动画
            if let maskLayer = backgroundImageView.layer.mask as? CAShapeLayer {
                let insetPath = makeAccurateInsetPath(
                    originalPath: mainPath,
                    inset: lineWidth / 2.0
                )
                let maskAnim = CABasicAnimation(keyPath: "path")
                maskAnim.fromValue = maskLayer.path
                maskAnim.toValue = insetPath.cgPath
                maskAnim.duration = animationDuration
                maskAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                maskLayer.add(maskAnim, forKey: "path")
            }
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            fillLayer.path = mainCGPath
            gradientMaskLayer.path = mainCGPath
            strokeLayer.path = mainCGPath
            updateImageViewMask()
            CATransaction.commit()
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            fillLayer.path = mainCGPath
            gradientMaskLayer.path = mainCGPath
            strokeLayer.path = mainCGPath
            updateImageViewMask()
            CATransaction.commit()
        }
    }
    
    /// 更新背景图片的遮罩层
    /// 使用精确的内缩路径，确保图片完全在边框内部且没有间隙
    private func updateImageViewMask() {
        guard bounds.width > 0 && bounds.height > 0 else { return }
        
        // 主路径
        let mainPath = makeDiamondPathWithHorizontalSides(
            in: bounds,
            angleDegrees: angleDegrees,
            cornerRadii: cornerRadii
        )
        
        // 创建精确的内缩路径
        // stroke 是居中的，所以图片需要内缩 lineWidth/2 才能完全在边框内
        let insetPath = makeAccurateInsetPath(
            originalPath: mainPath,
            inset: lineWidth / 2.0
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = insetPath.cgPath
        maskLayer.fillColor = UIColor.white.cgColor
        
        backgroundImageView.layer.mask = maskLayer
    }
    
    /// 创建精确的内缩路径
    /// 改进版：对圆角部分也进行准确的内缩处理
    private func makeAccurateInsetPath(originalPath: UIBezierPath, inset: CGFloat) -> UIBezierPath {
        guard inset > 0 else { return originalPath }
        
        // 获取原始路径的顶点
        let alpha = (180 - angleDegrees) * .pi / 180.0
        let halfW = bounds.width / 2.0
        let halfH = bounds.height / 2.0

        let cosA = cos(alpha)
        let absCosA = abs(cosA)
        let sinA = max(abs(sin(alpha)), CGFloat(1e-6))

        let sbMaxY = (2.0 * halfH) / sinA
        let sbMaxX: CGFloat = (absCosA < 1e-6) ? .greatestFiniteMagnitude : (2.0 * halfW) / absCosA
        let sb = min(sbMaxY, sbMaxX)

        var sa = 2.0 * halfW - sb * absCosA
        if sa < 0 { sa = 0 }

        let a = CGPoint(x: sa, y: 0)
        let b = CGPoint(x: sb * cosA, y: sb * sin(alpha))

        let cx = bounds.midX
        let cy = bounds.midY

        let mathP1 = CGPoint(x: cx + (a.x + b.x) / 2.0, y: cy + (a.y + b.y) / 2.0)
        let mathP2 = CGPoint(x: cx + (-a.x + b.x) / 2.0, y: cy + (-a.y + b.y) / 2.0)
        let mathP3 = CGPoint(x: cx + (-a.x - b.x) / 2.0, y: cy + (-a.y - b.y) / 2.0)
        let mathP4 = CGPoint(x: cx + (a.x - b.x) / 2.0, y: cy + (a.y - b.y) / 2.0)

        var allPoints = [
            (point: mathP1, index: 0),
            (point: mathP2, index: 1),
            (point: mathP3, index: 2),
            (point: mathP4, index: 3)
        ]
        
        allPoints.sort { p1, p2 in
            if abs(p1.point.y - p2.point.y) < 0.1 {
                return p1.point.x < p2.point.x
            }
            return p1.point.y < p2.point.y
        }
        
        let topPoints = Array(allPoints.prefix(2)).sorted { $0.point.x < $1.point.x }
        let bottomPoints = Array(allPoints.suffix(2)).sorted { $0.point.x < $1.point.x }
        
        let visualTopLeft = topPoints[0]
        let visualTopRight = topPoints[1]
        let visualBottomLeft = bottomPoints[0]
        let visualBottomRight = bottomPoints[1]
        
        let pts = [
            visualTopLeft.point,
            visualTopRight.point,
            visualBottomRight.point,
            visualBottomLeft.point
        ]
        
        // 对每个顶点进行内缩
        let insetPoints = insetPolygonPoints(points: pts, inset: inset)
        
        // 调整圆角半径
        let radiiArray: [CGFloat] = [
            adjustedCornerRadiusForInset(
                originalRadius: cornerRadii.topLeft,
                inset: inset,
                vertex: pts[0],
                prev: pts[3],
                next: pts[1]
            ),
            adjustedCornerRadiusForInset(
                originalRadius: cornerRadii.topRight,
                inset: inset,
                vertex: pts[1],
                prev: pts[0],
                next: pts[2]
            ),
            adjustedCornerRadiusForInset(
                originalRadius: cornerRadii.bottomRight,
                inset: inset,
                vertex: pts[2],
                prev: pts[1],
                next: pts[3]
            ),
            adjustedCornerRadiusForInset(
                originalRadius: cornerRadii.bottomLeft,
                inset: inset,
                vertex: pts[3],
                prev: pts[2],
                next: pts[0]
            )
        ]
        
        if radiiArray.allSatisfy({ $0 <= 0 }) {
            let path = UIBezierPath()
            path.move(to: insetPoints[0])
            for i in 1..<insetPoints.count { path.addLine(to: insetPoints[i]) }
            path.close()
            return path
        } else {
            return roundedPolygonPath(points: insetPoints, cornerRadiiArray: radiiArray)
        }
    }
    
    /// 根据内缩量和角度计算调整后的圆角半径
    private func adjustedCornerRadiusForInset(
        originalRadius: CGFloat,
        inset: CGFloat,
        vertex: CGPoint,
        prev: CGPoint,
        next: CGPoint
    ) -> CGFloat {
        guard originalRadius > 0 else { return 0 }
        
        let v1 = CGPoint(x: prev.x - vertex.x, y: prev.y - vertex.y)
        let v2 = CGPoint(x: next.x - vertex.x, y: next.y - vertex.y)
        
        let len1 = hypot(v1.x, v1.y)
        let len2 = hypot(v2.x, v2.y)
        
        let u1 = CGPoint(x: v1.x / len1, y: v1.y / len1)
        let u2 = CGPoint(x: v2.x / len2, y: v2.y / len2)
        
        let dotProduct = max(-1, min(1, u1.x * u2.x + u1.y * u2.y))
        let angle = acos(dotProduct)
        let sinHalfAngle = sin(angle / 2.0)
        
        var adjustedRadius: CGFloat
        if sinHalfAngle > 0.001 {
            adjustedRadius = originalRadius - inset / sinHalfAngle
        } else {
            adjustedRadius = originalRadius - inset
        }
        
        return max(0, adjustedRadius)
    }
    
    /// 对多边形的顶点进行内缩
    private func insetPolygonPoints(points: [CGPoint], inset: CGFloat) -> [CGPoint] {
        guard points.count >= 3 else { return points }
        
        let n = points.count
        var insetPoints: [CGPoint] = []
        
        for i in 0..<n {
            let prev = points[(i - 1 + n) % n]
            let cur = points[i]
            let next = points[(i + 1) % n]
            
            let v1 = CGPoint(x: prev.x - cur.x, y: prev.y - cur.y)
            let v2 = CGPoint(x: next.x - cur.x, y: next.y - cur.y)
            
            let len1 = hypot(v1.x, v1.y)
            let len2 = hypot(v2.x, v2.y)
            
            let u1 = CGPoint(x: v1.x / len1, y: v1.y / len1)
            let u2 = CGPoint(x: v2.x / len2, y: v2.y / len2)
            
            let n1 = CGPoint(x: u1.y, y: -u1.x)
            let n2 = CGPoint(x: -u2.y, y: u2.x)
            
            var bisector = CGPoint(x: n1.x + n2.x, y: n1.y + n2.y)
            let bisectorLen = hypot(bisector.x, bisector.y)
            
            if bisectorLen > 0.001 {
                bisector.x /= bisectorLen
                bisector.y /= bisectorLen
                
                let angle = acos(max(-1, min(1, u1.x * u2.x + u1.y * u2.y)))
                let sinHalfAngle = sin(angle / 2.0)
                let actualInset = sinHalfAngle > 0.001 ? inset / sinHalfAngle : inset
                
                let maxInset = min(len1, len2) / 3.0
                let finalInset = min(actualInset, maxInset)
                
                insetPoints.append(CGPoint(
                    x: cur.x + bisector.x * finalInset,
                    y: cur.y + bisector.y * finalInset
                ))
            } else {
                insetPoints.append(cur)
            }
        }
        
        return insetPoints
    }

    // MARK: - 单个角修改的便捷方法

    /// 修改单个角的半径（其他角保持不变）。可选择是否做路径动画。
    public func setCornerRadius(_ radius: CGFloat, for corner: JKDiamondCorner, animated: Bool = false, animationDuration: CFTimeInterval = 0.25) {
        var cr = self.cornerRadii
        let r = max(0, radius)
        switch corner {
        case .topRight: cr.topRight = r
        case .topLeft: cr.topLeft = r
        case .bottomLeft: cr.bottomLeft = r
        case .bottomRight: cr.bottomRight = r
        }
        self.cornerRadii = cr
        if animated {
            self.updatePath(animated: true, animationDuration: animationDuration)
        }
    }

    // MARK: - Geometry: 构造菱形（上/下边水平）

    private func makeDiamondPathWithHorizontalSides(in rect: CGRect, angleDegrees: CGFloat, cornerRadii: JKCornerRadii) -> UIBezierPath {
        let alpha = (180 - angleDegrees) * .pi / 180.0
        let halfW = rect.width / 2.0
        let halfH = rect.height / 2.0

        let cosA = cos(alpha)
        let absCosA = abs(cosA)
        let sinA = max(abs(sin(alpha)), CGFloat(1e-6))

        let sbMaxY = (2.0 * halfH) / sinA
        let sbMaxX: CGFloat = (absCosA < 1e-6) ? .greatestFiniteMagnitude : (2.0 * halfW) / absCosA
        let sb = min(sbMaxY, sbMaxX)

        var sa = 2.0 * halfW - sb * absCosA
        if sa < 0 { sa = 0 }

        let a = CGPoint(x: sa, y: 0)
        let b = CGPoint(x: sb * cosA, y: sb * sin(alpha))

        let cx = rect.midX
        let cy = rect.midY

        let mathP1 = CGPoint(x: cx + (a.x + b.x) / 2.0, y: cy + (a.y + b.y) / 2.0)
        let mathP2 = CGPoint(x: cx + (-a.x + b.x) / 2.0, y: cy + (-a.y + b.y) / 2.0)
        let mathP3 = CGPoint(x: cx + (-a.x - b.x) / 2.0, y: cy + (-a.y - b.y) / 2.0)
        let mathP4 = CGPoint(x: cx + (a.x - b.x) / 2.0, y: cy + (a.y - b.y) / 2.0)

        var allPoints = [
            (point: mathP1, index: 0),
            (point: mathP2, index: 1),
            (point: mathP3, index: 2),
            (point: mathP4, index: 3)
        ]
        
        allPoints.sort { p1, p2 in
            if abs(p1.point.y - p2.point.y) < 0.1 {
                return p1.point.x < p2.point.x
            }
            return p1.point.y < p2.point.y
        }
        
        let topPoints = Array(allPoints.prefix(2)).sorted { $0.point.x < $1.point.x }
        let bottomPoints = Array(allPoints.suffix(2)).sorted { $0.point.x < $1.point.x }
        
        let visualTopLeft = topPoints[0]
        let visualTopRight = topPoints[1]
        let visualBottomLeft = bottomPoints[0]
        let visualBottomRight = bottomPoints[1]
        
        let pts = [
            visualTopLeft.point,
            visualTopRight.point,
            visualBottomRight.point,
            visualBottomLeft.point
        ]
        
        let radiiArray: [CGFloat] = [
            cornerRadii.topLeft,
            cornerRadii.topRight,
            cornerRadii.bottomRight,
            cornerRadii.bottomLeft
        ]

        if radiiArray.allSatisfy({ $0 <= 0 }) {
            let path = UIBezierPath()
            path.move(to: pts[0])
            for i in 1..<pts.count { path.addLine(to: pts[i]) }
            path.close()
            return path
        } else {
            return roundedPolygonPath(points: pts, cornerRadiiArray: radiiArray)
        }
    }

    // MARK: - 顶点圆角实现（基于二次曲线近似）

    private func roundedPolygonPath(points: [CGPoint], cornerRadiiArray: [CGFloat]) -> UIBezierPath {
        guard points.count >= 3 else {
            return UIBezierPath()
        }

        let n = points.count
        let path = UIBezierPath()

        for i in 0..<n {
            let prev = points[(i - 1 + n) % n]
            let cur  = points[i]
            let next = points[(i + 1) % n]

            let v1 = CGPoint(x: prev.x - cur.x, y: prev.y - cur.y)
            let v2 = CGPoint(x: next.x - cur.x, y: next.y - cur.y)

            let len1 = max(hypot(v1.x, v1.y), 1e-6)
            let len2 = max(hypot(v2.x, v2.y), 1e-6)

            let d1 = CGPoint(x: v1.x / len1, y: v1.y / len1)
            let d2 = CGPoint(x: v2.x / len2, y: v2.y / len2)

            let desiredRadius = max(0, cornerRadiiArray[i])
            let offset = min(desiredRadius, min(len1, len2) / 2.0)

            let p1 = CGPoint(x: cur.x + d1.x * offset, y: cur.y + d1.y * offset)
            let p2 = CGPoint(x: cur.x + d2.x * offset, y: cur.y + d2.y * offset)

            if i == 0 {
                path.move(to: p1)
            } else {
                path.addLine(to: p1)
            }

            path.addQuadCurve(to: p2, controlPoint: cur)
        }

        path.close()
        return path
    }
}
