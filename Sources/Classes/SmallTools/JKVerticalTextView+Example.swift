//
//  JKVerticalTextView+Example.swift
//  JKSwiftExtension
//
//  Created by JKSwiftExtension on 2024/01/25.
//

import UIKit

// MARK: - JKVerticalTextView 使用示例
/**
 JKVerticalTextView 是一个支持垂直文本布局和多列显示的自定义视图组件
 
 主要特性：
 1. 支持文本垂直排列（从上到下）
 2. 当文本超出第一列高度时，自动流转到下一列
 3. 支持多列显示
 4. 可自定义列宽、列间距、文本属性等参数
 5. 支持最大列数限制
 6. 支持按字符或按词拆分文本
 7. 高效的文本渲染和测量
 
 适用场景：
 - 中文竖排文本显示
 - 古诗词、书法作品展示
 - 传统文档格式展示
 - 特殊布局需求的文本显示
 */

public extension JKVerticalTextView {
    
    // MARK: - 使用示例
    
    /// 创建基础的垂直文本视图
    /// - Returns: 配置好的垂直文本视图
    static func createBasicExample() -> JKVerticalTextView {
        let textView = JKVerticalTextView()
        textView.text = "这是一个垂直文本布局的示例，文本会从上到下排列，当超出一列的高度时会自动换到下一列继续显示。"
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = UIColor.black
        textView.columnWidth = 80
        textView.columnSpacing = 30
        textView.backgroundColor = UIColor.lightGray
        return textView
    }
    
    /// 创建古诗词显示示例
    /// - Returns: 配置好的古诗词显示视图
    static func createPoetryExample() -> JKVerticalTextView {
        let poem = """
        静夜思
        李白
        床前明月光，
        疑是地上霜。
        举头望明月，
        低头思故乡。
        """
        
        let textView = JKVerticalTextView()
        textView.text = poem
        textView.font = UIFont(name: "PingFangSC-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.darkGray
        textView.columnWidth = 60
        textView.columnSpacing = 40
        textView.lineSpacing = 8
        textView.textInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.92, alpha: 1.0)
        return textView
    }
    
    /// 创建限制列数的示例
    /// - Returns: 配置好的限制列数视图
    static func createLimitedColumnsExample() -> JKVerticalTextView {
        let longText = "这是一个很长的文本示例，用来演示当设置最大列数时的效果。即使文本很长，也只会显示指定的列数，超出的部分会被截断。这样可以控制显示的范围和布局。"
        
        let textView = JKVerticalTextView()
        textView.text = longText
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.blue
        textView.columnWidth = 100
        textView.columnSpacing = 25
        textView.maxColumns = 3  // 限制最大3列
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        return textView
    }
    
    /// 创建按词拆分的英文示例
    /// - Returns: 配置好的英文显示视图
    static func createEnglishExample() -> JKVerticalTextView {
        let englishText = "This is a vertical text layout example for English content. Words will be split and arranged vertically in columns."
        
        let textView = JKVerticalTextView()
        textView.text = englishText
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = UIColor.purple
        textView.columnWidth = 120
        textView.columnSpacing = 20
        textView.splitByCharacter = false  // 按词拆分
        textView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        return textView
    }
    
    /// 创建自定义样式示例
    /// - Returns: 配置好的自定义样式视图
    static func createCustomStyleExample() -> JKVerticalTextView {
        let textView = JKVerticalTextView(
            text: "自定义样式的垂直文本视图，可以设置各种参数来满足不同的显示需求。",
            font: UIFont.boldSystemFont(ofSize: 16),
            textColor: UIColor.red,
            columnWidth: 90,
            columnSpacing: 35
        )
        
        textView.lineSpacing = 5
        textView.textInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        
        return textView
    }
}

// MARK: - 在 UIViewController 中的使用示例
/**
 使用示例代码：
 
 ```swift
 class ViewController: UIViewController {
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // 创建垂直文本视图
         let verticalTextView = JKVerticalTextView.createBasicExample()
         verticalTextView.frame = CGRect(x: 20, y: 100, width: 300, height: 400)
         view.addSubview(verticalTextView)
         
         // 或者使用便利构造方法
         let poetryView = JKVerticalTextView(
             text: "春眠不觉晓，处处闻啼鸟。夜来风雨声，花落知多少。",
             font: UIFont.systemFont(ofSize: 18),
             textColor: .black,
             columnWidth: 70,
             columnSpacing: 30
         )
         poetryView.frame = CGRect(x: 50, y: 150, width: 250, height: 300)
         view.addSubview(poetryView)
         
         // 动态设置文本
         poetryView.setText("新的文本内容")
         
         // 设置文本属性
         poetryView.setTextAttributes(
             font: UIFont.boldSystemFont(ofSize: 20),
             color: .blue
         )
         
         // 设置列参数
         poetryView.setColumnParameters(
             width: 80,
             spacing: 25,
             maxColumns: 4
         )
         
         // 检查文本是否完全显示
         if !poetryView.isTextFullyDisplayed() {
             print("文本未完全显示，当前显示了 \(poetryView.getColumnCount()) 列")
         }
         
         // 计算所需尺寸
         let requiredSize = poetryView.sizeThatFits(CGSize(width: 400, height: 300))
         print("所需尺寸: \(requiredSize)")
     }
 }
 ```
 
 自动布局使用示例：
 
 ```swift
 // 使用自动布局
 let textView = JKVerticalTextView.createPoetryExample()
 textView.translatesAutoresizingMaskIntoConstraints = false
 view.addSubview(textView)
 
 NSLayoutConstraint.activate([
     textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
     textView.widthAnchor.constraint(equalToConstant: 300),
     textView.heightAnchor.constraint(equalToConstant: 400)
 ])
 ```
 
 参数说明：
 - text: 要显示的文本内容
 - font: 文本字体
 - textColor: 文本颜色
 - columnWidth: 每列的宽度
 - columnSpacing: 列与列之间的间距
 - lineSpacing: 行间距
 - maxColumns: 最大列数（nil表示不限制）
 - textInsets: 内边距
 - splitByCharacter: 是否按字符拆分（true为按字符，false为按词）
 
 注意事项：
 1. 组件会根据设置的参数自动计算文本布局
 2. 当文本超出指定列数时，超出部分会被截断
 3. 建议为组件设置明确的frame或约束
 4. 文本内容变化时会自动重绘
 5. 支持中文、英文等多种语言
 */