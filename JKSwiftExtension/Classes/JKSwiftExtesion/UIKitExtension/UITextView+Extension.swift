//
//  UITextView+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

// MARK: 提示：如果你想对textView.text直接赋值。请在设置属性之前进行，否则影响计算
// MARK:- 一、基本的扩展 (使用runtime添加属性)
public extension UITextView {
    
    // MARK: 1.1、设置占位符
    /// 设置占位符
    var placeholder: String? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholder, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            initPlaceholder(placeholder!)
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholder) as? String
        }
    }
    
    // MARK: 1.2、限制的字数
    /// 限制的字数
    var limitLength: NSNumber? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.limitLength, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            initWordCountLabel(limitLength!)
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.limitLength) as? NSNumber
        }
    }
    
    // MARK: 1.3、限制行数
    /// 限制的行数
    var limitLines: NSNumber? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.limitLines, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            NotificationCenter.default.addObserver(self, selector: #selector(limitLengthEvent), name: UITextView.textDidChangeNotification, object: self)
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.limitLines) as? NSNumber
        }
    }
    
    // MARK: 1.4、默认文本字体的大小
    /// 默认文本字体的大小
    var placeholdFont: UIFont? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholdFont, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if self.placeholderLabel != nil {
                self.placeholderLabel?.font = placeholdFont
            }
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholdFont) as? UIFont == nil ? UIFont.systemFont(ofSize: 13) : objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholdFont) as? UIFont
        }
    }
    
    // MARK: 1.5、默认文本的颜色
    /// 默认文本的颜色
    var placeholdColor: UIColor? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholdColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if self.placeholderLabel != nil {
                self.placeholderLabel?.textColor = placeholdColor
            }
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholdColor) as? UIColor == nil ? UIColor.lightGray : objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholdColor) as? UIColor
        }
    }
    
    // MARK: 1.6、设置 默认文本的Origin
    /// 设置 默认文本的Origin
    var placeholderOrigin: CGPoint? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholderOrigin, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if self.placeholderLabel != nil && placeholderOrigin != nil {
                self.placeholderLabel?.frame.origin = placeholderOrigin!
            }
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholderOrigin) as? CGPoint == nil ? CGPoint(x: 7, y: 7) : objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholderOrigin) as? CGPoint
        }
    }
    
    // MARK: 1.7、是否自动变化高度
    /// 是否自动变化高度
    var autoHeight: Bool? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.autoHeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.autoHeight) as? Bool == nil ? false : objc_getAssociatedObject(self, UITextView.RuntimeKey.autoHeight) as? Bool
        }
    }
}

// MARK:- fileprivate 私有的内容
extension UITextView {
    
    fileprivate struct RuntimeKey {
        static let placeholder: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDEL".hashValue)
        static let limitLength: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "LIMITLENGTH".hashValue)
        static let limitLines: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "LIMITLINES".hashValue)
        static let placeholderLabel: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDELABEL".hashValue)
        static let wordCountLabel: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "WORDCOUNTLABEL".hashValue)
        static let placeholdFont: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDFONT".hashValue)
        static let placeholdColor: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDCOLOR".hashValue)
        static let limitLabelColor: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "LIMITLABLECOLOR".hashValue)
        static let autoHeight: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "AUTOHEIGHT".hashValue)
        static let oldFrame: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "LODFRAME".hashValue)
        static let placeholderOrigin: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "PLACEHOLDERORIGIN".hashValue)
        // ...其他Key声明
    }
    
    /// 最初的 frame
    fileprivate var oldFrame: CGRect? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.oldFrame, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.oldFrame) as? CGRect
        }
    }
    
    /// 文字数量
    fileprivate var wordCountLabel: UILabel? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.wordCountLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.wordCountLabel) as? UILabel
        }
    }
    
    /// 默认文本
    fileprivate var placeholderLabel: UILabel? {
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.placeholderLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UITextView.RuntimeKey.placeholderLabel) as? UILabel
        }
    }
    
    /// 占位符
    /// - Parameter placeholder: 占位符
    fileprivate func initPlaceholder(_ placeholder: String) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(textChange(_:)), name: UITextView.textDidChangeNotification, object: self)
        self.placeholderLabel = UILabel()
        placeholderLabel?.font = self.placeholdFont
        placeholderLabel?.text = placeholder
        placeholderLabel?.numberOfLines = 0
        placeholderLabel?.lineBreakMode = .byWordWrapping
        placeholderLabel?.textColor = self.placeholdColor
        let rect = placeholder.boundingRect(with: CGSize(width: self.jk.width - placeholderOrigin!.x * 2, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : self.placeholdFont!], context: nil)
        placeholderLabel?.frame = CGRect(x: placeholderOrigin!.x, y: placeholderOrigin!.y, width: self.jk.width - placeholderOrigin!.x * 2, height: rect.size.height)
        addSubview(self.placeholderLabel!)
        oldFrame = self.frame
        placeholderLabel?.isHidden = self.text.count > 0 ? true : false
    }
    
    ///  字数限制
    /// - Parameter limitLength:  字数限制
    fileprivate func initWordCountLabel(_ limitLength : NSNumber) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(limitLengthEvent), name: UITextView.textDidChangeNotification, object: self)
        if wordCountLabel != nil {
            wordCountLabel?.removeFromSuperview()
        }
        wordCountLabel = UILabel(frame: CGRect(x: 0, y: self.frame.size.height - 20, width: self.frame.size.width - 10, height: 20))
        wordCountLabel?.textAlignment = .right
        wordCountLabel?.textColor = self.textColor
        wordCountLabel?.font = self.font
        if self.text.count > limitLength.intValue {
            self.text = (self.text as NSString).substring(to: limitLength.intValue)
        }
        wordCountLabel?.text = "\(self.text.count)/\(limitLength)"
        addSubview(wordCountLabel!)
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    /// 动态监听
    /// - Parameter notification: 动态监听
    @objc fileprivate func textChange(_ notification : Notification) {
        let textView = notification.object as! UITextView;
        self.text = textView.text;
        if placeholder != nil {
            placeholderLabel?.isHidden = true
            if self.text.count ==  0 {
                self.placeholderLabel?.isHidden = false
            }
        }
        if limitLength != nil {
            var wordCount = self.text.count
            if wordCount > (limitLength?.intValue)! {
                wordCount = (limitLength?.intValue)!
            }
            let limit = limitLength!.stringValue
            wordCountLabel?.text = "\(wordCount)/\(limit)"
        }
        if autoHeight == true {
            let size = getStringPlaceSize(self.text, textFont: self.font!)
            UIView.animate(withDuration: 0.15) { [weak self] in
                guard let weakSelf = self else { return }
                JKPrint("autoHeight的CGPoint=========\(weakSelf.placeholderOrigin!)")
                weakSelf.frame = CGRect(x: weakSelf.jk.x, y: weakSelf.jk.y, width: weakSelf.jk.width, height: size.height + weakSelf.placeholderOrigin!.y * 2 < weakSelf.oldFrame!.height ? weakSelf.oldFrame!.height : size.height + weakSelf.placeholderOrigin!.y * 2)
            }
        }
    }
    
    @objc fileprivate func limitLengthEvent() {
        if limitLength != nil {
            if self.text.count > (limitLength?.intValue)! && limitLength != nil {
                self.text = (self.text as NSString).substring(to: (limitLength?.intValue)!)
                JKPrint("Maximum number of words");
            }
        } else {
            //行数限制
            if (limitLines != nil) {
                var size = getStringPlaceSize(self.text, textFont: self.font!)
                let height = self.font!.lineHeight * CGFloat(limitLines!.floatValue)
                if (size.height > height) {
                    JKPrint("Maximum number of lines");
                    //循环计算当前高度可以存放的字符
                    while size.height > height {
                        self.text = (self.text as NSString).substring(to: self.text.count - 1)
                        size = getStringPlaceSize(self.text, textFont: self.font!)
                    }
                }
            }
        }
    }
    
    @objc fileprivate func getStringPlaceSize(_ string : String, textFont : UIFont) -> CGSize {
        ///计算文本高度
        let font : UIFont = textFont
        let attribute = [NSAttributedString.Key.font : font];
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let size = string.boundingRect(with: CGSize(width: self.contentSize.width-10, height: CGFloat.greatestFiniteMagnitude), options: options, attributes: attribute, context: nil).size
        return size
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:))
            || action == #selector(UIResponderStandardEditActions.select(_:))
            || action == #selector(UIResponderStandardEditActions.selectAll(_:))
            || action == #selector(UIResponderStandardEditActions.copy(_:))
            || action == #selector(UIResponderStandardEditActions.cut(_:))
            || action == #selector(UIResponderStandardEditActions.delete(_:))
        {
            OperationQueue.main.addOperation {
                UIMenuController.shared.setMenuVisible(false, animated: false)
            }
            self.selectedRange = NSRange.init(location: 0, length: 0)
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
