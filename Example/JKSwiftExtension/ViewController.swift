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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        MaskingManager.shareManager.isShow()
        JKAsyncs.delay(10) {
            MaskingManager.shareManager.dismissloading()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

