//
//  JKCircleProgressViewViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/12/8.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import JKSwiftExtension

class JKCircleProgressViewViewController: UIViewController {
    
    /// 进度条
    lazy var progressView: JKCircleProgressView = {
        let circleProgressView = JKCircleProgressView()
        circleProgressView.lineWidth = 10
        // circleProgressView.backgroundColor = .red
        /// 进度槽颜色
        circleProgressView.progressColor = UIColor.hexStringColor(hexString: "#2BDA62")
        /// 进度条颜色
        circleProgressView.trackColor = UIColor.hexStringColor(hexString: "#E6EAEF")
        return circleProgressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        view.addSubview(progressView)
    
        progressView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSizeMake(100, 100))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        JKAsyncs.asyncDelay(0) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.progressView.setProgress(25, animated: true)
            JKAsyncs.asyncDelay(1) {
            } _: {
                weakSelf.progressView.setProgress(65, animated: false)
                JKAsyncs.asyncDelay(1) {
                } _: {
                    weakSelf.progressView.setProgress(10, animated: true)
                    JKAsyncs.asyncDelay(1) {
                    } _: {
                        weakSelf.progressView.setProgress(90, animated: false)
                    }
                }
            }
        }
    }
}
