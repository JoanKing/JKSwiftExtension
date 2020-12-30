//
//  BundleExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class BundleExtensionViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、Bundle 的基本扩展"]
        dataArray = [["从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）", "从其他的 Bundle 通过 bundlename 获取 bundle"]]
    }
}

// MARK:- 一、Bundle 的基本扩展
extension BundleExtensionViewController {
    
    // MARK: 1.1、从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）
    @objc func test11() {
        // 当前 moudle 下的 bundle 图片
        let imagePath1 = Bundle.jk.getBundlePathResource(bundName: "JKBaseKit", resourceName: "icon_scan@2x.png", bundleType: .currentBundle)
        // 其他 moudle 下的 bundle 图片
        let imagePath2 = Bundle.jk.getBundlePathResource(bundName: "MJRefresh", resourceName: "trail_arrow", bundleType: .otherBundle)
       
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        imageView1.jk.centerX = self.view.jk.centerX
        imageView1.backgroundColor = .red
        imageView1.image = UIImage(named: imagePath1)

        var imageView2 = UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        imageView2.jk.centerX = self.view.jk.centerX
        imageView2.backgroundColor = .red
        imageView2.image = UIImage(named: imagePath2)
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、从其他的 Bundle 通过 bundlename 获取 bundle
    @objc func test12() {
        
        // 当前 moudle 下的 bundle 图片
        let imagePath1 = Bundle.jk.getBundleResource(bundName: "JKBaseKit", resourceName: "icon_scan@2x", ofType: "png", bundleType: .currentBundle)
        // 其他 moudle 下的 bundle 图片
        let imagePath2 = Bundle.jk.getBundleResource(bundName: "MJRefresh", resourceName: "trail_arrow@2x", ofType: "png", bundleType: .otherBundle)
        
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        imageView1.jk.centerX = self.view.jk.centerX
        imageView1.backgroundColor = .red
        imageView1.image = UIImage(named: imagePath1 ?? "")

        var imageView2 = UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        imageView2.jk.centerX = self.view.jk.centerX
        imageView2.backgroundColor = .red
        imageView2.image = UIImage(named: imagePath2 ?? "")
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
}
