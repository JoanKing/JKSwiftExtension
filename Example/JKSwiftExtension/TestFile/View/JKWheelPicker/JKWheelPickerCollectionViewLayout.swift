//
//  JKWheelPickerCollectionViewLayout.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/3/3.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

public protocol JKWheelPickerLayoutDelegate: AnyObject {
    func pickerViewStyle(for layout: JKWheelPickerCollectionViewLayout) -> JKWheelPickerStyle
}

open class JKWheelPickerCollectionViewLayout : UICollectionViewFlowLayout {
    
    open weak var delegate: JKWheelPickerLayoutDelegate?
    
    fileprivate var width = CGFloat(0.0)
    fileprivate var height = CGFloat(0.0)
    fileprivate var midX = CGFloat(0.0)
    fileprivate var midY = CGFloat(0.0)
    fileprivate var maxAngle = CGFloat(0.0)
    
    override open func prepare() {
        let visibleRect =  CGRect(origin: collectionView?.contentOffset ?? CGPoint.zero, size: collectionView?.bounds.size ?? CGSize.zero)
        midX = visibleRect.midX
        midY =  visibleRect.midY
        width = visibleRect.width/2
        height = visibleRect.height/2
        maxAngle = CGFloat(Double.pi / 2)
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attributes = super.layoutAttributesForItem(at: indexPath) , let style = delegate?.pickerViewStyle(for: self) {
            switch style {
            case .styleFlat:
                return attributes
            case .style3D:
                if scrollDirection == .horizontal {
                    let distance = attributes.frame.midX - midX
                    let currentAngle = maxAngle * distance / width / CGFloat(Double.pi / 2.0)
                    var transform = CATransform3DIdentity
                    transform = CATransform3DTranslate(transform, -distance, 0.0, -width)
                    transform = CATransform3DRotate(transform, currentAngle, 0, 1, 0)
                    transform = CATransform3DTranslate(transform, 0, 0, width)
                    if abs(currentAngle) < maxAngle {
                        attributes.transform3D = transform
                        attributes.alpha =   1.0
                    } else {
                        attributes.alpha = 0.0
                    }
                } else {
                    let distance = attributes.frame.midY - midY
                    let currentAngle = maxAngle * distance / height / CGFloat(Double.pi / 2)
                    var transform = CATransform3DIdentity
                    transform = CATransform3DTranslate(transform, 0, -distance, 0)
                    transform = CATransform3DRotate(transform, currentAngle, 1, 0, 0)
                    transform = CATransform3DTranslate(transform, 0, distance, 0)
                    if abs(currentAngle) < maxAngle / 2 {
                        attributes.transform3D = transform
                        attributes.alpha =   1.0
                    } else {
                        attributes.alpha = 0.0
                    }
                }
                return attributes
            }
        }
        return nil
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let style = delegate?.pickerViewStyle(for: self) {
            switch style {
            case .styleFlat:
                return super.layoutAttributesForElements(in: rect)
            case .style3D:
                var attributes = [UICollectionViewLayoutAttributes]()
                if  let indexs = collectionView?.numberOfItems(inSection: 0), (collectionView?.numberOfSections)! > 0 {
                    for index in 0 ..< indexs {
                        let indexPath = IndexPath(item: index, section: 0)
                        if let attribut = self.layoutAttributesForItem(at: indexPath) {
                            attributes.append(attribut)
                        } else {
                            attributes.append(UICollectionViewLayoutAttributes())
                        }
                    }
                }
                return attributes
            }
        }
        return nil
    }
}
