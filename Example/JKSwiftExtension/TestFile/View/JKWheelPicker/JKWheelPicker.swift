//
//  JKWheelPicker.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/3/3.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation

public enum JKWheelPickerStyle: Int {
    case style3D = 1
    case styleFlat
}

@objc public protocol JKWheelPickerDataSource: AnyObject {
    
    func numberOfItems(_ wheelPicker: JKWheelPicker) -> Int
    
    @objc optional func titleFor(_ wheelPicker: JKWheelPicker, at index: Int) -> String
    @objc optional func imageFor(_ wheelPicker: JKWheelPicker, at index: Int) -> UIImage
}

@objc public protocol JKWheelPickerDelegate: AnyObject {
    
    @objc optional func wheelPicker(_ wheelPicker: JKWheelPicker, didSelectItemAt index: Int)
    @objc optional func wheelPicker(_ wheelPicker: JKWheelPicker, marginForItem index: Int) -> CGSize
    @objc optional func wheelPicker(_ wheelPicker: JKWheelPicker, configureLabel label: UILabel, at index: Int)
    @objc optional func wheelPicker(_ wheelPicker: JKWheelPicker, configureImageView imageView: UIImageView, at index: Int)
}

public class JKWheelPicker: UIView {
    
    weak open var delegate: JKWheelPickerDelegate?
    weak open var dataSource: JKWheelPickerDataSource?
    
    /// font item
    open var font = UIFont.systemFont(ofSize: 20.0)
    
    /// font hlighted item
    open var highlightedFont = UIFont.boldSystemFont(ofSize: 20.0)
    
    /// text color item
    open var textColor = UIColor.darkGray
    
    /// text color hlighted item
    open var highlightedTextColor = UIColor.black
    
    ///  disable/enable mask
    open var isMaskDisabled = false {
        didSet {
            if isMaskDisabled == false {
                let maskLayer =  CAGradientLayer()
                maskLayer.frame = self.bounds
                maskLayer.colors = [UIColor.clear.cgColor,
                                    UIColor.black.cgColor,
                                    UIColor.black.cgColor,
                                    UIColor.clear.cgColor]
                maskLayer.locations = [NSNumber(value: 0.0),
                                       NSNumber(value: 0.33),
                                       NSNumber(value: 0.66),
                                       NSNumber(value: 1.0)]
                if scrollDirection == .horizontal {
                    maskLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                    maskLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
                } else {
                    maskLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                    maskLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
                }
                self.layer.mask = maskLayer
                self.layer.masksToBounds = true
            } else {
                self.layer.mask = nil
            }
        }
    }
    /// Space item
    open var interitemSpacing = CGFloat(10.0)
    
    /// 0...1; slight value recommended such as 0.0001
    open var fisheyeFactor = CGFloat(0.0001) {
        didSet {
            var transform =  CATransform3DIdentity
            if scrollDirection == .horizontal {
                transform.m34 = -max(min(fisheyeFactor, 1.0) ,0.0)
            } else {
                transform.m34 = max(min(fisheyeFactor, 1.0) ,0.0)
            }
            self.collectionView.layer.sublayerTransform = transform
        }
    }
    /// picker style .style3D or .styleFlat
    open var style = JKWheelPickerStyle.style3D
    open var scrollDirection = UICollectionView.ScrollDirection.horizontal {
        didSet {
            let value = self.fisheyeFactor
            self.fisheyeFactor = value
            let mask = self.isMaskDisabled
            isMaskDisabled = mask
            self.reloadData()
        }
    }
    ///  selected Item
    fileprivate(set) open var selectedItem = Int(0)
    fileprivate var prevIndex = Int(0)
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var feedbackGenerator: AnyObject?
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout:collectionViewLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = backgroundColor
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(JKWheelPickerCell.self, forCellWithReuseIdentifier: JKWheelPickerCell.identifier)
        
        layer.mask = nil
        
        addSubview(collectionView)
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        collectionView.collectionViewLayout = collectionViewLayout()
        collectionView.layer.mask?.frame = collectionView.bounds
    }
    
    fileprivate func collectionViewLayout()-> JKWheelPickerCollectionViewLayout {
        
        let layout = JKWheelPickerCollectionViewLayout()
        layout.scrollDirection =  self.scrollDirection
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.minimumLineSpacing = 0.0
        layout.delegate = self
        return layout
    }
}

// MARK: - Public methods

extension JKWheelPicker {
    
    public func reloadData() {
        
        invalidateIntrinsicContentSize()
        
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
        guard ((dataSource?.numberOfItems(self)) != nil) else {
            return
        }
        collectionView.setNeedsDisplay()
        self.selected(selectedItem, animated: false, notifySelection:  false)
    }
    
    public func select(_ item: Int, animated: Bool) {
        selected(item, animated: animated, notifySelection: true)
    }
    
    public func scroll(to item: Int, _ animated: Bool ) {
        
        switch style {
        case .styleFlat:
            let indexPath = IndexPath(item: item, section: 0)
            let position = scrollDirection == .horizontal ? UICollectionView.ScrollPosition.centeredHorizontally : UICollectionView.ScrollPosition.centeredVertically
            collectionView.scrollToItem(at: indexPath, at: position, animated: animated)
        case .style3D:
            if scrollDirection == .horizontal {
                collectionView.setContentOffset(CGPoint(x: offset(for: item) ,y: collectionView.contentOffset.y), animated: animated)
            } else {
                collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x ,y: offset(for: item)), animated: animated)
            }
        }
    }
}
// MARK: - Private methods
extension JKWheelPicker {
    
    fileprivate func selected(_ item: Int, animated: Bool, notifySelection: Bool) {
        
        let scrollPosition = scrollDirection == UICollectionView.ScrollDirection.vertical ? UICollectionView.ScrollPosition.centeredVertically : UICollectionView.ScrollPosition.centeredHorizontally
        selectedItem = item
        collectionView.selectItem(at: IndexPath(item:item, section: 0), animated: animated, scrollPosition: scrollPosition)
        scroll(to: item, animated)
        if notifySelection == true {
            delegate?.wheelPicker?(self, didSelectItemAt: item)
        }
    }
    
    fileprivate func offset(for item: Int)-> CGFloat {
        
        var offset = CGFloat(0.0)
        for  index  in 0 ..< item {
            let indexPath = IndexPath(item: index, section: 0)
            let cellSize = collectionView(collectionView, layout: collectionView.collectionViewLayout, indexPath: indexPath)
            if scrollDirection == .horizontal {
                offset += cellSize.width
            } else {
                offset += cellSize.height
            }
        }
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        let firstSize = collectionView(collectionView, layout: collectionView.collectionViewLayout, indexPath: firstIndexPath)
        let selectedIndexPath = IndexPath(item: item, section: 0)
        let selectedSize = collectionView(collectionView, layout: collectionView.collectionViewLayout, indexPath: selectedIndexPath)
        
        if scrollDirection == .horizontal {
            offset -= (firstSize.width - selectedSize.width) / 2
        } else {
            offset -= (firstSize.height - selectedSize.height) / 2
        }
        return offset
    }
    
    fileprivate func collectionView( _ collectionView: UICollectionView,  layout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize  {
        
        var size =  scrollDirection == .horizontal ? CGSize(width: interitemSpacing, height: collectionView.bounds.size.height) :
        CGSize(width: collectionView.bounds.size.width, height: interitemSpacing)
        
        if let title = dataSource?.titleFor?(self, at: indexPath.item) {
            if scrollDirection == .horizontal {
                size.width += sizeFor(title).width
            } else {
                size.height += sizeFor(title).height
            }
            if let marginSize = delegate?.wheelPicker?(self, marginForItem: indexPath.item) {
                if scrollDirection == .horizontal {
                    size.width += marginSize.width * 2
                } else {
                    size.height += marginSize.height * 2
                }
            }
        } else if let image = dataSource?.imageFor?(self, at: indexPath.item) {
            if scrollDirection == .horizontal {
                size.width += image.size.width
            } else {
                size.height += image.size.height
            }
        }
        return size
    }
    
    fileprivate func sizeFor(_ string: String) -> CGSize {
        let size =  string.size(withAttributes: [NSAttributedString.Key.font: font])
        let highlightedSize = string.size(withAttributes: [NSAttributedString.Key.font: highlightedFont])
        return CGSize(width: ceil(max(size.width, highlightedSize.width)), height: ceil(max(size.height, highlightedSize.height)))
    }
    
    fileprivate func didEndScrolling() {
        
        switch style {
        case .styleFlat:
            let center = self.convert(collectionView.center, to: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: center) {
                select(indexPath.item, animated: true)
            }
        case .style3D:
            guard let numberOfItems = dataSource?.numberOfItems(self) else {
                return
            }
            for index in 0 ..< numberOfItems {
                let indexPath = IndexPath(item: index, section: 0)
                if let cell = collectionView.cellForItem(at: indexPath) {
                    let half = scrollDirection == .horizontal ?  cell.bounds.size.width / 2 : cell.bounds.size.height / 2
                    let currentOffset = scrollDirection == .horizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
                    
                    if offset(for: index) + half > currentOffset {
                        select(index, animated: true)
                        break
                    }
                }
            }
        }
    }
    
    fileprivate func generateFeedback() {
        AudioServicesPlaySystemSoundWithCompletion(1104, nil)
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension JKWheelPicker: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard  let count = dataSource?.numberOfItems(self) else {
            return 0
        }
        return count > 0 ? 1 : 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfItems(self) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JKWheelPickerCell.identifier, for: indexPath) as? JKWheelPickerCell else {
            return UICollectionViewCell()
        }
        
        if let title = dataSource?.titleFor?(self, at: indexPath.item) {
            
            cell.label.isHidden = false
            cell.imageView.isHidden = true
            
            cell.label.text = title
            cell.label.textColor = self.textColor
            cell.label.highlightedTextColor = self.highlightedTextColor
            cell.label.font = self.font
            cell.font = self.font
            cell.highlightedFont = self.highlightedFont
            cell.label.bounds = CGRect(origin: CGPoint.zero, size: sizeFor(title))
            
            if let margin = delegate?.wheelPicker?(self, marginForItem: indexPath.item) {
                
                cell.label.frame = cell.label.frame.insetBy(dx: -margin.width, dy: -margin.height)
            }
            
            delegate?.wheelPicker?(self, configureLabel: cell.label, at: indexPath.item)
            
        } else if let image = dataSource?.imageFor?(self, at: indexPath.item) {
            
            cell.label.isHidden = true
            cell.imageView.isHidden = false
            
            cell.imageView.image = image
            
            if let margin = delegate?.wheelPicker?(self, marginForItem: indexPath.item) {
                cell.imageView.frame = cell.imageView.frame.insetBy(dx: -margin.width, dy: -margin.height)
            }
            delegate?.wheelPicker?(self, configureImageView: cell.imageView, at: indexPath.item)
        }
        cell.label.font = self.font
        cell.isSelected = indexPath.item == selectedItem
        debugPrint("显示：\(indexPath.item) 当前的item:\(selectedItem)")
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension JKWheelPicker: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size =  scrollDirection == .horizontal ? CGSize(width: interitemSpacing, height: bounds.size.height) :
        CGSize(width: bounds.size.width, height: interitemSpacing)
        
        if let title = dataSource?.titleFor?(self, at: indexPath.item) {
            if scrollDirection == .horizontal {
                size.width += sizeFor(title).width
            } else {
                size.height += sizeFor(title).height
            }
            if let marginSize = delegate?.wheelPicker?(self, marginForItem: indexPath.item) {
                size.width += marginSize.width * 2
                size.height += marginSize.height * 2
            }
        } else if let image = dataSource?.imageFor?(self, at: indexPath.item) {
            if scrollDirection == .horizontal {
                size.width += image.size.width
            } else {
                size.height += image.size.height
            }
        }
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if let number = dataSource?.numberOfItems(self), number > 0 {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            let firstSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, indexPath: firstIndexPath)
            let lastIndexPath = IndexPath(item: number - 1, section: 0)
            let lastSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, indexPath: lastIndexPath)
            
            if scrollDirection == .horizontal {
                return UIEdgeInsets(top: 0.0, left: (collectionView.bounds.size.width - firstSize.width) / 2, bottom: 0.0, right: (collectionView.bounds.size.width - lastSize.width) / 2)
            } else {
                return UIEdgeInsets(top: (collectionView.bounds.size.height - firstSize.height) / 2, left: 0.0, bottom: (collectionView.bounds.size.height - lastSize.height) / 2, right: 0.0)
            }
        } else {
            return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

// MARK: - UICollectionViewDelegate
extension JKWheelPicker: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        select(indexPath.item, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension JKWheelPicker: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isTracking == false {
            didEndScrolling()
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            didEndScrolling()
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let cells = collectionView.visibleCells
        
        for cell in cells {
            cell.isSelected = false
        }
        
        if scrollDirection == .horizontal {
            let x = collectionView.contentOffset.x + collectionView.bounds.width / 2
            if let indexPath = collectionView.indexPathForItem(at: CGPoint(x: x, y: collectionView.contentOffset.y)) , let cell = collectionView.cellForItem(at: indexPath) {
                cell.isSelected = true
                if indexPath.row != prevIndex {
                    generateFeedback()
                    prevIndex = indexPath.row
                }
            }
        } else {
            let y = collectionView.contentOffset.y + collectionView.bounds.height / 2
            
            if let indexPath = collectionView.indexPathForItem(at: CGPoint(x: collectionView.contentOffset.x, y: y)) , let cell = collectionView.cellForItem(at: indexPath) {
                
                cell.isSelected = true
                if indexPath.row != prevIndex {
                    generateFeedback()
                    prevIndex = indexPath.row
                }
            }
        }
    }
}

// MARK: - WheelPickerLayoutDelegate
extension JKWheelPicker: JKWheelPickerLayoutDelegate {
    
    public func  pickerViewStyle(for layout: JKWheelPickerCollectionViewLayout) -> JKWheelPickerStyle {
        return style
    }
}

