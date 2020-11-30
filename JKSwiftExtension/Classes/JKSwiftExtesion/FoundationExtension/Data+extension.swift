//
//  Data+extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/28.
//

import UIKit

public extension Data {

    var base64Encoded: String {
        return base64EncodedString(options: .lineLength64Characters)
    }
}
