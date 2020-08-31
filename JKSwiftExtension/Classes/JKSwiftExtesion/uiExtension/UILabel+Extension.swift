//
//  UILabel+Extension.swift
//  XCar
//
//  Created by 王冲 on 2020/1/14.
//  Copyright © 2020 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
	
	/// 改变行间距
	/// - Parameter space: 行间距大小
	func changeLineSpace(space: CGFloat) {
		if self.text == nil || self.text == "" {
			return
		}
		let text = self.text
		let attributedString = NSMutableAttributedString(string: text!)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = space
		attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
		self.attributedText = attributedString
		self.sizeToFit()
	}

	/// 改变字间距
	/// - Parameter space: 字间距大小
	func changeWordSpace(space: CGFloat) {
		if self.text == nil || self.text == "" {
			return
		}
		let text = self.text
		let attributedString = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern:space])
		let paragraphStyle = NSMutableParagraphStyle()
		attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
		self.attributedText = attributedString
		self.sizeToFit()
	}

	/// 改变字间距和行间距
	/// - Parameters:
	///   - lineSpace: 行间距
	///   - wordSpace: 字间距
	func changeSpace(lineSpace: CGFloat, wordSpace: CGFloat) {
		if self.text == nil || self.text == "" {
			return
		}
		let text = self.text
		let attributedString = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern:wordSpace])
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = lineSpace
		attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
		self.attributedText = attributedString
		self.sizeToFit()
		
	}
}
