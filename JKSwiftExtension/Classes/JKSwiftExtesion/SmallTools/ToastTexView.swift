//
//  ToastTexView.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

import UIKit
class ToastTexView: UIView {
    let contentView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.73)
        view.layer.cornerRadius = 6
        return view
    }()

    let textLable: UILabel = {
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
        contentView.addSubview(textLable)
        contentView.snp.remakeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        textLable.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(UIScreen.main.bounds.size.width - 80)
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20))
        }
    }
}
