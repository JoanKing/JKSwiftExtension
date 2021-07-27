//
//  BaseNavigationViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏背景颜色
        navigationBar.barTintColor = UIColor.cBackViewColor
        let dict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        // 标题颜色
        navigationBar.titleTextAttributes = (dict as! [NSAttributedString.Key : Any])
        // item颜色
        navigationBar.tintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
