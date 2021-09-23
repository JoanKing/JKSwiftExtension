//
//  ThreeViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Three"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.jk.pop(count: 2, animated: true)
    }

}
