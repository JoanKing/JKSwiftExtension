//
//  CharacterExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CharacterExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、Character 与其他类型的转换", "二、常用的属性和方法"]
        dataArray = [["Character 转 String", "Character 转 Int"], ["判断是不是 Emoji 表情"]]
    }
}

// MARK:- 二、常用的属性和方法
extension CharacterExtensionViewController {
    
    // MARK: 2.1、判断是不是 Emoji 表情
    @objc func test21() {
        let emoji: Character = "🙃"
        JKPrint("判断是不是 Emoji 表情", "\(emoji) 是不是emoji表情：\(emoji.isEmoji)")
    }
}

// MARK:- 一、Character 与其他类型的转换
extension CharacterExtensionViewController {
    
    // MARK: 1.1、Character 转 String
    @objc func test11() {
        let charater: Character = "a"
        JKPrint("Character 转 String", "\(charater) 转 String 后为 \(charater.toString)")
    }
    
    // MARK: 1.2、Character 转 Int
    @objc func test12() {
        let charater: Character = "f"
        JKPrint("Character 转 Int", "\(charater) 转 Int 后为 \(charater.toInt ?? 0)")
    }
}

