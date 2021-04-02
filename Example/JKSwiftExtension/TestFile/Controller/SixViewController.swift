//
//  SixViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class SixViewController: UIViewController {

    var isHave: Bool = false
    
    /// cell上的标题
    var dataTitleArray: [[String]] =  [["当前行情权限"], ["帮助信息", "客服电话"]]
    /// 头部标题
    var sectionDataArray: [String] = ["我的行情", "我的客服"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Six"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
        
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.text = "我是一只小小鸟"
        self.view.addSubview(textView)
        
        textView.becomeFirstResponder()
        
    }
}
