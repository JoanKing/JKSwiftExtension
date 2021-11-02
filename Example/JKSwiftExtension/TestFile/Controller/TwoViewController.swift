//
//  TwoViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    lazy var arrowLableTop: FBArrowLabel = {
        let label = FBArrowLabel()
        // 设置四个角的圆角值
        label.cornerRadius = 8
        // 设置箭头大小
        label.arrowSize = (6, 14)
        // 箭头起始的偏移值
        label.arrowOffset = 10
        // 箭头位置为在上面
        label.arrowPosition = .bottom
        
        // 设置需要阴影
        label.isNeedShadow = true
        // 设置文本的内边距
        label.textOffset = UIEdgeInsets(top: 8, left: 12, bottom: -8, right: -12)
        return label
    }()
    
    lazy var bgView: UIView = {
        let testView = UIView()
        testView.backgroundColor = .brown
        return testView
    }()
    
    lazy var bgView1: UILabel = {
        let testView = UILabel()
        testView.backgroundColor = .blue
        testView.textColor = .white
        testView.numberOfLines = 0
        return testView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Two"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.white
        
        arrowLableTop.backgroundColor = .green
        view.addSubview(bgView)
        view.addSubview(bgView1)
        view.addSubview(arrowLableTop)
        bgView.snp.makeConstraints {
            $0.left.equalTo(40)
            $0.width.equalTo(jk_kScreenW - 80)
            $0.height.equalTo(80)
            $0.centerY.equalToSuperview()
        }
        bgView1.snp.makeConstraints {
            $0.right.equalTo(-40)
            $0.width.equalTo(80)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        arrowLableTop.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.bottom.equalTo(-40)
            $0.width.equalTo(180)
            $0.height.equalTo(180)
        }
        
        arrowLableTop.setupText("网络支付反欺诈、套现安全风控措施加强，客户使用微信在线支付，受到不同程度的限制（金额限制或完全无法支付）")
        
        bgView1.text = "网络支付反欺诈、套现安全风控措施加强，客户使用微信在线支付，受到不同程度的限制"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}
