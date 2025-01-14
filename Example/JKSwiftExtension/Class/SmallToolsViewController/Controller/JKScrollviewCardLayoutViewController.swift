//
//  JKScrollviewCardLayoutViewController.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2025/1/14.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension
import SnapKit

class JKScrollviewCardLayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .randomColor
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: jk_kSafeDistanceTop + 44, left: 0, bottom: 185 + jk_kSafeDistanceBottom, right: 0))
        }
        
    }
    
    /// UICollectionView
    lazy var collectionView: UICollectionView = {
        let layout = JKScrollviewCardLayout()
        layout.itemSize = CGSize(width: jk_kScreenW - 94, height: jk_kScreenH - jk_kSafeDistanceTop - 44 - 24 - 185 - jk_kSafeDistanceBottom)
    
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.register(JKTeamRideShareShortImageCollectionViewCell.self, forCellWithReuseIdentifier: "JKTeamRideShareShortImageCollectionViewCell")
        view.register(JKTeamRideShareLongImageCollectionViewCell.self, forCellWithReuseIdentifier: "JKTeamRideShareLongImageCollectionViewCell")
        view.backgroundColor = UIColor.red
        return view
    }()

}

// MARK: -- delegate and datasource
extension JKScrollviewCardLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JKTeamRideShareShortImageCollectionViewCell", for: indexPath) as! JKTeamRideShareShortImageCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JKTeamRideShareLongImageCollectionViewCell", for: indexPath) as! JKTeamRideShareLongImageCollectionViewCell
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pointInView = view.convert(collectionView.center, to: collectionView)
        let indexPathNow = collectionView.indexPathForItem(at: pointInView)
        let index = (indexPathNow?.row ?? 0) % 2
        let curIndexStr = String(format: "滚动至第%d张", index)
        debugPrint(curIndexStr)
    }
}

