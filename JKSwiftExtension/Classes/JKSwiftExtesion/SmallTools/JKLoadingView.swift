//
//  JKLoadingView.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit
import SnapKit

class JKLoadingView: UIView {
    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 130, height: 130))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.73)
        view.layer.cornerRadius = 6
        return view
    }()

    let activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        activity.isHidden = false
        activity.startAnimating()
        return activity
    }()

    let lodingLabel: UILabel = {
        let aLabel = UILabel(frame: CGRect.zero)
        aLabel.textColor = UIColor.white
        aLabel.font = UIFont.systemFont(ofSize: 13.3)
        aLabel.textAlignment = NSTextAlignment.center
        aLabel.text = "正在加载..."
        aLabel.numberOfLines = 0
        return aLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configView() {
        addSubview(contentView)
        contentView.addSubview(activityView)
        contentView.addSubview(lodingLabel)
        contentView.snp.remakeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(130)
            make.height.greaterThanOrEqualTo(130)
        }
        activityView.snp.remakeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalToSuperview().offset(-20)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        lodingLabel.snp.makeConstraints { make in
            make.top.equalTo(activityView.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-20).priority(.high)
        }
    }
}
