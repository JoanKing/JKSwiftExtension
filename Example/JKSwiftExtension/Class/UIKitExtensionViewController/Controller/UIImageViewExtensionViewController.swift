//
//  UIImageViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


class UIImageViewExtensionViewController: BaseViewController {
    var gifImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、加载 gif"]
        dataArray = [["加载本地的gif图片", "加载 asset 里面的图片", "加载网络 url 的 gif 图片"]]
    }
}

// MARK:- 一、加载 gif
extension UIImageViewExtensionViewController {
    
    // MARK: 1.3、加载网络 url 的 gif 图片
    @objc func test13() {
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        gifImageView.loadGif(url: "http://pic19.nipic.com/20120222/8072717_124734762000_2.gif")
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、加载 asset 里面的图片
    @objc func test12() {
        guard let image = UIImage.jk.gif(asset: "pika3") else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: image.size.width, height: image.size.height))
        gifImageView.loadGif(asset: "pika3")
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.1、加载本地的gif图片
    @objc func test11() {
      
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        gifImageView.loadGif(name: "pika2")
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
}

