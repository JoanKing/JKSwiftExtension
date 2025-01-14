//
//  JKTeamRideShareShortImageCollectionViewCell.swift
//  JKScrollViewCard
//
//  Created by chongwang on 2025/1/6.
//
import UIKit
import SnapKit

class JKTeamRideShareShortImageCollectionViewCell: UICollectionViewCell {
    
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
extension JKTeamRideShareShortImageCollectionViewCell {
    
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
        contentView.backgroundColor = .yellow
    }
    
    /// 加载数据
    private func loadData() {
        
    }
}
