//
//  JKPaddingLabelViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/2/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class JKPaddingLabelViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的使用"]
        dataArray = [["设置有内边距的label"]]
    }
}

// MARK:- 一、基本的工具
extension JKPaddingLabelViewController {
    
    // MARK: 1.1、设置可点击的label
    @objc func test11() {
    
        let label = JKPaddingLabel()
        label.backgroundColor = UIColor.randomColor
        label.text = "我是有内边距的"
        label.paddingTop = 5
        label.paddingLeft = 5
        label.paddingBottom = 5
        label.paddingRight = 5
        self.view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.lessThanOrEqualTo(100)
        }
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            label.removeFromSuperview()
        }

    }
}
