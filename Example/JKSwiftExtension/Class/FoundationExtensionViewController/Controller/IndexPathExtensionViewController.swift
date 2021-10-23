//
//  IndexPathExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/31.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class IndexPathExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本扩展"]
        dataArray = [["{section, row}", "当前 NSIndexPath 的前一个 NSIndexPath", "当前 NSIndexPath 的后一个 NSIndexPath"]]
    }
}

// MARK: - 一、基本扩展
extension IndexPathExtensionViewController {
    
    // MARK: 1.3、当前 NSIndexPath 的后一个 NSIndexPath
    @objc func test13() {
        
    }
    
    // MARK: 1.2、当前 NSIndexPath 的前一个 NSIndexPath
    @objc func test12() {
        
    }
    
    // MARK: 1.1、{section, row}
    @objc func test11() {
        
    }
}

