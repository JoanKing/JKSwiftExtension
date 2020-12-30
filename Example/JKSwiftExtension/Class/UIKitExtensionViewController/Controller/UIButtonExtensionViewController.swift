//
//  UIButtonExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIButtonExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、链式调用", "三、UIButton 图片 与 title 位置关系(提示：title和image要在设置布局关系之前设置)", "四、自带倒计时功能的 Button"]
        dataArray = [["创建一个带颜色的 Button", "创建一个常规的 Button"], ["设置title", "设置文字颜色", "设置字体大小(UIFont)", "设置字体大小(CGFloat)", "设置字体粗体", "设置图片", "设置图片(通过Bundle加载)", "设置图片(通过Bundle加载)", "设置图片(纯颜色的图片)", "设置背景图片", "设置背景图片(通过Bundle加载)", "设置背景图片(通过Bundle加载)", "设置背景图片(纯颜色的图片)", "按钮点击的变化"], ["图片在左", "图片在右", "图片在上", "图片在下"], ["设置 Button 倒计时", "是否可以点击", "是否正在倒计时", "处于倒计时时，前缀文案，如：「再次获取」 + (xxxs)", "销毁定时器"]]
    }
    
    @objc func click() {
        testButton.countDown(10, timering: { (number) in
            print("\(number)")
        }, complete: {
            print("完成")
        }, timeringPrefix: "测试", completeText: "再来一次")
    }
    
    lazy var testButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12)
        button.backgroundColor = .brown
        button.center = self.view.center
        button.add(self, action: #selector(click))
        return button
    }()
}

// MARK:- 三、UIButton 图片 与 title 位置关系
extension UIButtonExtensionViewController {
    
    // MARK: 4.1、设置 Button 倒计时
    @objc func test41() {
        self.view.addSubview(testButton)
    }
    
    // MARK: 4.2、是否可以点击
    @objc func test42() {
        guard let result = testButton.reEnableCond else {
            print("-------nil--------")
            return
        }
        print("是否可以点击：\(result)")
    }
    
    // MARK: 4.3、是否正在倒计时
    @objc func test43() {
        let result = testButton.isTiming
        print("是否正在倒计时：\(result)")
    }
    
    // MARK: 4.4、处于倒计时时，前缀文案，如：「再次获取」 + (xxxs)
    @objc func test44() {
       guard let result = testButton.timeringPrefix else {
            print("-------nil--------")
            return
        }
        print("处于倒计时时，前缀文案：\(result)")
    }
    
    // MARK: 4.5、销毁定时器
    @objc func test45() {
        testButton.invalidate()
        print("销毁定时器")
    }
}
// MARK:- 三、UIButton 图片 与 title 位置关系
extension UIButtonExtensionViewController {
    
    // MARK: 3.1、图片在左
    @objc func test31() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).image(.brown).title("哈哈").jk.setImageTitleLayout(.imgLeft, spacing: 6)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 3.2、图片在右
    @objc func test32() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).image(.brown).title("哈哈").jk.setImageTitleLayout(.imgRight, spacing: 6)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 3.3、图片在上
    @objc func test33() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).image(.brown).title("哈哈").jk.setImageTitleLayout(.imgTop, spacing: 6)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 3.4、图片在下
    @objc func test34() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).font(6).image(.brown, CGSize(width: 20, height: 20), .normal).title("哈哈").jk.setImageTitleLayout(.imgBottom, spacing: 6)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
}

// MARK:- 二、链式调用
extension UIButtonExtensionViewController {
    
    // MARK: 2.1、设置title
    @objc func test21() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.2、设置文字颜色
    @objc func test22() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.3、设置字体大小(UIFont)
    @objc func test23() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).font(UIFont.systemFont(ofSize: 12))
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.4、设置字体大小(CGFloat)
    @objc func test24() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).font(16)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.5、设置字体粗体
    @objc func test25() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.6、设置图片
    @objc func test26() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).image(UIImage(named: "mark_highlighted"), .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.7、设置图片(通过Bundle加载)
    @objc func test27() {
        
        guard let path = Bundle.init(for: Self.self).path(forResource: "JKBaseKit", ofType: "bundle") else {
            return
        }
        let bundle = Bundle.init(path: path)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).image(in: bundle, "icon_scan", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.8、设置图片(通过Bundle加载)
    @objc func test28() {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).image(forParent: Self.self, bundleName: "JKBaseKit", "icon_scan", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.9、设置图片(纯颜色的图片)
    @objc func test29() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).image(UIColor.brown)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.10、设置背景图片
    @objc func test210() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).bgImage(UIImage(named: "testicon"))
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.11、设置背景图片(通过Bundle加载)
    @objc func test211() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).bgImage(forParent: Self.self, bundleName: "JKBaseKit", "icon_scan", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.12、设置背景图片(通过Bundle加载)
    @objc func test212() {
        guard let path = Bundle.init(for: Self.self).path(forResource: "JKBaseKit", ofType: "bundle") else {
            return
        }
        let bundle = Bundle.init(path: path)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).bgImage(in: bundle, "icon_scan", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.13、设置背景图片(纯颜色的图片)
    @objc func test213() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.brown, .normal).boldFont(12).bgImage(.yellow)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.14、按钮点击的变化
    @objc func test214() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.brown, .normal).boldFont(12).bgImage(.yellow).confirmButton()
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
}

// MARK:- 一、基本的扩展
extension UIButtonExtensionViewController {
    // MARK: 1.1、创建一个带颜色的 Button
    @objc func test11() {
        let button = UIButton.jk.small(type: .red, height: 200)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、创建一个常规的 Button
    @objc func test12() {
        let button = UIButton.jk.normal()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
}
