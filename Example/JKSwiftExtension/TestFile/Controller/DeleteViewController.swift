//
//  DeleteViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/12/25.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension
class DeleteViewController: UIViewController {
    /// 资源数组
    var dataArray = [Any]()
    /// 资源数组
    var headDataArray = [Any]()
    /// 更多收藏的地点
    private lazy var moreLocationButton: UIButton = {
        var button = UIButton()
        button.setTitle("编辑", for: .normal)
        button.setTitle("完成", for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(UIColor.hexStringColor(hexString: "#2C2D2E"), for: .normal)
        button.setTitleColor(UIColor.hexStringColor(hexString: "#2C2D2E"), for: .selected)
        button.addTarget(self, action: #selector(editClick), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.jk.touchExtendInset = UIEdgeInsets(top: -15, left: -15, bottom: -15, right: -16)
        return button
    }()
    lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame:CGRect(x:0, y: 0, width: jk_kScreenW, height: jk_kScreenH - CGFloat(jk_kNavFrameH)), style:.grouped)
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.backgroundColor = UIColor.cBackViewColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = false
        tableView.allowsSelectionDuringEditing = false
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kTabbarBottom))
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        // 设置一个默认高度
        tableView.estimatedRowHeight = 80.0
        // 开启自适应
        tableView.rowHeight = UITableView.automaticDimension
        tableView.jk.register(cellClass: DeleteViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.cBackViewColor
        headDataArray = ["一、Date 基本的扩展", "二、时间格式的转换"]
        dataArray = [["获取当前 秒级 时间戳 - 10 位", "获取当前 毫秒级 时间戳 - 13 位", "获取当前的时间 Date", "从 Date 获取年份", "从 Date 获取月份", "从 Date 获取 日", "从 Date 获取 小时", "从 Date 获取 分钟", "从 Date 获取 秒", "从 Date 获取 毫秒", "从日期获取 星期(英文)", "从日期获取 星期(中文)", "从日期获取 月(英文)"], ["时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串 如：1603849053 按照 yyyy-MM-dd HH:mm:ss 转化后为：2020-10-28 09:37:33", "时间戳(支持 10 位 和 13 位) 转 Date", "Date 转换为相应格式的字符串", "带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致", "带格式的时间转 Date", "秒转换成播放时间条的格式", "Date 转 时间戳"]]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreLocationButton)
        view.addSubview(tableView)
    }
    
    //MARK: 编辑
    /// 编辑
    @objc func editClick(sender: UIButton) {
        debugPrint("编辑")
        tableView.isEditing = !sender.isSelected
        sender.isSelected = !sender.isSelected
        tableView.reloadData()
    }
}

extension DeleteViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        debugPrint("100000")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        debugPrint("1100000")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        debugPrint("1200000")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        debugPrint("1300000")
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        debugPrint("1400000")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        debugPrint("1500000")
    }
    
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        debugPrint("1700000")
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        debugPrint("1800000")
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        debugPrint("1900000")
       
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        debugPrint("12100000")
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        debugPrint("1200000")
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension DeleteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.jk.dequeueReusableCell(cellType: DeleteViewCell.self, cellForRowAt: indexPath)
        let singleDataArray = dataArray[indexPath.section] as! [String]
        // 去除选中时的颜色
        cell.selectionStyle = .none
        cell.contentLabel.text = "\(indexPath.row + 1)：\((singleDataArray[indexPath.row]))"
        cell.backgroundColor = .green
        let sectionFootView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 10))
        sectionFootView.backgroundColor = .red
        cell.selectedBackgroundView = sectionFootView
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let str = headDataArray[section] as! String
        let size = str.jk.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: jk_kScreenW - 20, height: CGFloat(MAXFLOAT)))
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height:size.height + 20))
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: jk_kScreenW - 20, height: size.height))
        label.text = str
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        sectionView.addSubview(label)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let str = headDataArray[section] as! String
        let size = str.jk.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: jk_kScreenW - 20, height: CGFloat(MAXFLOAT)))
        return size.height + 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFootView = UIView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: 0.01))
        return sectionFootView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //返回每一个行对应的事件按钮
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
            //创建“删除”事件按钮
            let delete = UITableViewRowAction(style: .normal, title: "删除") {
                action, index in
                //将对应条目的数据删除
                // self.items.remove(at: index.row)
                tableView.reloadData()
            }
            delete.backgroundColor = UIColor.red
             
            //返回所有的事件按钮
            return [delete]
    }
     
    //MARK: 提示：两个方法都写。低版本下设备肯定没有滑动触发行为。而到了 iOS11 设备下，新的接口方法又回自动覆盖老方法，所有也是没问题的
    //尾部滑动事件按钮（左滑按钮）
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
        indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //删除事件按钮
        let deleteEvent = UIContextualAction(style: .normal, title: nil) {[weak self]
            (action, view, completionHandler) in
            guard let _ = self else {
                return
            }
            //weakSelf.deleteFavoriteData(forRowAt: indexPath)
            completionHandler(true)
        }
        deleteEvent.image = UIImage(named: "favorite_delete")
        deleteEvent.backgroundColor = UIColor.red
        //返回所有的事件按钮
        let configuration = UISwipeActionsConfiguration(actions: [deleteEvent])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //deleteFavoriteData(forRowAt: indexPath)
        }
    }
    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            // 修改拖动的图片
            cell.subviews.forEach { view in
                if view.className.range(of: "UITableViewCellReorderControl", options: .caseInsensitive) != nil {
                    view.subviews.forEach { subView in
                        if subView.className == UIImageView().className {
                            let imgView = subView as! UIImageView
                            imgView.image = UIImage(named: "cell_drag")
                            imgView.contentMode = .center
                        }
                    }
                } else if view.className.range(of: "UITableViewCellEditControl", options: .caseInsensitive) != nil {
                    view.subviews.forEach { subView in
                        if subView.className == "UIImageView" {
                            let imgView = subView as! UIImageView
                            imgView.image = UIImage(named: "drag_delete")
                            imgView.contentMode = .center
                        }
                    }
                }
            }
        }
        tableView.jk.addSectionCellCornerRadius(radius: 10, fillColor: UIColor.white, willDisplay: cell, forRowAt: indexPath, insetByDx: 0)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        debugPrint("5555555")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("666666")
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        debugPrint("77777")
        return nil
    }
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        debugPrint("bbbbbb")
    }
    
    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        debugPrint("aaaaaaaaa")
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        debugPrint("编辑结束111")
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        debugPrint("编辑结束2222")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        debugPrint("编辑结束4444")
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        JKAsyncs.asyncDelay(0.1) {
        } _: {
            if var deleteView = tableView.jk.findSubView(childViewClassName: "UISwipeActionStandardButton") {
                deleteView.backgroundColor = .blue
                deleteView.layer.cornerRadius = 10
                deleteView.clipsToBounds = true
            }
            if var deleteView = tableView.jk.findSubView(childViewClassName: "UISwipeActionPullView") {
                deleteView.backgroundColor = .yellow
                deleteView.jk.height = 30
            }
        }

        debugPrint("编辑结束333")
    }
    
    /// 去除编辑模式下的头部缩进
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        // 不同的section不允许拖动，同一个sectio拖动后回到自己的位置也不能移动
        if (sourceIndexPath.section == proposedDestinationIndexPath.section && sourceIndexPath.row != proposedDestinationIndexPath.row) {
            return proposedDestinationIndexPath
        }
        return sourceIndexPath
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 改变了位置才进行移动的数据源操作(不是同一个section才可以拖动)
        guard sourceIndexPath.section == destinationIndexPath.section else { return }
        if sourceIndexPath.section == 0 {
            tableView.reloadData()
        } else {
            tableView.reloadData()
        }
    }
}
