//
//  JKPhotoAlbumUtilViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/3/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
class JKPhotoAlbumUtilViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的使用"]
        dataArray = [["将图片保存到指定相簿中", "如果参数 isCustomPhotoAlbumName 不指定，则默认保存到相机胶卷中去"]]
    }
}

// MARK: - 一、基本的工具
extension JKPhotoAlbumUtilViewController {

    // MARK: 1.02、如果参数 isCustomPhotoAlbumName 不指定，则默认保存到相机胶卷中去
    @objc func test102() {
    
        guard let image = UIImage(named: "tfboy") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            JKPhotoAlbumUtil.saveImageInAlbum(image: image) { (result) in
                JKAsyncs.asyncDelay(1) {
                } _: {
                    imageView.removeFromSuperview()
                }
                switch result{
                case .success:
                    print("保存成功")
                case .denied:
                    print("被拒绝")
                case .error:
                    print("保存错误")
                }
            }
        }

    }
    
    // MARK: 1.01、将图片保存到指定相簿中
    @objc func test101() {
    
        guard let image = UIImage(named: "testicon") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            JKPhotoAlbumUtil.saveImageInAlbum(image: image, isCustomPhotoAlbumName: true) { (result) in
                
                JKAsyncs.asyncDelay(1) {
                } _: {
                    imageView.removeFromSuperview()
                }
                switch result{
                case .success:
                    print("保存成功")
                case .denied:
                    print("被拒绝")
                case .error:
                    print("保存错误")
                }
            }
        }
    }
}
