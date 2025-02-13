//
//  JKVVViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/7/29.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class JKVVViewController: UIViewController {
    var backClosure: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置当前视图控制器的外观为浅色模式
        overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .cN2
        
        debugPrint("当前 Trait Collection: \(traitCollection.userInterfaceStyle)")
        
        //        let array = ["4-20", "3-20"]
        //        let newArray = array.map { item -> [String: Int] in
        //            let itemArray = item.split(separator: "-")
        //            let typeValue = Int(itemArray[0]) ?? 20
        //            let tidValue = Int(itemArray[1]) ?? 0
        //            return ["type": typeValue, "tid": tidValue]
        //        }
        //        print(newArray) // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
        let linkDic = ["《用户协议》": "http://*",
                       "《隐私政策》": "http://*",]
        
        let protocolPolicyContent = "\t用户协议和隐私政策请您务必审值阅读、充分理解 “用户协议” 和 隐私政策, 各项条款，包括但不限于：为了向您提供即时通讯、内容分享等服务，我们需要收集您的设备信息、操作日志等个人信息。\n\t您可阅读《用户协议》和《隐私政策》了解详细信息。如果您同意，请点击 “同意” 开始接受我们的服务;"
        
        let paraStyle = NSMutableParagraphStyle()
        // 右对齐
        paraStyle.alignment = .left
        let attributedText = NSMutableAttributedString.createHighlightRichText(content: protocolPolicyContent, highlightRichTexts: linkDic.allKeys(), contentTextColor: UIColor.brown, contentFont: UIFont.systemFont(ofSize: 15), highlightRichTextColor: UIColor.blue, highlightRichTextFont: UIFont.systemFont(ofSize: 15), paraStyle: paraStyle)
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 200, height: 400))
        label.numberOfLines = 0
        label.attributedText = attributedText
        label.jk.addGestureTap { reco in
            (reco as? UITapGestureRecognizer)?.didTapLabelAttributedText(linkDic) {[weak self] text, url in
                guard let _ = self else {
                    return
                }
                debugPrint("\(text), \(url ?? "_")")
            }
        }
        self.view.addSubview(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.navigationController?.popViewController(animated: true)
        //backClosure?()
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // 处理 trait collection 的变化
        debugPrint("更新后的 Trait Collection: \(traitCollection.userInterfaceStyle)")
    }
}
