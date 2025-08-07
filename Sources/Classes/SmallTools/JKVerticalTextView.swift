//
//  JKVerticalTextView.swift
//  JKSwiftExtension
//
//  Created by JKSwiftExtension on 2024/01/25.
//

import UIKit
import Foundation

// MARK: - 垂直文本布局组件
/// 垂直文本布局组件，支持文本垂直排列和多列显示
public class JKVerticalTextView: UIView {
    
    // MARK: - Public Properties
    
    /// 列宽度
    public var columnWidth: CGFloat = 100 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 列间距
    public var columnSpacing: CGFloat = 20 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 文本内容
    public var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 字体
    public var font: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 文本颜色
    public var textColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 行间距
    public var lineSpacing: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 最大列数（nil表示不限制）
    public var maxColumns: Int? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 内边距
    public var textInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 是否按字符拆分（true为按字符，false为按词拆分）
    public var splitByCharacter: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Private Properties
    
    /// 字符高度缓存
    private var characterHeight: CGFloat = 0
    
    /// 列信息数组，每个元素包含该列的文本和绘制区域
    private var columnInfos: [ColumnInfo] = []
    
    // MARK: - Column Info Structure
    
    private struct ColumnInfo {
        let text: String
        let rect: CGRect
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = UIColor.clear
        contentMode = .redraw
    }
    
    // MARK: - Drawing
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let text = text, !text.isEmpty else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // 计算文本布局
        calculateTextLayout()
        
        // 绘制文本
        drawText(in: context)
    }
    
    // MARK: - Text Layout Calculation
    
    private func calculateTextLayout() {
        guard let text = text, !text.isEmpty else {
            columnInfos = []
            return
        }
        
        // 计算字符高度
        let testString = "测试Ag" as NSString
        let testSize = testString.size(withAttributes: [.font: font])
        characterHeight = testSize.height
        
        // 计算可用区域
        let availableRect = CGRect(
            x: textInsets.left,
            y: textInsets.top,
            width: bounds.width - textInsets.left - textInsets.right,
            height: bounds.height - textInsets.top - textInsets.bottom
        )
        
        // 计算单列可容纳的字符数
        let charactersPerColumn = calculateCharactersPerColumn(availableHeight: availableRect.height)
        
        // 拆分文本
        let textUnits = splitByCharacter ? Array(text).map { String($0) } : text.components(separatedBy: " ")
        
        // 分配文本到列
        columnInfos = distributeTextToColumns(
            textUnits: textUnits,
            charactersPerColumn: charactersPerColumn,
            availableRect: availableRect
        )
    }
    
    private func calculateCharactersPerColumn(availableHeight: CGFloat) -> Int {
        let totalLineHeight = characterHeight + lineSpacing
        return max(1, Int(availableHeight / totalLineHeight))
    }
    
    private func distributeTextToColumns(textUnits: [String], charactersPerColumn: Int, availableRect: CGRect) -> [ColumnInfo] {
        var columns: [ColumnInfo] = []
        var currentColumnText = ""
        var currentCharCount = 0
        var columnIndex = 0
        
        for unit in textUnits {
            let unitCharCount = splitByCharacter ? 1 : unit.count
            
            // 检查是否需要换列
            if currentCharCount + unitCharCount > charactersPerColumn && currentCharCount > 0 {
                // 创建当前列
                if !currentColumnText.isEmpty {
                    let columnRect = calculateColumnRect(index: columnIndex, availableRect: availableRect)
                    columns.append(ColumnInfo(text: currentColumnText, rect: columnRect))
                    columnIndex += 1
                }
                
                // 检查最大列数限制
                if let maxCols = maxColumns, columnIndex >= maxCols {
                    break
                }
                
                // 重置当前列
                currentColumnText = ""
                currentCharCount = 0
            }
            
            // 添加文本单元到当前列
            if splitByCharacter {
                currentColumnText += unit
            } else {
                currentColumnText += (currentColumnText.isEmpty ? "" : " ") + unit
            }
            currentCharCount += unitCharCount
        }
        
        // 添加最后一列
        if !currentColumnText.isEmpty && (maxColumns == nil || columnIndex < maxColumns!) {
            let columnRect = calculateColumnRect(index: columnIndex, availableRect: availableRect)
            columns.append(ColumnInfo(text: currentColumnText, rect: columnRect))
        }
        
        return columns
    }
    
    private func calculateColumnRect(index: Int, availableRect: CGRect) -> CGRect {
        let x = availableRect.origin.x + CGFloat(index) * (columnWidth + columnSpacing)
        return CGRect(
            x: x,
            y: availableRect.origin.y,
            width: columnWidth,
            height: availableRect.height
        )
    }
    
    // MARK: - Text Drawing
    
    private func drawText(in context: CGContext) {
        context.saveGState()
        
        // 设置文本属性
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor
        ]
        
        for columnInfo in columnInfos {
            drawVerticalText(
                text: columnInfo.text,
                in: columnInfo.rect,
                attributes: textAttributes
            )
        }
        
        context.restoreGState()
    }
    
    private func drawVerticalText(text: String, in rect: CGRect, attributes: [NSAttributedString.Key: Any]) {
        let characters = Array(text)
        var currentY = rect.origin.y
        
        for character in characters {
            let charString = String(character) as NSString
            let charSize = charString.size(withAttributes: attributes)
            
            // 检查是否超出绘制区域
            if currentY + charSize.height > rect.origin.y + rect.height {
                break
            }
            
            // 居中绘制字符
            let charRect = CGRect(
                x: rect.origin.x + (rect.width - charSize.width) / 2,
                y: currentY,
                width: charSize.width,
                height: charSize.height
            )
            
            charString.draw(in: charRect, withAttributes: attributes)
            
            // 移动到下一行
            currentY += charSize.height + lineSpacing
        }
    }
    
    // MARK: - Public Methods
    
    /// 设置文本内容
    /// - Parameter text: 文本内容
    public func setText(_ text: String?) {
        self.text = text
    }
    
    /// 设置文本属性
    /// - Parameters:
    ///   - font: 字体
    ///   - color: 颜色
    public func setTextAttributes(font: UIFont? = nil, color: UIColor? = nil) {
        if let font = font {
            self.font = font
        }
        if let color = color {
            self.textColor = color
        }
    }
    
    /// 设置列参数
    /// - Parameters:
    ///   - width: 列宽度
    ///   - spacing: 列间距
    ///   - maxColumns: 最大列数
    public func setColumnParameters(width: CGFloat? = nil, spacing: CGFloat? = nil, maxColumns: Int? = nil) {
        if let width = width {
            self.columnWidth = width
        }
        if let spacing = spacing {
            self.columnSpacing = spacing
        }
        if maxColumns != nil {
            self.maxColumns = maxColumns
        }
    }
    
    /// 计算所需的尺寸
    /// - Parameter maxWidth: 最大宽度
    /// - Returns: 所需的尺寸
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let text = text, !text.isEmpty else {
            return CGSize.zero
        }
        
        // 临时计算布局
        let oldBounds = bounds
        self.bounds = CGRect(origin: .zero, size: size)
        calculateTextLayout()
        let requiredColumns = columnInfos.count
        self.bounds = oldBounds
        
        // 计算所需宽度
        let requiredWidth = textInsets.left + textInsets.right + 
                           CGFloat(requiredColumns) * columnWidth + 
                           CGFloat(max(0, requiredColumns - 1)) * columnSpacing
        
        return CGSize(width: min(requiredWidth, size.width), height: size.height)
    }
    
    /// 获取当前列数
    /// - Returns: 当前列数
    public func getColumnCount() -> Int {
        return columnInfos.count
    }
    
    /// 获取文本是否完全显示
    /// - Returns: 是否完全显示
    public func isTextFullyDisplayed() -> Bool {
        guard let text = text, !text.isEmpty else { return true }
        
        let displayedText = columnInfos.map { $0.text }.joined()
        return displayedText.count >= text.count
    }
}

// MARK: - 便利构造方法
public extension JKVerticalTextView {
    
    /// 便利构造方法
    /// - Parameters:
    ///   - text: 文本内容
    ///   - font: 字体
    ///   - textColor: 文本颜色
    ///   - columnWidth: 列宽度
    ///   - columnSpacing: 列间距
    convenience init(text: String?, 
                    font: UIFont = UIFont.systemFont(ofSize: 16),
                    textColor: UIColor = UIColor.black,
                    columnWidth: CGFloat = 100,
                    columnSpacing: CGFloat = 20) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.columnWidth = columnWidth
        self.columnSpacing = columnSpacing
    }
}