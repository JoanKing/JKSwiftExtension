//
//  CAGradientLayerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/2/1.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class CAGradientLayerExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的颜色扩展"]
        dataArray = [["背景的渐变设置"]]
    }
}

// MARK:- 一、基本的颜色扩展
extension CAGradientLayerExtensionViewController {
    
    // MARK: 1.1、背景的渐变设置
    @objc func test11() {
        // 获取彩虹渐变层
        let gradientLayer = CAGradientLayer().jk.gradientLayer(.horizontal, [UIColor.red.cgColor, UIColor.green.cgColor], nil)
        
        let button = UIButton(frame: CGRect(x: 30, y: 150, width: kScreenW - 60, height: 50))
        self.view.addSubview(button)
        
        // 设置其CAGradientLayer对象的frame，并插入button的layer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: button.jk.width, height: button.jk.height)
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        JKAsyncs.asyncDelay(2) {
        } _: {
            button.removeFromSuperview()
        }
    }
}
