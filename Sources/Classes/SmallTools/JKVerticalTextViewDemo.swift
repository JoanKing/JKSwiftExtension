//
//  JKVerticalTextViewDemo.swift
//  JKSwiftExtension
//
//  Created by JKSwiftExtension on 2024/01/25.
//

import UIKit

// MARK: - 演示控制器
/**
 JKVerticalTextView 演示控制器
 展示各种使用场景和效果
 */
class JKVerticalTextViewDemoViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "JKVerticalTextView 演示"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createDemos()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        title = "垂直文本布局演示"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Title constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func createDemos() {
        var currentY: CGFloat = 70
        
        // 1. 基础示例
        currentY = addDemoSection(
            title: "1. 基础垂直文本",
            textView: JKVerticalTextView.createBasicExample(),
            startY: currentY
        )
        
        // 2. 古诗词示例
        currentY = addDemoSection(
            title: "2. 古诗词展示",
            textView: JKVerticalTextView.createPoetryExample(),
            startY: currentY
        )
        
        // 3. 限制列数示例
        currentY = addDemoSection(
            title: "3. 限制列数（最多3列）",
            textView: JKVerticalTextView.createLimitedColumnsExample(),
            startY: currentY
        )
        
        // 4. 英文按词拆分示例
        currentY = addDemoSection(
            title: "4. 英文按词拆分",
            textView: JKVerticalTextView.createEnglishExample(),
            startY: currentY
        )
        
        // 5. 自定义样式示例
        currentY = addDemoSection(
            title: "5. 自定义样式",
            textView: JKVerticalTextView.createCustomStyleExample(),
            startY: currentY
        )
        
        // 6. 动态配置示例
        currentY = addDynamicDemo(startY: currentY)
        
        // 设置内容高度
        contentView.heightAnchor.constraint(equalToConstant: currentY + 50).isActive = true
    }
    
    private func addDemoSection(title: String, textView: JKVerticalTextView, startY: CGFloat) -> CGFloat {
        // 创建标题标签
        let sectionLabel = UILabel()
        sectionLabel.text = title
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sectionLabel)
        
        // 配置文本视图
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textView)
        
        NSLayoutConstraint.activate([
            // Section label constraints
            sectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: startY),
            sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // TextView constraints
            textView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return startY + 240  // 标题高度 + 文本视图高度 + 间距
    }
    
    private func addDynamicDemo(startY: CGFloat) -> CGFloat {
        // 创建标题
        let sectionLabel = UILabel()
        sectionLabel.text = "6. 动态配置演示"
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sectionLabel)
        
        // 创建文本视图
        let textView = JKVerticalTextView()
        textView.text = "这是一个可以动态配置的垂直文本视图示例。你可以通过下面的按钮来改变文本内容和显示样式。"
        textView.columnWidth = 80
        textView.columnSpacing = 25
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textView)
        
        // 创建控制按钮
        let buttonStack = createControlButtons(for: textView)
        contentView.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            // Section label
            sectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: startY),
            sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // TextView
            textView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 150),
            
            // Button stack
            buttonStack.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 15),
            buttonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        return startY + 220  // 总高度
    }
    
    private func createControlButtons(for textView: JKVerticalTextView) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 按钮配置
        let buttonConfigs: [(title: String, action: () -> Void)] = [
            ("改变文本", {
                textView.setText("新的文本内容：垂直布局，多列显示，自动换行。")
            }),
            ("调整列宽", {
                textView.setColumnParameters(width: textView.columnWidth == 80 ? 60 : 80, spacing: nil, maxColumns: nil)
            }),
            ("限制列数", {
                textView.maxColumns = textView.maxColumns == nil ? 2 : nil
            }),
            ("改变颜色", {
                textView.setTextAttributes(font: nil, color: textView.textColor == .black ? .red : .black)
            })
        ]
        
        for config in buttonConfigs {
            let button = UIButton(type: .system)
            button.setTitle(config.title, for: .normal)
            button.backgroundColor = UIColor.systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.addAction(UIAction { _ in config.action() }, for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
}

// MARK: - 使用说明
/**
 在你的项目中使用此演示：
 
 1. 将演示控制器集成到你的应用中：
 ```swift
 let demoVC = JKVerticalTextViewDemoViewController()
 navigationController?.pushViewController(demoVC, animated: true)
 ```
 
 2. 或者在 TabBar 应用中使用：
 ```swift
 let demoVC = JKVerticalTextViewDemoViewController()
 let navController = UINavigationController(rootViewController: demoVC)
 tabBarController?.viewControllers?.append(navController)
 ```
 
 3. 在 StoryBoard 中使用：
 - 创建一个 UIViewController
 - 设置 Custom Class 为 JKVerticalTextViewDemoViewController
 - 连接 segue 或在代码中 present
 
 这个演示包含了 JKVerticalTextView 的各种使用场景：
 - 基础文本显示
 - 古诗词竖排
 - 列数限制
 - 英文按词拆分
 - 自定义样式
 - 动态配置
 
 通过这些示例，你可以了解如何在实际项目中使用 JKVerticalTextView 组件。
 */