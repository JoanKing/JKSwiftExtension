//
//  BleViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/6/19.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class BleViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1100000 ： 96
        //  100000    0x20 101
        let value1 = (0b0000101000 & (0b11 << 8)) >> 8
        let value2 = (0b0100101000 & (0b11 << 8)) >> 8
        let value3 = (0b1000101000 & (0b11 << 8)) >> 8
        let value4 = (0b1100101000 & (0b11 << 8)) >> 8
        debugPrint("value1: \(value1) value2: \(value2) value3: \(value3) value4: \(value4)")
        
        let param: [String: Any] = ["test": false]
        if let test = param["test"] as? Bool {
            debugPrint("类型判断✅：\(test)")
        } else {
            debugPrint("类型判断❎")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
