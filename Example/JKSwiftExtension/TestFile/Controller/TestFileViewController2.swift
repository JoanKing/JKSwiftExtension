//
//  TestFileViewController2.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/2/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TestFileViewController2: BaseViewController {

    lazy var tradeAccountHeadView: TradeAccountHeadView = {
        let headView = TradeAccountHeadView()
        headView.jk.gradientColor(.horizontal, [ UIColor.hexStringColor(hexString: "#492E9C").cgColor, UIColor.hexStringColor(hexString: "#6B51FC").cgColor], nil)
        // headView.backgroundColor = .randomColor
        return headView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestFile"
        self.view.backgroundColor = .white
        
        headDataArray = ["一、基本的使用"]
        dataArray = [["设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label", "设置有内边距的label"]]
      
        tableView.tableHeaderView?.addSubview(tradeAccountHeadView)
        tableView.tableHeaderView?.jk.height = 100
        tradeAccountHeadView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        tradeAccountHeadView.jk.gradientColor(.horizontal, [ UIColor.hexStringColor(hexString: "#492E9C").cgColor, UIColor.hexStringColor(hexString: "#6B51FC").cgColor], nil)
        
        JKAsyncs.asyncDelay(0.2) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            // weakSelf.tradeAccountHeadView.jk.gradientColor(.horizontal, [ UIColor.hexStringColor(hexString: "#492E9C").cgColor, UIColor.hexStringColor(hexString: "#6B51FC").cgColor], nil)
        }

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
    }
    
    @objc func test11() {
        tradeAccountHeadView.jk.height = 200
        tableView.tableHeaderView?.jk.height = 200
        tradeAccountHeadView.jk.gradientColor(.horizontal, [ UIColor.hexStringColor(hexString: "#492E9C").cgColor, UIColor.hexStringColor(hexString: "#6B51FC").cgColor], nil)
        
    }
    
    @objc func test12() {
        
        
    }
}

