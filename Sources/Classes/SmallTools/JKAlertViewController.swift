//
//  JKAlertViewController.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2023/5/25.
//

import UIKit

//MARK: - JKAlertActionStyle(弹框按钮样式)
@objc public enum JKAlertActionStyle : Int {
    
    case `default` = 0
    
    case cancel = 1
    
    case destructive = 2
    
    case suggestsive = 3
    
    case red = 4
    
    case blue = 5
    
    case gray = 6
    
    case niucancel = 7
}

//MARK: - JKAlertAction
public class JKAlertAction: NSObject {
    /// 事件名字
    @objc var title: String?
    /// 样式
    var style: JKAlertActionStyle?
    /// 点击回调
    @objc var handler: ((JKAlertAction) -> Void)?
    /// 是否可点击
    var isEnabled: Bool = true
    
    /// 初始化事件
    /// - Parameters:
    ///   - title: 事件名字
    ///   - style: 样式
    ///   - handler: 事件回调
    public init(title: String?, style: JKAlertActionStyle, handler: ((JKAlertAction) -> Void)? = nil){
        self.title = title
        self.style = style
        self.handler = handler
        super.init()
    }
}

//MARK: - JKAlertViewController
public class JKAlertViewController: UIViewController {
    //MARK: 弹出方式
    /// 弹出方式
    public enum Style : Int {
        /// 中间弹出
        case alert = 0
        /// 底部弹出
        case actionSheet = 1
    }
    
    /// 空白视图
    @objc public var backgroundTouchIsEnabled: Bool = true {
        didSet{
            self.backgroundMaskView.isEnabled = backgroundTouchIsEnabled
        }
    }
    
    //MARK: 描述基本文本初始化
    /// 描述基本文本初始化
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - message:  弹框描述信息
    ///   - preferredStyle: 样式
    ///   - textAlignment: 文本对齐方式
    ///   - backgroundDismissHandler: backgroundDismissHandler description
    public init(title: String = "", message: String = "", preferredStyle: JKAlertViewController.Style = .alert,textAlignment:NSTextAlignment = .center, backgroundDismissHandler: (() -> Void)? = nil) {
        
        self.preferredStyle = preferredStyle
        self.backgroundDismissHandler = backgroundDismissHandler
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        
        // 标题的样式
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.maximumLineHeight = 27
        titleParagraphStyle.minimumLineHeight = 27
        titleParagraphStyle.alignment = textAlignment
        let titleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: titleParagraphStyle]
        /// 描述的样式
        let descParagraphStyle = NSMutableParagraphStyle()
        descParagraphStyle.alignment = textAlignment
        descParagraphStyle.maximumLineHeight = 21
        descParagraphStyle.minimumLineHeight = 21
        let descAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.paragraphStyle: descParagraphStyle]
        
        if title.jk.isBlank || message.jk.isBlank {
            if title.count > 0 {
                let attributedText = NSMutableAttributedString(string: title, attributes: titleAttr)
                self.titleLab.textColor = UIColor.black
                self.titleLab.attributedText = attributedText
            } else if message.count > 0 {
                let attributedText = NSMutableAttributedString(string: message, attributes: descAttr)
                self.messageLab.textColor = UIColor.black
                self.messageLab.attributedText = attributedText
            } else {
                let attributedText = NSMutableAttributedString(string: "", attributes: descAttr)
                self.messageLab.textColor = UIColor.black
                self.messageLab.attributedText = attributedText
            }
        } else {
            let attributedText = NSMutableAttributedString(string: title, attributes: titleAttr)
            self.titleLab.textColor = UIColor.black
            self.titleLab.attributedText = attributedText
            
            let messageAttributedText = NSMutableAttributedString(string: message, attributes: descAttr)
            self.messageLab.textColor = UIColor.black
            self.messageLab.attributedText = messageAttributedText
        }
    }
    
    //MARK: 富文本描述基本文本初始化
    /// 富文本描述基本文本初始化
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - attributedMessage: 富文本描描述信息
    ///   - preferredStyle: 样式
    ///   - backgroundDismissHandler: backgroundDismissHandler description
    public init(title: String, attributedMessage: NSMutableAttributedString, preferredStyle: JKAlertViewController.Style = .alert, backgroundDismissHandler: (() -> Void)? = nil) {
        
        self.preferredStyle = preferredStyle
        self.backgroundDismissHandler = backgroundDismissHandler
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        
        do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = 27
            paragraphStyle.minimumLineHeight = 27
            paragraphStyle.alignment = .center
            
            let attr = [NSAttributedString.Key.font: UIFont.jk.textSB(18),
                        NSAttributedString.Key.paragraphStyle: paragraphStyle]
            let attributedText = NSMutableAttributedString(string: title, attributes: attr)
            self.titleLab.textColor = UIColor.black
            self.titleLab.attributedText = attributedText
        }
        
        do {
            self.messageLab.textColor = UIColor.black
            self.messageLab.attributedText = attributedMessage
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加事件
    /// - Parameter action: 事件
    @objc public func addAction(_ action: JKAlertAction){
        actions.append(action)
        updateActionBtnLayout()
    }
    /// 标题
    lazy var titleLab : UILabel = {
        let lab = UILabel(frame: CGRect.zero)
        lab.numberOfLines = 2
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    /// 描述
    lazy var messageLab : UILabel = {
        let lab = UILabel(frame: CGRect.zero)
        lab.numberOfLines = 0
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    /// 事件数组
    var actions: [JKAlertAction] = []
    /// 弹出方式
    var preferredStyle: JKAlertViewController.Style
    /// 视图消失
    var backgroundDismissHandler: (() -> Void)?
    /// 弹框试图
    lazy var contentView: UIView = {
        let contentView = UIView(frame: CGRect.zero)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    /// 弹框整体背景
    lazy var backgroundMaskView : UIControl = {
        let btn = UIControl(frame: CGRect.zero)
        btn.backgroundColor = UIColor(white: 0, alpha: 0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(closeBtnDidClicked), for: .touchUpInside)
        return btn
    }()
    /// 分割线
    lazy var separator: UIView = {
        let separator = UIView(frame: CGRect.zero)
        separator.backgroundColor = UIColor.hexStringColor(hexString: "#c8c8c8")
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    /// 按钮试图容器，如：确定/取消等等
    lazy var actionStackView : UIStackView = {
        let stackView = UIStackView(frame: CGRect.zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundMaskView)
        setupInterface()
    }
    
    func setupInterface() {
        do {
            contentView.addSubview(titleLab)
            contentView.addSubview(messageLab)
            contentView.addSubview(actionStackView)
            contentView.addSubview(separator)
            view.addSubview(contentView)
        }
        do {
            backgroundMaskView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundMaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundMaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundMaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        do {
            titleLab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
            titleLab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
            titleLab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
            
            let hasNoTitle = (titleLab.text ?? "").jk.isBlank
            
            messageLab.topAnchor.constraint(equalTo: titleLab.bottomAnchor, constant: hasNoTitle ? 5: 10).isActive = true
            messageLab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22.5).isActive = true
            messageLab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22.5).isActive = true
            
            actionStackView.topAnchor.constraint(equalTo: messageLab.bottomAnchor, constant: hasNoTitle ? 25: 27.5).isActive = true
            actionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            actionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            actionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            
            separator.bottomAnchor.constraint(equalTo: actionStackView.topAnchor, constant:0).isActive = true
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            
            contentView.widthAnchor.constraint(equalToConstant: 295).isActive = true
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    //MARK: 按钮的设置
    /// 按钮的设置
    /// - Parameter action: 事件
    /// - Returns: description
    func btnWitAction(action: JKAlertAction) -> UIView {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = 25.5
        paragraphStyle.minimumLineHeight = 25.5
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        var attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium),
                    NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        var darkAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium),
                        NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        let btn = UIControl(frame: CGRect.zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        switch action.style {
        case .destructive:
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .semibold)
            attr[NSAttributedString.Key.foregroundColor] =  UIColor.red
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] =  UIColor.red
        case .blue:
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .medium)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.init(red: 0.26, green: 0.42, blue: 0.95, alpha: 1.0)
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor.init(red: 0.26, green: 0.42, blue: 0.95, alpha: 1.0)
        case .gray:
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .regular)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.gray
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor.gray
        case .suggestsive:
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .semibold)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.hexStringColor(hexString: "#426BF2")
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor.hexStringColor(hexString: "#426BF2")
        case .niucancel:
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .regular)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.black
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor(white: 1, alpha: 0.8)
        default:
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .medium)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.black
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor(white: 1, alpha: 0.8)
        }
        attr[NSAttributedString.Key.baselineOffset] =  NSNumber(1)
        darkAttr[NSAttributedString.Key.baselineOffset] = NSNumber(1)
        let attributedText = NSMutableAttributedString(string: action.title ?? "", attributes: attr)
        let darkAttributedText = NSMutableAttributedString(string: action.title ?? "", attributes: darkAttr)
        
        let lab = UILabel(frame: CGRect.zero)
        lab.numberOfLines = 2
        lab.attributedText = attributedText
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addSubview(lab)
        
        lab.heightAnchor.constraint(equalToConstant: 26).isActive = true
        lab.topAnchor.constraint(equalTo: btn.topAnchor, constant: 10).isActive = true
        lab.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 8).isActive = true
        lab.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: -10).isActive = true
        lab.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -8).isActive = true
        
        btn.isEnabled = action.isEnabled
        btn.addTarget(self, action: #selector(actionBtnDidClicked), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }
    
    func updateActionBtnLayout() {
        for btn in actionStackView.arrangedSubviews {
            actionStackView.removeArrangedSubview(btn)
            btn.removeFromSuperview()
        }
        let btnCount = actions.count
        if btnCount > 2 {
            actionStackView.distribution = .fill
            actionStackView.axis = .vertical
            for idx in 0..<btnCount {
                let btn = btnWitAction(action: actions[idx])
                btn.tag = idx + 2000
                actionStackView.addArrangedSubview(btn)
                if idx != 0 {
                    let separator = UIView(frame: CGRect.zero)
                    separator.backgroundColor = UIColor.hexStringColor(hexString: "#c8c8c8")
                    separator.translatesAutoresizingMaskIntoConstraints = false
                    btn.addSubview(separator)
                    do {
                        separator.topAnchor.constraint(equalTo: btn.topAnchor).isActive = true
                        separator.centerXAnchor.constraint(equalTo: btn.leadingAnchor).isActive = true
                        separator.trailingAnchor.constraint(equalTo: btn.trailingAnchor).isActive = true
                        separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
                    }
                }
            }
        } else {
            actionStackView.distribution = .fillEqually
            actionStackView.axis = .horizontal
            for idx in 0..<btnCount {
                let btn = btnWitAction(action: actions[idx])
                btn.tag = idx + 2000
                actionStackView.addArrangedSubview(btn)
                if idx != 0 {
                    let separator = UIView(frame: CGRect.zero)
                    separator.backgroundColor = UIColor.hexStringColor(hexString: "#c8c8c8")
                    separator.translatesAutoresizingMaskIntoConstraints = false
                    btn.addSubview(separator)
                    do {
                        separator.topAnchor.constraint(equalTo: btn.topAnchor).isActive = true
                        separator.centerXAnchor.constraint(equalTo: btn.leadingAnchor).isActive = true
                        separator.bottomAnchor.constraint(equalTo: btn.bottomAnchor).isActive = true
                        separator.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
                    }
                }
            }
        }
    }
}

//MARK: - 事件
extension JKAlertViewController {
    
    //MARK: 按钮的点击事件
    /// 按钮的点击事件
    /// - Parameter btn: btn description
    @objc func actionBtnDidClicked(btn: UIControl) {
        let idx = btn.tag - 2000
        let action = actions[idx]
        dismiss(animated: true) {
            if let handler = action.handler {
                handler(action)
            }
        }
    }
    
    //MARK: 点击空白处消失
    /// 点击空白处消失
    /// - Parameter btn: btn description
    @objc func closeBtnDidClicked(btn: UIControl) {
        dismiss(animated: true) {
            if let backHandler = self.backgroundDismissHandler {
                backHandler()
                return
            }
            for action in self.actions {
                if action.style == .cancel || action.style == .niucancel {
                    if let handler = action.handler {
                        handler(action)
                    }
                    break
                }
            }
        }
    }
}

/*
public class JKVerAlertViewController: JKAlertViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupInterface() {
        separator.isHidden = true
        
        view.addSubview(backgroundMaskView)
        
        do {
            contentView.addSubview(titleLab)
            contentView.addSubview(messageLab)
            contentView.addSubview(actionStackView)
            view.addSubview(contentView)
        }
        
        do {
            backgroundMaskView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundMaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundMaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundMaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        do {
            
            let hasNoTitle = (titleLab.text ?? "").jk.isBlank
            
            titleLab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
            titleLab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            titleLab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            
            messageLab.topAnchor.constraint(equalTo: titleLab.bottomAnchor, constant: hasNoTitle ? 5: 10).isActive = true
            messageLab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22.5).isActive = true
            messageLab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22.5).isActive = true
            
            actionStackView.topAnchor.constraint(equalTo: messageLab.bottomAnchor, constant: 27.5).isActive = true
            actionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            actionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            actionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
            
            contentView.widthAnchor.constraint(equalToConstant: 295).isActive = true
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
    }
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layoutIfNeeded()
        for (idx, action) in actions.enumerated() {
            if action.style == .suggestsive {
                let container = actionStackView.arrangedSubviews[idx]
                let btn = container.subviews.first
                btn?.layer.cornerRadius = (btn?.jk.height ?? 0) * 0.5
                btn?.layer.masksToBounds = true
                
            }
        }
    }
    
    override func actionBtnDidClicked(btn: UIControl) {
        
        let idx = btn.superview!.tag - 2000
        let action = actions[idx]
        
        dismiss(animated: true) {
            
            if let handler = action.handler {
                handler(action)
            }
        }
    }
    
    override func btnWitAction(action: JKAlertAction) -> UIView {
        
        let container = UIView(frame: CGRect.zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = 25.5
        paragraphStyle.minimumLineHeight = 25.5
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        var attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                    NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        var darkAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                        NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        let btn = UIControl(frame: CGRect.zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        switch action.style {
        case .destructive: do {
            attr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.hexStringColor(hexString: "#FC2A30")
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor(white: 1, alpha: 0.8)
            
        }
            break
        case .blue: do {
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .semibold)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.init(red: 0.26, green: 0.42, blue: 0.95, alpha: 1.0)
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor.init(red: 0.26, green: 0.42, blue: 0.95, alpha: 1.0)
        }
            break
        case .suggestsive: do {
            attr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.white
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor.white
        }
            break
        case .gray: do {
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .regular)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.gray
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor.gray
        }
        case .niucancel: do {
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: .regular)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.black
            
            darkAttr[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 17)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor(white: 1, alpha: 0.8)
        }
            break
        default: do {
            
            paragraphStyle.maximumLineHeight = 22.5
            paragraphStyle.minimumLineHeight = 22.5
            
            attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 15)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.gray
            
            darkAttr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 15)
            darkAttr[NSAttributedString.Key.foregroundColor] = UIColor.gray
        }
        }
        
        let attributedText = NSMutableAttributedString(string: action.title ?? "", attributes: attr)
        let darkAttributedText = NSMutableAttributedString(string: action.title ?? "", attributes: darkAttr)
        
        let lab = UILabel(frame: CGRect.zero)
        lab.numberOfLines = 2
        lab.attributedText = attributedText
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addSubview(lab)
        lab.topAnchor.constraint(equalTo: btn.topAnchor, constant: 10).isActive = true
        lab.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 32).isActive = true
        lab.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: -10).isActive = true
        lab.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -32).isActive = true
        
        
        btn.isEnabled = action.isEnabled
        btn.addTarget(self, action: #selector(actionBtnDidClicked(btn:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(btn)
        btn.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        btn.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        btn.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        btn.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor, constant: 16).isActive = true
        btn.widthAnchor.constraint(greaterThanOrEqualToConstant: 175).isActive = true
        return container
    }
    
    override func updateActionBtnLayout() -> Void {
        for btn in actionStackView.arrangedSubviews {
            actionStackView.removeArrangedSubview(btn)
            btn.removeFromSuperview()
        }
        
        let btnCount = actions.count
        
        if btnCount > 1 {
            
            actionStackView.distribution = .fill
            actionStackView.axis = .vertical
            actionStackView.spacing = 5
            for idx in 0..<btnCount {
                
                let btn = btnWitAction(action: actions[idx])
                btn.tag = idx + 2000
                actionStackView.addArrangedSubview(btn)
            }
        } else {
            actionStackView.distribution = .fillEqually
            actionStackView.axis = .horizontal
            
            for idx in 0..<btnCount {
                
                let btn = btnWitAction(action: actions[idx])
                btn.tag = idx + 2000
                actionStackView.addArrangedSubview(btn)
            }
            
        }
    }
}
*/
