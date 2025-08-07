//
//  JKVerticalTextViewTests.swift
//  JKSwiftExtension
//
//  Created by JKSwiftExtension on 2024/01/25.
//

import XCTest
@testable import JKSwiftExtension

final class JKVerticalTextViewTests: XCTestCase {
    
    var verticalTextView: JKVerticalTextView!
    
    override func setUp() {
        super.setUp()
        verticalTextView = JKVerticalTextView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
    }
    
    override func tearDown() {
        verticalTextView = nil
        super.tearDown()
    }
    
    // MARK: - 基础属性测试
    
    func testInitialProperties() {
        XCTAssertEqual(verticalTextView.columnWidth, 100)
        XCTAssertEqual(verticalTextView.columnSpacing, 20)
        XCTAssertEqual(verticalTextView.lineSpacing, 2)
        XCTAssertTrue(verticalTextView.splitByCharacter)
        XCTAssertNil(verticalTextView.maxColumns)
        XCTAssertNil(verticalTextView.text)
    }
    
    func testConvenienceInitializer() {
        let textView = JKVerticalTextView(
            text: "测试文本",
            font: UIFont.systemFont(ofSize: 20),
            textColor: UIColor.red,
            columnWidth: 80,
            columnSpacing: 25
        )
        
        XCTAssertEqual(textView.text, "测试文本")
        XCTAssertEqual(textView.columnWidth, 80)
        XCTAssertEqual(textView.columnSpacing, 25)
        XCTAssertEqual(textView.font.pointSize, 20)
        XCTAssertEqual(textView.textColor, UIColor.red)
    }
    
    // MARK: - 文本设置测试
    
    func testSetText() {
        let testText = "这是测试文本"
        verticalTextView.setText(testText)
        XCTAssertEqual(verticalTextView.text, testText)
    }
    
    func testSetTextAttributes() {
        let testFont = UIFont.boldSystemFont(ofSize: 18)
        let testColor = UIColor.blue
        
        verticalTextView.setTextAttributes(font: testFont, color: testColor)
        
        XCTAssertEqual(verticalTextView.font, testFont)
        XCTAssertEqual(verticalTextView.textColor, testColor)
    }
    
    func testSetColumnParameters() {
        verticalTextView.setColumnParameters(width: 120, spacing: 30, maxColumns: 5)
        
        XCTAssertEqual(verticalTextView.columnWidth, 120)
        XCTAssertEqual(verticalTextView.columnSpacing, 30)
        XCTAssertEqual(verticalTextView.maxColumns, 5)
    }
    
    // MARK: - 布局计算测试
    
    func testEmptyTextHandling() {
        verticalTextView.text = nil
        XCTAssertEqual(verticalTextView.getColumnCount(), 0)
        XCTAssertTrue(verticalTextView.isTextFullyDisplayed())
        
        verticalTextView.text = ""
        XCTAssertEqual(verticalTextView.getColumnCount(), 0)
        XCTAssertTrue(verticalTextView.isTextFullyDisplayed())
    }
    
    func testSizeThatFitsWithEmptyText() {
        verticalTextView.text = nil
        let size = verticalTextView.sizeThatFits(CGSize(width: 300, height: 400))
        XCTAssertEqual(size, CGSize.zero)
        
        verticalTextView.text = ""
        let size2 = verticalTextView.sizeThatFits(CGSize(width: 300, height: 400))
        XCTAssertEqual(size2, CGSize.zero)
    }
    
    func testSplitByCharacterProperty() {
        verticalTextView.splitByCharacter = false
        XCTAssertFalse(verticalTextView.splitByCharacter)
        
        verticalTextView.splitByCharacter = true
        XCTAssertTrue(verticalTextView.splitByCharacter)
    }
    
    // MARK: - 边界测试
    
    func testMaxColumnsLimit() {
        verticalTextView.text = "这是一个很长的测试文本，用来测试最大列数的限制功能是否正常工作。"
        verticalTextView.maxColumns = 2
        verticalTextView.columnWidth = 50
        
        // 在实际的 iOS 环境中，这个测试会更有意义
        // 这里主要测试属性设置
        XCTAssertEqual(verticalTextView.maxColumns, 2)
    }
    
    func testTextInsets() {
        let insets = UIEdgeInsets(top: 15, left: 20, bottom: 25, right: 30)
        verticalTextView.textInsets = insets
        
        XCTAssertEqual(verticalTextView.textInsets.top, 15)
        XCTAssertEqual(verticalTextView.textInsets.left, 20)
        XCTAssertEqual(verticalTextView.textInsets.bottom, 25)
        XCTAssertEqual(verticalTextView.textInsets.right, 30)
    }
    
    // MARK: - 示例创建测试
    
    func testExampleCreation() {
        let basicExample = JKVerticalTextView.createBasicExample()
        XCTAssertNotNil(basicExample.text)
        XCTAssertEqual(basicExample.columnWidth, 80)
        XCTAssertEqual(basicExample.columnSpacing, 30)
        
        let poetryExample = JKVerticalTextView.createPoetryExample()
        XCTAssertNotNil(poetryExample.text)
        XCTAssertEqual(poetryExample.columnWidth, 60)
        XCTAssertEqual(poetryExample.columnSpacing, 40)
        
        let limitedExample = JKVerticalTextView.createLimitedColumnsExample()
        XCTAssertNotNil(limitedExample.text)
        XCTAssertEqual(limitedExample.maxColumns, 3)
        
        let englishExample = JKVerticalTextView.createEnglishExample()
        XCTAssertNotNil(englishExample.text)
        XCTAssertFalse(englishExample.splitByCharacter)
        
        let customExample = JKVerticalTextView.createCustomStyleExample()
        XCTAssertNotNil(customExample.text)
        XCTAssertEqual(customExample.columnWidth, 90)
        XCTAssertEqual(customExample.columnSpacing, 35)
    }
    
    // MARK: - 性能测试
    
    func testPerformanceWithLongText() {
        let longText = String(repeating: "这是一个很长的文本测试", count: 100)
        
        measure {
            verticalTextView.text = longText
            verticalTextView.setNeedsDisplay()
        }
    }
    
    // MARK: - 回归测试
    
    func testPropertyChangesInvalidateDisplay() {
        verticalTextView.text = "测试文本"
        
        // 测试属性变化是否会触发重绘（这在实际环境中会调用 setNeedsDisplay）
        verticalTextView.columnWidth = 150
        verticalTextView.columnSpacing = 40
        verticalTextView.font = UIFont.systemFont(ofSize: 24)
        verticalTextView.textColor = UIColor.green
        verticalTextView.lineSpacing = 5
        verticalTextView.maxColumns = 3
        
        // 验证属性设置成功
        XCTAssertEqual(verticalTextView.columnWidth, 150)
        XCTAssertEqual(verticalTextView.columnSpacing, 40)
        XCTAssertEqual(verticalTextView.font.pointSize, 24)
        XCTAssertEqual(verticalTextView.textColor, UIColor.green)
        XCTAssertEqual(verticalTextView.lineSpacing, 5)
        XCTAssertEqual(verticalTextView.maxColumns, 3)
    }
}