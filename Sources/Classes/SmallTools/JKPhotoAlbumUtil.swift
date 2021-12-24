//
//  JKPhotoAlbumUtil.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/3/14.
//

// MARK: - 相册操作工具类
import Foundation
import UIKit
import Photos
/**
 （1）保存时会先验证用户是否授权操作相册照片。
 （2）指定相簿名字，即可将图片保存到该相簿下。（如果相簿不存在，也会自动创建）
 （3）如果不指定相簿名字，则保存到相机胶卷中。
 （4）保存后会有回调函数，可以用来判读是否保存成功、还是失败、或是没有操作照片相册的权限。
 */

// 操作结果枚举
public enum JKPhotoAlbumUtilResult {
    case success, error, denied
}

// MARK: - 一、一、基本的使用
public class JKPhotoAlbumUtil: NSObject {
    
    // 1.1、保存图片到相册(异步操作保存到相册)
    /// 保存图片到相册(异步操作保存到相册)
    /// - Parameters:
    ///   - image: 图片
    ///   - isCustomPhotoAlbumName: 是否使用自定义的相册名字(默认是不使用，保存到相册交卷，相册名是app的名字)
    ///   - completion: 结果闭包
    public class func saveImageInAlbum(image: UIImage, isCustomPhotoAlbumName: Bool = false, completion: ((JKPhotoAlbumUtilResult) -> Void)?) {
        
        // 权限验证
        if !isAuthorized() {
            completion?(.denied)
            return
        }
        var assetAlbum: PHAssetCollection?
        
        // 如果指定的相册名称为空，则保存到相机胶卷。（否则保存到指定相册）
        if !isCustomPhotoAlbumName {
            let list = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
            assetAlbum = list[0]
        } else {
            // 相册的名字
            let albumName = Bundle.jk.bundleName
            // 看保存的指定相册是否存在
            let list = PHAssetCollection
                .fetchAssetCollections(with: .album, subtype: .any, options: nil)
            list.enumerateObjects({ (album, index, stop) in
                let assetCollection = album
                if albumName == assetCollection.localizedTitle {
                    assetAlbum = assetCollection
                    stop.initialize(to: true)
                }
            })
            // 不存在的话则创建该相册
            if assetAlbum == nil {
                PHPhotoLibrary.shared().performChanges({
                    PHAssetCollectionChangeRequest
                        .creationRequestForAssetCollection(withTitle: albumName)
                }, completionHandler: { (isSuccess, error) in
                    if isSuccess {
                        self.saveImageInAlbum(image: image, isCustomPhotoAlbumName: true, completion: completion)
                    } else {
                        completion?(.error)
                    }
                })
                return
            }
        }
        
        // 保存图片
        PHPhotoLibrary.shared().performChanges({
            // 添加的相机胶卷
            let result = PHAssetChangeRequest.creationRequestForAsset(from: image)
            // 是否要添加到相簿
            if isCustomPhotoAlbumName {
                let assetPlaceholder = result.placeholderForCreatedAsset
                let albumChangeRequset = PHAssetCollectionChangeRequest(for: assetAlbum!)
                albumChangeRequset!.addAssets([assetPlaceholder!] as NSArray)
            }
        }) { (isSuccess: Bool, error: Error?) in
            if isSuccess {
                completion?(.success)
            } else{
                // print(error!.localizedDescription)
                completion?(.error)
            }
        }
    }
    
    // 判断相册是否授权
    private class func isAuthorized() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == .authorized ||
            PHPhotoLibrary.authorizationStatus() == .notDetermined
    }
}
