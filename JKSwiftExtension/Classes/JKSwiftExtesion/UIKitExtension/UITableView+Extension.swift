//
//  UITableView+Extension.swift
//  JKLive
//
//  Created by IronMan on 2020/8/28.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

// MARK: - 一、基本的扩展
public extension JKPOP where Base: UITableView {

    // MARK: 1.1、tableView 在 iOS 11 上的适配
    /// tableView 在 iOS 11 上的适配
    func tableViewNeverAdjustContentInset() {
        if #available(iOS 11, *) {
            self.base.estimatedRowHeight = 0
            self.base.estimatedSectionFooterHeight = 0
            self.base.estimatedSectionHeaderHeight = 0
            self.base.contentInsetAdjustmentBehavior = .never
        }
    }
    
    // MARK: 1.2、是否滚动到顶部
    /// 是否滚动到顶部
    /// - Parameter animated: 是否要动画
    func scrollToTop(animated: Bool) {
        base.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    
    // MARK: 1.3、是否滚动到底部
    /// 是否滚动到底部
    /// - Parameter animated: 是否要动画
    func scrollToBottom(animated: Bool) {
        let y = base.contentSize.height - base.frame.size.height
        if y < 0 { return }
        base.setContentOffset(CGPoint(x: 0, y: y), animated: animated)
    }
    
    // MARK: 1.4、滚动到什么位置（CGPoint）
    /// 滚动到什么位置（CGPoint）
    /// - Parameter animated: 是否要动画
    func scrollToOffset(offsetX: CGFloat = 0, offsetY: CGFloat = 0, animated: Bool) {
        base.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: animated)
    }
    
    // MARK: 1.5、注册自定义cell
    /// 注册自定义cell
    /// - Parameter cellClass: UITableViewCell类型
    func register(cellClass: UITableViewCell.Type) {
        base.register(cellClass.self, forCellReuseIdentifier: cellClass.className)
    }
    
    // MARK: 1.6、注册Xib自定义cell
    /// 注册Xib自定义cell
    /// - Parameter nib: nib description
    func register(nib: UINib) {
        base.register(nib, forCellReuseIdentifier: nib.className)
    }
    
    // MARK: 1.7、创建UITableViewCell(注册后使用该方法)
    /// 创建UITableViewCell(注册后使用该方法)
    /// - Parameters:
    ///   - cellType: UITableViewCell类型
    ///   - indexPath: indexPath description
    /// - Returns: 返回UITableViewCell类型
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, cellForRowAt indexPath: IndexPath) -> T {
        return base.dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as! T
    }
}

// MARK: - 二、链式编程
public extension UITableView {
    
    // MARK: 2.1、设置 delegate 代理
    /// 设置 delegate 代理
    /// - Parameter delegate: delegate description
    /// - Returns: 返回自身
    @discardableResult
    func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    // MARK: 2.2、设置 dataSource 代理
    /// 设置 dataSource 代理
    /// - Parameter dataSource: dataSource description
    /// - Returns: 返回自身
    @discardableResult
    func dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    // MARK: 2.3、设置行高
    /// 设置行高
    /// - Parameter height: 行高
    /// - Returns: 返回自身
    @discardableResult
    func rowHeight(_ height: CGFloat) -> Self {
        self.rowHeight = height
        return self
    }
    
    // MARK: 2.4、设置段头(sectionHeaderHeight)的高度
    /// 设置段头(sectionHeaderHeight)的高度
    /// - Parameter height: 段头的高度
    /// - Returns: 返回自身
    @discardableResult
    func sectionHeaderHeight(_ height: CGFloat) -> Self {
        self.sectionHeaderHeight = height
        return self
    }
    
    // MARK: 2.5、设置段尾(sectionHeaderHeight)的高度
    /// 设置段尾(sectionHeaderHeight)的高度
    /// - Parameter height: 段尾的高度
    /// - Returns: 返回自身
    @discardableResult
    func sectionFooterHeight(_ height: CGFloat) -> Self {
        self.sectionFooterHeight = height
        return self
    }
    
    // MARK: 2.6、设置一个默认cell高度
    /// 设置一个默认cell高度
    /// - Parameter height: 默认cell高度
    /// - Returns: 返回自身
    @discardableResult
    func estimatedRowHeight(_ height: CGFloat) -> Self {
        self.estimatedRowHeight = height
        return self
    }
    
    // MARK: 2.7、设置默认段头(estimatedSectionHeaderHeight)高度
    /// 设置默认段头(estimatedSectionHeaderHeight)高度
    /// - Parameter height: 段头高度
    /// - Returns: 返回自身
    @discardableResult
    func estimatedSectionHeaderHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionHeaderHeight = height
        return self
    }
    
    // MARK: 2.8、设置默认段尾(estimatedSectionFooterHeight)高度
    /// 设置默认段尾(estimatedSectionFooterHeight)高度
    /// - Parameter height: 段尾高度
    /// - Returns: 返回自身
    @discardableResult
    func estimatedSectionFooterHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionFooterHeight = height
        return self
    }
    
    // MARK: 2.9、设置分割线的样式
    /// 设置分割线的样式
    /// - Parameter style: 分割线的样式
    /// - Returns: 返回自身
    @discardableResult
    func separatorStyle(_ style: UITableViewCell.SeparatorStyle = .none) -> Self {
        self.separatorStyle = style
        return self
    }
    
    // MARK: 2.10、设置 UITableView 的头部 tableHeaderView
    /// 设置 UITableView 的头部 tableHeaderView
    /// - Parameter head: 头部 View
    /// - Returns: 返回自身
    @discardableResult
    func tableHeaderView(_ head: UIView?) -> Self {
        self.tableHeaderView = head
        return self
    }
    
    // MARK: 2.11、设置 UITableView 的尾部 tableFooterView
    /// 设置 UITableView 的尾部 tableFooterView
    /// - Parameter foot: 尾部 View
    /// - Returns: 返回自身
    @discardableResult
    func tableFooterView(_ foot: UIView?) -> Self {
        self.tableFooterView = foot
        return self
    }

    // MARK: 2.12、滚动到第几个IndexPath
    /// 滚动到第几个IndexPath
    /// - Parameters:
    ///   - indexPath: 第几个IndexPath
    ///   - scrollPosition: 滚动的方式
    ///   - animated: 是否要动画
    /// - Returns: 返回自身
    @discardableResult
    func scroll(to indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition = .middle, animated: Bool = true) -> Self {
        if indexPath.section < 0 || indexPath.row < 0 || indexPath.section > self.numberOfSections || indexPath.row > self.numberOfRows (inSection: indexPath.section) {
            return self
        }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
        return self
    }
    
    // MARK: 2.13、滚动到第几个row、第几个section
    /// 滚动到第几个row、第几个section
    /// - Parameters:
    ///   - row: 第几 row
    ///   - section: 第几 section
    ///   - scrollPosition: 滚动的方式
    ///   - animated: 是否要动画
    /// - Returns: 返回自身
    @discardableResult
    func scroll(row: Int, section: Int = 0, at scrollPosition: UITableView.ScrollPosition = .middle, animated: Bool = true) -> Self {
        return scroll(to: IndexPath(row: row, section: section), at: scrollPosition, animated: animated)
    }
    
    // MARK: 2.14、滚动到最近选中的cell（选中的cell消失在屏幕中，触发事件可以滚动到选中的cell）
    /// 滚动到最近选中的cell（选中的cell消失在屏幕中，触发事件可以滚动到选中的cell）
    /// - Parameters:
    ///   - scrollPosition: 滚动的方式
    ///   - animated: 是否要动画
    /// - Returns: 返回自身
    @discardableResult
    func scrollToNearestSelectedRow(scrollPosition: UITableView.ScrollPosition = .middle, animated: Bool = true) -> Self {
        scrollToNearestSelectedRow(at: scrollPosition, animated: animated)
        return self
    }
}
