//
//  JKAlertViewControllerViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/5/25.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import JKSwiftExtension
//MARK: - 单位转换

class JKAlertViewControllerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、弹框"]
        dataArray = [["弹框1", "测试"]]
    }
}

//MARK: - 一、弹框
extension JKAlertViewControllerViewController {
    //MARK: 1.2、弹框
    @objc func test12() {
        
    }
    
    //MARK: 1.1、弹框
    @objc func test11() {
        let alert = JKAlertViewController(title: "哈哈", preferredStyle: .actionSheet)
        alert.backgroundTouchIsEnabled = true
        let cancelAction = JKAlertAction(title: "取消", style: .blue)
        let sureAction = JKAlertAction(title: "确定", style: .cancel) {[weak self] (action: JKAlertAction) in
            guard let self else {
                return
            }
            debugPrint("确定......")
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
