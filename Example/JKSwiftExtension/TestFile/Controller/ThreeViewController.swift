//
//  ThreeViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

    lazy var arrowTestLabel: FBArrowTestLabel = {
        let label = FBArrowTestLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Three"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
        
        arrowTestLabel.center = self.view.center
        self.view.addSubview(arrowTestLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        arrowTestLabel.jk.height = 30
        arrowTestLabel.changeHeight()
    }

}
