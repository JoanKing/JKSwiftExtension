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
        
        headDataArray = ["一、Bundle 的基本扩展", "二、App的基本信息"]
        dataArray = [["从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）", "从其他的 Bundle 通过 bundlename 获取 bundle", "读取项目本地图片"], ["App命名空间", "项目/app 的名字", "获取app的版本号", "获取app的 Build ID", "获取app的 Bundle Identifier", "Info.plist", "App 名称"]]
    }
}

// MARK: - 二、App的基本信息
extension BundleExtensionViewController {
    
    // MARK: 2.07、App 名称
    @objc func test207() {
        let appDisplayName = Bundle.jk.appDisplayName
        JKPrint("App 名称：\(appDisplayName)")
    }
    
    //MARK: 2.06、Info.plist
    @objc func test206() {
        guard let infoDictionary = Bundle.jk.infoDictionary else {
            return
        }
        JKPrint("项目 Info.plist 打印" ,"\(infoDictionary)")
    }
    
    // MARK: 2.05、获取app的 Bundle Identifier
    @objc func test205() {
        JKPrint("获取app的 Bundle Identifier：\(Bundle.jk.appBundleIdentifier)")
    }
    
    // MARK: 2.04、获取app的 Build ID
    @objc func test204() {
        JKPrint("获取app的 Build ID：\(Bundle.jk.appBuild)")
    }
    
    // MARK: 2.03、获取app的版本号
    @objc func test203() {
        JKPrint("获取app的版本号：\(Bundle.jk.appVersion)")
    }
    
    // MARK: 2.02、项目/app 的名字
    @objc func test202() {
        JKPrint("项目/app 的名字：\(Bundle.jk.bundleName)")
    }
    
    // MARK: 2.01、App命名空间
    @objc func test201() {
        JKPrint("App命名空间：\(Bundle.jk.namespace)")
    }
}

// MARK: - 一、Bundle 的基本扩展
extension BundleExtensionViewController {
    
    // MARK: 1.03、读取项目本地图片
    @objc func test103() {
        let filePath = Bundle.main.path(forResource: "girl", ofType: "jpg")
    
        let image = UIImage(contentsOfFile: filePath ?? "")
        // girl.jpg
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: 300, width: 150, height: 300))
        imageView2.jk.centerX = self.view.jk.centerX
        imageView2.backgroundColor = .red
        imageView2.image = image
        self.view.addSubview(imageView2)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 1.02、从其他的 Bundle 通过 bundlename 获取 bundle
    @objc func test102() {
        
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
    
    // MARK: 1.01、从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）
    @objc func test101() {
        // 当前 moudle 下的 bundle 图片
        let imagePath1 = Bundle.jk.getBundlePathResource(bundName: "JKBaseKit", resourceName: "icon_scan", bundleType: .currentBundle)
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
}
