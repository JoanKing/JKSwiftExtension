//
//  FiveViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController {

    lazy var testView: UIView = {
        let test = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        test.backgroundColor = .green
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
        label.backgroundColor = .brown
        test.addSubview(label)
        return test
    }()
    
    lazy var showLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: jk_kScreenW - 40, height: 0))
        label.font = UIFont.jk.textR(15)
        label.textColor = .black
        label.backgroundColor = .randomColor
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testView.center = self.view.center
        self.title = "Five"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(showLabel)
        
        let content = "今年市场特别流行一个词赛道今年市场特别流行一个词赛道今年市场特别流行一个词赛道今年市场特别流行一个词赛道今赛道今赛。"
        let contentH = JKContentSize.textStringSize(string: content, size: CGSize(width: jk_kScreenW - 40, height: CGFloat(MAXFLOAT)), font: UIFont.jk.textR(15)).height
        showLabel.text = content
        showLabel.jk.height = contentH
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testView.isHidden = true
    }
}
