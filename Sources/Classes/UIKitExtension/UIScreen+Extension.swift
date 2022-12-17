//
//  UIScreen+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
extension UIScreen: JKPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JKPOP where Base: UIScreen {

    // MARK: 1.1、获取宽度
    /// 获取宽度
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    // MARK: 1.2、获取高度
    /// 获取宽度
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    // MARK: 1.3、截屏或者录屏通知
    /// 截屏或者录屏通知
    /// - Parameter action: 事件
    static func detectScreenShot(_ action: @escaping (String) -> Void) {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: mainQueue) { _ in
            action("截屏")
        }
        //监听录屏通知,iOS 11后才有录屏
        if #available(iOS 11.0, *) {
            //如果正在捕获此屏幕（例如，录制、空中播放、镜像等），则为真
            if UIScreen.main.isCaptured {
                action("录屏")
            }
            //捕获的屏幕状态发生变化时,会发送UIScreenCapturedDidChange通知,监听该通知
            NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: mainQueue) { _ in
                action("录屏")
            }
        }
    }
}

