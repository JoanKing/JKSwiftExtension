//
//  UITableViewCellExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UITableViewCellExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["返回cell所在的UITableView"]]
    }
}

// MARK:- 一、基本的扩展
extension UITableViewCellExtensionViewController {
    
    // MARK: 1.1、返回cell所在的UITableView
    @objc func test11() {
        
    }
}
