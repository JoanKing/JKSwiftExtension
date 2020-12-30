//
//  UILabelExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UILabelExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、链式编程", "二、其他的基本扩展"]
        dataArray = [["设置文字", "设置文字行数", "设置文字对齐方式", "设置富文本文字", "设置文本颜色", "设置文本颜色（十六进制字符串）", "设置字体的大小", "设置字体的大小", "设置字体的大小（粗体）"], ["获取已知 frame 的 label 的文本行数 & 每一行内容", "获取已知 width 的 label 的文本行数 & 每一行内容", "获取第一行内容", "改变行间距", "改变字间距", "改变字间距和行间距", "添加中划线"]]
    }
    
    @objc func click(sender: UIButton) {
        JKPrint("点击事件")
    }
}


// MARK:- 一、链式编程
extension UILabelExtensionViewController {
    
    // MARK: 2.1、获取已知 frame 的 label 的文本行数 & 每一行内容
    @objc func test21() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        let result = testLabel.jk.linesCountAndLinesContent(lineSpace: 2)
        if let number = result.0 {
            print("行数：\(number)")
        }
        if let contents = result.1 {
            print("内容：\(contents)")
        }
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.2、获取已知 width 的 label 的文本行数 & 每一行内容
    @objc func test22() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        let result = testLabel.jk.linesCountAndLinesContent(accordWidth: 200, lineSpace: 2)
        if let number = result.0 {
            print("行数：\(number)")
        }
        if let contents = result.1 {
            print("内容：\(contents)")
        }
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.3、获取第一行内容
    @objc func test23() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        if let firstLine = testLabel.jk.firstLineString {
            JKPrint("获取第一行内容", "\(firstLine)")
        }
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.4、改变行间距
    @objc func test24() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.jk.changeLineSpace(space: 10)
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.5、改变字间距
    @objc func test25() {
        
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.jk.changeWordSpace(space: 4)
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.6、改变字间距和行间距
    @objc func test26() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.jk.changeSpace(lineSpace: 4, wordSpace: 4)
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.7、label添加中划线
    @objc func test27() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        testLabel.jk.centerLineText(lineValue: 1, underlineColor: .red)
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
}

// MARK:- 一、链式编程
extension UILabelExtensionViewController {
    
    // MARK: 1.1、设置文字
    @objc func test11() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
        testLabel.backgroundColor = .brown
        testLabel.text("2秒后消失")
        testLabel.tintColor = .yellow
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、设置文字行数
    @objc func test12() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 200))
        testLabel.backgroundColor = .brown
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        testLabel.line(0)
        testLabel.tintColor = .yellow
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.3、设置文字对齐方式
    @objc func test13() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
        testLabel.backgroundColor = .brown
        testLabel.text("2秒后消失")
        testLabel.textAlignment(.right)
        testLabel.tintColor = .yellow
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.4、设置富文本文字
    @objc func test14() {
        let attributedString = NSMutableAttributedString(string: "我是一只小小鸟").color(.randomColor).font(22)
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
        testLabel.backgroundColor = .brown
        testLabel.attributedText(attributedString)
        testLabel.textAlignment(.right)
        testLabel.tintColor = .yellow
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.5、设置文本颜色
    @objc func test15() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color(.yellow)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.6、设置文本颜色（十六进制字符串）
    @objc func test16() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32")
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.7、设置字体的大小
    @objc func test17() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").font(UIFont.systemFont(ofSize: 16))
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.8、设置字体的大小
    @objc func test18() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").font(12)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.9、设置字体的大小（粗体）
    @objc func test19() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").boldFont(18)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
}

