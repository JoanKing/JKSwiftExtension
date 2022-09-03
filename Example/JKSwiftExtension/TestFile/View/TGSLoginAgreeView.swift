//
//  TGSLoginAgreeView.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/8/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

/// 同意协议view
///点击类型
enum ClickLinkType {
    ///用户协议
    case userProtocol
    ///隐私条款
    case privacyPolicy
}

class TGSLoginAgreeView: UIView, UITextViewDelegate {
    
    ///点击事件
    var clickHandle:((_ clickType:ClickLinkType)->())?
    
    ///同意View
    private lazy var agreeTextView : UITextView = {
        let textStr = "登录既代表您已同意《用户协议》和《隐私条款》"
        let textView = UITextView()
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textColor = UIColor.red
        textView.textAlignment = .center

        ///设为true 在代理里面禁掉所有的交互事件
        textView.isEditable = true
        
        textView.autoresizingMask =  UIView.AutoresizingMask.flexibleHeight
        textView.isScrollEnabled = false
        let attStr = NSMutableAttributedString(string: textStr)
        
        //点击超链接
        attStr.addAttribute(NSAttributedString.Key.link, value: "userProtocol://", range: (textStr as NSString).range(of: "《用户协议》"))
        //点击超链接
        attStr.addAttribute(NSAttributedString.Key.link, value: "privacyPolicy://", range: (textStr as NSString).range(of: "《隐私条款》"))

        textView.attributedText = attStr
        ///只能设置一种颜色
        textView.linkTextAttributes =  [
            NSAttributedString.Key.foregroundColor: UIColor.blue
        ]
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TGSLoginAgreeView{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme  ==  "userProtocol"{
            self.clickHandle?(.userProtocol)
            return false
        }else if URL.scheme == "privacyPolicy"{
            self.clickHandle?(.privacyPolicy)
            return false
        }
        return true
    }
}

extension TGSLoginAgreeView{
    private func configUI(){
        ///同意view
        self.addSubview(agreeTextView)
        agreeTextView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
