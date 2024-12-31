//
//  TenViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/5/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TenViewController: UIViewController, UITextViewDelegate {
    
    lazy var writeTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 100, y: 150, width: 200, height: 200))
        textView.backgroundColor = .brown
        textView.textColor = .white
//        textView.jk.placeholdFont = UIFont.systemFont(ofSize: 16)
//        textView.jk.placeholdColor = .green
//        textView.jk.placeholderOrigin = CGPoint(x: 1, y: 7)
//        textView.font = UIFont.systemFont(ofSize: 16)
//        textView.jk.placeholder = "请输入文字"
        textView.delegate = self
        return textView
    }()

    lazy var showLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: jk_kScreenW / 3.0 - 15 - 5, height: 19))
        label.backgroundColor = .yellow
        label.font = UIFont.jk.pingFangSB(15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.brown
        label.minimumScaleFactor = 11 / 15
        return label
    }()
    
    lazy var showLabel2: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: resetButton.jk.bottom + 20, width: jk_kScreenW / 3.0 - 15 - 5, height: 19))
        label.backgroundColor = .yellow
        label.font = UIFont.jk.pingFangSB(15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 11 / 15
        label.textColor = UIColor.brown
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(frame: CGRect(x: (jk_kScreenW - 100) / 2.0, y: writeTextView.jk.bottom + 50, width: 100, height: 50))
        button.setTitle("重置", for: .normal)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.backgroundColor = .randomColor
        return button
    }()
    
    // Thujhgggncxvbbccbvvh
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(showLabel)
        self.view.addSubview(showLabel2)
        self.view.addSubview(writeTextView)
        self.view.addSubview(resetButton)
        // linesCountAndLinesContent
    }
    
    func textViewDidChange(_ textView: UITextView) {
       
    }
    
    @objc func click() {
      
    }
    
    func getFontSizeForLabel(_ label: UILabel) -> CGFloat {
        let text: NSMutableAttributedString = NSMutableAttributedString(attributedString: label.attributedText!)
        text.setAttributes([NSAttributedString.Key.font: label.font as Any], range: NSMakeRange(0, text.length))
        let context: NSStringDrawingContext = NSStringDrawingContext()
        context.minimumScaleFactor = label.minimumScaleFactor
        text.boundingRect(with: label.frame.size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: context)
        let adjustedFontSize: CGFloat = label.font.pointSize * context.actualScaleFactor
        return adjustedFontSize
    }


}
