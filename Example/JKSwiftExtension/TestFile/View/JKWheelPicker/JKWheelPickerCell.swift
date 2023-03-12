//
//  JKWheelPickerCell.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/3/3.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

open class JKWheelPickerCell : UICollectionViewCell {

    static public let identifier = "JKWheelPickerCell"
    
    open var label: UILabel!
    open var imageView: UIImageView!
    /// 正常的字体
    open var font: UIFont!
    /// 选中的字体
    open var highlightedFont: UIFont!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.isDoubleSided = false
        label = UILabel(frame: contentView.bounds)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.highlightedTextColor = UIColor.black
        label.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        contentView.addSubview(label)
        
        imageView = UIImageView(frame: contentView.bounds)
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .center
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(imageView)
    }
    
    override open var isSelected: Bool {
        didSet {
            //if oldValue == false {
                let transition = CATransition()
                transition.duration = 0.15
                transition.type = CATransitionType(rawValue: kCATransition)
                label.layer.add(transition, forKey: nil)
                label.font = isSelected ? highlightedFont : font
                debugPrint("是否选中：\(isSelected)")
            //}
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = ""
        imageView.image = nil
    }
}
