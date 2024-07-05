//
//  UIApplication+Photo.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2024/7/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Photos

// MARK: - 二、APP权限的检测
enum JKAppPermissionType {
    // 照相机
    case camera
    // 相册
    case album
    // 麦克风
    case audio
    // 定位
    case location
}
extension UIApplication {
    
    // MARK: 2.1、判断是否拥有权限，目前支持 照相机、相册、麦克风、定位，提示：这里判断是这些权限有没有被用户手动关闭
    /// 判断是否拥有权限，目前支持 照相机、相册、麦克风、定位，提示：这里判断是这些权限有没有被用户手动关闭
    /// - Parameter permission: 权限的类型
    /// - Returns: 结果
    static func isOpenPermission(_ permission: JKAppPermissionType) -> Bool {
        
        var result: Bool = true
        if permission == .camera || permission == .audio {
            // 是否开启相机和麦克风权限
            let authStatus = AVCaptureDevice.authorizationStatus(for: permission == .camera ? .video : .audio)
            result = authStatus != .restricted && authStatus != .denied
        } else if permission == .album {
            // 是否开启相册权限
            let authStatus = PHPhotoLibrary.authorizationStatus()
            result = authStatus != .restricted && authStatus != .denied
        } else if permission == .location {
            // 是否开启定位权限
            let authStatus = CLLocationManager.authorizationStatus()
            return authStatus != .restricted && authStatus != .denied
        }
        return result
    }
}
