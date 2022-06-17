//
//  UserDefaultsModel.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/6/12.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

struct UserDefaultsModel: Codable {
    /// 用户的
    var uid: Int = 0
    /// 用户的名字
    var name: String = ""
}
