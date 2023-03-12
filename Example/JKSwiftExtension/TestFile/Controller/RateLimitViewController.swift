//
//  RateLimitViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/3/9.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension
class RateLimitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        view.addSubview(sliderDashLineView)
        view.addSubview(sliderDashLineView2)
        
        /*
        let value1: Int = 10
        let value2: Int = 210
        let value3: Int = 1
        print(String(format: "%05d", value1), String(format: "%05d", value2), String(format: "%05d", value3))
        debugPrint("时间戳：\(Date().timeIntervalSince1970)")
        */
        let numberData = 0b1
        let value = numberData & 0b111
        if value == 0b100 {
            debugPrint("repeatedLearningCard")
        } else if value == 0b10 {
            debugPrint("nfcOpening")
        } else if value == 0b1 {
            debugPrint("cardConfigurationMode")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sliderDashLineView.setValue(value: 0.8)
    }
    
    lazy var sliderDashLineView: SliderDashLineView = {
        let view = SliderDashLineView(frame: CGRect(x: 20, y: 150, width: jk_kScreenW - 40, height: 100))
        // view.backgroundColor = .brown
        view.sliderClosure = {[weak self] value in
            guard let weakSelf = self else {
                return
            }
            weakSelf.sliderDashLineView2.setValue(value: value)
        }
        return view
    }()
    
    lazy var sliderDashLineView2: SliderDashLineView = {
        var style = SliderDashLineViewSryle()
        style.isEnabled = false
        let view = SliderDashLineView(frame: CGRect(x: 20, y: 350, width: jk_kScreenW - 40, height: 100), style: style)
        // view.backgroundColor = .brown
        return view
    }()
}
