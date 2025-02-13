//
//  UISliderExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/1/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class UISliderExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["UISlider的 闭包事件"]]
    }
}

// MARK: - 一、基本的扩展
extension UISliderExtensionViewController {
    
    // MARK: 1.01、UISlider的 闭包事件
    @objc func test101() {
        let slider = UISlider(frame: CGRect(x: 50, y: 100, width: 150, height: 50))
        slider.backgroundColor = .randomColor
        slider.maximumValue = 10
        slider.minimumValue = 0
        slider.value = 0.2
        slider.jk.setHandle { (value) in
            guard let weakvalue = value else {
                return
            }
            debugPrint("\(weakvalue)")
        }
        self.view.addSubview(slider)
        
        JKAsyncs.asyncDelay(20) {
        } _: {
            slider.removeFromSuperview()
        }
    }
}
