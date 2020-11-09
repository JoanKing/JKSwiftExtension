//
//  UISwitchExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UISwitchExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["开关切换"]]
    }
}

// MARK:- 一、一、基本的扩展
extension UISwitchExtensionViewController {
    
    // MARK: 1.1、开关切换
    @objc func test11() {
        let sh = UISwitch(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        sh.backgroundColor = .brown
        sh.addTo(self.view)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            sh.toggle()
            JKAsyncs.asyncDelay(5, {
            }) {
                sh.removeFromSuperview()
            }
        }
        
    }
    
}
