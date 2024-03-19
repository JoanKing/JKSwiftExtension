//
//  JKScreenShieldViewViewController.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2024/3/19.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class JKScreenShieldViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(screenShieldView)
        screenShieldView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        screenShieldView.addSubview(testView1)
        testView1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    
    /// 防截屏录屏子视图
    lazy var testView1: UIView = {
        let testView = UIView()
        testView.backgroundColor = .yellow
        return testView
    }()
    
    /// 防止截屏，放在其上子视图都会被屏蔽截图
    lazy var screenShieldView: JKScreenShieldView = {
        let shieldView = JKScreenShieldView()
        shieldView.backgroundColor = .brown
        return shieldView
    }()
}
