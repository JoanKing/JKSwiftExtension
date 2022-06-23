//
//  SpeechViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/8.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Speech

class SpeechViewController: UIViewController {

    lazy var startButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: animationView.jk.bottom + 20, width: 100, height: 60))
        button.backgroundColor = UIColor.brown
        button.addTarget(self, action: #selector(startClick), for: .touchUpInside)
        return button
    }()
    
    lazy var endButton: UIButton = {
        let button = UIButton(frame: CGRect(x: startButton.jk.right + 20, y: animationView.jk.bottom + 20, width: 100, height: 60))
        button.backgroundColor = UIColor.brown
        button.addTarget(self, action: #selector(endClick), for: .touchUpInside)
        return button
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton(frame: CGRect(x: startButton.jk.left + 20, y: startButton.jk.bottom + 50, width: 100, height: 60))
        button.backgroundColor = UIColor.brown
        button.addTarget(self, action: #selector(checkClick), for: .touchUpInside)
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(frame: CGRect(x: checkButton.jk.right + 20, y: startButton.jk.bottom + 50, width: 100, height: 60))
        button.backgroundColor = UIColor.brown
        button.addTarget(self, action: #selector(resetClick), for: .touchUpInside)
        return button
    }()
   
    lazy var animationView: AnimationView = {
        let animation = AnimationView(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        return animation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(animationView)
        self.view.addSubview(startButton)
        self.view.addSubview(endButton)
        self.view.addSubview(checkButton)
        self.view.addSubview(resetButton)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    @objc func startClick() {
        animationView.startAnimation()
    }
    
    @objc func endClick() {
        animationView.endAnimation()
    }
    
    @objc func checkClick() {
        animationView.checkPositiony()
    }
    
    @objc func resetClick() {
        animationView.resetPositiony()
    }
}
