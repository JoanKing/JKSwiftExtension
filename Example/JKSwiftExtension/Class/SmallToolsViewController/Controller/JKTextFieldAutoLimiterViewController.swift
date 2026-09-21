//
//  JKTextFieldAutoLimiterViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2026/9/12.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit

/// UITextField (PasteAwareTextField) 专用测试页面
class JKTextFieldAutoLimiterViewController: UIViewController {
    
    // MARK: - UI 控件
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    private let contentView = UIView()
    
    // 用例 1：限制 10 字节 + 仅允许字母数字 + 粘贴清洗首尾换行与空格
    private let case1Label: UILabel = {
        let label = UILabel()
        label.text = "用例 1: 限10字节 / 仅英数 / 粘贴清首尾换行"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    lazy var case1TextField: JKPasteAwareTextField = {
        let tf = JKPasteAwareTextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "测试中间插入、粘贴清洗"
        tf.clearButtonMode = .whileEditing
        tf.font = .systemFont(ofSize: 15)
        tf.delegate = self
        tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return tf
    }()
    
    // 用例 2：不限长度 + 仅允许纯数字 (用于验证可选 maxCharacters = nil)
    private let case2Label: UILabel = {
        let label = UILabel()
        label.text = "用例 2: 不限长度 / 纯数字正则白名单"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let case2TextField: JKPasteAwareTextField = {
        let tf = JKPasteAwareTextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "只能输入数字，不限字数"
        tf.keyboardType = .asciiCapableNumberPad
        tf.clearButtonMode = .whileEditing
        tf.font = .systemFont(ofSize: 15)
        return tf
    }()
    
    private let actionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()

    // MARK: - 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLimiters()
        
        
        JKAsyncs.asyncDelayMain(5) {[weak self] in
            // 接口返回超长或带脏字符的内容：
            let remoteData = "哈哈ABC123456789DEF"

            // 会自动按照设定的 10 字节、清洗空格换行、正则过滤规则截取并展示
            self?.case1TextField.setLimitedText(remoteData)
        }
        
    }
    
    // MARK: - 规则绑定
    
    private func setupLimiters() {
        // 用例 1 配置
        case1TextField.limitInput(
            maxCharacters: 10,
            lengthType: .customCountOfChars,               // 按字节计算长度
            regex: JKRegexCharacterType.type10.rawValue,   // 中文、英文、数字但不包括下划线等符号 ^[\u4E00-\u9FA5A-Za-z0-9]+$ 或 ^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$
            isInterceptString: true,                       // 超出截断
            isRemovePasteboardNewlineCharacters: true,     // 粘贴清除首尾空格和换行
            isMarkedTextRangeCanInput: true, isCountMarkedTextInLimit: false, textDidChangeHandler: { textField, text in
                // 最终过滤、截取完成的文本，每次有效输入严格打印 1 次
                debugPrint("输入的文字--闭包：\(text)")
            }, exceedLimitHandler: { tf, maxLimit in
            debugPrint("输入的文字--闭包 TextField 超长通知：已达上限 \(maxLimit)")
        })
        
        // 用例 2 配置 (验证不传 maxCharacters)
        case2TextField.limitInput(
            maxCharacters: nil,
            regex: "^[0-9]*$"                          // 纯数字
        )
    }
    
    // MARK: - UI 布局 (SnapKit)
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "TextField 限制测试"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(case1Label)
        contentView.addSubview(case1TextField)
        contentView.addSubview(case2Label)
        contentView.addSubview(case2TextField)
        contentView.addSubview(actionStackView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        case1Label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        case1TextField.snp.makeConstraints { make in
            make.top.equalTo(case1Label.snp.bottom).offset(8)
            make.leading.trailing.equalTo(case1Label)
            make.height.equalTo(44)
        }
        
        case2Label.snp.makeConstraints { make in
            make.top.equalTo(case1TextField.snp.bottom).offset(24)
            make.leading.trailing.equalTo(case1Label)
        }
        
        case2TextField.snp.makeConstraints { make in
            make.top.equalTo(case2Label.snp.bottom).offset(8)
            make.leading.trailing.equalTo(case1Label)
            make.height.equalTo(44)
        }
        
        actionStackView.snp.makeConstraints { make in
            make.top.equalTo(case2TextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(case1Label)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        setupActions()
    }
    
    // MARK: - 快捷测试按钮
    
    private func setupActions() {
        // 模拟 1：向剪贴板写入带脏换行符的超长文本
        let copyBtn = createActionButton(title: "1. 复制带换行与空格的内容到剪贴板") { [weak self] in
            UIPasteboard.general.string = "\n\n  ABC123456789DEF\n  "
            self?.showAlert(message: "已写入剪贴板内容：【\\n\\n  ABC123456789DEF\\n  】\n请长按输入框1点击“粘贴”，测试换行清洗与长度截取。")
        }
        
        // 模拟 2：预置内容并将光标定位在中间，测试中间插入
        let middleCursorBtn = createActionButton(title: "2. 预设文本 ABCDEF 并将光标放在中间") { [weak self] in
            guard let self = self else { return }
            self.case1TextField.text = "ABCDEF"
            // 光标定位在 ABC 与 DEF 之间 (下标 3)
            if let targetPos = self.case1TextField.position(from: self.case1TextField.beginningOfDocument, offset: 3) {
                self.case1TextField.selectedTextRange = self.case1TextField.textRange(from: targetPos, to: targetPos)
            }
            self.case1TextField.becomeFirstResponder()
        }
        
        // 模拟 3：重置输入框
        let clearBtn = createActionButton(title: "3. 清空所有输入框") { [weak self] in
            self?.case1TextField.text = ""
            self?.case2TextField.text = ""
            self?.view.endEditing(true)
        }
        
        actionStackView.addArrangedSubview(copyBtn)
        actionStackView.addArrangedSubview(middleCursorBtn)
        actionStackView.addArrangedSubview(clearBtn)
    }
    
    private func createActionButton(title: String, action: @escaping () -> Void) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 8
        btn.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        if #available(iOS 14.0, *) {
            btn.addAction(UIAction(handler: { _ in action() }), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }
        return btn
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default))
        present(alert, animated: true)
    }
}

extension JKTextFieldAutoLimiterViewController: UITextFieldDelegate {
    
   
    @objc func textDidChange(textField: UITextField) {
        debugPrint("输入的文字：\(textField.text ?? "--")")
    }
    
}
