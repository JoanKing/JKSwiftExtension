//
//  SliderDashLineView.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/3/9.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension

struct SliderDashLineViewSryle {
    var isEnabled: Bool = true
    /// 几段
    var section: Int = 4
    /// 虚线的宽度
    var dashLineWidth: CGFloat = 4
    /// 虚线的高度
    var dashLineHeight: CGFloat = 4
    /// 滑块左边的颜色
    var minimumTrackTintColor: UIColor = UIColor.hexStringColor(hexString: "#CFD7E2")
    /// 虚线的颜色
    var dashLineColor: UIColor = UIColor.hexStringColor(hexString: "#CFD7E2")
  
}

class SliderDashLineView: UIView {
    /// 样式
    private var style: SliderDashLineViewSryle
    /// 滑动的代理
    var sliderClosure: ((Float) -> Void)?
    init(frame: CGRect, style: SliderDashLineViewSryle = SliderDashLineViewSryle()) {
        self.style = style
        super.init(frame: frame)
        initUI()
        commonInit()
        changeTheme()
    }
    
    lazy var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = style.dashLineColor
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    lazy var rateLimitSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.addTarget(self, action: #selector(sliderChange(_:_:)), for: .valueChanged)
        return slider
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 基本的事件
extension SliderDashLineView {
    
    @objc func changeValue(sender: UISlider) {
        guard style.isEnabled else {
            // 禁用
            rateLimitSlider.value = 0
            return
        }
        debugPrint("进度：\(sender.value)")
        leftView.snp.updateConstraints { make in
            make.width.equalTo(self.frame.size.width * CGFloat(sender.value))
        }
        sliderClosure?(sender.value)
    }
            
    @objc func sliderChange(_ slider: UISlider, _ event: UIEvent) {
        let value = slider.value
        print(value)
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                print("开始拖动")
            case .moved:
                print("正在拖动")
            case .ended:
                print("结束拖动")
            default:
                break
            }
        }
    }
            
    func setValue(value: Float) {
        rateLimitSlider.setValue(value , animated: false)
        leftView.snp.updateConstraints { make in
            make.width.equalTo(self.frame.size.width * CGFloat(value))
        }
        sliderClosure?(value)
    }
}

extension SliderDashLineView {
    
    private func initUI() {
        addSubview(bgView)
        
        let itemW = self.frame.size.width / CGFloat(style.section)
        debugPrint("宽度：\(itemW)")
        for index in 0..<style.section {
            let imageView = UIImageView()
            bgView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                if index == 0 {
                    make.left.equalTo(0)
                    imageView.image = UIImage(named: "dashline_left_light")
                } else if index == style.section - 1 {
                    make.left.equalTo(itemW * CGFloat(index))
                    imageView.image = UIImage(named: "dashline_right_light")
                } else {
                    imageView.image = UIImage(named: "dashline_middle_light")
                    make.left.equalTo(itemW * CGFloat(index))
                }
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: itemW, height: 8))
            }
        }
        bgView.jk.addSubviews([leftView, rateLimitSlider])
    }
    
    private func commonInit() {
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        
        leftView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(0)
            make.height.equalTo(4)
        }
        rateLimitSlider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
    }
    
    private func changeTheme() {
        
    
    }

    func refreshUI() {
        rateLimitSlider.value = 0.6
    }
}

