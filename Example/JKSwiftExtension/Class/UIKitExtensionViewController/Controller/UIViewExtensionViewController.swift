//
//  UIViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/6.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import WebKit
import JKSwiftExtension
class UIViewExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        headDataArray = ["一、机型的判断", "二、屏幕尺寸常用的常量", "三、UIView 有关 Frame 的扩展", "四、继承于 UIView 视图的 平面、3D 旋转 以及 缩放", "五、关于UIView的 圆角 和 阴影的设置", "六、自定义链式编程", "七、其他的方法", "八、试图调试", "九、手势的扩展", "十、颜色渐变"]
        dataArray = [["设备型号", "是不是 iPhone X", "是不是 iPhone XS", "是不是 iPhone XR", "是不是 iPhone XsMax", "是不是 iPhone", "判断是否是 pad", "判断是不是 4or4s", "判断是不是 5 5c 5s", "判断是不是 6 6s 7 8", "判断是不是 6p 7p 8p", "当前设备是不是模拟器"], ["屏幕的宽", "屏幕的高", "获取statusBar的高度", "获取导航栏的高度", "屏幕底部Tabbar高度", "屏幕底部刘海高度", "屏幕比例", "身份证宽高比", "375尺寸适配比例", "屏幕16:9比例系数下的宽", "屏幕16:9比例系数下的高"], ["x 的位置", "y 的位置", "height: 视图的高度", "width: 视图的宽度", "size: 视图的zize", "centerX: 视图的X中间位置", "centerX: 视图的Y中间位置", "center: 视图的中间位置", "top 上端横坐标(y)", "left 左端横坐标(x)", "bottom 底端纵坐标 (y + height)", "right 底端纵坐标 (x + width)"], ["平面旋转", "沿 X 轴方向旋转多少度(3D旋转)", "沿 Y 轴方向旋转多少度(3D旋转)", "沿 Z 轴方向旋转多少度(3D旋转)", "沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)", "设置 x,y 缩放", "水平或垂直翻转", "移动到指定中心点位置"], ["设置圆角", "添加圆角和边框", "给继承于view的类添加阴影", "添加阴影和圆角并存", "通过贝塞尔曲线View添加阴影和圆角", "添加边框", "添加顶部的边框", "添加顶部的 内边框", "添加底部的 边框", "添加左边的 边框", "添加右边的 边框", "画圆环", "绘制虚线", "添加内阴影", "毛玻璃效果", "添加多个View子视图"], ["设置tag值", "设置圆角", "图片的模式", "设置背景色", "设置十六进制颜色", "设置 frame", "被添加到某个视图上", "设置是否支持触摸", "设置是否隐藏", "设置透明度", "设置tintColor", "链式编程的综合使用"], ["获取当前view的viewcontroller", "添加水印", "将 View 转换成图片", "添加点击事件", "键盘收起来", "视图抖动", "是否包含WKWebView"], ["图层调试", "UIResponder.Type寻找某个类型子视图", "T.Type寻找某个类型子视图", "根据类名寻找某个类型子视图", "移除所有的子视图", "移除layer"], ["通用响应添加方法", "手势 - 单击", "手势 - 长按", "手势 - 拖拽", "手势 - 屏幕边缘(靠近屏幕边缘的View类才支持)", "手势 - 屏幕边缘(闭包)", "手势 - 清扫", "手势 - 清扫(闭包)", "手势 - 捏合", "手势 - 旋转"], ["添加渐变色图层（棕色->绿色）", "colors 变化渐变动画"]]
    }
}

// MARK: - 十、颜色渐变
extension UIViewExtensionViewController {
    
    // MARK: 10.2、colors 变化渐变动画
    @objc func test102() {
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
    
    // MARK: 10.1、添加渐变色图层（棕色->绿色）
    @objc func test101() {
    
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

// MARK: - 九、手势的扩展
extension UIViewExtensionViewController {
    
    // MARK: 9.10、手势 - 旋转
    @objc func test910() {
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
    
    // MARK: 9.9、手势 - 捏合
    @objc func test99() {
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
    
    // MARK: 9.8、手势 - 清扫(闭包)
    @objc func test98() {
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
    
    // MARK: 9.7、手势 - 清扫
    @objc func test97() {
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
    
    // MARK: 9.6、手势 - 屏幕边缘(闭包)
    @objc func test96() {
        let testView = UIView(frame: CGRect(x: 0, y: 100, width: jk_kScreenW, height: 200))
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
    
    // MARK: 9.5、手势 - 屏幕边缘
    @objc func test95() {
        self.view.jk.addGestureEdgPan(self, action: #selector(gestureEdgPan1), for: .right)
    }
    
    @objc func gestureEdgPan1() {
        JKPrint("手势 - 屏幕边缘")
    }
    
    // MARK: 9.4、手势 - 拖拽
    @objc func test94() {
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
    
    // MARK: 9.3、手势 - 长按
    @objc func test93() {
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
    
    // MARK: 9.2、手势 - 单击
    @objc func test92() {
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
    
    // MARK: 9.1、通用响应添加方法
    @objc func test91() {
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

// MARK: - 八、试图调试
extension UIViewExtensionViewController {
    
    // MARK: 8.6、移除layer
    @objc func test86() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        testView.layer.borderWidth = 20
        testView.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(testView)
        
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.jk.removeLayer()
            JKAsyncs.asyncDelay(2, {
            }) {
                testView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 8.5、移除所有的子视图
    @objc func test85() {
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
    //MARK: 8.4、根据类名寻找某个类型子视图
    @objc func test84() {
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
        if let resultView = testView.jk.findSubView(childViewClassName: "UIView") {
            JKPrint("寻找子视图:\(testView) 结果是：\(resultView)")
        } else {
            JKPrint("寻找子视图:\(testView) 结果是：false")
        }
        JKAsyncs.asyncDelay(2) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    //MARK: 8.3、T.Type寻找某个类型子视图
    @objc func test83() {
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
        if let resultView = testView.jk.findSubView(childViewType: UIView.self) {
            JKPrint("寻找子视图:\(testView) 结果是：\(resultView)")
        } else {
            JKPrint("寻找子视图:\(testView) 结果是：false")
        }
        JKAsyncs.asyncDelay(2) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 8.2、UIResponder.Type寻找某个类型子视图
    @objc func test82() {
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
    
    // MARK: 8.1、图层调试(兼容OC)
    @objc func test81() {
        self.view.jk.getViewLayer()
    }
}

// MARK: - 七、其他的方法
extension UIViewExtensionViewController {
    
    // MARK: 7.7、是否包含WKWebView
    @objc func test77() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        let wkwebView = WKWebView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        wkwebView.backgroundColor = .randomColor
        testView.addSubview(wkwebView)
        
        print("视图是否包含WKWebView：\(testView.jk.isContainsWKWebView())")
        
        JKAsyncs.asyncDelay(2) {
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.6、视图抖动
    @objc func test76() {
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
    
    // MARK: 7.5、键盘收起来
    @objc func test75() {
        self.view.jk.keyboardEndEditing()
    }
    
    // MARK: 7.4、添加点击事件
    @objc func test74() {
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
    
    // MARK: 7.3、将 View 转换成图片
    @objc func test73() {
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
    
    // MARK: 7.2、添加水印
    @objc func test72() {
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
    
    // MARK: 7.1、获取当前view的viewcontroller
    @objc func test71() {
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

// MARK: - 六、自定义链式编程
extension UIViewExtensionViewController {
    
    // MARK: 6.1、设置tag值
    @objc func test61() {
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
    
    // MARK: 6.2、设置圆角
    @objc func test62() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.corner(22)
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 6.3、图片的模式
    @objc func test63() {
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
    
    // MARK: 6.4、设置背景色
    @objc func test64() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor(.brown)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 6.5、设置十六进制颜色
    @objc func test65() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor("#008000")
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 6.6、设置 frame
    @objc func test66() {
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
    
    // MARK: 6.7、被添加到某个视图上
    @objc func test67() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 6.8、设置是否支持触摸
    @objc func test68() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.isUserInteractionEnabled(true)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 6.9、设置是否隐藏
    @objc func test69() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.isHidden(false)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 6.10、设置透明度
    @objc func test610() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.alpha(0.6)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 6.11、设置tintColor
    @objc func test611() {
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
    
    // MARK: 6.12、链式编程的综合使用
    @objc func test612() {
        let testView1 = UILabel().frame(CGRect(x: 100, y: 100, width: 100, height: 100)).backgroundColor(.green).isUserInteractionEnabled(true).tag(101).corner(10).addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
}

// MARK: - 五、关于UIView的 圆角 和 阴影的设置
extension UIViewExtensionViewController {
    
    // MARK: 5.1、添加圆角
    @objc func test51() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addCorner(conrners: [.topLeft], radius: 20)
        self.view.addSubview(testView)
        
        let childView = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        childView.backgroundColor = .randomColor
        testView.addSubview(childView)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    //MARK: 5.2、添加圆角和边框
    @objc func test52() {
        var testView = UILabel()
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 100))
        }
        testView.layoutIfNeeded()
        testView.jk.addCorner(conrners: [.topLeft, .bottomRight], radius: 50, borderWidth: 10, borderColor: .randomColor)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 5.3、给继承于view的类添加阴影
    @objc func test53() {
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
    
    // MARK: 5.4、添加阴影和圆角并存
    @objc func test54() {
        
        var testView = UIView(frame: CGRect(x: 0, y: 100, width: 300, height: 200))
        testView.backgroundColor = .yellow
        testView.jk.centerX = self.view.jk.centerX
        // testView.layer.cornerRadius = 6
        testView.clipsToBounds = false
        self.view.addSubview(testView)
        
        let testLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 100))
        testLabel.backgroundColor = .white
        testLabel.text = "2秒后消失"
        testLabel.textAlignment = .center
        testLabel.textColor = .randomColor
        testLabel.jk.addCornerAndShadow(superview: testView, conrners: [.topLeft, .bottomRight], radius: 8, shadowColor: UIColor.black.withAlphaComponent(0.48), shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 1, shadowRadius: 16)
        testView.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    //MARK: 5.5、通过贝塞尔曲线View添加阴影和圆角
    @objc func test55() {
        var testView = UIView(frame: CGRect(x: 0, y: 100, width: 300, height: 200))
        testView.backgroundColor = .randomColor
        testView.jk.centerX = self.view.jk.centerX
        testView.jk.addViewCornerAndShadow(conrners: .allCorners, radius: 20, shadowColor: UIColor.black.withAlphaComponent(0.48), shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 1.0, shadowRadius: 10)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 5.6、添加边框
    @objc func test56() {
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
    
    // MARK: 5.7、添加顶部的边框
    @objc func test57() {
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
    
    // MARK: 5.8、添加顶部的 内边框
    @objc func test58() {
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
    
    // MARK: 5.9、添加底部的 边框
    @objc func test59() {
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
    
    // MARK: 5.10、添加左边的 边框
    @objc func test510() {
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
    
    // MARK: 5.11、添加右边的 边框
    @objc func test511() {
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
    
    // MARK: 5.12、画圆环
    @objc func test512() {
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
    
    // MARK: 5.13、绘制虚线
    @objc func test513() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        backgroundView.center = self.view.center
        backgroundView.backgroundColor = .brown
        self.view.addSubview(backgroundView)
        
        let lineView = UIView(frame: CGRect(x: 20, y: 20, width: 200, height: 2))
        // lineView.backgroundColor = .yellow
        lineView.jk.drawDashLine(strokeColor: UIColor.red, lineLength: 4, lineSpacing: 4, direction: .horizontal)
        backgroundView.addSubview(lineView)
        
        let lineView2 = UIView(frame: CGRect(x: 60, y: 130, width: 2, height: 200))
        // lineView2.backgroundColor = .yellow
        lineView2.jk.drawDashLine(strokeColor: UIColor.red, lineLength: 4, lineSpacing: 3, direction: .vertical)
        backgroundView.addSubview(lineView2)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            backgroundView.removeFromSuperview()
        }
    }
    
    // MARK: 5.14、添加内阴影
    @objc func test514() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        backgroundView.center = self.view.center
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 20
        backgroundView.clipsToBounds = true
        self.view.addSubview(backgroundView)
        
        backgroundView.jk.addInnerShadowLayer(shadowColor: UIColor.brown, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 0.5, shadowRadius: 10, insetBySize: CGSize(width: -42, height: -42))
        
        JKAsyncs.asyncDelay(3, {
        }) {
            backgroundView.removeFromSuperview()
        }
    }
    
    // MARK: 5.15、毛玻璃效果
    @objc func test315() {
        let image = UIImage(named: "testicon")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.jk.centerX = self.view.jk.centerX
        imageView.jk.effectViewWithAlpha()
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3, {
        }) {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 5.16、添加多个View子视图
    @objc func test516() {

        let backView = UIView()
        backView.backgroundColor = .brown
        view.addSubview(backView)
    
        let testView1 = UIView()
        testView1.backgroundColor = .blue
        
        let testView2 = UIView()
        testView2.backgroundColor = .red
        
        backView.jk.addSubviews([testView1, testView2])
        
        backView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 150))
            make.center.equalToSuperview()
        }
        
        testView1.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(30)
        }
        
        testView2.snp.makeConstraints { make in
            make.top.equalTo(testView1.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-30)
        }
    
        JKAsyncs.asyncDelay(3, {
        }) {
            backView.removeFromSuperview()
        }
    }
}

// MARK: - 四、继承于 UIView 视图的 平面、3D 旋转 以及 缩放
extension UIViewExtensionViewController {
    
    // MARK: 4.1、平面旋转
    @objc func test41() {
        let testView = UIView()
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        let image1 = UIImage(named: "campass_light")
        let imageView1 = UIImageView()
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        testView.addSubview(imageView1)
        imageView1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        UIView.animate(withDuration: 4, animations: {
            testView.jk.setRotation(-180)
        }) { (result) in
            JKAsyncs.asyncDelay(2) {
            } _: {
                UIView.animate(withDuration: 4, animations: {
                    testView.jk.setRotation(-270)
                }) { (result) in
                    // testView.removeFromSuperview()
                }
            }

        }
    }
    
    // MARK: 4.2、沿 X 轴方向旋转多少度(3D旋转)
    @objc func test42() {
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
    
    // MARK: 4.3、沿 Y 轴方向旋转多少度(3D旋转)
    @objc func test43() {
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
    
    // MARK: 4.4、沿 Z 轴方向旋转多少度(3D旋转)
    @objc func test44() {
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
    
    // MARK: 4.5、沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)
    @objc func test45() {
        
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
    
    // MARK: 4.6、设置 x,y 缩放
    @objc func test46() {
        
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 3, animations: {
            testView.jk.setScale(x: 2, y: 2)
        }) { (result) in
            JKAsyncs.asyncDelay(3) {
            } _: {
                testView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 4.7、水平或垂直翻转
    @objc func test47() {
        
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 20, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        let testView3 = UIView(frame: CGRect(x: 80, y: 80, width: 20, height: 20))
        testView3.backgroundColor = .randomColor
        testView.addSubview(testView3)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 3, animations: {
            testView.jk.flip(isHorizontal: true)
        }) { (result) in
            JKAsyncs.asyncDelay(2) {
            } _: {
                testView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 4.8、移动到指定中心点位置
    @objc func test48() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        JKAsyncs.asyncDelay(2) {
        } _: {
            UIView.animate(withDuration: 3, animations: {
                testView2.jk.moveToPoint(point: CGPoint(x: 90, y: 90))
            }) { (result) in
                JKAsyncs.asyncDelay(2) {
                } _: {
                    testView.removeFromSuperview()
                }
            }
        }
    }
}

// MARK: - 三、UIView 有关 Frame 的扩展
extension UIViewExtensionViewController {
    
    // MARK: 3.1、x 的位置
    @objc func test31() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.x = 150
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.2、y 的位置
    @objc func test32() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.y = 150
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.3、height: 视图的高度
    @objc func test33() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.height = 150
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.4、width: 视图的宽度
    @objc func test34() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.width = 150
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.5、size: 视图的zize
    @objc func test35() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.size = CGSize(width: 150, height: 150)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.6、centerX: 视图的X中间位置
    @objc func test36() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.centerX = 200
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.7、centerY: 视图的Y中间位置
    @objc func test37() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.centerY = 200
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.8、center: 视图的中间位置
    @objc func test38() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.center = CGPoint(x: 100, y: 250)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.9、top 上端横坐标(y)
    @objc func test39() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.top = 300
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.10、left 左端横坐标(x)
    @objc func test310() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.left = 250
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.11、bottom 底端纵坐标 (y + height)
    @objc func test311() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.bottom = 250
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.12、right 底端纵坐标 (x + width)
    @objc func test312() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jk.right = jk_kScreenW - 20
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
}

// MARK: - 二、机型的判断
extension UIViewExtensionViewController {
    
    //MARK: 2.11、屏幕16:9比例系数下的高
    /// 屏幕16:9比例系数下的高
    @objc func test211() {
        JKPrint("屏幕16:9比例系数下的高：\(jk_kScreenH16_9)")
    }
    
    //MARK: 2.10、屏幕16:9比例系数下的宽
    /// 屏幕16:9比例系数下的宽
    @objc func test210() {
        JKPrint("屏幕16:9比例系数下的宽：\(jk_kScreenW16_9)")
    }
    
    //MARK: 2.9、375尺寸适配比例
    /// 375尺寸适配比例
    @objc func test29() {
        JKPrint("375尺寸适配比例：\(jk_scaleIphone)")
    }
    
    //MARK: 2.8、身份证宽高比
    /// 身份证宽高比
    @objc func test28() {
        JKPrint("身份证宽高比：\(jk_kRatioIDCard)")
    }
    
    //MARK: 2.7、屏幕比例
    /// 屏幕比例
    @objc func test27() {
        JKPrint("屏幕比例：\(jk_kPixel)")
    }
    
    //MARK: 2.6、屏幕底部刘海高度
    /// 屏幕底部刘海高度
    @objc func test26() {
        JKPrint("屏幕底部刘海高度：\(jk_kTabbarBottom)")
    }
    
    //MARK: 2.5、屏幕底部Tabbar高度
    /// 屏幕底部Tabbar高度
    @objc func test25() {
        JKPrint("屏幕底部Tabbar高度：\(jk_kTabbarFrameH)")
    }
    
    //MARK: 2.4、获取导航栏的高度
    /// 获取导航栏的高度
    @objc func test24() {
        JKPrint("获取导航栏的高度：\(jk_kNavFrameH)")
    }
    
    //MARK: 2.3、获取statusBar的高度
    /// 获取statusBar的高度
    @objc func test23() {
        JKPrint("获取statusBar的高度：\(jk_kScreenH)")
    }
    
    //MARK: 2.2、屏幕的高
    /// 屏幕的高
    @objc func test22() {
        JKPrint("屏幕的高：\(jk_kScreenH)")
    }
    
    //MARK: 2.1、屏幕的宽
    /// 屏幕的宽
    @objc func test21() {
        JKPrint("屏幕的宽：\(jk_kScreenW)")
    }
}

// MARK: - 一、机型的判断
extension UIViewExtensionViewController {
    
    //MARK: 1.12、当前设备是不是模拟器
    /// 当前设备是不是模拟器
    @objc func test112() {
        JKPrint("\(jk_isSimulator())")
    }
    
    //MARK: 1.11、判断是不是 6p 7p 8p
    /// 判断是不是 6p 7p 8p
    @objc func test111() {
        JKPrint("\(jk_is678P())")
    }
    
    //MARK: 1.10、判断是不是 6 6s 7 8
    /// 判断是不是 6 6s 7 8
    @objc func test110() {
        JKPrint("\(jk_is678())")
    }
    
    //MARK: 1.9、判断是不是 5 5c 5s
    /// 判断是不是 5 5c 5s
    @objc func test19() {
        JKPrint("\(jk_is5())")
    }
    
    //MARK: 1.8、判断是不是 4or4s
    /// 判断是不是 4or4s
    @objc func test18() {
        JKPrint("\(jk_is4OrLess())")
    }
    
    //MARK: 1.7、判断是否是 pad
    /// 判断是否是 pad
    @objc func test17() {
        JKPrint("\(jk_isPadDevice())")
    }
    
    //MARK: 1.6、是不是 iPhone
    /// 是不是 iPhone
    @objc func test16() {
        JKPrint("\(jk_isIphone())")
    }
    
    //MARK: 1.5、是不是 iPhone XsMax
    /// 是不是 iPhone XsMax
    @objc func test15() {
        JKPrint("\(jk_isXsMax())")
    }
    
    //MARK: 1.4、是不是 iPhone XR
    /// 是不是 iPhone XR
    @objc func test14() {
        JKPrint("\(jk_isXR())")
    }
    
    //MARK: 1.3、是不是 iPhone XS
    /// 是不是 iPhone XS
    @objc func test13() {
        JKPrint("\(jk_isXs())")
    }
    
    // MARK: 1.2、是不是 iPhone X
    /// 是不是 iPhone X
    @objc func test12() {
        JKPrint("\(jk_isIphoneX())")
    }
    
    // MARK: 1.1、设备型号
    /// 设备型号
    @objc func test11() {
        JKPrint("\(jk_deviceModel())")
    }
}
