//
//  AVAssetExportSessionExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/1/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation
class AVAssetExportSessionExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、有关视频压缩的扩展"]
        dataArray = [["本地视频压缩"]]
    }
}

// MARK: - 一、有关视频压缩的扩展
extension AVAssetExportSessionExtensionViewController {
    // MARK: 1.1、本地视频压缩
    @objc func test11() {
        
        AVAssetExportSession.jk.assetExportSession(inputPath: "是本地视频路径", outputPath: "导出视频的路径", outputFileType: .mp4, completionHandler: { (exportSession, duration, videoSize, localVideoPath) in
            switch exportSession.status{
            case .waiting:
                print("等待压缩")
                break
            case .exporting:
                print("压缩中：")
                break
            case .completed:
                JKPrint("转码成功")
                //上传
                break
            case .cancelled:
                JKPrint("取消")
                break
            case .failed:
                JKPrint("失败...\(String(describing: exportSession.error?.localizedDescription))")
                break
            default:
                JKPrint("..")
                break
            }
        }, shouldOptimizeForNetworkUse: true)
    }
}
