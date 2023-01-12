//
//  DeleteViewCell.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/12/25.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension

class DeleteViewCell: UITableViewCell {

    var lineView: UIView = {
           let view = UIView()
        view.backgroundColor = UIColor.cN4
           return view
       }()
    /// 文本的展示
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.cN1
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        // self.selectionStyle = .none
        // self.backgroundColor = .blue
        self.contentView.backgroundColor = .red
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(lineView)
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10))
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
            make.height.equalTo(jk_kPixel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("contentView：\(contentView.frame)")
        customDragImgIcon()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        //print("嘿嘿11111")
        customDragImgIcon()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        //print("嘿嘿22222")
        customDragImgIcon()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        //print("嘿嘿3333")
        customDragImgIcon()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        //print("嘿嘿44444")
        customDragImgIcon()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        customDragImgIcon()
    }
    
    func customDragImgIcon() {
        for view in subviews where view.description.contains("Reorder") {
            for case let subview as UIImageView in view.subviews {
                subview.image = UIImage(named: "cell_drag")
                subview.contentMode = .center
            }
        }
        for view in subviews where view.description.contains("UITableViewCellEditControl") {
            for case let subview as UIImageView in view.subviews {
                subview.image = UIImage(named: "drag_delete")
                subview.contentMode = .center
            }
        }
    }
    
    override func didTransition(to state: UITableViewCell.StateMask) {
        super.didTransition(to: state)
        //print("嘿嘿")
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        customDragImgIcon()
    }
    
    @available(iOS 11.0, *)
    override func dragStateDidChange(_ dragState: UITableViewCell.DragState) {
        super.dragStateDidChange(dragState)
        print("哈哈哈")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isEditing {
            
            self.contentView.backgroundColor = .blue
        } else {
            self.contentView.backgroundColor = .brown
        }
    }
}
