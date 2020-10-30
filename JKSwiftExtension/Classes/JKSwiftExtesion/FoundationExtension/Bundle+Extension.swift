//
//  Bundle+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

public enum BundleType {
    // 自己 module 下的 bundle 文件
    case currentBundle
    // 其他 module 下的 bundle 文件
    case otherBundle
}

// MARK:- 一、Bundle 的基本扩展
public extension Bundle {
    
    // MARK: 1.1、通过 通过字符串地址 从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）
    /// 从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）
    /// - Parameters:
    ///   - bundName: bundle 的名字
    ///   - resourceName: 资源的名字，比如图片的名字
    ///   - bundleType: 类型：默认 currentBundle是在自己 module 下的 bundle 文件
    /// - Returns: 资源路径
    static func getBundlePathResource(bundName: String, resourceName: String, bundleType: BundleType = .currentBundle) -> String {
        if bundleType == .otherBundle {
            return "Frameworks/\(bundName).framework/\(bundName).bundle/\(resourceName)"
        }
        return "\(bundName).bundle/" + "\(resourceName)"
    }
    
    // MARK: 1.2、通过 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的
    /// 通过 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的
    /// - Parameters:
    ///   - bundName: bundle 的名字
    ///   - resourceName: 资源的名字，比如图片的名字(需要写出完整的名字，如图片：icon@2x)
    ///   - bundleType: 类型：默认 currentBundle是在自己 module 下的 bundle 文件
    /// - Returns: 资源路径
    static func getBundleResource(bundName: String, resourceName: String, ofType ext: String?, bundleType: BundleType = .currentBundle) -> String? {
        let resourcePath = bundleType == .otherBundle ? "Frameworks/\(bundName).framework/\(bundName)" : "\(bundName)"
        guard let bundlePath = Bundle.main.path(forResource: resourcePath, ofType: "bundle"), let bundle = Bundle.init(path: bundlePath) else {
            return nil
        }
        let imageStr = bundle.path(forResource: resourceName, ofType: ext)
        return imageStr
    }
    
    // MARK: 1.3、从其他的 Bundle 通过 bundlename 获取 bundle
    /// 从其他的 Bundle 通过 bundlename 获取 bundle
    /// - Parameters:
    ///   - bundleName: 目标bundle的名称
    ///   - aClass: 目标bundle所在的父bundle的class
    convenience init?(bundleName: String, forParent aClass: AnyClass) {
        guard let path = Bundle(for: aClass).path(forResource: bundleName, ofType: "bundle") else {
            return nil
        }
        self.init(path: path)
    }
}

