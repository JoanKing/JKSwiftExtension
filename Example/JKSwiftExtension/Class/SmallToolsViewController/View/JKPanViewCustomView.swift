//
//  JKPanViewCustomView.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/12/6.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class JKPanViewCustomView: JKPanView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(testView1)
        self.addSubview(testView2)
        
        testView1.snp.makeConstraints { make in
            make.top.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(30)
        }
        
        testView2.snp.makeConstraints { make in
            make.bottom.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var testView1 = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    lazy var testView2 = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

}
