//
//  NSAttributedString+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/12/31.
//

import Foundation
import UIKit

extension NSAttributedString: JKPOPCompatible {}

// MARK: - 一、文本设置的基本扩展
public extension JKPOP where Base: NSAttributedString {
    
    // MARK: 1.1、设置特定区域的字体大小
    /// 设置特定区域的字体大小
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域
    /// - Returns: 返回设置后的富文本
    func setRangeFontText(font: UIFont, range: NSRange) -> NSAttributedString {
        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.font : font], range: range)
    }
    
    // MARK: 1.2、设置特定文字的字体大小
    /// 设置特定文字的字体大小
    /// - Parameters:
    ///   - text: 特定文字
    ///   - font: 字体
    /// - Returns: 返回设置后的富文本
    func setSpecificTextFont(_ text: String, font: UIFont) -> NSAttributedString {
        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.font : font])
    }
    
    // MARK: 1.3、设置特定区域的字体颜色
    /// 设置特定区域的字体颜色
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - range: 区域
    /// - Returns: 返回设置后的富文本
    func setSpecificRangeTextColor(color: UIColor, range: NSRange) -> NSAttributedString {
        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.foregroundColor : color], range: range)
    }
    
    // MARK: 1.4、设置特定文字的字体颜色
    /// 设置特定文字的字体颜色
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 字体颜色
    /// - Returns: 返回设置后的富文本
    func setSpecificTextColor(_ text: String, color: UIColor) -> NSAttributedString {
        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    // MARK: 1.5、设置特定区域行间距
    /// 设置特定区域行间距
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - alignment: 对齐方式
    ///   - range: 区域
    /// - Returns: 返回设置后的富文本
    func setSpecificRangeTextLineSpace(lineSpace: CGFloat, alignment: NSTextAlignment, range: NSRange) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = alignment
        
        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle], range: range)
    }
    
    // MARK: 1.6、设置特定文字行间距
    /// 设置特定文字行间距
    /// - Parameters:
    ///   - text: 特定的文字
    ///   - lineSpace: 行间距
    ///   - alignment: 对齐方式
    /// - Returns: 返回设置后的富文本
    func setSpecificTextLineSpace(_ text: String, lineSpace: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = alignment
        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // MARK: 1.7、设置特定区域的下划线
    /// 设置特定区域的下划线
    /// - Parameters:
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    ///   - range: 特定区域范围
    /// - Returns: 返回设置后的富文本
    func setSpecificRangeUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange) -> NSAttributedString {
        // 下划线样式
        let lineStytle = NSNumber(value: Int8(stytle.rawValue))
        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.underlineStyle: lineStytle, NSAttributedString.Key.underlineColor: color], range: range)
    }
    
    // MARK: 1.8、设置特定文字的下划线
    /// 设置特定文字的下划线
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    /// - Returns: 返回设置后的富文本
    func setSpecificTextUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single) -> NSAttributedString {
        // 下划线样式
        let lineStytle = NSNumber(value: Int8(stytle.rawValue))
        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.underlineStyle : lineStytle, NSAttributedString.Key.underlineColor: color])
    }
    
    // MARK: 1.9、设置特定区域的删除线
    /// 设置特定区域的删除线
    /// - Parameters:
    ///   - color: 删除线颜色
    ///   - range: 范围
    /// - Returns: 返回设置后的富文本
    func setSpecificRangeDeleteLine(color: UIColor, range: NSRange) -> NSAttributedString {
        var attributes = Dictionary<NSAttributedString.Key, Any>()
        // 删除线样式
        let lineStytle = NSNumber(value: Int8(NSUnderlineStyle.single.rawValue))
        attributes[NSAttributedString.Key.strikethroughStyle] = lineStytle
        attributes[NSAttributedString.Key.strikethroughColor] = color
        
        let version = UIDevice.jk.currentSystemVersion as NSString
        if version.floatValue >= 10.3 {
            attributes[NSAttributedString.Key.baselineOffset] = 0
        }
        return setSpecificRangeTextMoreAttributes(attributes: attributes, range: range)
    }
    
    // MARK: 1.10、设置特定文字的删除线
    /// 设置特定文字的删除线
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 删除线颜色
    /// - Returns: 返回设置后的富文本
    func setSpecificTextDeleteLine(_ text: String, color: UIColor) -> NSAttributedString {
        var attributes = Dictionary<NSAttributedString.Key, Any>()
        // 删除线样式
        let lineStytle = NSNumber(value: Int8(NSUnderlineStyle.single.rawValue))
        attributes[NSAttributedString.Key.strikethroughStyle] = lineStytle
        attributes[NSAttributedString.Key.strikethroughColor] = color
        
        let version = UIDevice.jk.currentSystemVersion as NSString
        if version.floatValue >= 10.3 {
            attributes[NSAttributedString.Key.baselineOffset] = 0
        } 
        return setSpecificTextMoreAttributes(text, attributes: attributes)
    }
    
    // MARK: 1.11、插入图片
    /// 插入图片
    /// - Parameters:
    ///   - imgName: 要添加的图片名称，如果是网络图片，需要传入完整路径名，且imgBounds必须传值
    ///   - imgBounds: 图片的大小，默认为.zero，即自动根据图片大小设置，并以底部基线为标准。 y > 0 ：图片向上移动；y < 0 ：图片向下移动
    ///   - imgIndex: 图片的位置，默认放在开头
    /// - Returns: 返回设置后的富文本
    func insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self.base)
        // NSTextAttachment可以将要插入的图片作为特殊字符处理
        let attch = NSTextAttachment()
        attch.image = loadImage(imageName: imgName)
        attch.bounds = imgBounds
        // 创建带有图片的富文本
        let string = NSAttributedString(attachment: attch)
        // 将图片添加到富文本
        attributedString.insert(string, at: imgIndex)
        return attributedString
    }
    
    // MARK: 1.12、首行缩进
    /// 首行缩进
    /// - Parameter edge: 缩进宽度
    /// - Returns: 返回设置后的富文本
    func firstLineLeftEdge(_ edge: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = edge
        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: self.base.length))
    }
    
    // MARK: 1.13、设置特定区域的多个字体属性
    /// 设置特定区域的多个字体属性
    /// - Parameters:
    ///   - attributes: 字体属性
    ///   - range: 特定区域
    /// - Returns: 返回设置后的富文本
    func setSpecificRangeTextMoreAttributes(attributes: Dictionary<NSAttributedString.Key, Any>, range: NSRange) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: self.base)
        for name in attributes.keys {
            mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: range)
        }
        return mutableAttributedString
    }
    
    // MARK: 1.14、设置特定文字的多个字体属性
    /// 设置特定文字的多个字体属性
    /// - Parameters:
    ///   - text: 特定文字
    ///   - attributes: 字体属性
    /// - Returns: 返回设置后的富文本
    func setSpecificTextMoreAttributes(_ text: String, attributes: Dictionary<NSAttributedString.Key, Any>) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: self.base)
        let rangeArray = getStringRangeArray(with: [text])
        if !rangeArray.isEmpty {
            for name in attributes.keys {
                for range in rangeArray {
                    mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: range)
                }
            }
        }
        return mutableAttributedString
    }
    
    // MARK: 1.15、设置特定区域的倾斜
    /// 设置特定区域的倾斜
    /// - Parameters:
    ///   - inclination: 倾斜度
    ///   - range: 特定区域范围
    /// - Returns: 返回设置后的富文本
    func setSpecificRangeBliqueness(inclination: Float = 0, range: NSRange) -> NSAttributedString {
        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.obliqueness: inclination], range: range)
    }
    
    // MARK: 1.16、设置特定文字的倾斜
    /// 设置特定文字的倾斜
    /// - Parameters:
    ///   - text: 特定文字
    ///   - inclination: 倾斜度
    /// - Returns: 返回设置后的富文本
    func setSpecificTextBliqueness(_ text: String, inclination: Float = 0) -> NSAttributedString {
        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.obliqueness : inclination])
    }
}

// MARK: - Private Func
public extension JKPOP where Base: NSAttributedString {
    /// 获取对应字符串的range数组
    /// - Parameter textArray: 字符串数组
    /// - Returns: range数组
    private func getStringRangeArray(with textArray: Array<String>) -> Array<NSRange> {
        var rangeArray = Array<NSRange>()
        // 遍历
        for str in textArray {
            if base.string.contains(str) {
                let subStrArr = base.string.components(separatedBy: str)
                var subStrIndex = 0
                for i in 0 ..< (subStrArr.count - 1) {
                    let subDivisionStr = subStrArr[i]
                    if i == 0 {
                        subStrIndex += (subDivisionStr.lengthOfBytes(using: .unicode) / 2)
                    } else {
                        subStrIndex += (subDivisionStr.lengthOfBytes(using: .unicode) / 2 + str.lengthOfBytes(using: .unicode) / 2)
                    }
                    let newRange = NSRange(location: subStrIndex, length: str.count)
                    rangeArray.append(newRange)
                }
            }
        }
        return rangeArray
    }
    
    // MARK: 加载网络图片
    /// 加载网络图片
    /// - Parameter imageName: 图片名
    /// - Returns: 图片
    private func loadImage(imageName: String) -> UIImage? {
        if imageName.hasPrefix("http://") || imageName.hasPrefix("https://") {
            let imageURL = URL(string: imageName)
            var imageData: Data? = nil
            do {
                imageData = try Data(contentsOf: imageURL!)
                return UIImage(data: imageData!)!
            } catch {
                return nil
            }
        }
        return UIImage(named: imageName)!
    }
}

// MARK: - 二、富文本的一些计算
public extension JKPOP where Base: NSAttributedString {
    // 2.1、计算富文本的宽度
    /// 计算富文本的宽度
    /// - Parameters:
    ///   - size: 最大size
    ///   - options: options description
    /// - Returns: 富文本的宽度
    func widthOfAttributedString(size: CGSize, options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]) -> CGFloat {
        return sizeOfAttributedString(size: size, options: options).width
    }
    
    // 2.2、计算富文本的高度
    /// 计算富文本的高度
    /// - Parameters:
    ///   - size: 最大size
    ///   - options: options description
    /// - Returns: 富文本的高度
    func heightOfAttributedString(size: CGSize, options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]) -> CGFloat {
        return sizeOfAttributedString(size: size, options: options).height
    }
    
    // 2.3、计算富文本的Size
    /// 计算富文本的Size
    /// - Parameters:
    ///   - size: 最大size
    ///   - options: options description
    /// - Returns: 富文本的size
    func sizeOfAttributedString(size: CGSize, options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]) -> CGSize {
        let attributedStringSize = self.base.boundingRect(with: size, options: options, context: nil)
        return CGSize(width: attributedStringSize.width, height: attributedStringSize.height)
    }
}
