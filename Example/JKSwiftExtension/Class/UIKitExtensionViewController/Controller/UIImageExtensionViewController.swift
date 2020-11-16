//
//  UIImageExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation

class UIImageExtensionViewController: BaseViewController {

    var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、UIColor 生成的图片 和 生成渐变色图片", "三、图片的拉伸和缩放", "四、UIImage 压缩相关", "五、二维码的处理", "六、pdf 加载"]
        dataArray = [["设置图片的圆角", "设置圆形图片", "获取视频的第一帧", "layer 转 image", "设置图片透明度", "裁剪给定区域"], ["生成指定尺寸的纯色图像", "生成指定尺寸和圆角的纯色图像", "生成渐变色的图片 [\"#B0E0E6\", \"#00CED1\", \"#2E8B57\"]", "生成渐变色的图片 [UIColor, UIColor, UIColor]", "生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]"], ["获取固定大小的 image", "按宽高比系数：等比缩放", "按指定尺寸等比缩放", "图片中间 1*1 拉伸——如气泡一般", "调整图像方向 避免图像有旋转"], ["压缩图片", "异步图片压缩", "压缩图片质量", "ImageIO 方式调整图片大小 性能很好", "CoreGraphics 方式调整图片大小 性能很好"], ["生成二维码图片"], ["验证资源的格式，返回资源格式（png/gif/jpeg...）", "加载 data 数据的 gif 图片", "加载网络 url 的 gif 图片", "加载本地的gif图片", "加载 asset 里面的图片"]]
    }
}

// MARK:- 六、gif 加载
extension UIImageExtensionViewController {
    
    // MARK: 6.5、加载 asset 里面的图片
    @objc func test65() {
        guard let image = UIImage.gif(asset: "pika3") else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: image.size.width, height: image.size.height))
        gifImageView.image = image
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 6.4、加载本地的gif图片
    @objc func test64() {
        guard let image = UIImage.gif(name: "pika2") else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        gifImageView.image = image
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 6.3、加载网络 url 的 gif 图片
    @objc func test63() {
        guard let image = UIImage.gif(url: "http://pic19.nipic.com/20120222/8072717_124734762000_2.gif") else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        gifImageView.image = image
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(30) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 6.2、加载 data 数据的 gif 图片
    @objc func test62() {
        
        guard let path = Bundle.main.path(forResource: "pika2", ofType: "gif") else {
            return
        }

        guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return
        }
        guard let image = UIImage.gif(data: imageData) else {
            return
        }
        
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        gifImageView.image = image
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(30) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
        
    }
    
    // MARK: 6.1、验证资源的格式，返回资源格式（png/gif/jpeg...）
    @objc func test61() {
        guard let path = Bundle.main.path(forResource: "pika2", ofType: "gif") else {
            return
        }
        guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return
        }
        JKPrint("验证资源的格式，返回资源格式（png/gif/jpeg...）", "格式是：\(UIImage.checkImageDataType(data: imageData))")
    }
}

// MARK:- 五、二维码的处理
extension UIImageExtensionViewController {
    
    // MARK: 5.1、生成二维码图片
    @objc func test51() {
        let image = UIImage.QRImage(with: "https://www.jianshu.com/u/8fed18ed70c9", size: CGSize(width: 100, height: 100), isLogo: true, logoSize: CGSize(width: 30, height: 30), logoImage: UIImage(named: "ironman"), logoRoundCorner: 4)
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = image
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
}

// MARK:- 四、UIImage 压缩相关
extension UIImageExtensionViewController {
    
    // MARK: 4.5、CoreGraphics 方式调整图片大小 性能很好
    @objc func test45() {
        guard let image = UIImage(named: "testicon")!.resizeCG(resizeSize: CGSize(width: 200, height: 300)) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 4.4、ImageIO 方式调整图片大小 性能很好
    @objc func test44() {
        guard let image = UIImage(named: "testicon")!.resizeIO(resizeSize: CGSize(width: 200, height: 400)) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 300, height: 400))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 4.3、压缩图片质量
    @objc func test43() {
    
        guard let imageData = UIImage(named: "testicon")!.compressDataSize(maxSize: 500) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 250, height: 300))
        imageView.image = UIImage(data: imageData)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 4.2、异步图片压缩
    @objc func test42() {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 250, height: 300))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        UIImage(named: "testicon")!.asyncCompress(mode: .high, queue: DispatchQueue.global(), complete: { (data, size) in
            guard let weakData = data else {
                return
            }
            imageView.image = UIImage(data: weakData)
            JKAsyncs.asyncDelay(3) {
            } _: {
                imageView.removeFromSuperview()
            }
        })
    }
    
    // MARK: 4.1、压缩图片
    @objc func test41() {
        
        guard let imageData = UIImage(named: "testicon")!.compress(mode: .high) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 250, height: 300))
        imageView.image = UIImage(data: imageData)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
}

// MARK:- 三、图片的拉伸和缩放
extension UIImageExtensionViewController {
    
    // MARK: 3.5、调整图像方向 避免图像有旋转
    @objc func test35() {
        JKPrint("调整图像方向 避免图像有旋转")
        let image = UIImage(named: "testicon")!.fixOrientation()
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 250, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 3.4、图片中间 1*1 拉伸——如气泡一般
    @objc func test34() {
        JKPrint("图片中间 1*1 拉伸——如气泡一般")
        let image = UIImage(named: "sender")!.strechAsBubble()
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 250, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 3.3、按指定尺寸等比缩放
    @objc func test33() {
        JKPrint("按指定尺寸等比缩放")
        guard let image = UIImage(named: "testicon")?.scaleTo(size: CGSize(width: 200, height: 300)) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 3.2、按宽高比系数：等比缩放
    @objc func test32() {
        JKPrint("按宽高比系数：等比缩放")
        guard let image = UIImage(named: "testicon")?.scaleTo(scale: 2) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 3.1、获取固定大小的 image
    @objc func test31() {
        JKPrint("获取固定大小的 image")
        guard let image = UIImage(named: "testicon")?.solidTo(size: CGSize(width: 200, height: 300)) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
}

// MARK:- 二、UIColor 生成的图片 和 生成渐变色图片
extension UIImageExtensionViewController {
    
    // MARK: 2.5、生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]
    @objc func test25() {
        JKPrint("生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]")
        guard let image = UIImage.gradient([.red, .brown, .yellow], size: CGSize(width: 200, height: 100), radius: 10, locations: nil, direction: .vertical) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 2.4、生成渐变色的图片 [UIColor, UIColor, UIColor]
    @objc func test24() {
        JKPrint("生成渐变色的图片 [UIColor, UIColor, UIColor]")
        guard let image = UIImage.gradient([.red, .brown, .yellow], size: CGSize(width: 200, height: 100), locations: nil, direction: .vertical) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 2.3、生成渐变色的图片 ["#B0E0E6", "#00CED1", "#2E8B57"]
    @objc func test23() {
        JKPrint("生成渐变色的图片 [\"#B0E0E6\", \"#00CED1\", \"#2E8B57\"]")
        guard let image = UIImage.gradient(["#B0E0E6", "#00CED1", "#2E8B57"], size: CGSize(width: 200, height: 100), locations: nil, direction: .horizontal) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 2.2、生成指定尺寸和圆角的纯色图像
    @objc func test22() {
        JKPrint("生成指定尺寸和圆角的纯色图像")
        guard let image = UIImage.image(color: .brown, size: CGSize(width: 100, height: 200), corners: .allCorners, radius: 10) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 200))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 2.1、生成指定尺寸的纯色图像
    @objc func test21() {
        JKPrint("生成指定尺寸的纯色图像")
        guard let image = UIImage.image(color: .yellow, size: CGSize(width: 2, height: 2)) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 200))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
}

// MARK:- 一、基本的扩展
extension UIImageExtensionViewController {
    // MARK: 1.6、裁剪给定区域
    @objc func test16() {
        // 这里获取的是 四分之一 的区域
        guard let image = UIImage(named: "testicon"), let newImage = image.cropWithCropRect(CGRect(x: 0, y: 0, width: image.size.width / 2.0, height: image.size.height / 2.0)) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 200))
        imageView.image = newImage
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.5、设置图片透明度
    @objc func test15() {
        
        let image = UIImage(named: "testicon")?.imageByApplayingAlpha(0.5)
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 200))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.4、layer 转 image
    @objc func test14() {
        
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.backgroundColor = UIColor.randomColor.cgColor
        
        guard let image = UIImage.image(from: layer) else {
            return
        }
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 200))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.3、获取视频的第一帧
    @objc func test13() {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 200))
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        UIImage.getVideoFirstImage(videoUrl: "http://gslb.miaopai.com/stream/1UKfVpOmazRYEb4fVejwhgpX~3uIxmHBV~8VCQ__.mp4") { (image) in
            JKPrint("获取到了视频的第第一帧")
            imageView.image = image
            JKAsyncs.asyncDelay(3) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.2、设置圆形图片
    @objc func test12() {
        JKPrint("设置圆形图片")
        guard let image = UIImage(named: "ironman")?.isCircleImage() else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 200))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.1、设置图片的圆角
    @objc func test11() {
        JKPrint("设置图片的圆角")
        guard let image = UIImage(named: "testicon")?.isRoundCorner(radius: 16, byRoundingCorners: .allCorners, imageSize: CGSize(width: 200, height: 300)) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 200))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
}
