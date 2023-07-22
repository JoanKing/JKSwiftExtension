//
//  JKAlertViewController.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2023/5/25.
//

import UIKit

/// 弹框的样式
@objc public enum JKAlertStyle: Int {
    /// 系统样式
    case system = 0
    /// 卡片样式
    case card = 1
}

//MARK: - JKAlertActionStyle(弹框按钮样式)
@objc public enum JKAlertActionStyle : Int {
    /// 默认样式
    case `default` = 0
    /// 取消
    case cancel = 1
    /// 警告(红色字体)
    case destructive = 2
    /// 性暗示的(蓝色)
    case suggestsive = 3
    /// 红色
    case red = 4
    /// 蓝色
    case blue = 5
    /// 灰色
    case gray = 6
}

//MARK: - JKAlertAction
public class JKAlertAction: NSObject {
    /// 事件名字
    @objc fileprivate var title: String?
    /// 样式
    fileprivate var style: JKAlertActionStyle?
    /// 点击回调
    @objc var handler: ((JKAlertAction) -> Void)?
    /// 是否可点击
    @objc public var isEnabled: Bool = true
    
    /// 初始化事件
    /// - Parameters:
    ///   - title: 事件名字
    ///   - style: 样式
    ///   - handler: 事件回调
    @objc public convenience init(title: String?, style: JKAlertActionStyle, handler: ((JKAlertAction) -> Void)? = nil) {
        self.init(title: title, alertActionStyle: style, handler: handler)
    }
    
    private init(title: String?, alertActionStyle: JKAlertActionStyle, handler: ((JKAlertAction) -> Void)? = nil) {
        self.title = title
        self.style = alertActionStyle
        self.handler = handler
        super.init()
    }
}

//MARK: - JKAlertViewController
public class JKAlertViewController: UIViewController {
    /// 弹框的样式
    fileprivate var alertStyle: JKAlertStyle = .card
    //MARK: 排列方式
    /// 排列方式
    @objc public enum ArrangementDirectionStyle: Int {
        /// 水平(超过两个垂直排列)
        case horizontal = 0
        /// 垂直
        case vertical = 1
    }
    
    /// 空白视图
    @objc public var backgroundTouchIsEnabled: Bool = true {
        didSet {
            self.backgroundMaskView.isEnabled = backgroundTouchIsEnabled
        }
    }
    /// 添加事件
    /// - Parameter action: 事件
    @objc public func addAction(_ action: JKAlertAction) {
        actions.append(action)
        updateActionBtnLayout()
    }
    
    //MARK: 描述基本文本初始化
    /// 描述基本文本初始化
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - message: 弹框描述信息
    ///   - arrangementDirectionStyle: 排列样式
    ///   - textAlignment: 文本对齐方式
    ///   - alertStyle: 弹框样式
    ///   - backgroundDismissHandler: backgroundDismissHandler description
    @objc public convenience init(title: String = "", message: String = "", arrangementDirectionStyle: JKAlertViewController.ArrangementDirectionStyle = .horizontal, textAlignment: NSTextAlignment = .center, alertStyle: JKAlertStyle = .card, backgroundDismissHandler: (() -> Void)? = nil) {
        self.init(titleString: title, message: message, arrangementDirectionStyle: arrangementDirectionStyle, textAlignment: textAlignment, alertStyle: alertStyle, backgroundDismissHandler: backgroundDismissHandler)
    }
    
    //MARK: 富文本描述基本文本初始化
    /// 富文本描述基本文本初始化
    /// - Parameters:
    ///   - titleString: 弹框标题
    ///   - attributedMessage: 富文本描描述信息
    ///   - arrangementDirectionStyle: 排列样式
    ///   - alertStyle: 弹框样式
    ///   - backgroundDismissHandler: backgroundDismissHandler description
    @objc public convenience init(title: String = "", attributedMessage: NSMutableAttributedString, arrangementDirectionStyle: JKAlertViewController.ArrangementDirectionStyle = .horizontal, alertStyle: JKAlertStyle = .card, backgroundDismissHandler: (() -> Void)? = nil) {
        self.init(titleString:title, attributedMessage: attributedMessage, arrangementDirectionStyle: arrangementDirectionStyle, alertStyle: alertStyle, backgroundDismissHandler: backgroundDismissHandler)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 标题
    fileprivate lazy var titleLab: UILabel = {
        let lab = UILabel(frame: CGRect.zero)
        lab.numberOfLines = 2
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    /// 描述
    fileprivate lazy var messageLab: UILabel = {
        let lab = UILabel(frame: CGRect.zero)
        lab.numberOfLines = 0
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    /// 事件数组
    fileprivate var actions: [JKAlertAction] = []
    /// 弹出方式
    fileprivate var arrangementDirectionStyle: JKAlertViewController.ArrangementDirectionStyle
    /// 视图消失
    fileprivate var backgroundDismissHandler: (() -> Void)?
    /// 弹框试图
    fileprivate lazy var contentView: UIView = {
        let contentView = UIView(frame: CGRect.zero)
        contentView.backgroundColor = UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#F2F4F7"), darkColor: UIColor.hexStringColor(hexString: "#222222"))
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    /// 弹框整体背景
    fileprivate lazy var backgroundMaskView : UIControl = {
        let btn = UIControl(frame: CGRect.zero)
        btn.backgroundColor = UIColor(white: 0, alpha: 0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(closeBtnDidClicked), for: .touchUpInside)
        return btn
    }()
    /// 分割线
    fileprivate lazy var separator: UIView = {
        let separator = UIView(frame: CGRect.zero)
        separator.backgroundColor = UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#C8C8C8"), darkColor: UIColor(white: 0, alpha: 0.2))
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    /// 按钮试图容器，如：确定/取消等等
    fileprivate lazy var actionStackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect.zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundMaskView)
        setupInterface()
    }
    
    /// 描述基本文本初始化
    /// - Parameters:
    ///   - titleString: 弹框标题
    ///   - message: 弹框描述信息
    ///   - arrangementDirectionStyle: 排列样式
    ///   - textAlignment: 文本对齐方式
    ///   - alertStyle: 弹框样式
    ///   - backgroundDismissHandler: backgroundDismissHandler description
    private init(titleString: String = "", message: String = "", arrangementDirectionStyle: JKAlertViewController.ArrangementDirectionStyle = .horizontal, textAlignment: NSTextAlignment = .center, alertStyle: JKAlertStyle = .card, backgroundDismissHandler: (() -> Void)? = nil) {
        self.alertStyle = alertStyle
        self.arrangementDirectionStyle = arrangementDirectionStyle
        self.backgroundDismissHandler = backgroundDismissHandler
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        
        // 标题的样式
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.maximumLineHeight = 27
        titleParagraphStyle.minimumLineHeight = 27
        titleParagraphStyle.alignment = textAlignment
        let titleAttr = [NSAttributedString.Key.font: UIFont.jk.textSB(20), NSAttributedString.Key.paragraphStyle: titleParagraphStyle, NSAttributedString.Key.foregroundColor: UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#2C2D2E"), darkColor: UIColor.hexStringColor(hexString: "#FFFFFF"))]
        /// 描述的样式
        let descParagraphStyle = NSMutableParagraphStyle()
        descParagraphStyle.alignment = textAlignment
        descParagraphStyle.maximumLineHeight = 21
        descParagraphStyle.minimumLineHeight = 21
        let descAttr = [NSAttributedString.Key.font: UIFont.jk.textR(14), NSAttributedString.Key.paragraphStyle: descParagraphStyle, NSAttributedString.Key.foregroundColor: UIColor.hexStringColor(hexString: "#7C828C")]
        if titleString.jk.isBlank || message.jk.isBlank {
            if titleString.count > 0 {
                let attributedText = NSMutableAttributedString(string: titleString, attributes: titleAttr)
                self.titleLab.attributedText = attributedText
            } else if message.count > 0 {
                let attributedText = NSMutableAttributedString(string: message, attributes: descAttr)
                self.messageLab.attributedText = attributedText
            } else {
                let attributedText = NSMutableAttributedString(string: "", attributes: descAttr)
                self.messageLab.attributedText = attributedText
            }
        } else {
            let attributedText = NSMutableAttributedString(string: titleString, attributes: titleAttr)
            self.titleLab.attributedText = attributedText
            let messageAttributedText = NSMutableAttributedString(string: message, attributes: descAttr)
            self.messageLab.attributedText = messageAttributedText
        }
    }
    
    /// 富文本描述基本文本初始化
    /// - Parameters:
    ///   - titleString: 弹框标题
    ///   - attributedMessage: 富文本描描述信息
    ///   - arrangementDirectionStyle: 排列样式
    ///   - alertStyle: 弹框样式
    ///   - backgroundDismissHandler: backgroundDismissHandler description
    private init(titleString: String = "", attributedMessage: NSMutableAttributedString, arrangementDirectionStyle: JKAlertViewController.ArrangementDirectionStyle = .horizontal, alertStyle: JKAlertStyle = .card, backgroundDismissHandler: (() -> Void)? = nil) {
        self.alertStyle = alertStyle
        self.arrangementDirectionStyle = arrangementDirectionStyle
        self.backgroundDismissHandler = backgroundDismissHandler
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        
        do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = 27
            paragraphStyle.minimumLineHeight = 27
            paragraphStyle.alignment = .center
            
            let attr = [NSAttributedString.Key.font: UIFont.jk.textSB(20),
                        NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#2C2D2E"), darkColor: UIColor.hexStringColor(hexString: "#FFFFFF"))]
            let attributedText = NSMutableAttributedString(string: titleString, attributes: attr)
            self.titleLab.attributedText = attributedText
        }
        do {
            self.messageLab.attributedText = attributedMessage
        }
    }
}

//MARK: - UI布局和添加
public extension JKAlertViewController {
    //MARK: 布局
    /// 布局
    func setupInterface() {
        do {
            contentView.addSubview(titleLab)
            contentView.addSubview(messageLab)
            contentView.addSubview(actionStackView)
            if alertStyle == .system {
                contentView.addSubview(separator)
            }
            view.addSubview(contentView)
        }
        do {
            backgroundMaskView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundMaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundMaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundMaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        do {
            titleLab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
            titleLab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            titleLab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            // 是否空标题
            let titleIsBlank = (titleLab.text ?? "").jk.isBlank
            // 是否空详细信息
            let messageIsBlank = (messageLab.text ?? "").jk.isBlank
            messageLab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            messageLab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            if titleIsBlank || messageIsBlank {
                if titleIsBlank && messageIsBlank {
                    messageLab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
                    // 标题和详情都是空
                    actionStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: alertStyle == .card ? 16 : 0).isActive = true
                } else {
                    if titleIsBlank {
                        messageLab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
                        // 标题和详细信息都有
                        actionStackView.topAnchor.constraint(equalTo: messageLab.bottomAnchor, constant: 16).isActive = true
                    } else {
                        // 标题和详细信息都有
                        actionStackView.topAnchor.constraint(equalTo: titleLab.bottomAnchor, constant: 16).isActive = true
                    }
                }
            } else {
                // 标题和详细信息都有
                messageLab.topAnchor.constraint(equalTo: titleLab.bottomAnchor, constant: 16).isActive = true
                actionStackView.topAnchor.constraint(equalTo: messageLab.bottomAnchor, constant: 16).isActive = true
            }
            actionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            actionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            actionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: alertStyle == .system ? 0 : -16).isActive = true
            if alertStyle == .system {
                separator.bottomAnchor.constraint(equalTo: actionStackView.topAnchor, constant:0).isActive = true
                separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
                separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
                separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            }
            contentView.widthAnchor.constraint(equalToConstant: 295).isActive = true
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    //MARK: 按钮的布局
    /// 按钮的布局
    @objc func updateActionBtnLayout() {
        for btn in actionStackView.arrangedSubviews {
            actionStackView.removeArrangedSubview(btn)
            btn.removeFromSuperview()
        }
        let btnCount = actions.count
        if btnCount != 2 || arrangementDirectionStyle == .vertical {
            actionStackView.distribution = .fill
            actionStackView.axis = .vertical
            for idx in 0..<btnCount {
                let btn = verticalBtnWitAction(action: actions[idx], index: idx)
                btn.tag = idx + 2000
                actionStackView.addArrangedSubview(btn)
                if alertStyle == .system, idx != 0 {
                    let separator = UIView(frame: CGRect.zero)
                    separator.backgroundColor = UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#C8C8C8"), darkColor: UIColor(white: 0, alpha: 0.2))
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
                let btn = horizontalBtnWitAction(action: actions[idx], index: idx)
                btn.tag = idx + 2000
                actionStackView.addArrangedSubview(btn)
                if alertStyle == .system, idx != 0 {
                    let separator = UIView(frame: CGRect.zero)
                    separator.backgroundColor = UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#C8C8C8"), darkColor: UIColor(white: 0, alpha: 0.2))
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
                if action.style == .cancel {
                    if let handler = action.handler {
                        handler(action)
                    }
                    break
                }
            }
        }
    }
}

//MARK: - 按钮的排列和属性设置
extension JKAlertViewController {
    //MARK: 水平排列
    /// 水平排列
    /// - Parameters:
    ///   - action: action description
    ///   - index: index description
    /// - Returns: description
    fileprivate func horizontalBtnWitAction(action: JKAlertAction, index: Int) -> UIView {
        
        let btn = UIControl(frame: CGRect.zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = getActionAttributedText(action: action)
        
        let lab = UILabel(frame: CGRect.zero)
        lab.numberOfLines = 2
        if alertStyle == .card {
            lab.backgroundColor = UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#FFFFFF"), darkColor: UIColor.hexStringColor(hexString: "#303133"))
            lab.layer.cornerRadius = 10
            lab.clipsToBounds = true
        }
        lab.attributedText = attributedText
        lab.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(lab)
        lab.heightAnchor.constraint(equalToConstant: 44).isActive = true
        lab.topAnchor.constraint(equalTo: btn.topAnchor, constant: 0).isActive = true
        lab.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: index == 0 ? 16 : 8).isActive = true
        lab.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: 0).isActive = true
        lab.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: index == 1 ? -16 : -8).isActive = true
        btn.isEnabled = action.isEnabled
        btn.addTarget(self, action: #selector(actionBtnDidClicked(btn:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    //MARK: 垂直排列
    /// 垂直排列
    /// - Parameters:
    ///   - action: action description
    ///   - index: index description
    /// - Returns: description
    fileprivate func verticalBtnWitAction(action: JKAlertAction, index: Int) -> UIView {
        
        let btn = UIControl(frame: CGRect.zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = getActionAttributedText(action: action)
        
        let lab = UILabel(frame: CGRect.zero)
        lab.numberOfLines = 2
        if alertStyle == .card {
            lab.backgroundColor = UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#FFFFFF"), darkColor: UIColor.hexStringColor(hexString: "#303133"))
            lab.layer.cornerRadius = 10
            lab.clipsToBounds = true
        }
        lab.attributedText = attributedText
        lab.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(lab)
        if alertStyle == .system {
            lab.heightAnchor.constraint(equalToConstant: 26).isActive = true
            lab.topAnchor.constraint(equalTo: btn.topAnchor, constant: 10).isActive = true
            lab.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 8).isActive = true
            lab.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: -10).isActive = true
            lab.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -8).isActive = true
        } else {
            lab.heightAnchor.constraint(equalToConstant: 44).isActive = true
            lab.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 16).isActive = true
            lab.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -16).isActive = true
            lab.topAnchor.constraint(equalTo: btn.topAnchor, constant: index == 0 ? 0 : 12).isActive = true
            lab.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: 0).isActive = true
        }
        btn.isEnabled = action.isEnabled
        btn.addTarget(self, action: #selector(actionBtnDidClicked(btn:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    //MARK: 获取按钮的AttributedText
    /// 获取按钮的AttributedText
    /// - Parameter action: action description
    /// - Returns: description
    fileprivate func getActionAttributedText(action: JKAlertAction) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = 25.5
        paragraphStyle.minimumLineHeight = 25.5
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        var attr = [NSAttributedString.Key.font: UIFont.jk.textR(16),
                    NSAttributedString.Key.paragraphStyle: paragraphStyle]
        switch action.style {
        case .destructive:
            attr[NSAttributedString.Key.font] = UIFont.jk.textSB(16)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.red
        case .blue:
            attr[NSAttributedString.Key.font] = UIFont.jk.textSB(16)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.init(red: 0.26, green: 0.42, blue: 0.95, alpha: 1.0)
        case .gray:
            attr[NSAttributedString.Key.font] = UIFont.jk.textR(16)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.gray
        case .suggestsive:
            attr[NSAttributedString.Key.font] = UIFont.jk.textSB(16)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.hexStringColor(hexString: "#426BF2")
        default:
            attr[NSAttributedString.Key.font] = UIFont.jk.textR(16)
            attr[NSAttributedString.Key.foregroundColor] = UIColor.darkModeColor(lightColor: UIColor.black, darkColor: UIColor(white: 1, alpha: 0.8))
        }
        attr[NSAttributedString.Key.baselineOffset] = NSNumber(1)
        let attributedText = NSMutableAttributedString(string: action.title ?? "", attributes: attr)
        return attributedText
    }
}

//MARK: - 垂直排列
public class JKVerAlertViewController: JKAlertViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func updateViewConstraints() {
        for btn in actionStackView.arrangedSubviews {
            actionStackView.removeArrangedSubview(btn)
            btn.removeFromSuperview()
        }
        let btnCount = actions.count
        actionStackView.distribution = .fill
        actionStackView.axis = .vertical
        for idx in 0..<btnCount {
            let btn = verticalBtnWitAction(action: actions[idx], index: idx)
            btn.tag = idx + 2000
            actionStackView.addArrangedSubview(btn)
            if alertStyle == .system, idx != 0 {
                let separator = UIView(frame: CGRect.zero)
                separator.backgroundColor = UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#C8C8C8"), darkColor: UIColor(white: 0, alpha: 0.2))
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
    }
}
