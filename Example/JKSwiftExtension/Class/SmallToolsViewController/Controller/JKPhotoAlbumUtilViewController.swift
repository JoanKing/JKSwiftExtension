//
//  JKPhotoAlbumUtilViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/3/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Photos
class JKPhotoAlbumUtilViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的使用"]
        dataArray = [["将图片保存到指定相簿中", "如果参数 isCustomPhotoAlbumName 不指定，则默认保存到相机胶卷中去"]]
    }
}

// MARK: - 一、基本的工具
extension JKPhotoAlbumUtilViewController {

    // MARK: 1.02、如果参数 isCustomPhotoAlbumName 不指定，则默认保存到相机胶卷中去
    @objc func test102() {
    
        guard let image = UIImage(named: "tfboy") else {
            return
        }
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(imageView)
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            JKPhotoAlbumUtil.saveImageInAlbum(image: image) { result, authorizedStatus  in
                let authorizedStatusMessage = JKPhotoAlbumUtilViewController.authorizedStatusMessage(authorizeStatus: authorizedStatus, imageView: imageView)
                switch result{
                case .success:
                    print("保存成功：\(authorizedStatusMessage)")
                case .notPermission:
                    print("被拒绝：\(authorizedStatusMessage)")
                case .error:
                    print("保存错误：\(authorizedStatusMessage)")
                }
            }
        }
    }
    
    // MARK: 1.01、将图片保存到指定相簿中
    @objc func test101() {
    
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
            JKPhotoAlbumUtil.saveImageInAlbum(image: image, isCustomPhotoAlbumName: true) { result, authorizedStatus in
                let authorizedStatusMessage = JKPhotoAlbumUtilViewController.authorizedStatusMessage(authorizeStatus: authorizedStatus, imageView: imageView)
                switch result{
                case .success:
                    print("保存成功：\(authorizedStatusMessage)")
                case .notPermission:
                    print("被拒绝：\(authorizedStatusMessage)")
                case .error:
                    print("保存错误：\(authorizedStatusMessage)")
                }
            }
        }
    }
}

extension JKPhotoAlbumUtilViewController {
    
    static func authorizedStatusMessage(authorizeStatus: PHAuthorizationStatus, imageView: UIImageView) -> String {
        /**
         @available(iOS 8, *)
         case notDetermined = 0 // User has not yet made a choice with regards to this application

         @available(iOS 8, *)
         case restricted = 1 // This application is not authorized to access photo data.

         // The user cannot change this application’s status, possibly due to active restrictions
         //   such as parental controls being in place.
         @available(iOS 8, *)
         case denied = 2 // User has explicitly denied this application access to photos data.

         @available(iOS 8, *)
         case authorized = 3 // User has authorized this application to access photos data.

         @available(iOS 14, *)
         case limited = 4 // User has authorized this application for limited photo library access. Add PHPhotoLibr
         */
        JKAsyncs.asyncDelay(1) {
        } _: {
            imageView.removeFromSuperview()
        }
        if authorizeStatus == .notDetermined {
            return "notDetermined"
        } else if authorizeStatus == .restricted {
            return "restricted"
        } else if authorizeStatus == .denied {
            return "denied"
        } else if authorizeStatus == .authorized {
            return "authorized"
        } else {
            return "limited"
        }
    }
}
