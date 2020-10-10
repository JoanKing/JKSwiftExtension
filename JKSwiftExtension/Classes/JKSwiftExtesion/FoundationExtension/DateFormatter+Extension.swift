//
//  DateFormatter+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import Foundation

extension DateFormatter {

    public convenience init(format: String) {
        self.init()
        dateFormat = format
    }
}
