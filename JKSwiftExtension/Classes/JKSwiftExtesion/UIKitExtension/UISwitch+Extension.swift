//
//  UISwitch+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

extension UISwitch {

    /// toggles Switch
    public func toggle() {
        self.setOn(!self.isOn, animated: true)
    }
}
