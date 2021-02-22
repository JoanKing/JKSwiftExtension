//
//  TestFileViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import EventKit

class TestFileViewController: UIViewController {
    
    lazy var textFiled: UITextField = {
        let filed = UITextField(frame: CGRect(x: 20, y: 100, width: kScreenW - 40, height: 50))
        filed.backgroundColor = .randomColor
        filed.font = UIFont.systemFont(ofSize: 16)
        filed.placeholder = "请输入文字"
        filed.adjustsFontSizeToFitWidth = true  //当文字超出文本框宽度时，自动调整文字大小
        filed.minimumFontSize = 12  //最小可缩小的字号
        filed.returnKeyType = .go
        filed.delegate = self
        return filed
    }()
    
    lazy var showLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: textFiled.jk.bottom + 30, width: kScreenW - 40, height: 200))
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var textview: UITextView = {
        let textview = UITextView(frame:CGRect(x: 10, y: 100, width: 200, height: 100))
        textview.layer.borderWidth = 1  //边框粗细
        textview.layer.borderColor = UIColor.gray.cgColor //边框颜色
        textview.placeholder = "你是谁呀"
        return textview
    }()
    
    lazy var appleImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        imageView.image = UIImage(named: "good5")
        return imageView
    }()
    
    var dynamicAnimator = UIDynamicAnimator()
    var snap: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestFile"
        self.view.backgroundColor = .white
        
        self.view.addSubview(appleImageView)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        //附加识别器到视图
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func tapped(tap: UITapGestureRecognizer) {

        //获取点击位置
        let point = tap.location(in: self.view)
        
        // 删除之前的吸附,添加一个新的
        if self.snap != nil {
            self.dynamicAnimator.removeBehavior(self.snap!)
        }
        self.snap = UISnapBehavior(item: self.appleImageView, snapTo: point)
        self.dynamicAnimator.addBehavior(self.snap!)

    }
    
    @objc func onMail(){
        print("mail")
    }
    
    @objc func onWeiXin(){
        print("weixin")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(QRTestViewController(), animated: true)
    }
    
}

extension TestFileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        textField.resignFirstResponder()
        // 打印出文本框中的值
        print("输出：\(textField.text ?? "")")
        return true
    }
}
