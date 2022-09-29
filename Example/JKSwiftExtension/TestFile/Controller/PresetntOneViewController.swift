//
//  PresetntOneViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/9/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class PresetntOneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "One"
        self.view.backgroundColor = .brown
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let vc = UINavigationController(rootViewController: PresetntTwoViewController())
        vc.modalPresentationStyle = .fullScreen
        // 渐变出来
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}
