//
//  FileManagerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FileManagerExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、沙盒路径的获取"]
        dataArray = [["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"]]
    }

}

// MARK:- 一、沙盒路径的获取
extension FileManagerExtensionViewController {
    
    // MARK: 1.1、获取Home的完整路径名
    @objc func test11() {
        JKPrint("获取 Home 的完整路径名:\(FileManager.homeDirectory())")
    }
    
    // MARK: 1.2、获取Documnets的完整路径名
    @objc func test12() {
        JKPrint("获取 Documnets 的完整路径名:\(FileManager.DocumnetsDirectory())")
    }
    
    // MARK: 1.3、"获取Library的完整路径名"
    @objc func test13() {
        JKPrint("获取 Library 的完整路径名:\(FileManager.LibraryDirectory())")
    }
    
    // MARK: 1.4、获取/Library/Cache的完整路径名
    @objc func test14() {
        JKPrint("获取 /Library/Cache 的完整路径名:\(FileManager.CachesDirectory())")
    }
    
    // MARK: 1.5、获取/Library/Preferences的完整路径名
    @objc func test15() {
        JKPrint("获取 /Library/Preferences 的完整路径名:\(FileManager.PreferencesDirectory())")
    }
    
    // MARK: 1.6、"获取Tmp的完整路径名"
    @objc func test16() {
        JKPrint("获取 Tmp 的完整路径名:\(FileManager.TmpDirectory())")
    }
}
