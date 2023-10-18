//
//  NibLoadableViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NibLoadableViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、继承于UIView的才可以使用该协议的扩展"]
        dataArray = [["加载xib视图"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、继承于UIView的才可以使用该协议的扩展
extension NibLoadableViewController {
    
    // MARK: 1.01、加载xib视图
    @objc func test101() {
        var testView = TestView.loadFromNib().frame(CGRect(x: 0, y: 100, width: 100, height: 100))
        testView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(testView)
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            testView.removeFromSuperview()
        }
    }
    
}

