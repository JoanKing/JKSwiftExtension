//
//  UIImageView+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/16.
//

import UIKit
// MARK: - 一、加载 gif
public extension JKPOP where Base: UIImageView {
    
    // MARK: 1.1、加载本地的gif图片
    /// 加载本地的gif图片
    /// - Parameter name: 图片的名字
    func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.jk.gif(name: name)
            DispatchQueue.main.async {
                self.base.image = image
            }
        }
    }
    
    // MARK: 1.2、加载 asset 里面的图片
    /// 加载 asset 里面的图片
    /// - Parameter asset: asset 里面的图片名字
    @available(iOS 9.0, *)
    func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.jk.gif(asset: asset)
            DispatchQueue.main.async {
                self.base.image = image
            }
        }
    }
    
    // MARK: 1.3、加载网络 url 的 gif 图片
    /// 加载网络 url 的 gif 图片
    /// - Parameter url: gif图片的网络地址
    @available(iOS 9.0, *)
    func loadGif(url: String) {
        DispatchQueue.global().async {
            let image = UIImage.jk.gif(url: url)
            DispatchQueue.main.async {
                self.base.image = image
            }
        }
    }
}

