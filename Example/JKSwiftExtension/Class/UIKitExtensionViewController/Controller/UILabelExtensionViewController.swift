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
        
        headDataArray = ["一、链式编程", "二、其他的基本扩展", "三、特定区域和特定文字的基本扩展"]
        dataArray = [["设置文字", "设置文字行数", "设置文字对齐方式", "设置富文本文字", "设置文本颜色", "设置文本颜色（十六进制字符串）", "设置字体的大小", "设置字体的大小", "设置字体的大小（粗体）"], ["获取已知 frame 的 label 的文本行数 & 每一行内容", "获取已知 width 的 label 的文本行数 & 每一行内容", "获取第一行内容", "改变行间距", "改变字间距", "改变字间距和行间距", "添加中划线"], ["设置特定区域的字体大小", "设置特定文字的字体大小", "设置特定区域的字体颜色", "设置特定文字的字体颜色", "设置行间距", "设置特定文字区域的下划线", "设置特定文字的下划线", "设置特定区域的删除线", "设置特定文字的删除线", "插入图片", "首行缩进", "设置特定文字区域的倾斜", "设置特定文字的倾斜"]]
    }
    
    @objc func click(sender: UIButton) {
        JKPrint("点击事件")
    }
}

// MARK: - 三、特定区域和特定文字的基本扩展
extension UILabelExtensionViewController {
    
    // MARK: 3.13、设置特定文字的倾斜
    @objc func test313() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 20)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setSpecificTextBliqueness("傲雪", inclination: 0.3)
            JKAsyncs.asyncDelay(5, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.12、设置特定文字区域的倾斜
    @objc func test312() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 20)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setSpecificRangeBliqueness(inclination: 0.5, range: NSRange(location: 2, length: 3))
            JKAsyncs.asyncDelay(5, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.11、首行缩进
    @objc func test311() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 20)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.firstLineLeftEdge(20)
            JKAsyncs.asyncDelay(5, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.10、插入图片
    @objc func test310() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 20)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.insertImage(imgName: "good6", imgBounds: CGRect(x: 0, y: -4, width: 20, height: 20), imgIndex: 5)
            testLabel.jk.insertImage(imgName: "good8", imgBounds: CGRect.zero, imgIndex: 10)
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.09、设置特定文字的删除线
    @objc func test309() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setSpecificTextDeleteLine("的", color: .green)
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.08、设置特定区域的删除线
    @objc func test308() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setSpecificRangeDeleteLine(color: .yellow, range: NSRange(location: 3, length: 17))
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.07、设置特定文字的下划线
    @objc func test307() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setSpecificTextUnderLine("的", color: .blue)
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.06、设置特定文字区域的下划线
    @objc func test306() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setSpecificRangeTextUnderLine(color: .green, range: NSRange(location: 3, length: 16))
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.05、设置行间距
    @objc func test305() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setTextLineSpace(20)
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.04、设置特定文字的字体颜色
    @objc func test304() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setSpecificTextColor("的", color: .green)
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.03、设置特定区域的字体颜色
    @objc func test303() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setSpecificRangeTextColor(color: .red, range: NSRange(location: 5, length: 5))
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.02、设置特定文字的字体大小
    @objc func test302() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setsetSpecificTextFont("的", font: UIFont.systemFont(ofSize: 30))
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.01、设置特定区域的字体大小
    @objc func test301() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.jk.setRangeFontText(font: UIFont.systemFont(ofSize: 30), range: NSRange(location: 2, length: 5))
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
}

// MARK: - 二、其他的基本扩展
extension UILabelExtensionViewController {
    
    // MARK: 2.07、label添加中划线
    @objc func test207() {
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
    
    // MARK: 2.06、改变字间距和行间距
    @objc func test206() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 1
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
    
    // MARK: 2.05、改变字间距
    @objc func test205() {
        
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
    
    // MARK: 2.04、改变行间距
    @objc func test204() {
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
    
    // MARK: 2.03、获取第一行内容
    @objc func test203() {
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
    
    // MARK: 2.02、获取已知 width 的 label 的文本行数 & 每一行内容
    @objc func test202() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        let result = testLabel.jk.accordWidthLinesCountAndLinesContent(accordWidth: 200, lineSpace: 2)
        if let number = result.0 {
            debugPrint("行数：\(number)")
        }
        if let contents = result.1 {
            debugPrint("内容：\(contents)")
        }
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.01、获取已知 frame 的 label 的文本行数 & 每一行内容
    @objc func test201() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.text("舒服得很，可惜乡里没房子🏠")
        self.view.addSubview(testLabel)
        let result = testLabel.jk.linesCountAndLinesContent(lineSpace: 2)
        if let number = result.0 {
            debugPrint("行数：\(number)")
        }
        if let contents = result.1 {
            debugPrint("内容：\(contents)")
        }
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
}

// MARK: - 一、链式编程
extension UILabelExtensionViewController {
    
    // MARK: 1.09、设置字体的大小（粗体）
    @objc func test109() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").boldFont(18)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.08、设置字体的大小
    @objc func test108() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").font(12)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.07、设置字体的大小
    @objc func test107() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").font(UIFont.systemFont(ofSize: 16))
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.06、设置文本颜色（十六进制字符串）
    @objc func test106() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32")
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.05、设置文本颜色
    @objc func test105() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color(.yellow)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.04、设置富文本文字
    @objc func test104() {
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
    
    // MARK: 1.03、设置文字对齐方式
    @objc func test103() {
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
    
    // MARK: 1.02、设置文字行数
    @objc func test102() {
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
    
    // MARK: 1.01、设置文字
    @objc func test101() {
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
}

