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
        var models: [SoundModel] = []
        
        let model1 = SoundModel()
        model1.name = "我是1"
        model1.sound_weight = 1
        models.append(model1)
        
        let model2 = SoundModel()
        model2.name = "我是4"
        model2.sound_weight = 4
        models.append(model2)
        
        let model3 = SoundModel()
        model3.name = "我是3"
        model3.sound_weight = 3
        models.append(model3)
        
        let model4 = SoundModel()
        model4.name = "我是9"
        model4.sound_weight = 9
        models.append(model4)
        
        let model5 = SoundModel()
        model5.name = "我是7"
        model5.sound_weight = 7
        models.append(model5)
        
        let models2 = models.sorted { item1, item2 in
            return item1.sound_weight < item2.sound_weight
        }
        for item in models2 {
            debugPrint("改值前顺序：\(item.name)")
        }
        
        for (index, item) in models2.enumerated() {
            item.sound_weight = index + 1
        }
        
        for item in models2 {
            debugPrint("改值后顺序：\(item.name) index：\(item.sound_weight)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // sliderDashLineView.setValue(value: 0.8)
        
        let progress = progressValue(ratio: 50, low_base: 25)
        debugPrint("进度条的值：\(progress)")
        
        let value = speedRatioValue(progress: 0.6, low_base: 25)
        debugPrint("上传的值：\(value)")
    }
    
    //MARK: 根据百分比获取进度条的值
    /// 根据百分比获取进度条的值
    /// - Parameters:
    ///   - ratio: 百分比
    ///   - low_base: 低档位的百分比
    func progressValue(ratio: Int, low_base: Int) -> Float {
        return Float(ratio - low_base) / Float(100 - low_base)
    }

    //MARK: 根据进度条的值，获取百分比的值(给蓝牙和后端上传使用)
    /// 根据进度条的值，获取百分比的值(给蓝牙和后端上传使用)
    /// - Parameters:
    ///   - progress: 进度条值
    ///   - low_base: 低档位的百分比
    func speedRatioValue(progress: Float, low_base: Int) -> Int {
        return Int(progress * Float((100 - low_base))) + low_base
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
