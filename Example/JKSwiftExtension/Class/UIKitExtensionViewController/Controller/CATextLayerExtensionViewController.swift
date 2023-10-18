//
//  CATextLayerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CATextLayerExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的链式编程"]
        dataArray = [["设置文字的内容", "设置 NSAttributedString 文字", "自动换行，默认NO", "当文本显示不全时的裁剪方式", "文本显示模式：左 中 右", "设置字体的颜色", "设置字体的颜色(十六进制)", "设置字体的大小", "设置字体的Font", "设置字体粗体"]]
    }
}

// MARK: - 一、基本的链式编程
extension CATextLayerExtensionViewController {
    
    // MARK: 1.10、设置字体粗体
    @objc func test110() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 50, y: 100, width: 300, height: 400)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.color("#FF00FF")
        textLayer.text("可能你在异乡")
        textLayer.boldFont(16)
        textLayer.alignment(.right)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.09、设置字体的Font
    @objc func test109() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 50, y: 100, width: 300, height: 400)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.color("#FF00FF")
        textLayer.text("可能你在异乡")
        textLayer.font(UIFont.systemFont(ofSize: 12))
        textLayer.alignment(.right)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.08、设置字体的大小
    @objc func test108() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 50, y: 100, width: 300, height: 400)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.color("#FF00FF")
        textLayer.text("可能你在异乡")
        textLayer.font(9)
        textLayer.alignment(.right)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.07、设置字体的颜色(十六进制)
    @objc func test107() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 50, y: 100, width: 300, height: 400)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.color("#FF00FF")
        textLayer.text("可能你在异乡")
        textLayer.isWrapped(true)
        textLayer.alignment(.right)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.06、设置字体的颜色
    @objc func test106() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 50, y: 100, width: 300, height: 400)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.color(.green)
        textLayer.text("可能你在异乡")
        textLayer.isWrapped(true)
        textLayer.alignment(.right)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.05、文本显示模式：左 中 右
    @objc func test105() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 50, y: 100, width: 300, height: 400)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.text("可能你在异乡")
        textLayer.isWrapped(true)
        textLayer.alignment(.right)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.04、当文本显示不全时的裁剪方式
    @objc func test104() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 100, y: 100, width: 200, height: 400)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.text("可能你在异乡，忍受着孤独寂寞，下雨没人送伞，开心没人分享…但你从未放弃努力，因为你相信：不怕抵达的日子遥遥无期，所有的隐忍和坚持，终将成就更优秀的你!")
        textLayer.isWrapped(true)
        textLayer.truncationMode(.end)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.03、自动换行，默认NO
    @objc func test103() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 100, y: 100, width: 200, height: 400)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.text("可能你在异乡，忍受着孤独寂寞，下雨没人送伞，开心没人分享…但你从未放弃努力，因为你相信：不怕抵达的日子遥遥无期，所有的隐忍和坚持，终将成就更优秀的你!")
        textLayer.isWrapped(true)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.02、设置 NSAttributedString 文字
    @objc func test102() {
        
        let attributedString = NSMutableAttributedString(string: "2秒后消失")
        attributedString.addAttributes([NSAttributedString.Key.backgroundColor : UIColor.red, NSAttributedString.Key.foregroundColor : UIColor.green, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22)], range: NSRange(location: 0, length: 3))
        
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.attributedText(attributedString)
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.01、设置文字的内容
    @objc func test101() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        textLayer.backgroundColor = UIColor.brown.cgColor
        textLayer.text("2秒后消失")
        self.view.layer.addSublayer(textLayer)
        JKAsyncs.asyncDelay(2, {
        }) {
            textLayer.removeFromSuperlayer()
        }
    }
}

