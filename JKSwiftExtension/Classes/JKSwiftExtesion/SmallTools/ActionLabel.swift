//
//  ActionLabel.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

public typealias UILabelAction = (UILabel) -> Void

public class ActionLabel: UILabel {
    @objc public var action: UILabelAction?
    
    // MARK:- 自定义 ActionLabel
    /// 自定义 ActionLabel
    /// - Parameters:
    ///   - frame: frame
    ///   - target: target
    ///   - selector: selector description
    /// - Returns: 描述
    public class func createActionLabel(frame: CGRect, target: Any?, selector: Selector = #selector(tapAction)) -> ActionLabel {
        let label = ActionLabel(frame: frame)
        label.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: target, action: selector)
        label.addGestureRecognizer(recognizer)
        return label
    }
    
    /// 不是使用上面的创建可以实现下面的方法来定义事件
    /// - Returns: description
    public func addTarget() -> Self {
        isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(recognizer)
        return self
    }

    /// 事件的回调
    @objc public func tapAction() {
        action?(self)
    }
}


