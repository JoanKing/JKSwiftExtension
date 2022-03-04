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
        let navbarTintColor = UIColor.cBackViewColor
        // iOS 15后，需要手动设置UINavigationBar的scrollEdgeAppearance和standardAppearance属性才行
        if #available(iOS 13, *) {
            // 处于顶部时的背景
            let scrollEdgeAppearance = UINavigationBarAppearance()
            scrollEdgeAppearance.backgroundColor = navbarTintColor
            navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
            /*
             navigationBar.scrollEdgeAppearance = {
                let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = .red
                return appearance
             }()
             */
            // 滑动后的背景
            let standardAppearance = UINavigationBarAppearance()
            standardAppearance.backgroundColor = navbarTintColor
            navigationBar.standardAppearance = standardAppearance 
            /*
             navigationBar.standardAppearance = {
                let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = .green
                return appearance
             }()
             */
            
            // 不设置任何属性则是默认的毛玻璃效果
        } else {
            navigationBar.barTintColor = navbarTintColor
        }
        let dict: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        // 标题颜色
        navigationBar.titleTextAttributes = dict
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
