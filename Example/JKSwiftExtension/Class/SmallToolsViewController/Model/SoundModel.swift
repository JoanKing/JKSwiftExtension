//
//  SoundModel.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/3/14.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class SoundModel: NSObject {
    /// 名字
    var name: String = ""
    /// 1-63的需要，达到63后从1开始，指令全部(有值的音效槽)发送
    var sound_weight: Int = 1
}
