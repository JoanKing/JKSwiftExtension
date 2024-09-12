//
//  UILabel+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit
import Foundation

// MARK: - 一、链式编程
public extension UILabel {
    
    // MARK: 1.1、设置文字
    /// 设置文字
    /// - Parameter text: 文字内容
    /// - Returns: 返回自身
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    // MARK: 1.2、设置文字行数
    /// 设置文字行数
    /// - Parameter number: 行数
    /// - Returns: 返回自身
    @discardableResult
    func line(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
    
    // MARK: 1.3、设置文字对齐方式
    /// 设置文字对齐方式
    /// - Parameter alignment: 对齐方式
    /// - Returns: 返回自身
    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    // MARK: 1.4、设置富文本文字
    /// 设置富文本文字
    /// - Parameter attributedText: 富文本文字
    /// - Returns: 返回自身
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    // MARK: 1.5、设置文本颜色
    /// 设置文本颜色
    /// - Parameter color: 颜色
    /// - Returns:  返回自身
    @discardableResult
    func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    // MARK: 1.6、设置文本颜色（十六进制字符串）
    /// 设置文本颜色（十六进制字符串）
    /// - Parameter hex: 十六进制字符串
    /// - Returns: 返回自身
    @discardableResult
    func color(_ hex: String) -> Self {
        textColor = UIColor.hexStringColor(hexString: hex)
        return self
    }
    
    // MARK: 1.7、设置字体的大小
    /// 设置字体的大小
    /// - Parameter font: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    // MARK: 1.8、设置字体的大小
    /// 设置字体的大小
    /// - Parameter fontSize: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func font(_ fontSize: CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    // MARK: 1.9、设置字体的大小（粗体）
    /// 设置字体的大小（粗体）
    /// - Parameter fontSize: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func boldFont(_ fontSize: CGFloat) -> Self {
        font = UIFont.boldSystemFont(ofSize: fontSize)
        return self
    }
}

// MARK: - 二、其他的基本扩展
public extension JKPOP where Base: UILabel {
    
    // MARK: 2.1、获取已知 frame 的 label 的文本行数 & 每一行内容
    /// 获取已知 frame 的 label 的文本行数 & 每一行内容
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - textSpace: 字间距，默认为0.0
    ///   - paraSpace: 段间距，默认为0.0
    /// - Returns: label 的文本行数 & 每一行内容
    func linesCountAndLinesContent(lineSpace: CGFloat, textSpace: CGFloat = 0.0, paraSpace: CGFloat = 0.0) -> (Int?, [String]?) {
        return accordWidthLinesCountAndLinesContent(accordWidth: base.frame.size.width, lineSpace: lineSpace, textSpace: textSpace, paraSpace: paraSpace)
    }
    
    // MARK: 2.2、获取已知 width 的 label 的文本行数 & 每一行内容
    /// 获取已知 width 的 label 的文本行数 & 每一行内容
    /// - Parameters:
    ///   - accordWidth: label 的 width
    ///   - lineSpace: 行间距
    ///   - textSpace: 字间距，默认为0.0
    ///   - paraSpace: 段间距，默认为0.0
    /// - Returns: description
    func accordWidthLinesCountAndLinesContent(accordWidth: CGFloat, lineSpace: CGFloat, textSpace: CGFloat = 0.0, paraSpace: CGFloat = 0.0) -> (Int?, [String]?) {
        guard let t = base.text, let f = base.font else {return (0, nil)}
        let align = base.textAlignment
        let c_fn = f.fontName as CFString
        let fp = f.pointSize
        let c_f = CTFontCreateWithName(c_fn, fp, nil)
        
        let contentDict = UILabel.jk.genTextStyle(text: t as NSString, linebreakmode: NSLineBreakMode.byCharWrapping, align: align, font: f, lineSpace: lineSpace, textSpace: textSpace, paraSpace: paraSpace)
        
        let attr = NSMutableAttributedString(string: t)
        let range = NSRange(location: 0, length: attr.length)
        attr.addAttributes(contentDict, range: range)
        
        attr.addAttribute(NSAttributedString.Key.font, value: c_f, range: range)
        let frameSetter = CTFramesetterCreateWithAttributedString(attr as CFAttributedString)
        
        let path = CGMutablePath()
        /// 2.5 是经验误差值
        path.addRect(CGRect(x: 0, y: 0, width: accordWidth - 2.5, height: CGFloat(MAXFLOAT)))
        let framef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        let lines = CTFrameGetLines(framef) as NSArray
        var lineArr = [String]()
        for line in lines {
            let lineRange = CTLineGetStringRange(line as! CTLine)
            let lineString = t.jk.sub(start: lineRange.location, length: lineRange.length)
            lineArr.append(lineString as String)
        }
        return (lineArr.count, lineArr)
    }
    
    // MARK: 2.3、获取第一行内容
    /// 获取第一行内容
    var firstLineString: String? {
        return self.linesCountAndLinesContent(lineSpace: 0.0).1?.first
    }
    
    // MARK: 2.4、改变行间距
    /// 改变行间距
    /// - Parameter space: 行间距大小
    func changeLineSpace(space: CGFloat) {
        if self.base.text == nil || self.base.text == "" {
            return
        }
        let text = self.base.text
        let attributedString = NSMutableAttributedString(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = self.base.textAlignment
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.base.attributedText = attributedString
        self.base.sizeToFit()
    }
    
    // MARK: 2.5、改变字间距
    /// 改变字间距
    /// - Parameter space: 字间距大小
    func changeWordSpace(space: CGFloat) {
        if self.base.text == nil || self.base.text == "" {
            return
        }
        let text = self.base.text
        let attributedString = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern:space])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.base.textAlignment
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.base.attributedText = attributedString
        self.base.sizeToFit()
    }
    
    // MARK: 2.6、改变字间距和行间距
    /// 改变字间距和行间距
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - wordSpace: 字间距
    func changeSpace(lineSpace: CGFloat, wordSpace: CGFloat) {
        if self.base.text == nil || self.base.text == "" {
            return
        }
        let text = self.base.text
        let attributedString = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern:wordSpace])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.base.textAlignment
        paragraphStyle.lineSpacing = lineSpace
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.base.attributedText = attributedString
        self.base.sizeToFit()
    }
    
    // MARK: 2.7、label添加中划线
    /// label添加中划线
    /// - Parameters:
    ///   - lineValue: value 越大,划线越粗
    ///   - underlineColor: 中划线的颜色
    func centerLineText(lineValue: Int = 1, underlineColor: UIColor = .black) {
        guard let content = base.text else {
            return
        }
        let arrText = NSMutableAttributedString(string: content)
        arrText.addAttributes([NSAttributedString.Key.strikethroughStyle: lineValue, NSAttributedString.Key.strikethroughColor: underlineColor], range: NSRange(location: 0, length: arrText.length))
        base.attributedText = arrText
    }
    
    // MARK: 设置文本样式
    /// 设置文本样式
    /// - Parameters:
    ///   - text: 文字内容
    ///   - linebreakmode: 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    ///   - align: 文本对齐方式：（左，中，右，两端对齐，自然）
    ///   - font: 字体大小
    ///   - lineSpace: 字体的行间距
    ///   - textSpace: 设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
    ///   - paraSpace: 段与段之间的间距
    /// - Returns: 返回样式 [NSAttributedString.Key : Any]
    private static func genTextStyle(text: NSString, linebreakmode: NSLineBreakMode, align: NSTextAlignment, font: UIFont, lineSpace: CGFloat, textSpace: CGFloat, paraSpace: CGFloat) -> [NSAttributedString.Key : Any] {
        let style = NSMutableParagraphStyle()
        // 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
        /**
         case byWordWrapping = 0       //  以单词为显示单位显示，后面部分省略不显示
         case byCharWrapping = 1        //  以字符为显示单位显示，后面部分省略不显示
         case byClipping = 2                  //  剪切与文本宽度相同的内容长度，后半部分被删除
         case byTruncatingHead = 3      //  前面部分文字以……方式省略，显示尾部文字内容
         case byTruncatingTail = 4         //  结尾部分的内容以……方式省略，显示头的文字内容
         case byTruncatingMiddle = 5    //  中间的内容以……方式省略，显示头尾的文字内容
         */
        style.lineBreakMode = linebreakmode
        // 文本对齐方式：（左，中，右，两端对齐，自然）
        style.alignment = align
        // 字体的行间距
        style.lineSpacing = lineSpace
        // 连字属性 在iOS，唯一支持的值分别为0和1
        style.hyphenationFactor = 1.0
        // 首行缩进
        style.firstLineHeadIndent = 0.0
        // 段与段之间的间距
        style.paragraphSpacing = paraSpace
        // 段首行空白空间
        style.paragraphSpacingBefore = 0.0
        // 整体缩进(首行除外)
        style.headIndent = 0.0
        // 文本行末缩进距离
        style.tailIndent = 0.0
        
        /*
         // 一组NSTextTabs。 内容应按位置排序。 默认值是一个由12个左对齐制表符组成的数组，间隔为28pt ？？？？？
         style.tabStops =
         // 一个布尔值，指示系统在截断文本之前是否可以收紧字符间间距 ？？？？？
         style.allowsDefaultTighteningForTruncation = true
         // 文档范围的默认选项卡间隔 ？？？？？
         style.defaultTabInterval = 1
         // 最低行高（设置最低行高后，如果文本小于20行，会通过增加行间距达到20行的高度）
         style.minimumLineHeight = 10
         // 最高行高（设置最高行高后，如果文本大于10行，会通过降低行间距达到10行的高度）
         style.maximumLineHeight = 20
         //从左到右的书写方向
         style.baseWritingDirection = .leftToRight
         // 在受到最小和最大行高约束之前，自然线高度乘以该因子（如果为正） 多少倍行间距
         style.lineHeightMultiple = 15
         */
        
        let dict = [
            NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.kern : textSpace] as [NSAttributedString.Key : Any]
        return dict
    }
    
    // MARK: 2.08、获取已知label 的文本行数 & 每一行内容
    /// 获取已知label 的文本行数 & 每一行内容
    /// - Returns: 每行的内容
    func linesCountAndLinesContent() -> (Int?, [String]?) {
        guard let t = base.text else {return (0, nil)}
        let lodFontName = base.font.fontName == ".SFUI-Regular" ? "TimesNewRomanPSMT" : base.font.fontName
        let fontSize = getFontSizeForLabel()
        let newFont = UIFont(name: lodFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        let c_fn = newFont.fontName as CFString
        let fp = newFont.pointSize
        let c_f = CTFontCreateWithName(c_fn, fp, nil)
 
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byCharWrapping
        let contentDict = [NSAttributedString.Key.paragraphStyle : style] as [NSAttributedString.Key : Any]
        
        let attr = NSMutableAttributedString(string: t)
        let range = NSRange(location: 0, length: attr.length)
        attr.addAttributes(contentDict, range: range)
        attr.addAttribute(NSAttributedString.Key.font, value: c_f, range: range)
        let frameSetter = CTFramesetterCreateWithAttributedString(attr as CFAttributedString)
        
        let path = CGMutablePath()
        /// 2.5 是经验误差值
        path.addRect(CGRect(x: 0, y: 0, width: base.jk.width, height: base.jk.height > (fp * 1.5) ? base.jk.height : fp * 1.5))
        let framef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        let lines = CTFrameGetLines(framef) as NSArray
        var lineArr = [String]()
        for line in lines {
            let lineRange = CTLineGetStringRange(line as! CTLine)
            let lineString = t.jk.sub(start: lineRange.location, length: lineRange.length)
            lineArr.append(lineString as String)
        }
        return (lineArr.count, lineArr)
    }
    
    // MARK: 2.09、获取字体的大小
    /// 获取字体的大小
    /// - Returns: 字体大小
    func getFontSizeForLabel() -> CGFloat {
        let text: NSMutableAttributedString = NSMutableAttributedString(attributedString: base.attributedText!)
        text.setAttributes([NSAttributedString.Key.font: base.font as Any], range: NSMakeRange(0, text.length))
        let context: NSStringDrawingContext = NSStringDrawingContext()
        context.minimumScaleFactor = base.minimumScaleFactor
        text.boundingRect(with: base.frame.size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: context)
        let adjustedFontSize: CGFloat = base.font.pointSize * context.actualScaleFactor
        return adjustedFontSize
    }
    
    // MARK: 2.10、设置行高
    /// 设置行高
    /// - Parameter lineHeight: 行高
    func setLineHeight(lineHeight: CGFloat) {
        guard let text = base.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - (base.font.lineHeight - base.font.pointSize)
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        base.attributedText = attributedString
    }
}

// MARK: - 三、特定区域和特定文字的基本扩展
public extension JKPOP where Base: UILabel {

    // MARK: 3.1、设置特定区域的字体大小
    /// 设置特定区域的字体大小
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域
    func setRangeFontText(font: UIFont, range: NSRange) {
        let attributedString = base.attributedText?.jk.setRangeFontText(font: font, range: range)
        base.attributedText = attributedString
    }
    
    // MARK: 3.2、设置特定文字的字体大小
    /// 设置特定文字的字体大小
    /// - Parameters:
    ///   - text: 特定文字
    ///   - font: 字体
    func setsetSpecificTextFont(_ text: String, font: UIFont) {
        let attributedString = base.attributedText?.jk.setSpecificTextFont(text, font: font)
        base.attributedText = attributedString
    }
    
    // MARK: 3.3、设置特定区域的字体颜色
    /// 设置特定区域的字体颜色
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - range: 区域
    func setSpecificRangeTextColor(color: UIColor, range: NSRange) {
        let attributedString = base.attributedText?.jk.setSpecificRangeTextColor(color: color, range: range)
        base.attributedText = attributedString
    }
    
    // MARK: 3.4、设置特定文字的字体颜色
    /// 设置特定文字的字体颜色
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 字体颜色
    func setSpecificTextColor(_ text: String, color: UIColor) {
        let attributedString = base.attributedText?.jk.setSpecificTextColor(text, color: color)
        base.attributedText = attributedString
    }
    
    // MARK: 3.5、设置行间距
    /// 设置行间距
    /// - Parameter space: 行间距
    func setTextLineSpace(_ space: CGFloat) {
        let attributedString = base.attributedText?.jk.setSpecificRangeTextLineSpace(lineSpace: space, alignment: base.textAlignment, range: NSRange(location: 0, length: base.text?.count ?? 0))
        base.attributedText = attributedString
    }
    
    // MARK: 3.6、设置特定文字区域的下划线
    /// 设置特定区域的下划线
    /// - Parameters:
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    ///   - range: 文字区域
    func setSpecificRangeTextUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange) {
        let attributedString = base.attributedText?.jk.setSpecificRangeUnderLine(color: color, stytle: stytle, range: range)
        base.attributedText = attributedString
    }
    
    // MARK: 3.7、设置特定文字的下划线
    /// 设置特定文字的下划线
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    func setSpecificTextUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single) {
        let attributedString = base.attributedText?.jk.setSpecificTextUnderLine(text, color: color, stytle: stytle)
        base.attributedText = attributedString
    }
    
    // MARK: 3.8、设置特定区域的删除线
    /// 设置特定区域的删除线
    /// - Parameters:
    ///   - color: 删除线颜色
    ///   - range: 特定区域范围
    func setSpecificRangeDeleteLine(color: UIColor, range: NSRange) {
        let attributedString = base.attributedText?.jk.setSpecificRangeDeleteLine(color: color, range: range)
        base.attributedText = attributedString
    }
    
    // MARK: 3.9、设置特定文字的删除线
    /// 设置特定文字的删除线
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 删除线颜色
    func setSpecificTextDeleteLine(_ text: String, color: UIColor) {
        let attributedString = base.attributedText?.jk.setSpecificTextDeleteLine(text, color: color)
        base.attributedText = attributedString
    }
    
    // MARK: 3.10、插入图片
    /// 插入图片
    /// - Parameters:
    ///   - imgName: 要添加的图片名称，如果是网络图片，需要传入完整路径名，且imgBounds必须传值
    ///   - imgBounds: 图片的大小，默认为.zero，即自动根据图片大小设置，并以底部基线为标准。 y > 0 ：图片向上移动；y < 0 ：图片向下移动
    ///   - imgIndex:  图片的位置，默认放在开头
    func insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0) {
        // 设置换行方式
        base.lineBreakMode = NSLineBreakMode.byCharWrapping
        let attributedString = base.attributedText?.jk.insertImage(imgName: imgName, imgBounds: imgBounds, imgIndex: imgIndex)
        base.attributedText = attributedString
    }
    
    // MARK: 3.11、首行缩进
    /// 首行缩进
    /// - Parameter edge: 缩进宽度
    func firstLineLeftEdge(_ edge: CGFloat) {
        let attributedString = base.attributedText?.jk.firstLineLeftEdge(edge)
        base.attributedText = attributedString
    }
    
    // MARK: 3.12、设置特定文字区域的倾斜
    /// 设置特定区域的倾斜
    /// - Parameters:
    ///   - inclination: 倾斜度
    ///   - range: 文字区域
    func setSpecificRangeBliqueness(inclination: Float = 0, range: NSRange) {
        let attributedString = base.attributedText?.jk.setSpecificRangeBliqueness(inclination: inclination, range: range)
        base.attributedText = attributedString
    }
    
    // MARK: 3.13、设置特定文字的倾斜
    /// 设置特定文字的倾斜
    /// - Parameters:
    ///   - text: 特定文字
    ///   - inclination: 倾斜度
    func setSpecificTextBliqueness(_ text: String, inclination: Float = 0) {
        let attributedString = base.attributedText?.jk.setSpecificTextBliqueness(text, inclination: inclination)
        base.attributedText = attributedString
    }
}
