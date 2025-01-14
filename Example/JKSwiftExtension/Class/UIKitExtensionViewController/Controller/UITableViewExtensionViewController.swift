//
//  UITableViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UITableViewExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本扩展", "二、链式编程"]
        dataArray = [["tableView 在 iOS 11 上的适配", "是否滚动到顶部", "是否滚动到底部", "滚动到什么位置（CGPoint）", "注册自定义cell", "注册Xib自定义cell", "创建UITableViewCell(注册后使用该方法)", "给单个section整体cell加圆角", "每段的cell数量", "是否是每个section的最后一个cell", "滚动 tableView 一段特定的距离"], ["设置 delegate 代理", "设置 dataSource 代理", "设置行高", "设置段头(sectionHeaderHeight)的高度", "设置段尾(sectionHeaderHeight)的高度", "设置一个默认cell高度", "设置默认段头(estimatedSectionHeaderHeight)高度", "设置默认段尾(estimatedSectionFooterHeight)高度", "设置分割线的样式", "设置 UITableView 的头部 tableHeaderView", "设置 UITableView 的尾部 tableFooterView", "滚动到第几个IndexPath", "滚动到第几个row、第几个section"]]
    }
}

// MARK: - 二、链式编程
extension UITableViewExtensionViewController {
    
    // MARK: 2.14、滚动到最近选中的cell（选中的cell消失在屏幕中，触发事件可以滚动到选中的cell）
    @objc func test214() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        self.view.addSubview(testTableView)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.scrollToNearestSelectedRow(at: .top, animated: true)
            JKAsyncs.asyncDelay(2, {
            }) {
                testTableView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.13、滚动到第几个row、第几个section
    @objc func test213() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        self.view.addSubview(testTableView)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.scroll(row: 2, section: 2, at: .middle, animated: true)
            JKAsyncs.asyncDelay(2, {
            }) {
                testTableView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.12、滚动到第几个IndexPath
    @objc func test212() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        self.view.addSubview(testTableView)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.scroll(to: IndexPath(row: 2, section: 2), at: .top, animated: true)
            JKAsyncs.asyncDelay(2, {
            }) {
                testTableView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.11、设置 UITableView 的尾部 tableFooterView
    @objc func test211() {
        let footView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        footView.backgroundColor = .brown
        
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.estimatedRowHeight(50).separatorStyle(.singleLine).tableFooterView(footView)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.10、设置 UITableView 的头部 tableHeaderView
    @objc func test210() {
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        headView.backgroundColor = .red
        
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.estimatedRowHeight(50).separatorStyle(.singleLine).tableHeaderView(headView)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.09、设置分割线的样式
    @objc func test209() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.estimatedRowHeight(50).separatorStyle(.singleLine)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.08、设置默认段尾(estimatedSectionFooterHeight)高度
    @objc func test208() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.estimatedRowHeight(50).estimatedSectionFooterHeight(20)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.07、设置默认段头(estimatedSectionHeaderHeight)高度
    @objc func test207() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.estimatedRowHeight(50).estimatedSectionHeaderHeight(20)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.06、设置一个默认cell高度
    @objc func test206() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.rowHeight(20).sectionFooterHeight(30).estimatedRowHeight(50)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.05、设置段尾(sectionHeaderHeight)的高度
    @objc func test205() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.rowHeight(20).sectionFooterHeight(30)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.04、设置段头(sectionHeaderHeight)的高度
    @objc func test204() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.rowHeight(20).sectionHeaderHeight(20)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.03、设置行高
    @objc func test203() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.rowHeight(20)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.02、设置 dataSource 代理
    @objc func test202() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
    
    // MARK: 2.01、设置 delegate 代理
    @objc func test201() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        testTableView.delegate(self)
        self.view.addSubview(testTableView)
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
}

// MARK: - 一、基本扩展
extension UITableViewExtensionViewController {
    
    //MARK: 1.11、滚动 tableView 一段特定的距离
    @objc func test111() {
        tableView.jk.scrollBy(distance: 100, animated: true, duration: 2)
        JKPrint("滚动 tableView 一段特定的距离")
    }
    
    //MARK: 1.10、是否是每个section的最后一个cell
    @objc func test110() {
        JKPrint("是否是每个section的最后一个cell", "我们创造一个IndexPath(row: 8, section: 0)", "它是都值当前section的最后一个cell：\(tableView.jk.isLastCell(cellForRowAt: IndexPath(row: 8, section: 0)))")
    }
    
    //MARK: 1.09、每段的cell数量
    @objc func test109() {
        JKPrint("每段的cell数量", "当前tableView的第0段section的row数量是：\(tableView.jk.sectionOfRowNumber(section: 0))")
    }
    
    // MARK: 1.08、给单个section整体cell加圆角
    @objc func test108() {
        JKPrint("给单个section整体cell加圆角")
        self.navigationController?.pushViewController(RadiusViewController(), animated: true)
    }
    
    // MARK: 1.07、创建UITableViewCell(注册后使用该方法)
    @objc func test107() {
        JKPrint("查看：BaseViewController 中TableView的创建里面有注册cell后使用该方法")
    }
    
    // MARK: 1.06、注册Xib自定义cell
    @objc func test106() {
        JKPrint("注册Xib自定义cell")
    }
    
    // MARK: 1.05、注册自定义cell
    @objc func test105() {
        JKPrint("查看：BaseViewController 中TableView的创建里面有注册cell")
    }
    
    // MARK: 1.04、滚动到什么位置（CGPoint）
    @objc func test104() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        self.view.addSubview(testTableView)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.jk.scrollToOffset(offsetX: 0, offsetY: 10, animated: true)
            JKAsyncs.asyncDelay(2, {
            }) {
                testTableView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.03、是否滚动到底部
    @objc func test103() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        self.view.addSubview(testTableView)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.jk.scrollToBottom(animated: true)
           JKAsyncs.asyncDelay(2, {
            }) {
                testTableView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.02、是否滚动到顶部
    @objc func test102() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        self.view.addSubview(testTableView)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.jk.scrollToTop(animated: true)
            JKAsyncs.asyncDelay(2, {
            }) {
                testTableView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.01、tableView 在 iOS 11 上的适配
    @objc func test101() {
        let testTableView = UITableView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testTableView.jk.tableViewNeverAdjustContentInset()
        testTableView.backgroundColor = .randomColor
        self.view.addSubview(testTableView)
        
        JKAsyncs.asyncDelay(2, {
        }) {
            testTableView.removeFromSuperview()
        }
    }
}

