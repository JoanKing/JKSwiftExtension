//
//  UIScrollViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import WebKit
class UIScrollViewExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、链式编程"]
        dataArray = [["适配iOS 11", "设置滚动到：上左下右", "获取 ScrollView 的 contentScroll 长图像"], ["设置偏移量 CGPoint", "设置偏移量 x: CGFloat, y: CGFloat", "设置滑动区域大小(CGSize)，默认是CGSizeZero", "设置滑动区域大小(width: CGFloat, height: CGFloat)，默认是CGSizeZero", "设置边缘插入内容以外的可滑动区域，默认是UIEdgeInsetsZero(提示：必须设置contentSize后才有效)", "设置边缘插入内容以外的可滑动区域(UIEdgeInsets)，默认是UIEdgeInsetsZero(提示：必须设置contentSize后才有效)", "设置代理", "设置弹性效果，默认是true, 如果设置成false，则当你滑动到边缘时将不具有弹性效果", "竖直方向 总是可以弹性滑动，默认是 false", "水平方向 总是可以弹性滑动，默认是 false", "设置是否可分页，默认是false， 如果设置成true， 则可分页", "是否显示水平方向滑动条，默认是true, 如果设置为false，当滑动的时候则不会显示水平滑动条", "是否显示垂直方向滑动条，默认是true, 如果设置为false，当滑动的时候则不会显示水平滑动条", "设置偏移量(x,y)", "设置 水平方向(x) 偏移量", "设置 垂直方向(y) 偏移量", "设置滑动条的边缘插入，即是距离上、左、下、右的距离，比如：top(20) 当向下滑动时，滑动条距离顶部的距离总是 20", "是否可滑动，默认是true, 如果默认为false, 则无法滑动", "设置滑动条颜色，默认是灰白色", "设置减速率，CGFloat类型，当你滑动松开手指后的减速速率， 但是尽管decelerationRate是一个CGFloat类型，但是目前系统只支持以下两种速率设置选择：fast 和 normal", "锁住水平或竖直方向的滑动， 默认为false，如果设置为TRUE，那么在推拖拽UIScrollView的时候，会锁住水平或竖直方向的滑动"]]
    }
}

extension UIScrollViewExtensionViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isMember(of: UITableView.self) {
            print("UITableView-----滚动")
        } else if scrollView.isMember(of: UIScrollView.self) {
            print("UIScrollView-----滚动")
        }
    }
}

// MARK: - 二、链式编程
extension UIScrollViewExtensionViewController {
    
    // MARK: 2.21、锁住水平或竖直方向的滑动， 默认为false，如果设置为TRUE，那么在推拖拽UIScrollView的时候，会锁住水平或竖直方向的滑动
    @objc func test221() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).isDirectionalLockEnabled(true)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "锁住水平或竖直方向的滑动"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.20、设置减速率，CGFloat类型，当你滑动松开手指后的减速速率， 但是尽管decelerationRate是一个CGFloat类型，但是目前系统只支持以下两种速率设置选择：fast 和 normal
    @objc func test220() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).indicatorStyle(.black).decelerationRate(.fast)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "设置减速率：fast"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.19、设置滑动条颜色，默认是灰白色
    @objc func test219() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).indicatorStyle(.black)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "设置滑动条颜色，默认是灰白色"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.18、是否可滑动，默认是true, 如果默认为false, 则无法滑动
    @objc func test218() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).isScrollEnabled(false)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "设置 是否可滑动"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.17、设置滑动条的边缘插入，即是距离上、左、下、右的距离，比如：top(20) 当向下滑动时，滑动条距离顶部的距离总是 20
    @objc func test217() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).scrollIndicatorInsets(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "设置滑动条的边缘插入"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.16、设置 垂直方向(y) 偏移量
    @objc func test216() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).setContentOffsetY(10)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "设置 垂直方向(10) 偏移量"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.15、设置 水平方向(x) 偏移量
    @objc func test215() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).setContentOffsetX(20)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "设置 水平方向(20) 偏移量"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.14、设置偏移量(x,y)
    @objc func test214() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).setContentOffset(20, 10)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "设置偏移量(20,10)"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.13、是否显示 垂直 方向滑动条，默认是true, 如果设置为false，当滑动的时候则不会显示水平滑动条
    @objc func test213() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).showsVerticalScrollIndicator(false)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "垂直 方向滑动条 隐藏"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.12、是否显示 水平 方向滑动条，默认是true, 如果设置为false，当滑动的时候则不会显示水平滑动条
    @objc func test212() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).showsHorizontalScrollIndicator(false)
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 350, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "水平 方向滑动条 隐藏"
        scrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.11、设置是否可分页，默认是false， 如果设置成true， 则可分页
    @objc func test211() {
        let testScrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).delegate(self).bounces(true).isPagingEnabled(true).contentSize(width: 500, height: 0)
        testScrollView.backgroundColor = .randomColor
        testScrollView.jk.neverAdjustContentInset()
        self.view.addSubview(testScrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置是否可分页，默认是false"
        testScrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            testScrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.10、水平方向 总是可以弹性滑动，默认是 false
    @objc func test210() {
        let testScrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).delegate(self).bounces(true).alwaysBounceHorizontal(true)
        testScrollView.backgroundColor = .randomColor
        testScrollView.jk.neverAdjustContentInset()
        self.view.addSubview(testScrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置没有弹性"
        testScrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            testScrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.09、竖直方向 总是可以弹性滑动，默认是 false
    @objc func test209() {
        let testScrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).delegate(self).bounces(true).alwaysBounceVertical(true)
        testScrollView.backgroundColor = .randomColor
        testScrollView.jk.neverAdjustContentInset()
        self.view.addSubview(testScrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置没有弹性"
        testScrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            testScrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.08、设置弹性效果，默认是true, 如果设置成false，则当你滑动到边缘时将不具有弹性效果
    @objc func test208() {
        let testScrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).delegate(self).bounces(false)
        testScrollView.backgroundColor = .randomColor
        testScrollView.jk.neverAdjustContentInset()
        testScrollView.contentSize(width: 0, height: 300)
        self.view.addSubview(testScrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置没有弹性"
        testScrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            testScrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.07、设置代理
    @objc func test207() {
        let testScrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200)).delegate(self)
        testScrollView.backgroundColor = .randomColor
        testScrollView.jk.neverAdjustContentInset()
        testScrollView.contentSize(width: 0, height: 300)
        self.view.addSubview(testScrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置代理"
        testScrollView.addSubview(testLabel1)
        
        JKAsyncs.asyncDelay(8, {
        }) {
            testScrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.06、设置边缘插入内容以外的可滑动区域(UIEdgeInsets)，默认是UIEdgeInsetsZero(提示：必须设置contentSize后才有效)
    @objc func test206() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置滑动区域：width: 0, height: 230"
        scrollView.addSubview(testLabel1)
        
        let testLabel2 = UILabel(frame: CGRect(x: 0, y: 210, width: 250, height: 20))
        testLabel2.backgroundColor = .brown
        testLabel2.adjustsFontSizeToFitWidth = true
        testLabel2.text = "我是底部，下面多出 20"
        scrollView.addSubview(testLabel2)
        
        scrollView.contentSize(width: 0, height: 230)
        scrollView.contentInset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.05、设置边缘插入内容以外的可滑动区域，默认是UIEdgeInsetsZero(提示：必须设置contentSize后才有效)
    @objc func test205() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置滑动区域：width: 0, height: 230"
        scrollView.addSubview(testLabel1)
        
        let testLabel2 = UILabel(frame: CGRect(x: 0, y: 210, width: 250, height: 20))
        testLabel2.backgroundColor = .brown
        testLabel2.adjustsFontSizeToFitWidth = true
        testLabel2.text = "我是底部，下面多出 20"
        scrollView.addSubview(testLabel2)
        
        scrollView.contentSize(width: 0, height: 230)
        scrollView.contentInset(top: 0, left: 0, bottom: 20, right: 0)
        JKAsyncs.asyncDelay(8, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.04、设置滑动区域大小(width: CGFloat, height: CGFloat)，默认是CGSizeZero
    @objc func test204() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置滑动区域：width: 0, height: 230"
        scrollView.addSubview(testLabel1)
        
        scrollView.contentSize(width: 0, height: 230)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.03、设置滑动区域大小(CGSize)，默认是CGSizeZero
    @objc func test203() {
        let scrollView = UIScrollView(frame: CGRect(x: 50, y: 100, width: 250, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.adjustsFontSizeToFitWidth = true
        testLabel1.text = "设置滑动区域：width: 280, height: 200"
        scrollView.addSubview(testLabel1)
        
        scrollView.contentSize(CGSize(width: 280, height: 200))
        
        JKAsyncs.asyncDelay(2, {
        }) {
            scrollView.removeFromSuperview()
        }
    }
    
    // MARK: 2.02、设置偏移量 x: CGFloat, y: CGFloat
    @objc func test202() {
        let scrollView = UIScrollView(frame: CGRect(x: 100, y: 100, width: 150, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.contentSize = CGSize(width: 180, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "2秒后y偏移20"
        scrollView.addSubview(testLabel1)
        JKAsyncs.asyncDelay(2, {
        }) {
            UIView.animate(withDuration: 2, animations: {
                scrollView.contentOffset(x: 0, y: 20)
            }) { (_) in
                JKAsyncs.asyncDelay(2, {
                }) {
                    scrollView.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: 2.01、设置偏移量 CGPoint
    @objc func test201() {
        let scrollView = UIScrollView(frame: CGRect(x: 100, y: 100, width: 150, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 180, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "2秒后y偏移20"
        scrollView.addSubview(testLabel1)
        JKAsyncs.asyncDelay(2, {
        }) {
            UIView.animate(withDuration: 2, animations: {
                scrollView.contentOffset(CGPoint(x: 0, y: 20))
            }) { (_) in
                JKAsyncs.asyncDelay(2, {
                }) {
                    scrollView.removeFromSuperview()
                }
            }
        }
    }
}

// MARK: - 一、基本的扩展
extension UIScrollViewExtensionViewController {
    
    // MARK: 1.03、获取 ScrollView 的 contentScroll 长图像
    @objc func test103() {
        
    }
    
    // MARK: 1.02、设置滚动到：上左下右
    @objc func test102() {
        let scrollView = UIScrollView(frame: CGRect(x: 100, y: 100, width: 100, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.contentSize = CGSize(width: 180, height: 280)
        self.view.addSubview(scrollView)
        
        let testLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        testLabel1.backgroundColor = .brown
        testLabel1.text = "上边"
        scrollView.addSubview(testLabel1)
        
        let testLabel2 = UILabel(frame: CGRect(x: 0, y: 180, width: 50, height: 50))
        testLabel2.backgroundColor = .brown
        testLabel2.text = "左边"
        scrollView.addSubview(testLabel2)
        
        let testLabel3 = UILabel(frame: CGRect(x: 0, y: 260, width: 100, height: 20))
        testLabel3.backgroundColor = .brown
        testLabel3.text = "底边"
        scrollView.addSubview(testLabel3)
        
        let testLabel4 = UILabel(frame: CGRect(x: 130, y: 200, width: 50, height: 80))
        testLabel4.backgroundColor = .brown
        testLabel4.text = "右边"
        scrollView.addSubview(testLabel4)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            scrollView.jk.scroll(edege: .bottom)
            JKAsyncs.asyncDelay(2, {
            }) {
                scrollView.jk.scroll(edege: .right)
                JKAsyncs.asyncDelay(2, {
                }) {
                    scrollView.jk.scroll(edege: .left)
                    JKAsyncs.asyncDelay(2, {
                    }) {
                        scrollView.jk.scroll(edege: .top)
                        JKAsyncs.asyncDelay(2, {
                        }) {
                            scrollView.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: 1.01、适配iOS 11
    @objc func test101() {
        let scrollView = UIScrollView(frame: CGRect(x: 100, y: 100, width: 100, height: 200))
        scrollView.backgroundColor = .randomColor
        scrollView.jk.neverAdjustContentInset()
        scrollView.contentSize = CGSize(width: 100, height: 280)
        self.view.addSubview(scrollView)
        
        let testView = UIView(frame: CGRect(x: 0, y: 260, width: 100, height: 20))
        testView.backgroundColor = .brown
        scrollView.addSubview(testView)
        
        JKAsyncs.asyncDelay(2) {
        } _: {
            scrollView.removeFromSuperview()
        }
    }
}
