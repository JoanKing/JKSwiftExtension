//
//  MaskingManagerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class MaskingManagerExtensionViewController: BaseViewController {
    var testView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、UIView 直接调用吐司", "二、UIViewController 直接调用吐司", "三、String 直接调用吐司"]
        dataArray = [["展示Loading", "隐藏Loading", "是否在展示 Loading"], ["展示Loading", "隐藏Loading", "是否在展示 Loading"], ["String 直接调用吐司"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 三、String 直接调用吐司
extension MaskingManagerExtensionViewController {
    
    // MARK: 3.1、String 直接调用吐司
    @objc func test31() {
        "我是吐司".toast()
    }
}

// MARK:- 二、UIViewController 直接调用吐司
extension MaskingManagerExtensionViewController {
    
    // MARK: 2.3、是否在展示 Loading
    @objc func test23() {
        JKPrint("是否在展示 Loading：\(self.isShowHUD)")
    }
    
    // MARK: 2.2、隐藏Loading
    @objc func test22() {
        self.hideHUD()
    }
    
    // MARK: 2.1、展示Loading
    @objc func test21() {
        self.showHUD()
    }
}

// MARK:- 一、UIView 直接调用吐司
extension MaskingManagerExtensionViewController {
    
    // MARK: 1.3、是否在展示 Loading
    @objc func test13() {
        guard let weakTestView = testView else {
            return
        }
        JKPrint("是否在展示 Loading：\(weakTestView.isShowHUD)")
    }
    
    // MARK: 1.2、隐藏Loading
    @objc func test12() {
        guard let weakTestView = testView else {
            return
        }
        weakTestView.hideHUD()
        JKAsyncs.asyncDelay(1) {
        } _: {
            weakTestView.removeFromSuperview()
        }
    }
    
    // MARK: 1.1、展示Loading
    @objc func test11() {
        testView = UIView(frame: CGRect(x: 0, y: 100, width: 200, height: 200))
        testView!.backgroundColor = .randomColor
        testView!.jk.centerX = self.view.jk.centerX
        self.view.addSubview(testView!)
        testView!.showHUD()
    }
}
