//
//  UICollectionViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UICollectionViewExtensionViewController: BaseViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
   
        let collection = UICollectionView(frame: CGRect(x: 10, y: 150, width: 200, height: 300), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.jk.register(cellClass: UICollectionViewCell.self)
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、滚动和注册"]
        dataArray = [["移动 item"], ["是否滚动到顶部", "是否滚动到底部", "滚动到什么位置（CGPoint）", "注册自定义cell", "注册Xib自定义cell", "创建UITableViewCell(注册后使用该方法)", "创建Section 的Header或者Footer(注册后使用该方法)"]]
    }
}

// MARK: - 二、滚动和注册
extension UICollectionViewExtensionViewController {
    
    // MARK: 2.8、创建Section 的Header或者Footer(注册后使用该方法)
    @objc func test28() {
        
    }
    
    // MARK: 2.7、注册自定义: Section 的Header或者Footer
    @objc func test27() {
        
    }
    
    // MARK: 2.6、创建UITableViewCell(注册后使用该方法)
    @objc func test26() {
        
    }
    
    // MARK: 2.5、注册Xib自定义cell
    @objc func test25() {
        let nib = UINib(nibName: "Xib的名字", bundle: nil)
        collectionView.jk.register(nib: nib)
    }
    
    // MARK: 2.4、注册自定义cell
    @objc func test24() {
        collectionView.jk.register(cellClass: UICollectionViewCell.self)
    }
    
    // MARK: 2.3、滚动到什么位置（CGPoint）
    @objc func test23() {
        collectionView.jk.scrollToOffset(offsetX: 20, offsetY: 100, animated: true)
    }
    
    // MARK: 2.2、是否滚动到底部
    @objc func test22() {
        collectionView.jk.scrollToBottom(animated: true)
    }
    
    // MARK: 2.1、是否滚动到顶部
    @objc func test21() {
        collectionView.jk.scrollToTop(animated: true)
    }
}

// MARK: - 一、基本的扩展
extension UICollectionViewExtensionViewController {
    
    // MARK: 1.1、移动 item
    @objc func test11() {
        self.view.addSubview(collectionView)
        collectionView.allowsMoveItem()
    }
}

extension UICollectionViewExtensionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.jk.dequeueReusableCell(cellType: UICollectionViewCell.self, cellForRowAt: indexPath)
        cell.backgroundColor = .randomColor
        return cell
    }
    
    // MARK: 能否移动
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: 移动cell结束
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath)
        print(destinationIndexPath)
        // 修改数据源
        // let temp = self.data[sourceIndexPath.section].remove(at: sourceIndexPath.item)
        // self.data[destinationIndexPath.section].insert(temp, at: destinationIndexPath.item)
        // print(self.data)
    }
}
