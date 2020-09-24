//
//  UITableView+Extension.swift
//  JKLive
//
//  Created by IronMan on 2020/8/28.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

public extension UITableView {

    // MARK: tableView 在 iOS 11 上的适配
    /// tableView 在 iOS 11 上的适配
    func tableViewNeverAdjustContentInset() {
        if #available(iOS 11, *) {
            self.estimatedSectionFooterHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.contentInsetAdjustmentBehavior = .never
        }
    }
    
    // MARK: 是否滚动到底部
    /// 是否滚动到底部
    /// - Parameter animated: 是否要动画
    func scrollToBottom(animated: Bool) {
        let y = contentSize.height - frame.size.height
        if y < 0 { return }
        setContentOffset(CGPoint(x: 0, y: y), animated: animated)
        
    }
}
