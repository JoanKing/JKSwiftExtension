//
//  JKTextViewAutoLimiterViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2026/9/12.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit

/// UITextView (PasteAwareTextView) 专用测试页面
class JKTextViewAutoLimiterViewController: UIViewController {
    
    // MARK: - UI 控件
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    private let contentView = UIView()
    
    // 用例 1：多行文本 - 限制 30 字符 + 允许中英文/数字/换行/常用标点 + 超长截断
    private let case1Label: UILabel = {
        let label = UILabel()
        label.text = "用例 1: 限30字 / 允许换行与标点 / 超长截断"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let case1TextView: JKPasteAwareTextView = {
        let tv = JKPasteAwareTextView()
        tv.font = .systemFont(ofSize: 15)
        tv.layer.borderColor = UIColor.separator.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 8
        return tv
    }()
    
    // 用例 2：严格模式 - 限制 15 字符 + 超长直接禁止输入 (isInterceptString: false)
    private let case2Label: UILabel = {
        let label = UILabel()
        label.text = "用例 2: 限15字 / 超长不截断直接拒输 (isInterceptString=false)"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let case2TextView: JKPasteAwareTextView = {
        let tv = JKPasteAwareTextView()
        tv.font = .systemFont(ofSize: 15)
        tv.layer.borderColor = UIColor.separator.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 8
        return tv
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
    }
    
    // MARK: - 规则绑定
    
    private func setupLimiters() {
        // 用例 1 配置：多行常规输入，保留换行
        case1TextView.limitInput(
            maxCharacters: 10,
            lengthType: .customCountOfChars,
            regex: JKRegexCharacterType.type10.rawValue,   // 中文、英文、数字但不包括下划线等符号 ^[\u4E00-\u9FA5A-Za-z0-9]+$ 或 ^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$
            isInterceptString: true,
            isRemovePasteboardNewlineCharacters: true,       // 多行文本框保留粘贴换行
            isMarkedTextRangeCanInput: false
        )
        
        // 用例 2 配置：超长完全拒绝输入，不进行截取
        case2TextView.limitInput(
            maxCharacters: 15,
            lengthType: .count,
            regex: nil,
            isInterceptString: false,                         // 达到上限后禁止再输入或粘贴
            isRemovePasteboardNewlineCharacters: false,
            isMarkedTextRangeCanInput: false
        )
    }
    
    // MARK: - UI 布局 (SnapKit)
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "TextView 限制测试"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(case1Label)
        contentView.addSubview(case1TextView)
        contentView.addSubview(case2Label)
        contentView.addSubview(case2TextView)
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
        
        case1TextView.snp.makeConstraints { make in
            make.top.equalTo(case1Label.snp.bottom).offset(8)
            make.leading.trailing.equalTo(case1Label)
            make.height.equalTo(110)
        }
        
        case2Label.snp.makeConstraints { make in
            make.top.equalTo(case1TextView.snp.bottom).offset(24)
            make.leading.trailing.equalTo(case1Label)
        }
        
        case2TextView.snp.makeConstraints { make in
            make.top.equalTo(case2Label.snp.bottom).offset(8)
            make.leading.trailing.equalTo(case1Label)
            make.height.equalTo(110)
        }
        
        actionStackView.snp.makeConstraints { make in
            make.top.equalTo(case2TextView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(case1Label)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        setupActions()
    }
    
    // MARK: - 快捷测试按钮
    
    private func setupActions() {
        // 模拟 1：复制大段文字，用于测试粘贴截取与光标定位
        let copyParagraphBtn = createActionButton(title: "1. 复制一段长文本到剪贴板") { [weak self] in
            UIPasteboard.general.string = "Swift 是一门强大且直观的编程语言，专为 iOS、iPadOS、macOS、tvOS 和 watchOS 的开发而设计。"
            self?.showAlert(message: "已写入长文本到剪贴板，请在输入框内长按粘贴，测试多行输入下的安全截断与光标自动滚动聚焦。")
        }
        
        // 模拟 2：预置多行文本并将光标放在换行处中间
        let middleCursorBtn = createActionButton(title: "2. 预设文本并把光标放在两段文字中间") { [weak self] in
            guard let self = self else { return }
            self.case1TextView.text = "第一行内容AAA\n第二行内容BBB"
            // 定位在第一行末尾换行符前 (下标 9)
            if let targetPos = self.case1TextView.position(from: self.case1TextView.beginningOfDocument, offset: 9) {
                self.case1TextView.selectedTextRange = self.case1TextView.textRange(from: targetPos, to: targetPos)
            }
            self.case1TextView.becomeFirstResponder()
        }
        
        // 模拟 3：清空输入框
        let clearBtn = createActionButton(title: "3. 清空所有多行输入框") { [weak self] in
            self?.case1TextView.text = ""
            self?.case2TextView.text = ""
            self?.view.endEditing(true)
        }
        
        actionStackView.addArrangedSubview(copyParagraphBtn)
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
