//
//  UIScreen+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

extension UIScreen {

    /// Returns screen width
    public static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    /// Returns screen height
    public static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    /// Calls action when a screen shot is taken
    public static func detectScreenShot(_ action: @escaping () -> Void) {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: mainQueue) { _ in
            // executes after screenshot
            action()
        }
    }

}

