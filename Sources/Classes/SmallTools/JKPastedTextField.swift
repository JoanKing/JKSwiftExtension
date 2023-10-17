//
//  JKPastedTextField.swift
//  JKSwiftExtension
//
//  Created by 小冲冲 on 2023/10/12.
//

import UIKit

public class JKPastedTextField: UITextField {
    /// 是否正在复制
    public var isPasting = false
    
    public override func paste(_ sender: Any?) {
        super.paste(sender)
        isPasting = true
    }
}

