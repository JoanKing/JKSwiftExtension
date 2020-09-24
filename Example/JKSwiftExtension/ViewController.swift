//
//  ViewController.swift
//  JKSwiftExtension
//
//  Created by JoanKing on 08/31/2020.
//  Copyright (c) 2020 JoanKing. All rights reserved.
//

import UIKit
import JKSwiftExtension

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor(hex: "#444444", alpha: 1.0)
        
        let label1 = ActionLabel.createActionLabel(frame: CGRect(x: 16, y: 100, width: 100, height: 100), target: self, selector: #selector(tapAction1))
        label1.backgroundColor = .brown
        label1.action = { (label) in
            print("哈哈1")
        }
        view.addSubview(label1)
        
    }
    
    @objc func tapAction1() {
        print("自定义点击事件")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

