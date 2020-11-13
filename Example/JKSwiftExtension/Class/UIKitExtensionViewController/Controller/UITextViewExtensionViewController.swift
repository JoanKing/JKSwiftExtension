//
//  UITextViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UITextViewExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展 (使用runtime添加属性)"]
        dataArray = [["增加占位符", "限制的字数", "限制行数", "默认文本字体的大小", "默认文本的颜色", "设置 默认文本的Origin", "是否自动变化高度"]]
    }
    
    deinit {
        print("销毁了----------------")
    }
}

// MARK:- 一、基本的扩展
extension UITextViewExtensionViewController {
    
    // MARK: 1.7、是否自动变化高度
    @objc func test17() {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.placeholdFont = UIFont.systemFont(ofSize: 16)
        textView.placeholdColor = .green
        textView.placeholderOrigin = CGPoint(x: 1, y: 7)
        textView.autoHeight = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.placeholder = "设置默认文本的CGSize(width: 20, height: 20)"
        self.view.addSubview(textView)
        JKPrint("设置默认文本的CGSize(width: 20, height: 20)")
        JKAsyncs.asyncDelay(100, {
        }) {
            textView.removeFromSuperview()
        }
    }
    
    // MARK: 1.6、设置默认文本的 CGSize
    @objc func test16() {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.placeholdFont = UIFont.systemFont(ofSize: 16)
        textView.placeholdColor = .green
        textView.placeholderOrigin = CGPoint(x: 1, y: 7)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.placeholder = "设置默认文本的CGSize(width: 20, height: 20)"
        self.view.addSubview(textView)
        JKPrint("设置默认文本的CGSize(width: 20, height: 20)")
        JKAsyncs.asyncDelay(10, {
        }) {
            textView.removeFromSuperview()
        }
    }
    
    // MARK: 1.5、默认文本的颜色
    @objc func test15() {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.placeholder = "默认文本的颜色：green"
        textView.placeholdFont = UIFont.systemFont(ofSize: 16)
        textView.placeholdColor = .green
        textView.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textView)
        JKPrint("默认文本字体的大小")
        JKAsyncs.asyncDelay(8, {
        }) {
            textView.removeFromSuperview()
        }
    }
    
    // MARK: 1.4、默认文本字体的大小
    @objc func test14() {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.placeholder = "默认文本字体的大小：16"
        textView.placeholdFont = UIFont.systemFont(ofSize: 16)
        textView.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textView)
        textView.placeholdColor = .yellow
        JKPrint("默认文本字体的大小")
        JKAsyncs.asyncDelay(8, {
        }) {
            textView.removeFromSuperview()
        }
    }
    
    // MARK: 1.3、限制行数
    @objc func test13() {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.limitLines = 20
        textView.placeholder = "我限制行数：1"
        textView.limitLines = 1
        self.view.addSubview(textView)
        JKPrint("设置占位符")
        JKAsyncs.asyncDelay(8, {
        }) {
            textView.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、限制的字数
    @objc func test12() {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.placeholder = "限制的字数: 5"
        textView.limitLength = 5
        self.view.addSubview(textView)
        
        JKPrint("限制的字数: 5")
        
        JKAsyncs.asyncDelay(8, {
        }) {
            textView.removeFromSuperview()
        }
    }
    
    // MARK: 1.1、设置占位符
    @objc func test11() {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.placeholder = "我是占位符"
        self.view.addSubview(textView)
        JKPrint("设置占位符")
        JKAsyncs.asyncDelay(3, {
        }) {
            textView.removeFromSuperview()
        }
    }
}
