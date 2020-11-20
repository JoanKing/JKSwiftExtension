//
//  TouchViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TouchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
       
        let greenView = UIView(frame: CGRect(x: 100, y: 150, width: 200, height: 200))
        greenView.backgroundColor = .green
        self.view.addSubview(greenView)
        
        let yellowView = JKTouchView(frame: CGRect(x: 30, y: 30, width: 140, height: 140))
        yellowView.backgroundColor = .yellow
        greenView.addSubview(yellowView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(click1))
        yellowView.addGestureRecognizer(tap)
            
    }

    @objc func click1() {
        JKPrint("---------")
    }
}
