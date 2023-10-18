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
  
        headDataArray = ["一、常用的系统基本字体扩展", "二、PingFangSC-字体使用", "三、加载自定义的字体"]
        dataArray = [["系统字体", "常规字体", "中等的字体", "加粗的字体", "半粗体的字体", "超细的字体", "纤细的字体", "亮字体", "介于Bold和Black之间", "最粗字体"], ["常规字体", "中等的字体(介于Regular和Semibold之间)", "纤细的字体", "亮字体", "超细的字体", "半粗体的字体"], ["自定义字体", "打印所有的字体"]]
    }
}

// MARK: - 二、自定义字体
extension UIFontExtensionViewController {
    //MARK: 3.02、打印所有的字体
    /// 打印所有的字体
    @objc func test302() {
        JKPrint(UIFont.jk.showAllFont())
    }
    
    // MARK: 3.01、自定义字体
    /// 自定义字体
    @objc func test301() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .yellow
        label.textColor = .red
        label.text = "测试"
        label.font = UIFont.systemFont(ofSize: 19)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.text = ""
            label.font = UIFont.jk.customFont(26, fontName: "niu")
            JKAsyncs.asyncDelay(5, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
}

// MARK: - 二、自定义字体
extension UIFontExtensionViewController {
    
    // MARK: 2.06、半粗体的字体
    @objc func test206() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.pingFangSB(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.pingFangSB(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.05、超细的字体
    @objc func test205() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.pingFangUL(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.pingFangUL(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.04、亮字体
    @objc func test204() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.pingFangL(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.pingFangL(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.03、纤细的字体
    @objc func test203() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.pingFangT(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.pingFangT(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.02、中等的字体(介于Regular和Semibold之间)
    @objc func test202() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.pingFangM(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.pingFangM(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.01、常规字体
    @objc func test201() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jk.pingFangR(16)
        label.jk.centerX = self.view.jk.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jk.pingFangR(26)
            JKAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
}

// MARK: - 一、常用的系统基本字体扩展
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
    
    // MARK: 1.09、介于Bold和Black之间
    @objc func test109() {
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
    
    // MARK: 1.08、亮字体
    @objc func test108() {
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
    
    // MARK: 1.07、纤细的字体
    @objc func test107() {
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
    
    // MARK: 1.06、超细的字体
    @objc func test106() {
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
    
    // MARK: 1.05、半粗体的字体
    @objc func test105() {
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
    
    // MARK: 1.04、加粗的字体
    @objc func test104() {
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
    
    // MARK: 1.03、中等的字体
    @objc func test103() {
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
    
    // MARK: 1.02、常规字体
    @objc func test102() {
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
    
    // MARK: 1.01、系统字体
    @objc func test101() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jk.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "配置信息"
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
