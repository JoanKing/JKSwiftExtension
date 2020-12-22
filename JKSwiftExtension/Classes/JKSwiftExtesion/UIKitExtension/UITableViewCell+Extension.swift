//
//  UITableViewCell+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/12/17.
//

import UIKit

// MARK:- 一、基本的扩展
extension  UITableViewCell  {
    
    // MARK: 返回cell所在的UITableView
    /// 返回cell所在的UITableView
    /// - Returns: cell 所在的UITableView
    func superTableView() -> UITableView? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView  {
                return tableView
            }
        }
        return nil
    }
}
