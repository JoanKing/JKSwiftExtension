//
//  JKPlaceHolderTextViewViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2022/1/21.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension

class JKPlaceHolderTextViewViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的使用"]
        dataArray = [["UITextView 设置PlaceHolder"]]
    }
}

// MARK: - 一、基本的使用
extension JKPlaceHolderTextViewViewController {
    
    // MARK: 1.01、UITextView 设置PlaceHolder
    @objc func test101() {
    
        let textView = JKPlaceHolderTextView()
        textView.backgroundColor = UIColor.brown
        textView.placeHolder = "这是placeHolder0123456789-9876543210-123456789"
        textView.placeHolderColor = UIColor.green
        textView.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(200)
            make.centerY.equalToSuperview()
        }
        
        JKAsyncs.asyncDelay(10) {
        } _: {
            textView.text = "这是placeHolder0123456789-9876543210-123456789----"
            JKAsyncs.asyncDelay(3) {
            } _: {
                textView.removeFromSuperview()
            }
        }
    }
}
