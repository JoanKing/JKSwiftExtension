//
//  UIControlExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIControlExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的链式编程", "二、基本的扩展"]
        dataArray = [["设置是否可用", "设置 点击状态", "是否高亮状态", "设置 垂直方向 对齐方式", "设置 水平方向 对齐方式", "添加事件（默认点击事件：touchUpInside）", "移除事件（默认移除 点击事件：touchUpInside）"], ["多少秒内不可重复点击"]]
    }
    
    @objc func click(sender: UIButton) {
        JKPrint("点击测试")
    }
}


// MARK:- 二、基本的扩展
extension UIControlExtensionViewController {
    
    // MARK: 2.1、多少秒内不可重复点击
    @objc func test21() {
        let hitTime : Double = 5
        let btn = UIButton(frame: CGRect(x: 50, y: kScreenH - 250, width: 200, height: 100))
        btn.backgroundColor = .randomColor
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        btn.tag = 20
        btn.setTitle("\(hitTime)秒内不可重复点击", for: .normal)
        btn.jk.preventDoubleHit(hitTime)
        btn.jk.setHandleClick { (btn) in
            guard let weakBtn = btn else { return }
            print("button的点击事件", "tag：\(weakBtn.tag)")
        }
        btn.addTo(self.view)
        JKAsyncs.asyncDelay(10, {
        }) {
            btn.removeFromSuperview()
        }
    }
}

// MARK:- 一、基本的链式编程
extension UIControlExtensionViewController {
    
    // MARK: 1.1、设置是否可用(测试这里设置不可用)
    @objc func test11() {
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .randomColor
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        btn.isEnabled(false)
        btn.addTo(self.view)
        JKAsyncs.asyncDelay(5, {
        }) {
            
        }
    }
    
    // MARK: 1.2、设置 点击状态
    @objc func test12() {
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .yellow
        btn.setTitleColor(.red, for: .normal)
        btn.setTitleColor(.green, for: .selected)
        btn.setTitle("2秒后消失", for: .normal)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        // 设置选中状态
        btn.isSelected(true)
        btn.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            btn.removeFromSuperview()
        }
    }
    
    // MARK: 1.3、是否高亮状态
    @objc func test13() {
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .yellow
        btn.setTitleColor(.red, for: .normal)
        btn.setTitleColor(.green, for: .selected)
        btn.setTitleColor(.black, for: .highlighted)
        btn.setTitle("2秒后消失", for: .normal)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        // 设置选中状态
        btn.isHighlighted(true)
        btn.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            btn.removeFromSuperview()
        }
    }
    
    // MARK: 1.4、设置垂直方向对齐方式
    @objc func test14() {
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .yellow
        btn.setTitleColor(.red, for: .normal)
        btn.setTitleColor(.green, for: .selected)
        btn.setTitleColor(.black, for: .highlighted)
        btn.setTitle("2秒后消失", for: .normal)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        btn.contentVerticalAlignment(.bottom)
        btn.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            btn.removeFromSuperview()
        }
    }
    
    // MARK: 1.5、设置水平方向对齐方式
    @objc func test15() {
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .yellow
        btn.setTitleColor(.red, for: .normal)
        btn.setTitleColor(.green, for: .selected)
        btn.setTitleColor(.black, for: .highlighted)
        btn.setTitle("2秒后消失", for: .normal)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        btn.contentHorizontalAlignment(.left)
        btn.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            btn.removeFromSuperview()
        }
    }
    
    // MARK: 1.6、添加事件（默认点击事件：touchUpInside）
    @objc func test16() {
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .yellow
        btn.setTitleColor(.red, for: .normal)
        btn.setTitleColor(.green, for: .selected)
        btn.setTitleColor(.black, for: .highlighted)
        btn.setTitle("5秒后消失", for: .normal)
        btn.add(self, action: #selector(click))
        btn.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            btn.removeFromSuperview()
        }
    }
    
    // MARK: 1.7、移除事件（默认移除 点击事件：touchUpInside）
    @objc func test17() {
        let btn = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
        btn.backgroundColor = .yellow
        btn.setTitleColor(.red, for: .normal)
        btn.setTitleColor(.green, for: .selected)
        btn.setTitleColor(.black, for: .highlighted)
        btn.setTitle("5秒后无法点击", for: .normal)
        btn.setTitle("现在无法点击", for: .selected)
        btn.add(self, action: #selector(click))
        btn.addTo(self.view)
        
        JKAsyncs.asyncDelay(5, {
        }) { [weak self] in
            btn.isSelected(true)
            guard let weakSelf = self else { return }
            btn.remove(weakSelf, action: #selector(weakSelf.click))
            JKAsyncs.asyncDelay(5, {
            }) {
                btn.removeFromSuperview()
            }
        }
    }
}
