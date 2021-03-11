//
//  UIFontExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIFontExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
        headDataArray = ["一、常用的基本字体扩展"]
        dataArray = [["系统字体", "常规字体", "中等的字体", "加粗的字体", "半粗体的字体", "超细的字体", "纤细的字体", "亮字体", "介于Bold和Black之间", "最粗字体", "测试"]]
    }
}

// MARK:- 一、常用的基本字体扩展
extension UIFontExtensionViewController {
    
    // MARK: 1.10、最粗字体
    @objc func test110() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textBlack(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textBlack(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.9、介于Bold和Black之间
    @objc func test19() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textHeavy(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textHeavy(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.8、亮字体
    @objc func test18() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textLight(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textLight(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.7、纤细的字体
    @objc func test17() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textThin(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textThin(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.6、超细的字体
    @objc func test16() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textUltraLight(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textUltraLight(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.5、半粗体的字体
    @objc func test15() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textSB(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textSB(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.4、加粗的字体
    @objc func test14() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textB(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textB(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.3、中等的字体
    @objc func test13() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textM(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textM(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.2、常规字体
    @objc func test12() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textR(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textR(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.1、系统字体
    @objc func test11() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.textF(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.textF(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
}
