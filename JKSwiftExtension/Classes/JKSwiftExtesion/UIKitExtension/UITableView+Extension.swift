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

// MARK:- 链式编程
public extension UITableView {
    @discardableResult
    func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    @discardableResult
    func dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    @discardableResult
    func rowHeight(_ height: CGFloat) -> Self {
        self.rowHeight = height
        return self
    }
    @discardableResult
    func sectionFooterHeight(_ height: CGFloat) -> Self {
        self.sectionFooterHeight = height
        return self
    }
    @discardableResult
    func sectionHeaderHeight(_ height: CGFloat) -> Self {
        self.sectionHeaderHeight = height
        return self
    }
    @discardableResult
    func estimatedRowHeight(_ height: CGFloat) -> Self {
        self.estimatedRowHeight = height
        return self
    }
    @discardableResult
    func estimatedSectionHeaderHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionHeaderHeight = height
        return self
    }
    @discardableResult
    func estimatedSectionFooterHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionFooterHeight = height
        return self
    }
    @discardableResult
    func scroll(to indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition = .middle, animated: Bool = true) -> Self {
        if indexPath.section < 0 || indexPath.row < 0 || indexPath.section > self.numberOfSections || indexPath.row > self.numberOfRows (inSection: indexPath.section) {
            return self
        }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
        return self
    }
    @discardableResult
    func scroll(row: Int, section: Int = 0, at scrollPosition: UITableView.ScrollPosition = .middle, animated: Bool = true) -> Self {
        return scroll(to: IndexPath.init(row: row, section: section), at: scrollPosition, animated: animated)
    }
    @discardableResult
    func scrollToNearestSelectedRow(scrollPosition: UITableView.ScrollPosition = .middle, animated: Bool = true) -> Self {
        scrollToNearestSelectedRow(at: scrollPosition, animated: animated)
        return self
    }
    @discardableResult
    func separatorStyle(_ style: UITableViewCell.SeparatorStyle = .none) -> Self {
        self.separatorStyle = style
        return self
    }
    @discardableResult
    func tableHeaderView(_ head: UIView?) -> Self {
        self.tableHeaderView = head
        return self
    }
    @discardableResult
    func tableFooterView(_ foot: UIView?) -> Self {
        self.tableFooterView = foot
        return self
    }
}
