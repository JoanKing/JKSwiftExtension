//
//  OneViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class OneViewController: BaseViewController {

    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "One"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
        
        scrollView = UIScrollView(frame: CGRect(x: 100, y: 100, width: 100, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 180, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "上边"
        scrollView.addSubview(testLabel1)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // self.present(UIViewControllerExtensionViewController(), animated: true, completion: nil)
        scrollView.contentOffset(CGPoint(x: 0, y: 20))
    }
}


