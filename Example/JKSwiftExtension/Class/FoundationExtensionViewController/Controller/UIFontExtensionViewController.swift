//
//  UIFontExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIFontExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、常用的基本字体扩展"]
        dataArray = [["6 号字体", "8 号字体", "hook字体", "测试"]]
    }
}

// MARK:- 一、常用的基本字体扩展
extension UIFontExtensionViewController {
    
    // MARK: 1.4、测试
    @objc func test14() -> String? {
        let array = ["1", "2", "3"]
        
        for item in array {
            print("打印：\(item)")
            if item == "2" {
                return item
            }
        }
        print("没有值------")
        return nil
    
    }
    
    // MARK: 1.3、hook
    @objc func test13() {
        
        JKRuntime.methods(from: UIViewController.self)
       
        JKRuntime.methods(from: UIFont.self)
        
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.systemFont(ofSize: 18)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
    }
    
    // MARK: 1.2、8 号字体
    @objc func test12() {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        label.textColor = .brown
        label.textAlignment = .left
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1) {
            label.font = UIFont.f8
            JKAsyncs.asyncDelay(1) {
                label.font = UIFont.f8Light
                JKAsyncs.asyncDelay(1) {
                    label.font = UIFont.f8Medium
                    JKAsyncs.asyncDelay(1, {
                        label.font = UIFont.f8Bold
                    }) {
                        label.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    // MARK: 1.1、6号字体
    @objc func test11() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.f6
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.f6Light
            JKAsyncs.asyncDelay(1, {
            }) {
                label.font = UIFont.f6
                JKAsyncs.asyncDelay(1, {
                }) {
                    label.font = UIFont.f6Medium
                    JKAsyncs.asyncDelay(1, {
                    }) {
                        label.font = UIFont.f6Bold
                        JKAsyncs.asyncDelay(1, {
                        }) {
                            label.removeFromSuperview()
                        }
                    }
                    
                }
            }
        }
    }
}
