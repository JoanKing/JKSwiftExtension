//
//  JKCircleProgressViewViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/12/8.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
class JKCircleProgressViewViewController: UIViewController {
    
    /// 进度条
    lazy var progressView: JKCircleProgressView = {
        let circleProgressView = JKCircleProgressView()
        return circleProgressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        view.addSubview(progressView)
    
        progressView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        JKAsyncs.asyncDelay(0) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.progressView.setProgress(25, animated: true)
            JKAsyncs.asyncDelay(1) {
            } _: {
                weakSelf.progressView.setProgress(50, animated: true)
            }
        }
    }
}
