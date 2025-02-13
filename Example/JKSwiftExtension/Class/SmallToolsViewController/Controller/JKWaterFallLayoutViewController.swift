//
//  JKWaterFallLayoutViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKWaterFallLayoutViewController: BaseViewController {
    var collectioView: UICollectionView!
    fileprivate let cellWithReuseIdentifier = "JKWaterFallLayoutCellWithReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、CollectionView流水布局"]
        dataArray = [["弹出布局", "随机高度"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、CollectionView流水布局
extension JKWaterFallLayoutViewController {
    
    // MARK: 1.02、随机高度
    @objc func test102() {
        let number = Int(arc4random()%150).jk.intToCGFloat
        debugPrint("\(number)")
    }
    
    // MARK: 1.01、弹出布局
    @objc func test101() {
        let layout = JKWaterFallLayout()
        layout.dataSource = self
        layout.cols = 3
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        collectioView = UICollectionView(frame: CGRect(x: 20, y: 20, width: jk_kScreenW - 40 - jk_kNavFrameH, height: 500), collectionViewLayout: layout)
        collectioView.jk.centerX = self.view.jk.centerX
        collectioView.delegate = self
        collectioView.dataSource = self
        collectioView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellWithReuseIdentifier)
        self.view.addSubview(collectioView)
    }
}

// MARK: - 一、CollectionView流水布局
extension JKWaterFallLayoutViewController: JKWaterFallLayoutDataSoure, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellWithReuseIdentifier, for: indexPath)
        cell.backgroundColor = .randomColor
        return cell
    }
    
    // 每个item的大小
    /*
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return CGSize(width: 50, height: 50)
     }
     */
    
    func waterfall(_ waterfall: JKWaterFallLayout, item: Int) -> CGFloat {
        return Int.jk.random(within: 60..<150).jk.intToCGFloat
    }
    
}

