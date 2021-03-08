//
//  TestFileViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TestFileViewController: BaseViewController {
    
    lazy var showLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .randomColor
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var tradeAccountHeadView: TradeAccountHeadView = {
        let headView = TradeAccountHeadView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 100))
        headView.backgroundColor = .randomColor
        return headView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestFile"
        self.view.backgroundColor = .white
        
        headDataArray = ["一、基本的使用"]
        dataArray = [["设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label"]]
      
        self.view.addSubview(tradeAccountHeadView)
        
        tradeAccountHeadView.addSubview(showLabel)
        
        showLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        self.navigationController?.pushViewController(ThreeViewController(), animated: true)
    }
    
    @objc func test19() {
        tradeAccountHeadView.jk.height = 200
    }
    
    @objc func test12() {
        
        self.navigationController?.pushViewController(TestFileViewController2(), animated: true)
    }
}


