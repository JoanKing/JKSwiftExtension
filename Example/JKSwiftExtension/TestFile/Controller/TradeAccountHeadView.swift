//
//  TradeAccountHeadView.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/2/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

// MARK:- 交易首页的header
class TradeAccountHeadView: UIView {
    
    lazy var accountCardView: UIView = {
        let view = UIView()
        // headView.jk.gradientColor(.horizontal, [ UIColor.hexStringColor(hexString: "#492E9C").cgColor, UIColor.hexStringColor(hexString: "#6B51FC").cgColor], nil)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        commonUI()
        updateTheme()
    }
    
    /// 创建控件
    private func initUI() {
        self.addSubview(accountCardView)
    }
    
    /// 添加控件和设置约束
    private func commonUI() {
        
    }
    
    /// 更新控件的颜色，字体，背景色等等
    private func updateTheme() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
