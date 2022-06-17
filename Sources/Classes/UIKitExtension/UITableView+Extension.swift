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
    
    // MARK: 1.8、给单个section整体cell加圆角
    /// 给单个section整体cell加圆角
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - fillColor: 整个cell的填充色
    ///   - cell: 透传cell
    ///   - indexPath: 透传indexPath
    ///   - insetByDx: cell距离左边的距离
    ///   - insetByDy: cell距离顶部的距离
    func addSectionCellCornerRadius(radius: CGFloat, fillColor: UIColor, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath, insetByDx: CGFloat, insetByDy: CGFloat = 0) {
        // 设置cell 背景色为透明
        cell.backgroundColor = UIColor.clear
        // 创建两个layer
        let normalLayer = CAShapeLayer()
        let selectLayer = CAShapeLayer()
        // 获取显示区域大小
        let bounds = cell.bounds.insetBy(dx: insetByDx, dy: insetByDy)
        // 获取每组行数
        let rowNum = self.base.numberOfRows(inSection: indexPath.section)
        // 贝塞尔曲线
        var bezierPath: UIBezierPath = UIBezierPath()
        if rowNum == 1 {
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        } else {
            if (indexPath.row == 0) {
                // 每组第一行（添加左上和右上的圆角）
                bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
            } else if (indexPath.row == rowNum - 1){
                // 每组最后一行（添加左下和右下的圆角）
                bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            } else {
                // 每组不是首位的行不设置圆角
                bezierPath = UIBezierPath(rect: bounds)
            }
        }
        // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
        normalLayer.path = bezierPath.cgPath
        selectLayer.path = bezierPath.cgPath
        
        let nomarBgView = UIView(frame: bounds)
        // 设置填充颜色
        normalLayer.fillColor = fillColor.cgColor
        // 添加图层到nomarBgView中
        nomarBgView.layer.insertSublayer(normalLayer, at: 0)
        nomarBgView.backgroundColor = UIColor.clear
        cell.backgroundView = nomarBgView
        // 此时圆角显示就完成了，但是如果没有取消cell的点击效果，还是会出现一个灰色的长方形的形状，再用上面创建的selectLayer给cell添加一个selectedBackgroundView
        let selectBgView = UIView(frame: bounds)
        selectLayer.fillColor = fillColor.cgColor
        selectBgView.layer.insertSublayer(selectLayer, at: 0)
        selectBgView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectBgView
    }
    
    //MARK: 1.9、每段的cell数量
    /// 每段的cell数量
    /// - Parameter section: 段落
    /// - Returns: cell数量
    func sectionOfRowNumber(section: Int) -> Int {
        return self.base.numberOfRows(inSection: section)
    }
    
    //MARK: 1.10、是否是每个section的最后一个cell
    /// 是否是每个section的最后一个cell
    /// - Parameter indexPath: 透传indexPath
    /// - Returns: 结果
    func isLastCell(cellForRowAt indexPath: IndexPath) -> Bool {
        return self.base.numberOfRows(inSection: indexPath.section) == indexPath.row + 1
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
