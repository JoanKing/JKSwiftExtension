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
        
        headDataArray = ["一、基本的扩展", "二、UIColor 生成的图片 和 生成渐变色图片", "三、图片的拉伸和缩放", "四、UIImage 压缩相关", "五、二维码的处理", "六、gif 加载", "七、图片旋转的一些操作", "给图片添加滤镜效果（棕褐色老照片滤镜，黑白滤镜）"]
        dataArray = [["设置图片的圆角", "设置圆形图片", "获取视频的第一帧", "layer 转 image", "设置图片透明度", "裁剪给定区域", "给图片添加文字水印", "添加图片水印", "文字图片占位符", "更改图片颜色", "获取图片某一个位置像素的颜色", "保存图片到相册", "保存图片到相册(建议使用这个)", "图片的模糊效果（高斯模糊滤镜）", "像素化后的图片", "返回一个将白色背景变透明的UIImage", "返回一个将黑色背景变透明的UIImage"], ["生成指定尺寸的纯色图像", "生成指定尺寸和圆角的纯色图像", "生成渐变色的图片 [\"#B0E0E6\", \"#00CED1\", \"#2E8B57\"]", "生成渐变色的图片 [UIColor, UIColor, UIColor]", "生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]"], ["获取固定大小的 image", "按宽高比系数：等比缩放", "按指定尺寸等比缩放", "图片中间 1*1 拉伸——如气泡一般", "图片设置拉伸", "调整图像方向 避免图像有旋转"], ["压缩图片", "异步图片压缩", "压缩图片质量", "ImageIO 方式调整图片大小 性能很好", "CoreGraphics 方式调整图片大小 性能很好"], ["生成二维码图片", "获取图片中二维码数组", "获取图片每个二维码里面的信息数组"], ["验证资源的格式，返回资源格式（png/gif/jpeg...）", "加载 data 数据的 gif 图片", "加载网络 url 的 gif 图片", "加载本地的gif图片", "加载 asset 里面的图片", "获取 asset 里面的gif图片的信息：包含分解后的图片和gif时间", "获取 加载本地的 的gif图片的信息：包含分解后的图片和gif时间", "获取 网络 url 的 gif 图片的信息：包含分解后的图片和gif时间"], ["图片旋转 (角度)", "图片旋转 (弧度)", "水平翻转", "垂直翻转", "向下翻转", "向左翻转", "镜像向左翻转", "向右翻转", "镜像向右翻转", "图片平铺区域"], ["图片加滤镜", "全图马赛克", "检测人脸的frame", "检测人脸并打马赛克"]]
    }
}

// MARK:- 八、给图片添加滤镜效果（棕褐色老照片滤镜，黑白滤镜）以及 马赛克
extension UIImageExtensionViewController {
    
    // MARK: 8.4、检测人脸并打马赛克
    @objc func test84() {
        guard let image1 = UIImage(named: "tfboy"), let image = image1.jk.detectAndPixFace() else {
            return
        }
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        JKAsyncs.asyncDelay(2) {
        } _: {
            imageView1.image = image
            JKAsyncs.asyncDelay(5) {
            } _: {
                imageView1.removeFromSuperview()
            }
        }
    }
    
    // MARK: 8.3、检测人脸的frame
    @objc func test83() {
        
        guard let image1 = UIImage(named: "tfboy"), let rects = image1.jk.detectFace() else {
            return
        }
        print("人脸的rects：\(rects)")

        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = image1
        imageView.contentMode = .scaleAspectFit
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        
        guard let inputImage = CIImage(image: image1) else {
            return
        }
        let inputImageSize = inputImage.extent.size
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -inputImageSize.height)
        
        for rect in rects {
            var faceViewBounds = rect
            
            // 由于检测的原图放在imageView中缩放的原因,我们还要考虑缩放比例和x,y轴偏移
            let scale = min(imageView.bounds.size.width / inputImageSize.width,
                            imageView.bounds.size.height / inputImageSize.height)
            let offsetX = (imageView.bounds.size.width - inputImageSize.width * scale) / 2
            let offsetY = (imageView.bounds.size.height - inputImageSize.height * scale) / 2
            
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            // 每个人脸对应一个UIView方框
            let faceView = UIView(frame: faceViewBounds)
            faceView.layer.borderColor = UIColor.orange.cgColor
            faceView.layer.borderWidth = 2
            
            imageView.addSubview(faceView)
        }
        
        JKAsyncs.asyncDelay(5) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 8.2、全图马赛克
    @objc func test82() {
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        JKAsyncs.asyncDelay(2) {
        } _: {
            imageView1.image = image1?.jk.pixAll()
            JKAsyncs.asyncDelay(2) {
            } _: {
                imageView1.removeFromSuperview()
            }
        }
    }
    
    // MARK: 8.1、图片加滤镜
    @objc func test81() {
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        let image2 = UIImage(named: "testicon")
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(2) {
        } _: {
            let image3 = UIImage(named: "testicon")?.jk.filter(filterType: .CISepiaTone, alpha: 0.8)
            imageView2.image = image3
            JKAsyncs.asyncDelay(2) {
            } _: {
                let image4 = UIImage(named: "testicon")?.jk.filter(filterType: .CIPhotoEffectNoir, alpha: nil)
                imageView2.image = image4
                JKAsyncs.asyncDelay(2) {
                } _: {
                    imageView1.removeFromSuperview()
                    imageView2.removeFromSuperview()
                }
            }
        }
    }
}

// MARK:- 七、图片旋转的一些操作
extension UIImageExtensionViewController {
    
    // MARK: 7.10、图片平铺区域
    @objc func test710() {
        JKPrint("图片平铺")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.imageTile(size: CGSize(width: 100, height: 100)) else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.9、镜像向右翻转
    @objc func test79() {
        JKPrint("镜像向右翻转")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.flipRightMirrored() else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.8、向右翻转
    @objc func test78() {
        JKPrint("向右翻转")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.flipRight() else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.7、镜像向左翻转
    @objc func test77() {
        JKPrint("镜像向左翻转")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.flipLeftMirrored() else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.6、向左翻转
    @objc func test76() {
        JKPrint("向左翻转")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.flipLeft() else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.5、向下翻转
    @objc func test75() {
        JKPrint("向下翻转")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.flipDown() else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.4、垂直翻转
    @objc func test74() {
        JKPrint("垂直翻转")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.flipVertical() else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.3、水平翻转
    @objc func test73() {
        JKPrint("水平翻转")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.flipHorizontal() else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.2、图片旋转 (弧度)
    @objc func test72() {
        JKPrint("图片旋转 (角度)")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.imageRotated(radians: CGFloat(Double.pi)) else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 7.1、图片旋转 (角度)
    @objc func test71() {
        JKPrint("图片旋转 (角度)")
        let image1 = UIImage(named: "testicon")
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView1.image = image1
        imageView1.contentMode = .scaleAspectFit
        imageView1.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView1)
        
        guard let image2 = UIImage(named: "testicon")?.jk.imageRotated(degree: 90) else {
            return
        }
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: imageView1.jk.bottom + 30, width: 200, height: 200))
        imageView2.image = image2
        imageView2.contentMode = .scaleAspectFit
        imageView2.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView2)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
}
// MARK:- 六、gif 加载
extension UIImageExtensionViewController {
    
    // MARK: 6.8、获取 网络 url 的 gif 图片的信息：包含分解后的图片和gif时间
    @objc func test68() {
        let gifInfo = UIImage.jk.gifImages(url: "http://pic19.nipic.com/20120222/8072717_124734762000_2.gif")
        guard let images = gifInfo.gifImages, let duration = gifInfo.duration else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: images[0].size.width, height: images[0].size.height))
        gifImageView.image = images[0]
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        
        // 设置imageView的属性
        gifImageView.animationImages = images
        // 播放时间
        gifImageView.animationDuration = duration
        // 播放次数
        gifImageView.animationRepeatCount = 1
        // 开始播放
        gifImageView.startAnimating()

        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 6.7、获取 加载本地的 的gif图片的信息：包含分解后的图片和gif时间
    @objc func test67() {
        let gifInfo = UIImage.jk.gifImages(name: "pika2")
        guard let images = gifInfo.gifImages, let duration = gifInfo.duration else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: images[0].size.width, height: images[0].size.height))
        gifImageView.image = images[0]
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        
        // 设置imageView的属性
        gifImageView.animationImages = images
        // 播放时间
        gifImageView.animationDuration = duration
        // 播放次数
        gifImageView.animationRepeatCount = 1
        // 开始播放
        gifImageView.startAnimating()

        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 6.6、获取 asset 里面的gif图片的信息：包含分解后的图片和gif时间
    @objc func test66() {
        let gifInfo = UIImage.jk.gifImages(asset: "pika3")
        guard let images = gifInfo.gifImages, let duration = gifInfo.duration else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: images[0].size.width, height: images[0].size.height))
        gifImageView.image = images[0]
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        
        // 设置imageView的属性
        gifImageView.animationImages = images
        // 播放时间
        gifImageView.animationDuration = duration
        // 播放次数
        gifImageView.animationRepeatCount = 1
        // 开始播放
        gifImageView.startAnimating()

        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 6.5、加载 asset 里面的图片
    @objc func test65() {
        guard let image = UIImage.jk.gif(asset: "pika3") else {
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
        guard let image = UIImage.jk.gif(name: "pika2") else {
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
        guard let image = UIImage.jk.gif(url: "http://pic19.nipic.com/20120222/8072717_124734762000_2.gif") else {
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
        guard let image = UIImage.jk.gif(data: imageData) else {
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
        JKPrint("验证资源的格式，返回资源格式（png/gif/jpeg...）", "格式是：\(UIImage.jk.checkImageDataType(data: imageData))")
    }
}

// MARK:- 五、二维码的处理
extension UIImageExtensionViewController {
    
    // MARK: 5.3、获取图片每个二维码里面的信息数组
    @objc func test53() {
        let image = UIImage(named: "qr_test")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 300, height: 500))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
    
        let qrCodeFeatures = image!.jk.getImageQRImageInfo()
        JKPrint("获取图片每个二维码里面的信息数组：\(qrCodeFeatures)")
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 5.2、获取图片中二维码数组
    @objc func test52() {
        let image = UIImage(named: "qr_test")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 300, height: 500))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
    
        let qrCodeFeatures = image!.jk.getImageQRImage()
        JKPrint("图片中二维码数组：\(qrCodeFeatures)")
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 5.1、生成二维码图片
    @objc func test51() {
        let image = UIImage.jk.QRImage(with: "https://www.jianshu.com/u/8fed18ed70c9", size: CGSize(width: 100, height: 100), isLogo: true, logoSize: CGSize(width: 30, height: 30), logoImage: UIImage(named: "ironman"), logoRoundCorner: 4)
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
        guard let image = UIImage(named: "testicon")!.jk.resizeCG(resizeSize: CGSize(width: 200, height: 300)) else {
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
        guard let image = UIImage(named: "testicon")!.jk.resizeIO(resizeSize: CGSize(width: 200, height: 400)) else {
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
    
        guard let imageData = UIImage(named: "testicon")!.jk.compressDataSize(maxSize: 500) else {
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
        UIImage(named: "testicon")!.jk.asyncCompress(mode: .high, queue: DispatchQueue.global(), complete: { (data, size) in
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
        
        guard let imageData = UIImage(named: "testicon")!.jk.compress(mode: .high) else {
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
    
    // MARK: 3.6、调整图像方向 避免图像有旋转
    @objc func test36() {
        JKPrint("调整图像方向 避免图像有旋转")
        let image = UIImage(named: "testicon")!.jk.fixOrientation()
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
    
    // MARK: 3.5、图片设置拉伸
    @objc func test35() {
        // 有关图片拉伸：https://www.jianshu.com/p/26220f66af57?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
        // 首先定义一张图片
        var image = UIImage(named: "yoububble.png")
        image = image!.jk.strechBubble(edgeInsets: UIEdgeInsets(top: (image?.size.height)! / 2 + 10, left: 10, bottom: 10, right: 10))
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .brown
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
        let image = UIImage(named: "sender")!.jk.strechAsBubble()
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .brown
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
        guard let image = UIImage(named: "testicon")?.jk.scaleTo(size: CGSize(width: 200, height: 300)) else {
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
        guard let image = UIImage(named: "testicon")?.jk.scaleTo(scale: 2) else {
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
        guard let image = UIImage(named: "testicon")?.jk.solidTo(size: CGSize(width: 200, height: 300)) else {
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
        guard let image = UIImage.jk.gradient([.red, .brown, .yellow], size: CGSize(width: 200, height: 100), radius: 10, locations: nil, direction: .vertical) else {
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
        guard let image = UIImage.jk.gradient([.red, .brown, .yellow], size: CGSize(width: 200, height: 100), locations: nil, direction: .vertical) else {
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
        guard let image = UIImage.jk.gradient(["#B0E0E6", "#00CED1", "#2E8B57"], size: CGSize(width: 200, height: 100), locations: nil, direction: .horizontal) else {
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
        guard let image = UIImage.jk.image(color: .brown, size: CGSize(width: 100, height: 200), corners: .allCorners, radius: 10) else {
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
        guard let image = UIImage.jk.image(color: .yellow, size: CGSize(width: 2, height: 2)) else {
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
    
    // MARK: 1.17、返回一个将黑色背景变透明的UIImage
    @objc func test117() {
        guard let image = UIImage(named: "flower2") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(2) {
        } _: {
            // 像素化后的图片
            if let weakImage = image.jk.imageByRemoveBlackBg() {
               imageView.image = weakImage
            }
            JKAsyncs.asyncDelay(2) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.16、返回一个将白色背景变透明的UIImage
    @objc func test116() {
        guard let image = UIImage(named: "flower") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(2) {
        } _: {
            // 像素化后的图片
            if let weakImage = image.jk.imageByRemoveWhiteBg() {
               imageView.image = weakImage
            }
            JKAsyncs.asyncDelay(2) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.15、像素化后的图片
    @objc func test115() {
        guard let image = UIImage(named: "testicon") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(2) {
        } _: {
            // 像素化后的图片
            imageView.image = image.jk.getPixellateImage(fuzzyValue: 10)
            JKAsyncs.asyncDelay(2) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.14、图片的模糊效果（高斯模糊滤镜）
    @objc func test114() {
        guard let image = UIImage(named: "testicon") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(2) {
        } _: {
            // 设置高斯模糊
            imageView.image = image.jk.getGaussianBlurImage(fuzzyValue: 10)
            JKAsyncs.asyncDelay(2) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.13、保存图片到相册(建议使用这个)
    @objc func test113() {
        guard let image = UIImage(named: "testicon") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            image.jk.savePhotosImageToAlbum { (isSuccess: Bool, error: Error?) in
                if isSuccess {
                    print("保存成功!")
                } else{
                    print("保存失败：", error!.localizedDescription)
                }
            }
            JKAsyncs.asyncDelay(3) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.12、保存图片到相册
    @objc func test112() {
        guard let image = UIImage(named: "testicon") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(1) {
        } _: {
            image.jk.saveImageToPhotoAlbum { (result) in
                print("保存结果：\(result)")
                JKAsyncs.asyncDelay(3) {
                } _: {
                    imageView.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: 1.11、获取图片某一个位置像素的颜色
    @objc func test111() {

        guard let image = UIImage.jk.image(color: .yellow, size: CGSize(width: 10, height: 10)) else {
            return
        }
        
        let point = CGPoint(x: 5, y: 5)
        
        JKPrint("获取图片某一个位置像素的颜色", "点：\(point) 的颜色为：\(image.jk.pixelColor(point)!.hexString!)", "yellow：\(UIColor.yellow.hexString!)")
        
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
    
    // MARK: 1.10、更改图片颜色
    @objc func test110() {
        guard let image = UIImage(named: "testicon") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.image = image.jk.tint(color: .green, blendMode: .destinationIn)
            JKAsyncs.asyncDelay(3) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.9、文字图片占位符
    @objc func test19() {
        guard let image = UIImage.jk.textImage("正式", size: (100, 100), backgroundColor: .brown, textColor: .white, isCircle: false) else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.8添加图片水印
    @objc func test18() {
        guard let image = UIImage(named: "testicon") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 150, height: 200))
        imageView.image = image.jk.addImageWatermark(rect: CGRect(x: 25, y: 25, width: 50, height: 50), image: UIImage(named: "good5")!)
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.7、给图片添加文字水印
    @objc func test17() {
        guard let image = UIImage(named: "testicon") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 150, height: 200))
        imageView.image = image.jk.drawTextInImage(drawTextframe: CGRect(x: 25, y: 100, width: 150, height: 50), drawText: "我是水印", withAttributes: [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26)])
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        JKAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.6、裁剪给定区域
    @objc func test16() {
        // 这里获取的是 四分之一 的区域
        guard let image = UIImage(named: "testicon"), let newImage = image.jk.cropWithCropRect(CGRect(x: 0, y: 0, width: image.size.width / 2.0, height: image.size.height / 2.0)) else {
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
        let image = UIImage(named: "testicon")?.jk.imageByApplayingAlpha(0.5)
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
        
        guard let image = UIImage.jk.image(from: layer) else {
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
        UIImage.jk.getVideoFirstImage(videoUrl: "http://gslb.miaopai.com/stream/1UKfVpOmazRYEb4fVejwhgpX~3uIxmHBV~8VCQ__.mp4") { (image) in
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
        guard let image = UIImage(named: "ironman")?.jk.isCircleImage() else {
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
        guard let image = UIImage(named: "testicon")?.jk.isRoundCorner(radius: 16, byRoundingCorners: .allCorners, imageSize: CGSize(width: 200, height: 300)) else {
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
