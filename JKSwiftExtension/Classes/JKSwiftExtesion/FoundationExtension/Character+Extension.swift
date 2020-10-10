//
//  Character+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

extension Character {

    // MARK: Character 转 String
    /// Character 转 String
    public var toString: String { return String(self) }

    /// If the character represents an integer that fits into an Int, returns the corresponding integer.
    public var toInt: Int? { return Int(String(self)) }

    /// Checks if character is emoji
    var isEmoji: Bool {
        return String(self).includesEmoji()
    }
}
