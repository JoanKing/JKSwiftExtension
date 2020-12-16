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
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "1234")
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["移动 item"]]
    }
}

// MARK:- 一、基本的扩展
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1234", for: indexPath)
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
