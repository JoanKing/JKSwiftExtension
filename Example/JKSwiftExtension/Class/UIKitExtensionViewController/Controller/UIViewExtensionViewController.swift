//
//  UIViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/6.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIViewExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、UIView 有关 Frame 的扩展", "二、继承于 UIView 视图的 平面、3D 旋转 以及 缩放", "三、关于UIView的 圆角 和 阴影的设置", "四、自定义链式编程", "五、其他的方法", "六、试图调试", "七、手势的扩展", "八、颜色渐变"]
        dataArray = [["x 的位置", "y 的位置", "height: 视图的高度", "width: 视图的宽度", "size: 视图的zize", "centerX: 视图的X中间位置", "centerX: 视图的Y中间位置", "center: 视图的中间位置", "top 上端横坐标(y)", "left 左端横坐标(x)", "bottom 底端纵坐标 (y + height)", "right 底端纵坐标 (x + width)"], ["平面旋转", "沿 X 轴方向旋转多少度(3D旋转)", "沿 Y 轴方向旋转多少度(3D旋转)", "沿 Z 轴方向旋转多少度(3D旋转)", "沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)", "设置 x,y 缩放"], ["设置圆角", "添加阴影", "添加阴影和圆角并存", "添加边框", "添加顶部的边框", "添加顶部的 内边框", "添加底部的 边框", "添加左边的 边框", "添加右边的 边框", "画圆环"], ["设置tag值", "设置圆角", "图片的模式", "设置背景色", "设置十六进制颜色", "设置 frame", "被添加到某个视图上", "设置是否支持触摸", "设置是否隐藏", "设置透明度", "设置tintColor", "链式编程的综合使用"], ["获取当前view的viewcontroller", "添加水印", "将 View 转换成图片", "添加点击事件", "键盘收起来", "视图抖动"], ["图层调试", "寻找某个类型子视图", "移除所有的子视图"], ["通用响应添加方法", "手势 - 单击", "手势 - 长按", "手势 - 拖拽", "手势 - 屏幕边缘(靠近屏幕边缘的View类才支持)", "手势 - 屏幕边缘(闭包)", "手势 - 清扫", "手势 - 清扫(闭包)", "手势 - 捏合", "手势 - 旋转"], ["添加渐变色图层（棕色->绿色）", "colors 变化渐变动画"]]
    }
}

// MARK:- 八、颜色渐变
extension UIViewExtensionViewController {
    
    // MARK: 8.2、colors 变化渐变动画
    @objc func test82() {
        let testView = UIView(frame: CGRect(x: 0, y: 200, width: 260, height: 60))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jk.gradientColorAnimation(startGradientColors: [UIColor.brown.cgColor, UIColor.green.cgColor], endGradientColors: [UIColor.yellow.cgColor, UIColor.purple.cgColor])
        JKAsyncs.asyncDelay(3) {
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 8.1、添加渐变色图层（棕色->绿色）
    @objc func test81() {
        let testView = UIView(frame: CGRect(x: 0, y: 200, width: 260, height: 60))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        testView.jk.gradientColor(.horizontal, [UIColor.brown.cgColor, UIColor.green.cgColor])
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            testView.removeFromSuperview()
        }
    }
}

// MARK:- 七、手势的扩展
extension UIViewExtensionViewController {
    
    // MARK: 7.10、手势 - 旋转
    @objc func test710() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jk.addGestureRotation { (gestureRecognizer) in
            JKPrint("手势 - 旋转")
        }
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.9、手势 - 捏合
    @objc func test79() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jk.addGesturePinch { (gestureRecognizer) in
            JKPrint("手势 - 捏合")
        }
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.8、手势 - 清扫(闭包)
    @objc func test78() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jk.addGestureSwip({ (gestureRecognizer) in
            JKPrint("手势 - 清扫")
        }, for: .left)
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.7、手势 - 清扫
    @objc func test77() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jk.addGestureSwip(self, action: #selector(swip), for: .right)
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    @objc func swip() {
        JKPrint("手势 - 清扫")
    }
    
    // MARK: 7.6、手势 - 屏幕边缘(闭包)
    @objc func test76() {
        let testView = UIView(frame: CGRect(x: 0, y: 100, width: kScreenW, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jk.addGestureEdgPan({ (gestureRecognizer) in
            JKPrint("手势 - 屏幕边缘")
        }, for: .right)
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.5、手势 - 屏幕边缘
    @objc func test75() {
        self.view.jk.addGestureEdgPan(self, action: #selector(gestureEdgPan1), for: .right)
    }
    
    @objc func gestureEdgPan1() {
        JKPrint("手势 - 屏幕边缘")
    }
    
    // MARK: 7.4、手势 - 拖拽
    @objc func test74() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        testView.jk.addGesturePan { (gestureRecognizer) in
            JKPrint("手势 - 拖拽")
        }
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.3、手势 - 长按
    @objc func test73() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        testView.jk.addGestureLongPress({ (gestureRecognizer) in
            JKPrint("长按2秒")
        }, for: 2)
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.2、手势 - 单击
    @objc func test72() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        testView.jk.addGestureTap { (gestureRecognizer) in
            JKPrint("手势 - 单击")
        }
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.1、通用响应添加方法
    @objc func test71() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        testView.jk.addActionClosure { (tapGestureRecognizer, view, integer) in
            JKPrint("点击了")
        }
        JKAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
}

// MARK:- 六、试图调试
extension UIViewExtensionViewController {
    
    // MARK: 6.3、移除所有的子视图
    @objc func test63() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        let testView1 = UIView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        testView1.backgroundColor = .randomColor
        testView.addSubview(testView1)
        let testView2 = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.jk.removeAllSubViews()
            JKAsyncs.asyncDelay(2, {
            }) {
                testView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 6.2、寻找某个类型子视图
    @objc func test62() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        let testView1 = UIView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        testView1.backgroundColor = .randomColor
        testView.addSubview(testView1)
        let testView2 = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        if let resultView = testView.jk.findSubview(type: UIView.self, resursion: true) {
            JKPrint("寻找子视图:\(testView) 结果是：\(resultView)")
        } else {
            JKPrint("寻找子视图:\(testView) 结果是：false")
        }
        JKAsyncs.asyncDelay(2) {
            
        } _: {
            testView.removeFromSuperview()
        }

    }
    
    // MARK: 6.1、图层调试(兼容OC)
    @objc func test61() {
        self.view.jk.getViewLayer()
    }
}

// MARK:- 五、其他的方法
extension UIViewExtensionViewController {
    // MARK: 5.6、视图抖动
    @objc func test56() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        JKAsyncs.asyncDelay(2) {
        } _: {
            testView.jk.shake(direction: .horizontal, times: 3, interval: 0.1, delta: 2) {
                JKAsyncs.asyncDelay(2) {
                } _: {
                    testView.jk.shake(direction: .vertical, times: 3, interval: 0.1, delta: 2) {
                        JKAsyncs.asyncDelay(2) {
                        } _: {
                            testView.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: 5.5、键盘收起来
    @objc func test55() {
        self.view.jk.keyboardEndEditing()
    }

    // MARK: 5.4、添加点击事件
    @objc func test54() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        testView.jk.addTapGestureRecognizerAction(self, #selector(click))
        self.view.addSubview(testView)
        
        JKAsyncs.asyncDelay(5) {
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // 测试
    @objc func click() {
        JKPrint("测试---添加点击事件")
    }
    
    // MARK: 5.3、将 View 转换成图片
    @objc func test53() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        let testView1 = UIView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        testView1.backgroundColor = .randomColor
        testView.addSubview(testView1)
        let testView2 = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        
        let gifImageView = UIImageView(frame: CGRect(x: 100, y: testView.jk.bottom + 50, width: 200,height: 200))
        self.view.addSubview(gifImageView)
        
        guard let image = testView.jk.toImage() else {
            JKPrint("view转换image失败")
            return
        }
        
        JKAsyncs.asyncDelay(3, {
        }) {
            gifImageView.image = image
            JKAsyncs.asyncDelay(2, {
            }) {
                testView.removeFromSuperview()
                gifImageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 5.2、添加水印
    @objc func test52() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        testView.jk.addWater(markText: "这是水印", textColor: .red, font: .systemFont(ofSize: 19))
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 5.1、获取当前view的viewcontroller
    @objc func test51() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        guard let vc = testView.jk.currentVC else {
            return
        }
        JKAsyncs.asyncDelay(1, {
            JKPrint("获取当前view的viewcontroller：\(vc.className)")
        }) {
            testView.removeFromSuperview()
        }
    }
}

// MARK:- 四、自定义链式编程 
extension UIViewExtensionViewController {
    
    // MARK: 4.1、设置tag值
    @objc func test41() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.tag(108)
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            JKPrint("tag值：\(testView.tag)")
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.2、设置圆角
    @objc func test42() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.corner(22)
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.3、图片的模式
    @objc func test43() {
        var testImageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 200, height: 300))
        testImageView.jk.centerX = self.view.jk.centerX
        testImageView.image = UIImage(named: "testicon")
        testImageView.contentMode(.scaleAspectFill)
        testImageView.backgroundColor = .randomColor
        self.view.addSubview(testImageView)
        JKAsyncs.asyncDelay(3, {
        }) {
            testImageView.removeFromSuperview()
        }
    }
    
    // MARK: 4.4、设置背景色
    @objc func test44() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor(.brown)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.5、设置十六进制颜色
    @objc func test45() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor("#008000")
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.6、设置 frame
    @objc func test46() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.frame = CGRect(x: 200, y: 100, width: 50, height: 50)
            JKAsyncs.asyncDelay(2, {
            }) {
                testView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 4.7、被添加到某个视图上
    @objc func test47() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.8、设置是否支持触摸
    @objc func test48() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.isUserInteractionEnabled(true)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.9、设置是否隐藏
    @objc func test49() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.isHidden(false)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.10、设置透明度
    @objc func test410() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.alpha(0.6)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.11、设置tintColor
    @objc func test411() {
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 400))
        testView1.backgroundColor = .brown
        testView1.text = "2秒后消失"
        testView1.tintColor = .yellow
        testView1.addTo(self.view)
        let testView2 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        testView2.backgroundColor = .green
        testView2.text = "2秒后消失"
        testView1.addSubview(testView2)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 4.12、链式编程的综合使用
    @objc func test412() {
        let testView1 = UILabel().frame(CGRect(x: 100, y: 100, width: 100, height: 100)).backgroundColor(.green).isUserInteractionEnabled(true).tag(101).corner(10).addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
}

// MARK:- 三、关于UIView的 圆角 和 阴影的设置
extension UIViewExtensionViewController {
    
    // MARK: 3.1、设置圆角
    @objc func test31() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addShadow(shadowColor: UIColor.black.withAlphaComponent(0.48), shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 1, shadowRadius: 20)
        testView.jk.addCorner(conrners: [.topLeft], radius: 20)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.2、添加阴影
    @objc func test32() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addShadow(shadowColor: UIColor.black.withAlphaComponent(0.48), shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 1, shadowRadius: 20)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.3、添加 圆角 和 阴影
    @objc func test33() {
        
        var testView = UIView(frame: CGRect(x: 0, y: 100, width: 300, height: 200))
        testView.backgroundColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.layer.cornerRadius = 6
        testView.clipsToBounds = false
        self.view.addSubview(testView)
        
        let testLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 100))
        testLabel.backgroundColor = .randomColor
        testLabel.text = "2秒后消失"
        testLabel.textAlignment = .center
        testLabel.textColor = .randomColor
        testLabel.jk.addCornerAndShadow(superview: testView, conrners: [.allCorners], radius: 6, shadowColor: UIColor.black.withAlphaComponent(0.48), shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 1, shadowRadius: 6)
        testView.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.4、添加边框
    @objc func test34() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addBorder(borderWidth: 10, borderColor: .red)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.5、添加顶部的边框
    @objc func test35() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addBorderTop(borderWidth: 10, borderColor: .red)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.6、添加顶部的 内边框
    @objc func test36() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addBorderTopWithPadding(borderWidth: 40, borderColor: .brown, padding: 8)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.7、添加底部的 边框
    @objc func test37() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addBorderBottom(borderWidth: 20, borderColor: .brown)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.8、添加左边的 边框
    @objc func test38() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addBorderLeft(borderWidth: 20, borderColor: .brown)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.9、添加右边的 边框
    @objc func test39() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addBorderRight(borderWidth: 20, borderColor: .brown)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.10、添加右边的 边框
    @objc func test310() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.drawCircle(fillColor: .red, strokeColor: .blue, strokeWidth: 10)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
}

// MARK:- 二、继承于 UIView 视图的 平面、3D 旋转 以及 缩放
extension UIViewExtensionViewController {
    
    // MARK: 2.1、沿 X 轴方向旋转多少度
    @objc func test21() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.set3DRotationX(CGFloat.pi)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.2、沿 X 轴方向旋转多少度(3D旋转)
    @objc func test22() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        //testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.set3DRotationX(CGFloat.pi)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.3、沿 Y 轴方向旋转多少度(3D旋转)
    @objc func test23() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.set3DRotationY(CGFloat.pi)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.4、沿 Z 轴方向旋转多少度(3D旋转)
    @objc func test24() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.set3DRotationZ(CGFloat.pi)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.5、沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)
    @objc func test25() {
        
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.setRotation(xAngle: CGFloat.pi, yAngle: CGFloat.pi/2, zAngle: CGFloat.pi / 2)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.5、设置 x,y 缩放
    @objc func test26() {
        
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.setScale(x: 2, y: 2)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
}

// MARK:- 一、UIView 有关 Frame 的扩展
extension UIViewExtensionViewController {
    
    // MARK: 1.1、x 的位置
    @objc func test11() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.x = 150
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、y 的位置
    @objc func test12() {
       var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
       testView.backgroundColor = .randomColor
       self.view.addSubview(testView)
       UIView.animate(withDuration: 2, animations: {
           testView.jk.y = 150
       }) { (result) in
           testView.removeFromSuperview()
       }
    }
    
    // MARK: 1.3、height: 视图的高度
    @objc func test13() {
       var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
       testView.backgroundColor = .randomColor
       self.view.addSubview(testView)
       UIView.animate(withDuration: 2, animations: {
           testView.jk.height = 150
       }) { (result) in
           testView.removeFromSuperview()
       }
    }
    
    // MARK: 1.4、width: 视图的宽度
    @objc func test14() {
       var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
       testView.backgroundColor = .randomColor
       self.view.addSubview(testView)
       UIView.animate(withDuration: 2, animations: {
           testView.jk.width = 150
       }) { (result) in
           testView.removeFromSuperview()
       }
    }
    
    // MARK: 1.5、size: 视图的zize
    @objc func test15() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.size = CGSize(width: 150, height: 150)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.6、centerX: 视图的X中间位置
    @objc func test16() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.centerX = 200
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.7、centerY: 视图的Y中间位置
    @objc func test17() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.centerY = 200
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.8、center: 视图的中间位置
    @objc func test18() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.center = CGPoint(x: 100, y: 250)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.9、top 上端横坐标(y)
    @objc func test19() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.top = 300
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.10、left 左端横坐标(x)
    @objc func test110() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.left = 250
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.11、bottom 底端纵坐标 (y + height)
    @objc func test111() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.bottom = 250
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.12、right 底端纵坐标 (x + width)
    @objc func test112() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.right = kScreenW - 20
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
}

