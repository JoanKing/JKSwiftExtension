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
        
        headDataArray = ["一、基本的扩展 (使用runtime添加属性)", "二、文本链接的扩展"]
        dataArray = [["增加占位符", "默认文本字体的大小", "默认文本的颜色", "设置 默认文本的Origin"], ["添加链接文本（链接为空时则表示普通文本）", "转换特殊符号标签字段"]]
    }
    
    deinit {
        JKPrint("销毁了----------------")
    }
}

// MARK: - 二、文本链接的扩展
extension UITextViewExtensionViewController: UITextViewDelegate {
    
    // MARK: 2.2、转换特殊符号标签字段
    @objc func test22() {
        let textView = UITextView(frame: CGRect(x: 16, y: 100, width: kScreenW - 32, height: 200))
        textView.backgroundColor = .brown
        //设置展示文本框的代理
        textView.delegate = self
        let font = UIFont.systemFont(ofSize: 15)
        textView.font = font
        textView.text = ""
        // 自动识别链接
        textView.dataDetectorTypes = .link
        // 链接的字体颜色
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.yellow]
        textView.isEditable = false
        self.view.addSubview(textView)
        
        // 设置展示文本框的内容
        textView.text = "@小度，测试啦啦#你是谁#，我是百度https://www.baidu.com"
        // 对内容中的特殊标签字段做处理
        textView.jk.resolveHashTags()
        
        
        JKAsyncs.asyncDelay(10, {
        }) {
            textView.removeFromSuperview()
        }
    }
    
    // MARK: 2.1、添加链接文本（链接为空时则表示普通文本）
    @objc func test21() {
        let textView = UITextView(frame: CGRect(x: 16, y: 100, width: kScreenW - 32, height: 200))
        textView.backgroundColor = .brown
        //设置展示文本框的代理
        textView.delegate = self
        let font = UIFont.systemFont(ofSize: 15)
        textView.font = font
        textView.text = ""
        textView.isEditable = false
        textView.jk.appendLinkString(string: "欢迎使用JKSwiftExtension!\n", font: font)
        textView.jk.appendLinkString(string: "(1）", font: font)
        textView.jk.appendLinkString(string: "查看详细说明", font: font, withURLString: "about://www.baidu.com")
        textView.jk.appendLinkString(string: "\n(2）", font: font)
        textView.jk.appendLinkString(string: "问题反馈", font: font, withURLString: "feedback://www.baidu.com")
        self.view.addSubview(textView)
        
        JKAsyncs.asyncDelay(30, {
        }) {
            textView.removeFromSuperview()
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
    
    // 链接点击响应方法
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL,
                  in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if let scheme = URL.scheme {
            switch scheme {
            case "about" :
                showAlert(tagType: "about", payload: (URL as NSURL).resourceSpecifier!.removingPercentEncoding!)
            case "feedback" :
                showAlert(tagType: "feedback", payload: (URL as NSURL).resourceSpecifier!.removingPercentEncoding!)
            case "test1" :
                showAlert(tagType: "test1", payload: (URL as NSURL).resourceSpecifier!.removingPercentEncoding!)
            case "test2" :
                showAlert(tagType: "test2", payload: (URL as NSURL).resourceSpecifier!.removingPercentEncoding!)
            default:
                print("这个是普通的url")
            }
        }
        return true
    }
    
    // 显示消息
    func showAlert(tagType: String, payload: String){
        let alertController = UIAlertController(title: "检测到\(tagType)标签", message: payload, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}



// MARK: - 一、基本的扩展
extension UITextViewExtensionViewController {
    
    // MARK: 1.4、设置默认文本的 CGPoint
    @objc func test14() {
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
    
    // MARK: 1.3、默认文本的颜色
    @objc func test13() {
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
    
    // MARK: 1.2、默认文本字体的大小
    @objc func test12() {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.placeholder = "默认文本字体的大小：16默认文本字体的大小：16"
        textView.placeholdFont = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textView)
        textView.placeholdColor = .yellow
        JKPrint("默认文本字体的大小")
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
