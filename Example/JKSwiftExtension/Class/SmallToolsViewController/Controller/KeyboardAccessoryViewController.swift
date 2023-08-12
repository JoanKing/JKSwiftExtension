//
//  KeyboardAccessoryViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class KeyboardAccessoryViewController: BaseViewController {
    var textView: UITextView = {
        let view = UITextView(frame: CGRect(x: 20, y: 100, width: jk_kScreenW - 40, height: 200))
        view.backgroundColor = .randomColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        headDataArray = ["一、键盘的 inputAccessoryView"]
        dataArray = [["done"]]
        
        let keyboardAccessory = KeyboardAccessory()
        keyboardAccessory.delegate = self
        textView.inputAccessoryView = keyboardAccessory
        self.view.addSubview(textView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、基本的方法
extension KeyboardAccessoryViewController: KeyboardAccessoryDelegate {
    
    func keyboardAccessoryDone() {
        debugPrint("点击了 done")
        UIApplication.jk.keyWindow?.endEditing(true)
    }
}

