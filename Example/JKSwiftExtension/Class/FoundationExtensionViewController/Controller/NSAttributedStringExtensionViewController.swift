//
//  NSAttributedStringExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/31.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NSAttributedStringExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、文本设置的基本扩展", "二、富文本的一些计算"]
        dataArray = [
            ["设置特定区域的字体大小", "设置特定文字的字体大小", "设置特定区域的字体颜色", "设置特定文字的字体颜色", "设置特定区域行间距", "设置特定文字行间距", "设置特定文字区域的下划线", "设置特定文字的下划线", "设置特定区域的删除线", "设置特定文字的删除线", "插入图片", "首行缩进", "设置特定区域的多个字体属性", "设置特定文字的多个字体属性"],
            ["计算富文本的宽度", "计算富文本的高度", "计算富文本的Size"]
        ]
    }
}

// MARK: - 二、富文本的一些计算
extension NSAttributedStringExtensionViewController {
    
    // MARK: 2.3、计算富文本的size
    @objc func test23() {
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为20
        paraph.lineSpacing = 4
        // 剧中显示
        paraph.alignment = .left
        // 样式属性集合
        // 正值上偏，负值下偏
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: "用我三生烟火,换你一世迷离。", attributes: attributes)
        let attributedStringSize = attributedString.jk.sizeOfAttributedString(size: CGSize(width: 100, height: CGFloat(MAXFLOAT)))
        let testLabel = UILabel(frame: CGRect(x: 20, y: 50, width: 100, height: attributedStringSize.height))
        testLabel.backgroundColor = .yellow
        testLabel.numberOfLines = 0
        testLabel.attributedText = attributedString
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.2、计算富文本的高度
    @objc func test22() {
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为20
        paraph.lineSpacing = 4
        // 剧中显示
        paraph.alignment = .left
        // 样式属性集合
        // 正值上偏，负值下偏
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: "* If you are passionate about something, pursue it, no matter what any", attributes: attributes)
        
        let testLabel = UILabel(frame: CGRect(x: 20, y: 50, width: 100, height: attributedString.jk.heightOfAttributedString(size: CGSize(width: 100, height: CGFloat(MAXFLOAT)))))
        testLabel.backgroundColor = .yellow
        testLabel.numberOfLines = 0
        testLabel.attributedText = attributedString
        self.view.addSubview(testLabel)
    }
    
    // MARK: 2.1、计算富文本的宽度
    @objc func test21() {
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为20
        paraph.lineSpacing = 4
        // 剧中显示
        paraph.alignment = .left
        // 样式属性集合
        // 正值上偏，负值下偏
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: "* If you are", attributes: attributes)
        let attributedStringWidth = attributedString.jk.widthOfAttributedString(size: CGSize(width: CGFloat(MAXFLOAT), height: 30))
        let testLabel = UILabel(frame: CGRect(x: 20, y: 50, width: attributedStringWidth, height: 30))
        testLabel.backgroundColor = .yellow
        testLabel.numberOfLines = 0
        testLabel.attributedText = attributedString
        self.view.addSubview(testLabel)
    }
}

// MARK: - 一、文本设置的基本扩展
extension NSAttributedStringExtensionViewController {
    
    // MARK: 1.1、
    @objc func test11() {
       
    }
}
