//
//  NSDecimalNumberHandlerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NSDecimalNumberHandlerExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "NSDecimalNumberHandlerExtensionViewController"
        self.view.backgroundColor = .white
        
    }
    
    func test1() {
       print("结果：\(NSDecimalNumberHandler.getFloorValue(value1: 47.05, value2: 0.05))")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        test1()
    }
    
    

}
