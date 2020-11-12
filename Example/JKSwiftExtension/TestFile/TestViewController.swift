//
//  TestViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    /// 消息的数量
    fileprivate var messageCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "JKSwiftExtension"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        let right1 = UIBarButtonItem(title: "old", style: .plain, target: self, action: #selector(click1))
        let right2 = UIBarButtonItem(title: "new", style: .plain, target: self, action: #selector(click2))
        self.navigationItem.rightBarButtonItems = [right1,right2]
        
        NotificationCenter.default.addObserver(self, selector: #selector(click2), name: NSNotification.Name.FBTradeHomeListDataNotification, object: nil)
    }
    
    @objc func clickk() {
        print("哈哈")
    }
    
    @objc func click1() {
      
    }
    
    @objc func click2() {
        
    }
    
}
