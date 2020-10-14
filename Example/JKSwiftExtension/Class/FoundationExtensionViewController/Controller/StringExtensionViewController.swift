//
//  StringExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class StringExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        var N: Double = 47.76
        let a: Double = 0.05
        
        for i in 0...3 {
            print("i=\(i)")
            N = floor(N / a) * a + a
            print("当i时\(i) N=\(N)")
        }
        
        print("最后结果：N=\(N)")
        
        
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let a = "1.00".cutLastZeroAfterDot()
        
        JKPrint(a)
    }

}
