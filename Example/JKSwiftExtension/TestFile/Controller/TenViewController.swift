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
        textView.placeholdFont = UIFont.systemFont(ofSize: 16)
        textView.placeholdColor = .green
        textView.placeholderOrigin = CGPoint(x: 1, y: 7)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.placeholder = "请输入文字"
        textView.delegate = self
        return textView
    }()

    lazy var showLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: kScreenW / 3.0 - 15 - 5, height: 19))
        label.backgroundColor = .yellow
        label.font = UIFont.jk.customFontSB(15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.brown
        label.minimumScaleFactor = 11 / 15
        return label
    }()
    
    lazy var showLabel2: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: resetButton.jk.bottom + 20, width: kScreenW / 3.0 - 15 - 5, height: 19))
        label.backgroundColor = .yellow
        label.font = UIFont.jk.customFontSB(15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 11 / 15
        label.textColor = UIColor.brown
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(frame: CGRect(x: (kScreenW - 100) / 2.0, y: writeTextView.jk.bottom + 50, width: 100, height: 50))
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
        let content = textView.text ?? ""
        print("输入的内容：\(content)")
        let newContent = JKContentSize.linesCountAndLinesContent(content: content, font: UIFont.jk.customFontSB(15), width: kScreenW / 3.0 - 15 - 5, height: 10, minimumScaleFactor: 11 / 15).1?.first ?? ""
        showLabel2.text = content
        showLabel.text = newContent
        print("第一行的内容：\(newContent)")
    }
    
    @objc func click() {
        let content = "17 Education & Techology Group incorporation"
        /*
        showLabel2.text = content
        let s = showLabel2.jk.linesCountAndLinesContent().1?.first ?? ""
        showLabel.text = s
        print("第一行的内容：\(s)")
        */
        let newContent = JKContentSize.linesCountAndLinesContent(content: content, font: UIFont.jk.customFontSB(15), width: kScreenW / 3.0 - 15 - 5, height: 10, minimumScaleFactor:11 / 15).1?.first ?? ""
        showLabel2.text = content
        showLabel.text = newContent
        print("第一行的内容：\(newContent)")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
