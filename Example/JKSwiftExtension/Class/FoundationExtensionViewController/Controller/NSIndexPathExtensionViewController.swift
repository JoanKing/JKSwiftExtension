//
//  NSIndexPathExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/31.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NSIndexPathExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本扩展"]
        dataArray = [["{section, row}", "当前 NSIndexPath 的前一个 NSIndexPath", "当前 NSIndexPath 的后一个 NSIndexPath"]]
    }
}

// MARK: - 一、基本扩展
extension NSIndexPathExtensionViewController {
   
    // MARK: 1.03、当前 NSIndexPath 的后一个 NSIndexPath
    @objc func test103() {
        
    }
    
    // MARK: 1.02、当前 NSIndexPath 的前一个 NSIndexPath
    @objc func test102() {
        
    }
    
    // MARK: 1.01、{section, row}
    @objc func test101() {
        
    }
}
