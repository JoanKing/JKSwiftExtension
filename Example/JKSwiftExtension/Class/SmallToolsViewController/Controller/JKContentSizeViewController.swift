//
//  JKContentSizeViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKContentSizeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、文字内容的计算"]
        dataArray = [["返回文字的 size", "计算富文本的 size"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 一、文字内容的计算
extension JKContentSizeViewController {
    
    // MARK: 1.02、计算富文本的 size
    @objc func test102() {
        
        let font = UIFont.systemFont(ofSize: 16)
        
        let attributedString = NSMutableAttributedString(string: "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。").color(.green).font(font).kern(10)
        let size = JKContentSize.attributedStringSize(attributedString: attributedString, width: jk_kScreenW - 100, height: CGFloat(MAXFLOAT), font: font)
        
        let testView1 = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: size.height))
        testView1.backgroundColor = .brown
        testView1.numberOfLines = 0
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(5, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 1.01、返回文字的 size
    @objc func test101() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀😄😄😄😄😄鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。😄😄😄😄转圈"
        let font = UIFont.systemFont(ofSize: 22)
        let size = JKContentSize.textStringSize(string: testString, size: CGSize(width: 300, height: CGFloat(MAXFLOAT)), font: font)
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: 300, height: size.height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.backgroundColor = UIColor.randomColor
        testLabel.text = testString
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
}
