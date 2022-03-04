//
//  JKPrintViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class Point {
    var x = 11
    var test = true
    var y = 22
}

final class Ref<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}

class JKPrintViewController: BaseViewController, UIDocumentInteractionControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、打印的方式"]
        dataArray = [["打印单个内容", "打印多个内容", "变量的：地址、内存、大小 的打印", "对象的：地址、内存、大小 的打印", "测试"]]
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、打印的方式
extension JKPrintViewController {
    
    
    // MARK: 1.5、变量的：地址、内存、大小 的打印
    @objc func test15() {
        
        var name1 = "王三"
        var name2 = name1
        JKPrintPointer(ptr: &name1)
        JKPrintPointer(ptr: &name2)
        
        JKPrint(val: &name1)
        JKPrint(val: &name2)
        
        print("------------------")
        
        var x = [1, 2, 3]
        var y = x
        JKPrintPointer(ptr: &x)
        JKPrintPointer(ptr: &y)
        
        JKPrint(val: &x)
        JKPrint(val: &y)
    }
    
    // MARK: 1.4、对象的：地址、内存、大小 的打印
    @objc func test14() {
        let p = Point()
        JKPrint(ref: p)
        // -------------- Point --------------
        // 对象的地址: 0x000060000353d530
        // 对象的内存: 0x000000010d7e0e90 0x0000000200000003 0x000000000000000b 0x0080200c03000001 0x0000000000000016 0x0000000000000000
        // 对象的大小: 48
    }
    
    // MARK: 1.3、变量的：地址、内存、大小 的打印
    @objc func test13() {
        var p = Point()
        JKPrint(val: &p)
        // -------------- Point --------------
        // 变量的地址: 0x00007ffee2639468
        // 变量的内存: 0x000060000353d530
        // 变量的大小: 8
        var name1 = "王三"
        var name2 = name1
        JKPrint(val: &name1)
        JKPrint(val: &name2)
        name2 = "李四"
        JKPrint(val: &name1)
        JKPrint(val: &name2)
    }
    
    // MARK: 1.2、打印多个内
    @objc func test12() {
        JKPrint("第 1 个内容", "第 2 个内容")
    }
    
    // MARK: 1.1、打印单个内容
    @objc func test11() {
        JKPrint("第 1 个内容")
    }
}

extension JKPrintViewController {
    // MARK: 发送文件：废弃
    @objc func test() {
        let cachePath = FileManager.jk.CachesDirectory()
        let logURL = cachePath + "/log.txt"
        let documentController = UIDocumentInteractionController(url: URL(string: logURL)!)
        documentController.delegate = self
        documentController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
    }
}
