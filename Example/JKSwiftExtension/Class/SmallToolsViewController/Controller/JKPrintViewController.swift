//
//  JKPrintViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKPrintViewController: BaseViewController, UIDocumentInteractionControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、打印的方式"]
        dataArray = [["打印单个内容", "打印多个内容"]]
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 一、打印的方式
extension JKPrintViewController {
    
    // MARK: 1.1、打印单个内容
    @objc func test11() {
        JKPrint("第 1 个内容")
    }
    
    // MARK: 1.2、打印多个内
    @objc func test12() {
        JKPrint("第 1 个内容", "第 2 个内容")
    }
    
    // MARK: 1.3、发送文件
    @objc func test13() {
        let cachePath = FileManager.CachesDirectory()
        let logURL = cachePath + "/log.txt"
        let documentController = UIDocumentInteractionController(url: URL(string: logURL)!)
        documentController.delegate = self
        documentController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
    }
}
