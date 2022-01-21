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
        
        headDataArray = ["一、基本的扩展 ", "二、文本链接的扩展"]
        dataArray = [["暂无"], ["添加链接文本（链接为空时则表示普通文本）", "转换特殊符号标签字段"]]
    }
    
    deinit {
        JKPrint("销毁了----------------")
    }
}

// MARK: - 二、文本链接的扩展
extension UITextViewExtensionViewController: UITextViewDelegate {
    
    // MARK: 2.2、转换特殊符号标签字段
    @objc func test22() {
        let textView = UITextView(frame: CGRect(x: 16, y: 100, width: jk_kScreenW - 32, height: 200))
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
        let textView = UITextView(frame: CGRect(x: 16, y: 100, width: jk_kScreenW - 32, height: 200))
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
    
    // MARK: 1.1、设置占位符
    @objc func test11() {
        
    }
}
