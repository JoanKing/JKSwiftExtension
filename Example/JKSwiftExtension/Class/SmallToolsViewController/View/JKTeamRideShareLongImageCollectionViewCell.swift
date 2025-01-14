//
//  JKTeamRideShareLongImageCollectionViewCell.swift
//  JKScrollViewCard
//
//  Created by chongwang on 2025/1/6.
//

import UIKit
import SnapKit

class JKTeamRideShareLongImageCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        commonInit()
        changeTheme()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
}

// MARK: - 基本设置
extension JKTeamRideShareLongImageCollectionViewCell {
    
    private func initUI() {
        contentView.addSubview(testView)
    }
    
    private func commonInit() {
        testView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    
    private func changeTheme() {
        contentView.backgroundColor = .green
        
        layoutIfNeeded()
        
        testView.jk.addCorner(conrners: .allCorners, radius: 50)
    }
    
    /// 加载数据
    private func loadData() {
        
    }
}

