//
//  JKRollingNoticeViewCell2.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/5/16.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class JKRollingNoticeViewCell2: JKNoticeViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func noticeCellData(name: String) {
        contentLabel.text = name
    }
}
