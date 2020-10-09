//
//  UIButton+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit

// MARK:- 链式调用
public extension UIButton {
    @discardableResult
    func title(_ text: String, _ state: UIControl.State = .normal) -> Self {
        setTitle(text, for: state)
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func font(_ fontSize: Float) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func font(_ fontSize: Int) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func boldFont(_ fontSize: Float) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func boldFont(_ fontSize: Int) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(in bundle: Bundle? = nil, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(in bundle: Bundle, name imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(for aClass: AnyClass, name imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: Bundle(for: aClass), compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(forParent aClass: AnyClass, bundleName: String, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        guard let path = Bundle(for: aClass).path(forResource: bundleName, ofType: "bundle") else {
            return self
        }
        let image = UIImage(named: imageName, in: Bundle(path: path), compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    
    
    @discardableResult
    func image(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage.createImageWithSize(color: color)
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(forParent aClass: AnyClass, bundleName: String, _ imageName: String, _: UIControl.State = .normal) -> Self {
        guard let path = Bundle(for: aClass).path(forResource: bundleName, ofType: "bundle") else {
            return self
        }
        let image = UIImage(named: imageName, in: Bundle(path: path), compatibleWith: nil)
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(in bundle: Bundle? = nil, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(for aClass: AnyClass, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: Bundle(for: aClass), compatibleWith: nil)
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage.createImageWithSize(color: color)
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func confirmButton() -> Self {
        let normalImage = UIImage.image(color: UIColor.hexColor(hex: "#E54749"), size: CGSize(width: 10, height: 10), round: 4)?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        let disableImg = UIImage.image(color: UIColor.hexColor(hex: "#E6E6E6"), size: CGSize(width: 10, height: 10), round: 4)?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        setBackgroundImage(normalImage, for: .normal)
        setBackgroundImage(disableImg, for: .disabled)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor?, state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
}

// MARK:- 自带倒计时功能的Button
/// 自带倒计时功能的Button
/// - Important: 状态分为 [倒计时中，倒计时完成]，分别提供回调
/// - Attention: 需要和业务结合时，后期再考虑
public extension UIButton {
    typealias TimeringBlock = (Int) -> ()
    typealias CompletionBlock = () -> ()
    
    private struct TimerKey {
        static var timer_key = "timer_key"
        static var running_key = "running_key"
        static var timeringPrefix_key = "timering_prefix_key"
        static var reEnableCond_key = "re_enable_cond_key"
    }
    var reEnableCond: Bool? {
        get {
            if let value = objc_getAssociatedObject(self, &TimerKey.reEnableCond_key) {
                return value as? Bool
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &TimerKey.reEnableCond_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var timer: DispatchSourceTimer? {
        get {
            if let value = objc_getAssociatedObject(self, &TimerKey.timer_key) {
                return value as? DispatchSourceTimer
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &TimerKey.timer_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var isTiming: Bool {
        get {
            if let value = objc_getAssociatedObject(self, &TimerKey.running_key) {
                return value as! Bool
            }
            // 默认状态
            return false
        }
        set {
            objc_setAssociatedObject(self, &TimerKey.running_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 当处于倒计时时，前缀文案——such as 「再次获取」 + (xxxs)
    var timeringPrefix: String? {
        get {
            if let value = objc_getAssociatedObject(self, &TimerKey.timeringPrefix_key) {
                return value as? String
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &TimerKey.timeringPrefix_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func countDown(_ count: Int, timering: TimeringBlock? = nil, complete: CompletionBlock? = nil, timeringPrefix: String = "再次获取", completeText: String = "重新获取") {
        isEnabled = false
        let begin = ProcessInfo().systemUptime
        let c_default = UIColor.hexColor(hex: "#2798fd")
        let c_default_disable = UIColor.hexColor(hex: "#999999")
        
        self.color(titleColor(for: .normal) ?? c_default)
        self.color(titleColor(for: .disabled) ?? c_default_disable, .disabled)
        var remainingCount: Int = count {
            willSet {
                setTitle(timeringPrefix + "(\(newValue)s)", for: .normal)
                if newValue <= 0 {
                    setTitle(completeText, for: .normal)
                }
            }
        }
        self.invalidate()
        self.timer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        self.timer?.schedule(deadline: .now(), repeating: .seconds(1))
        self.isTiming = true
        self.timer?.setEventHandler(handler: {
            DispatchQueue.main.async {
                remainingCount = count - Int(ProcessInfo().systemUptime - begin)
                if remainingCount <= 0 {
                    if let cb = complete {
                        cb()
                    }
                    // 计时结束后，enable的条件
                    self.isEnabled = self.reEnableCond ?? true
                    self.isTiming = false
                    self.invalidate()
                } else {
                    if let tb = timering {
                        tb(remainingCount)
                    }
                }
            }
        })
        self.timer?.resume()
    }
    
    func invalidate() {
        if self.timer != nil {
            self.timer?.cancel()
            self.timer = nil
        }
    }
}

// MARK:- UIButton 图片与title位置关系
/// UIButton 图片与title位置关系 https://www.jianshu.com/p/0f34c1b52604
public extension UIButton {
    
    enum ImageTitleLayout {
        case imgTop
        case imgBottom
        case imgLeft
        case imgRight
    }
    
    @discardableResult
    func setImgTitleLayout(_ layout: ImageTitleLayout, spacing: CGFloat = 0) -> Self {
        switch layout {
        case .imgLeft:
            alignHorizontal(spacing: spacing, imageFirst: true)
        case .imgRight:
            alignHorizontal(spacing: spacing, imageFirst: false)
        case .imgTop:
            alignVertical(spacing: spacing, imageTop: true)
        case .imgBottom:
            alignVertical(spacing: spacing, imageTop: false)
        }
        return self
    }
    
    private func alignHorizontal(spacing: CGFloat, imageFirst: Bool) {
        let edgeOffset = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0,
                                       left: -edgeOffset,
                                       bottom: 0,
                                       right: edgeOffset)
        titleEdgeInsets = UIEdgeInsets(top: 0,
                                       left: edgeOffset,
                                       bottom: 0,
                                       right: -edgeOffset)
        
        if !imageFirst {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
            imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        // increase content width to avoid clipping
        contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
    }
    
    private func alignVertical(spacing: CGFloat, imageTop: Bool) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else {
                return
        }
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let imageVerticalOffset = (titleSize.height + spacing)/2
        let titleVerticalOffset = (imageSize.height + spacing)/2
        let imageHorizontalOffset = (titleSize.width)/2
        let titleHorizontalOffset = (imageSize.width)/2
        let sign: CGFloat = imageTop ? 1 : -1
        
        imageEdgeInsets = UIEdgeInsets(top: -imageVerticalOffset * sign,
                                       left: imageHorizontalOffset,
                                       bottom: imageVerticalOffset * sign,
                                       right: -imageHorizontalOffset)
        titleEdgeInsets = UIEdgeInsets(top: titleVerticalOffset * sign,
                                       left: -titleHorizontalOffset,
                                       bottom: -titleVerticalOffset * sign,
                                       right: titleHorizontalOffset)
        
        // increase content height to avoid clipping
        let edgeOffset = (min(imageSize.height, titleSize.height) + spacing)/2
        contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0, bottom: edgeOffset, right: 0)
    }
    
}

// MARK:- 带有样式的button
private enum LineType {
    case none
    case color(_: UIColor)
}

private func drawSmallBtn(color: UIColor, height: CGFloat, lineType: LineType) -> UIImage? {
    let rect = CGRect(x: 0, y: 0, width: 200, height: height + 20)
    let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 3, width: 180, height: height), cornerRadius: height / 2)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.addPath(path.cgPath)
    context?.setShadow(offset: CGSize(width: 1, height: 4), blur: 10, color: color.withAlphaComponent(0.5).cgColor)
    context?.fillPath()
    
    switch lineType {
    case let .color(color):
        color.setStroke()
        path.lineWidth = kPixel
        path.stroke()
    default:
        break
    }
    
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
}

private func drawNormalBtn(color: UIColor) -> UIImage? {
    let rect = CGRect(x: 0, y: 0, width: 260, height: 50)
    let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 3, width: 240, height: 40), cornerRadius: 3)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.addPath(path.cgPath)
    context?.setShadow(offset: CGSize(width: 1, height: 2), blur: 6, color: color.withAlphaComponent(0.5).cgColor)
    context?.fillPath()
    
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
}

public extension UIButton {
    enum SmallButtonType {
        case red
        case pink
    }

    static func small(type: SmallButtonType = .red, height: CGFloat = 45) -> UIButton {
        let normalColor: UIColor
        let disabledColor: UIColor
        let lineTypeNormal: LineType
        let lineTypeDisable: LineType
        let titleColorNormal: UIColor
        let titleColorDisable: UIColor

        switch type {
        case .red:
            normalColor = .hexColor(hex: "#E54749")
            disabledColor = .hexColor(hex: "#CCCCCC")
            lineTypeNormal = .none
            lineTypeDisable = .none
            titleColorNormal = .white
            titleColorDisable = .white
        case .pink:
            normalColor = .hexColor(hex: "#FFE8E8")
            disabledColor = .hexColor(hex: "#CCCCCC")
            lineTypeNormal = .color(.hexColor(hex: "#F6CDCD"))
            lineTypeDisable = .color(.hexColor(hex: "#9C9C9C"))
            titleColorNormal = .hexColor(hex: "#E54749")
            titleColorDisable = .white
        }

        let btn = UIButton(type: .custom).font(.systemFont(ofSize: 16))
        btn.setTitleColor(titleColorNormal, for: .normal)
        btn.setTitleColor(titleColorDisable, for: .disabled)
        btn.setBackgroundImage(drawSmallBtn(color: normalColor, height: height, lineType: lineTypeNormal), for: .normal)
        btn.setBackgroundImage(drawSmallBtn(color: disabledColor, height: height, lineType: lineTypeDisable), for: .disabled)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 13, right: 0)
        return btn
    }
    
    static func normal() -> UIButton {
        let btn = UIButton(type: .custom).font(.boldSystemFont(ofSize: 18))
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.white, for: .disabled)
        btn.setBackgroundImage(drawNormalBtn(color: .hexColor(hex: "#E54749"))?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)), for: .normal)
        btn.setBackgroundImage(drawNormalBtn(color: .hexColor(hex: "#CCCCCC"))?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)), for: .disabled)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        return btn
    }

}
