# JKVerticalTextView

`JKVerticalTextView` 是一个支持垂直文本布局和多列显示的自定义 UIView 组件，专为中文竖排文本和特殊布局需求设计。

## 特性

- ✅ **垂直文本布局**：支持文本从上到下垂直排列
- ✅ **多列自动换行**：当文本超出一列高度时，自动流转到下一列
- ✅ **灵活配置**：支持自定义列宽、列间距、文本属性等参数
- ✅ **列数限制**：可设置最大列数，控制显示范围
- ✅ **多语言支持**：支持中文按字符拆分、英文按词拆分
- ✅ **高性能渲染**：采用 Core Graphics 直接绘制，性能优异
- ✅ **易于集成**：简单的 API 设计，易于使用和扩展

## 适用场景

- 📜 **古诗词展示**：传统竖排文本显示
- 🖋️ **书法作品**：毛笔字、书法字体展示
- 📄 **传统文档**：古籍、文言文等文档格式
- 🎨 **艺术设计**：需要特殊文本布局的设计场景
- 📚 **教育应用**：语文教学、古典文学展示

## 安装

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/JoanKing/JKSwiftExtension.git", from: "2.8.6")
]
```

### CocoaPods

```ruby
pod 'JKSwiftExtension'
```

## 基础使用

### 1. 快速开始

```swift
import JKSwiftExtension

// 创建垂直文本视图
let verticalTextView = JKVerticalTextView()
verticalTextView.text = "这是一个垂直文本布局的示例"
verticalTextView.frame = CGRect(x: 20, y: 100, width: 300, height: 400)
view.addSubview(verticalTextView)
```

### 2. 便利构造方法

```swift
let poetryView = JKVerticalTextView(
    text: "春眠不觉晓，处处闻啼鸟。夜来风雨声，花落知多少。",
    font: UIFont.systemFont(ofSize: 18),
    textColor: .black,
    columnWidth: 70,
    columnSpacing: 30
)
```

### 3. 古诗词展示

```swift
let poemView = JKVerticalTextView.createPoetryExample()
poemView.frame = CGRect(x: 50, y: 150, width: 250, height: 300)
view.addSubview(poemView)
```

## 配置参数

### 基础属性

| 属性 | 类型 | 默认值 | 说明 |
|-----|------|--------|------|
| `text` | `String?` | `nil` | 要显示的文本内容 |
| `font` | `UIFont` | `UIFont.systemFont(ofSize: 16)` | 文本字体 |
| `textColor` | `UIColor` | `UIColor.black` | 文本颜色 |
| `columnWidth` | `CGFloat` | `100` | 每列的宽度 |
| `columnSpacing` | `CGFloat` | `20` | 列与列之间的间距 |
| `lineSpacing` | `CGFloat` | `2` | 行与行之间的间距 |

### 高级属性

| 属性 | 类型 | 默认值 | 说明 |
|-----|------|--------|------|
| `maxColumns` | `Int?` | `nil` | 最大列数（nil表示不限制） |
| `textInsets` | `UIEdgeInsets` | `(10, 10, 10, 10)` | 内边距 |
| `splitByCharacter` | `Bool` | `true` | 是否按字符拆分（false为按词拆分） |

## 方法 API

### 设置方法

```swift
// 设置文本内容
verticalTextView.setText("新的文本内容")

// 设置文本属性
verticalTextView.setTextAttributes(
    font: UIFont.boldSystemFont(ofSize: 20),
    color: .blue
)

// 设置列参数
verticalTextView.setColumnParameters(
    width: 80,
    spacing: 25,
    maxColumns: 4
)
```

### 查询方法

```swift
// 获取列数
let columnCount = verticalTextView.getColumnCount()

// 检查文本是否完全显示
let isFullyDisplayed = verticalTextView.isTextFullyDisplayed()

// 获取显示百分比
let percentage = verticalTextView.getDisplayPercentage()

// 获取每列文本
let columnTexts = verticalTextView.getColumnTexts()

// 计算所需尺寸
let requiredSize = verticalTextView.sizeThatFits(CGSize(width: 400, height: 300))
```

### 实用方法

```swift
// 清空文本
verticalTextView.clearText()

// 重置到默认值
verticalTextView.resetToDefaults()
```

## 使用示例

### 1. 基础文本显示

```swift
let basicView = JKVerticalTextView()
basicView.text = "垂直文本布局示例"
basicView.columnWidth = 80
basicView.columnSpacing = 20
basicView.frame = CGRect(x: 20, y: 100, width: 280, height: 200)
view.addSubview(basicView)
```

### 2. 古诗词竖排

```swift
let poem = """
静夜思
李白
床前明月光，
疑是地上霜。
举头望明月，
低头思故乡。
"""

let poetryView = JKVerticalTextView()
poetryView.text = poem
poetryView.font = UIFont(name: "PingFangSC-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
poetryView.columnWidth = 60
poetryView.columnSpacing = 40
poetryView.lineSpacing = 8
poetryView.textInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
poetryView.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.92, alpha: 1.0)
```

### 3. 限制列数

```swift
let limitedView = JKVerticalTextView()
limitedView.text = "这是一个很长的文本，但是限制了最大列数为3列"
limitedView.maxColumns = 3
limitedView.columnWidth = 100
limitedView.columnSpacing = 25
```

### 4. 英文按词拆分

```swift
let englishView = JKVerticalTextView()
englishView.text = "This is a vertical text layout example for English content"
englishView.splitByCharacter = false  // 按词拆分
englishView.columnWidth = 120
englishView.columnSpacing = 20
```

### 5. 自动布局

```swift
let textView = JKVerticalTextView.createBasicExample()
textView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(textView)

NSLayoutConstraint.activate([
    textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
    textView.widthAnchor.constraint(equalToConstant: 300),
    textView.heightAnchor.constraint(equalToConstant: 400)
])
```

## 预设样式

库提供了多个预设样式方便快速使用：

```swift
// 基础示例
let basicExample = JKVerticalTextView.createBasicExample()

// 古诗词样式
let poetryExample = JKVerticalTextView.createPoetryExample()

// 限制列数样式
let limitedExample = JKVerticalTextView.createLimitedColumnsExample()

// 英文样式
let englishExample = JKVerticalTextView.createEnglishExample()

// 自定义样式
let customExample = JKVerticalTextView.createCustomStyleExample()
```

## 性能优化

1. **按需重绘**：只在属性变化时才重新计算布局
2. **文本缓存**：高效的文本测量和布局计算
3. **内存优化**：合理的对象创建和释放
4. **渲染优化**：使用 Core Graphics 直接绘制，避免多层视图嵌套

## 注意事项

1. **尺寸设置**：建议为组件设置明确的 frame 或约束
2. **文本长度**：超长文本可能影响性能，建议合理控制
3. **列宽设置**：列宽应该合理设置，避免过小或过大
4. **字体选择**：建议使用等宽字体获得更好的排版效果
5. **内存管理**：在不需要时及时清空文本内容

## 最佳实践

### 1. 古诗词展示

```swift
func createPoetryView(poem: String) -> JKVerticalTextView {
    let view = JKVerticalTextView()
    view.text = poem
    view.font = UIFont(name: "PingFangSC-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
    view.textColor = UIColor.darkGray
    view.columnWidth = 60
    view.columnSpacing = 40
    view.lineSpacing = 8
    view.textInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    view.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.92, alpha: 1.0)
    view.layer.cornerRadius = 8
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowOpacity = 0.1
    view.layer.shadowRadius = 4
    return view
}
```

### 2. 响应式布局

```swift
class ResponsiveVerticalTextView: JKVerticalTextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 根据视图宽度动态调整列宽
        let availableWidth = bounds.width - textInsets.left - textInsets.right
        let optimalColumnWidth = availableWidth / 4 - columnSpacing * 0.75
        
        if optimalColumnWidth > 50 && optimalColumnWidth < 150 {
            columnWidth = optimalColumnWidth
        }
    }
}
```

### 3. 性能监控

```swift
func measurePerformance() {
    let longText = String(repeating: "这是性能测试文本", count: 100)
    let textView = JKVerticalTextView()
    
    let startTime = CFAbsoluteTimeGetCurrent()
    textView.text = longText
    textView.setNeedsDisplay()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    
    print("文本布局耗时: \(timeElapsed * 1000) 毫秒")
}
```

## 版本历史

- **2.8.6**: 初始发布 JKVerticalTextView 组件
  - 实现垂直文本布局
  - 支持多列自动换行
  - 提供丰富的配置选项

## 许可证

JKSwiftExtension 基于 MIT 许可证开源。详情请参见 [LICENSE](LICENSE) 文件。

## 贡献

欢迎提交 Issue 和 Pull Request 来帮助改进这个组件！

## 联系方式

- 作者: JoanKing
- 邮箱: jkironman@163.com
- GitHub: [JoanKing/JKSwiftExtension](https://github.com/JoanKing/JKSwiftExtension)