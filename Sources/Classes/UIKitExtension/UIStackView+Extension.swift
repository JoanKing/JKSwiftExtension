//
//  UIStackView+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/29.
//

import UIKit

// MARK: - 一、链式编程
/**
 UIStackView 是 UIView 的子类，它不能用来呈现自身的内容，而是用来约束子控件的一个控件。
 UIStackView 提供了一个高效的接口用于平铺一行或一列的视图组合。对于嵌入到 StackView 的视图，我们不用再添加自动布局的约束了。Stack View 会管理这些子视图的布局，并帮我们自动布局约束。也就是说，这些子视图能够适应不同的屏幕尺寸。
 UIStackView 支持嵌套，我们可以将一个 Stack View 嵌套到另一个 Stack View 中，从而实现更为复杂的用户界面。
 使用 UIStackView 并不意味这不需要处理自动布局了。我们仍旧要定义一些布局约束来约束 Stack View。它只是帮我们节约了为每个 UI 元素创建约束的时间，同时它更容易的从布局中添加/删除一个视图。
 */

public extension UIStackView {
    
    // MARK: 1.1、布局时是否参照基准线，默认是 false（决定了垂直轴如果是文本的话，是否按照 baseline 来参与布局）
    /// 布局时是否参照基准线，默认是 false
    /// - Parameter arrangement: 是否参照基线
    /// - Returns: 返回自身
    @discardableResult
    func set(baselineRelative arrangement: Bool) -> Self {
        isBaselineRelativeArrangement = arrangement
        return self
    }
    
    // MARK: 1.2、设置布局时是否以控件的LayoutMargins为标准，默认为false，是以控件的bounds为标准
    /// 设置布局时是否以控件的LayoutMargins为标准，默认为 false，是以控件的bounds为标准
    /// - Parameter arrangement: 是否以控件的LayoutMargins为标准
    /// - Returns: 返回自身
    @discardableResult
    func set(layoutMarginsRelative arrangement: Bool) -> Self {
        isLayoutMarginsRelativeArrangement = arrangement
        return self
    }
    
    // MARK: 1.3、子控件布局方向(水平或者垂直),也就是轴方向
    /// 子控件布局方向(水平或者垂直),也就是轴方向
    /// - Parameter axis: 轴方向
    /// - Returns: 返回自身
    @discardableResult
    func set(axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }
    
    // MARK: 1.4、子视图在轴向上的分布方式
    /// 子视图在轴向上的分布方式
    /// - Parameter distribution: 分布方式
    /// - Returns: 返回自身
    @discardableResult
    func set(distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
    
    // MARK: 1.5、对齐模式
    /// 对齐模式
    /// - Parameter alignment: 对齐模式
    /// - Returns: 返回自身
    @discardableResult
    func set(alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    // MARK: 1.6、设置子控件间距
    /// 设置子控件间距
    /// - Parameter spacing: 子控件间距
    /// - Returns: 返回自身
    @discardableResult
    func set(spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
    
    // MARK: 1.7、添加排列子视图
    /// 添加排列子视图
    /// - Parameter items: 子视图
    /// - Returns: 返回自身
    @discardableResult
    func addArrangedSubviews(_ items: UIView...) -> Self {
        if items.isEmpty { return self }
        for i in 0..<items.count {
            addArrangedSubview(items[i])
        }
        return self
    }
}

// https://blog.csdn.net/weixin_34390105/article/details/88007306
public extension UIStackView {
    func addCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        if #available(iOS 11.0, *) {
            self.setCustomSpacing(spacing, after: arrangedSubview)
        } else {
            let separatorView = UIView(frame: .zero)
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            switch axis {
            case .horizontal:
                separatorView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
            case .vertical:
                separatorView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
            default:
                JKPrint("未知")
            }
            if let index = self.arrangedSubviews.firstIndex(of: arrangedSubview) {
                insertArrangedSubview(separatorView, at: index + 1)
            }
        }
    }
}
