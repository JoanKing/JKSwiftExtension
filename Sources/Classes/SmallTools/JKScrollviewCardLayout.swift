//
//  JKScrollviewCardLayout.swift
//  JKSwiftExtension
//
//  Created by chongwang on 2025/1/9.
//
// 注释:借鉴于 JFBanner

import UIKit

public class JKScrollviewCardLayout: UICollectionViewFlowLayout {
    /// item间距
    var itemSpacing: CGFloat = 30
    /// 缩放比例
    var scaleRate: CGFloat = 0.7
    /// 透明度
    var alphaRate: CGFloat = 0.7
    /// contentView
    private var contentView: UICollectionView {
        guard let collectionView = collectionView else {
            fatalError("CollectionView could not be nil!")
        }
        return collectionView
    }
    
    private var insetX: CGFloat { (contentView.frame.width - itemSize.width) / 2 }
    
    private var insetY: CGFloat { (contentView.frame.height - itemSize.height) / 2 }
    
    public override class var layoutAttributesClass: AnyClass { JKBannerAttributes.self }
    
    public override init() {
        super.init()
        itemSize = CGSize(width: 1, height: 1)
        scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        if itemSize == CGSize(width: 1, height: 1) {
            itemSize = contentView.frame.size
        }
        sectionInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        minimumLineSpacing = itemSpacing
        minimumInteritemSpacing = 0
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        return attributes.compactMap { $0.copy() as? JKBannerAttributes }.map { transformLayoutAttributes($0) }
    }

    private func transformLayoutAttributes(_ attributes: JKBannerAttributes) -> UICollectionViewLayoutAttributes {
        
        let alphaFactor: CGFloat
        let transform: CGAffineTransform
         
        switch scrollDirection {
        case .horizontal:
            let centerX = contentView.contentOffset.x + insetX + itemSize.width / 2
            let itemOffset = attributes.center.x - centerX
            let offsetFactor = itemOffset / (itemSize.width + itemSpacing)
            // 计算缩放比例
            // 如果scaleRate = 0.7 缩放比例为 ... 0.49 <- 0.7 <- 1 -> 0.7 -> 0.49 ...
            let scaleFactor = pow(scaleRate, abs(offsetFactor))

            // 计算平移距离
            // 当前算法平移距离只是约等于itemSpacing，如果有更好的计算方法，请联系我，谢谢！
            let translationX = -(attributes.frame.width * (1 - scaleFactor) / 2) * offsetFactor
            
            transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor).concatenating(CGAffineTransform(translationX: translationX, y: 0))
            
            alphaFactor = 1 - (abs(offsetFactor) * (1 - alphaRate))
            attributes.centerX = attributes.center.x
        case .vertical:
            let centerY = contentView.contentOffset.y + insetY + itemSize.height / 2
            let itemOffset = attributes.center.y - centerY
            let offsetFactor = itemOffset / (itemSize.height + itemSpacing)
            
            let scaleFactor = pow(scaleRate, abs(offsetFactor))

            let translationY = -(attributes.frame.height * (1 - scaleFactor) / 2) * offsetFactor
            
            transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor).concatenating(CGAffineTransform(translationX: 0, y: translationY))

            alphaFactor = 1 - (abs(offsetFactor) * (1 - alphaRate))
            attributes.centerY = attributes.center.y
        @unknown default:
            fatalError("Unknown case!")
        }
        
        attributes.alpha = max(0.3, alphaFactor)
        attributes.transform = transform
        
        return attributes
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var targetContentOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        guard let layoutAttributes = layoutAttributesForElements(in: contentView.bounds) as? [JKBannerAttributes] else {
            return targetContentOffset
        }
        guard !layoutAttributes.isEmpty else {
            return targetContentOffset
        }
        switch scrollDirection {
        case .horizontal:
            let centerX = contentView.frame.width / 2
            let proposedCenterX = proposedContentOffset.x + centerX
            let closestAttributes = layoutAttributes.sorted(by: { abs($0.centerX - proposedCenterX) < abs($1.centerX - proposedCenterX) }).first!
            targetContentOffset = CGPoint(x: closestAttributes.centerX - centerX, y: proposedContentOffset.y)
        case .vertical:
            let centerY = contentView.frame.height / 2
            let proposedCenterY = proposedContentOffset.y + centerY
            let closestAttributes = layoutAttributes.sorted(by: { abs($0.centerY - proposedCenterY) < abs($1.centerY - proposedCenterY) }).first!
            targetContentOffset = CGPoint(x: proposedContentOffset.x, y: closestAttributes.centerY - centerY)
        @unknown default:
            fatalError("Unknown case!")
        }
        return targetContentOffset
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class JKBannerAttributes: UICollectionViewLayoutAttributes {
    
    var centerX: CGFloat = 0
    var centerY: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! JKBannerAttributes
        copy.centerX = centerX
        copy.centerY = centerY
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let o = object as? JKBannerAttributes else { return false }
        return super.isEqual(o) && o.centerX == centerX && o.centerY == centerY
    }
}

