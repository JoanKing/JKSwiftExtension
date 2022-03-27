//
//  UIVisualEffectViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/3/26.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class UIVisualEffectViewExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["创建一个UIVisualEffectView对象"]]
    }
}

// MARK: - 一、基本的扩展
extension UIVisualEffectViewExtensionViewController {
    
    // MARK: 1.1、创建一个UIVisualEffectView对象
    @objc func test11() {
        let visualEffectView = UIVisualEffectView.jk.visualEffectView(size: CGSize(width: 100, height: 100))
        let image = UIImage(named: "testicon")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.jk.centerX = self.view.jk.centerX
        imageView.addSubview(visualEffectView)
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3, {
        }) {
            imageView.removeFromSuperview()
        }
    }
}
