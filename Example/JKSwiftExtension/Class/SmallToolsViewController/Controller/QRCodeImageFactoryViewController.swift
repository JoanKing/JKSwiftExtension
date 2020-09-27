//
//  QRCodeImageFactoryViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Photos
class QRCodeImageFactoryViewController: UIViewController {
    
    fileprivate lazy var bag: DisposeBag = DisposeBag()
    fileprivate var qrImage: UIImage?
    
    lazy var qrImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "二维码工厂"
        self.view.backgroundColor = .white
        
        let btn = UIButton(frame: CGRect(x: self.view.centerX - 150, y: 130, width: 130, height: 50))
        btn.backgroundColor = .brown
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("生成二维码", for: .normal)
        btn.rx.tap.subscribe { [weak self] (event: Event<()>) in
            guard let weakSelf = self else { return }
            weakSelf.getQRImage()
        }.disposed(by: bag)
        self.view.addSubview(btn)
        
        let saveImageBtn = UIButton(frame: CGRect(x: self.view.centerX + 20, y: 130, width: 130, height: 50))
        saveImageBtn.backgroundColor = .brown
        saveImageBtn.setTitleColor(.white, for: .normal)
        saveImageBtn.setTitle("保存二维码", for: .normal)
        saveImageBtn.rx.tap.subscribe { [weak self] (event: Event<()>) in
            guard let weakSelf = self else { return }
            weakSelf.saveQRImage()
        }.disposed(by: bag)
        
        self.view.addSubview(saveImageBtn)
        
        qrImageView.center = self.view.center
        self.view.addSubview(qrImageView)
    }
    
    // MARK: 生成二维码
    func getQRImage() {
        let image = QRCodeImageFactory.qrCodeImage(content: "https://www.jianshu.com/u/8fed18ed70c9", size: CGSize(width: 100, height: 100), logo: UIImage(named: "ironman"), logoSize: CGSize(width: 30, height: 30), logoRoundCorner: 4)
        qrImageView.image = image
        qrImage = image
    }
    
    // MARK: 保存二维码
    func saveQRImage() {
        guard let image = qrImage else {
            return
        }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { (success, error) in
            OperationQueue.main.addOperation({
                if error == nil {
                    "已保存到系统相册".toast()
                } else {
                    "保存失败".toast()
                }
            })
        }
    }
}
