//
//  DateFormatterExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/4.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class DateFormatterExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展"]
        dataArray = [["格式化快捷方式"]]
    }

}

// MARK: - 一、基本的扩展
extension DateFormatterExtensionViewController {
    
    // MARK: 1.01、格式化快捷方式
    @objc func test101() {
        let dateFormatter = DateFormatter(format: "EEEE")
        JKPrint("格式化快捷方式", "\(dateFormatter)")
    }
}
