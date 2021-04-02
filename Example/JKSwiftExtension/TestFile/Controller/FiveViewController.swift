//
//  FiveViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Five"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
        
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        // 内容缩进为0（去除左右边距）
        textView.textContainer.lineFragmentPadding = 0
        // 文本边距设为0（去除上下边距）
        textView.textContainerInset = .zero
        textView.placeholderOrigin = CGPoint(x: 0, y: 0)
        textView.placeholdFont = UIFont.systemFont(ofSize: 16)
        textView.placeholder = "默认文本字体的大小：16默认文本字体的大小"
        self.view.addSubview(textView)
        textView.placeholdColor = .yellow
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(SixViewController(), animated: true)
    }
}
