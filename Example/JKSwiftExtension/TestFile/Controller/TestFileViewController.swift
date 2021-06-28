//
//  TestFileViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TestFileViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestFile"
        self.view.backgroundColor = .white
        
        let uuid = UIDevice.current.identifierForVendor!.uuidString as NSString
        print("uuid：\(uuid)")
        
        headDataArray = ["一、基本的使用"]
        dataArray = [["设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label"]]
    }
}

extension TestFileViewController {
    
    @objc func test13() {
        self.navigationController?.pushViewController(SixViewController(), animated: true)
    }
    
    @objc func test12() {
        self.navigationController?.pushViewController(TenViewController(), animated: true)
    }
    
    @objc func test11() {
        self.navigationController?.pushViewController(FiveViewController(), animated: true)
    }
}


