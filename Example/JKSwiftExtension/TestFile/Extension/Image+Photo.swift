//
//  Image+Photo.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2024/7/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Photos

// MARK: - 一、基本的扩展
extension UIImage {
    
    // MARK: 1.15、保存图片到相册(建议使用这个)
    /// 保存图片到相册
    func savePhotosImageToAlbum(completion: @escaping ((Bool, Error?) -> Void)) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: self)
        } completionHandler: { (isSuccess: Bool, error: Error?) in
            completion(isSuccess, error)
        }
    }
}
