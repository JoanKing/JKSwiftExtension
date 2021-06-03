//
//  TestViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    /// 消息的数量
    fileprivate var messageCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    /// html 富文本设置
    /// - Parameters:
    ///   - str: html 未处理的字符串
    ///   - font: 设置字体
    ///   - lineSpacing: 设置行高
    /// - Returns: 默认不将 \n替换<br/> 返回处理好的富文本
    func setAttributedString(_ str: String?, font: UIFont? = UIFont.systemFont(ofSize: 16), lineSpacing: CGFloat? = 10) -> NSMutableAttributedString? {
      var str = str
      //如果有换行，把\n替换成<br/>
      //如果有需要请去掉注释 // .replacingOccurrences(of: "\n", with: "<br/>")
      //利用 CSS 设置HTML图片的宽度
      str = "<head><style>img{width:\(1 * 0.97) !important;height:auto}</style></head>\(str ?? "")" //.replacingOccurrences(of: "\n", with: "<br/>")
      var htmlString: NSMutableAttributedString? = nil
      do {
        if let data = str?.data(using: .utf8) {
          htmlString = try NSMutableAttributedString(data: data, options: [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
          ], documentAttributes: nil)
        }
      } catch {
      }
      //设置富文本字的大小
      if let font = font {
        htmlString?.addAttributes([
          NSAttributedString.Key.font: font
        ], range: NSRange(location: 0, length: htmlString?.length ?? 0))
      }
      //设置行间距
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = lineSpacing!
      htmlString?.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: htmlString?.length ?? 0))
      
      return htmlString
      
    }
    
    @objc func clickk() {
        print("哈哈")
    }
    
    @objc func click1() {
        
    }
    
    @objc func click2() {
        
    }
    
    
    
}
