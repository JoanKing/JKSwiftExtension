//
//  JKDrawSignatureViewViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/2/22.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class JKDrawSignatureViewViewController: UIViewController {
    /// 签名预览
    lazy var signatureImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 100, y: drawView.jk.bottom + 50, width: 100, height: 80))
        return imageView
    }()
    /// 签名区域视图
    lazy var drawView: JKDrawSignatureView = {
        let drawSignatureView = JKDrawSignatureView(frame: CGRect(x: 100, y: showSignature.jk.bottom + 50, width: 200, height: 150))
        drawSignatureView.backgroundColor = .randomColor
        return drawSignatureView
    }()
    
    lazy var showSignature: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: kNavFrameH + 20, width: 80, height: 40))
        button.setTitle("预览签名", for: .normal)
        button.backgroundColor = .randomColor
        button.addTarget(self, action: #selector(previewSignatureClick), for: .touchUpInside)
        return button
    }()
    
    lazy var saveSignature: UIButton = {
        let button = UIButton(frame: CGRect(x: showSignature.jk.right + 20, y: kNavFrameH + 20, width: 80, height: 40))
        button.setTitle("保存签名", for: .normal)
        button.backgroundColor = .randomColor
        button.addTarget(self, action: #selector(savaSignatureClick), for: .touchUpInside)
        return button
    }()
    
    lazy var clearSignature: UIButton = {
        let button = UIButton(frame: CGRect(x: saveSignature.jk.right + 20, y: kNavFrameH + 20, width: 130, height: 40))
        button.setTitle("清除预览签名", for: .normal)
        button.backgroundColor = .randomColor
        button.addTarget(self, action: #selector(clearSignatureClick), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "签名"
        self.view.backgroundColor = .white
     
        // 添加签名区域
        self.view.addSubview(drawView)
        // 添加签名预览
        self.view.addSubview(signatureImageView)
        
        self.view.addSubview(showSignature)
        self.view.addSubview(saveSignature)
        self.view.addSubview(clearSignature)
    }
    
    /// 预览签名
    @objc func previewSignatureClick() {
        let signatureImage = self.drawView.getSignature()
        signatureImageView.image = signatureImage
    }
    
    /// 保存签名
    @objc func savaSignatureClick() {
        let signatureImage = self.drawView.getSignature()
        UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
        self.drawView.clearSignature()
    }
    
    /// 清除签名
    @objc func clearSignatureClick() {
        self.drawView.clearSignature()
        self.signatureImageView.image = nil
    }
}
