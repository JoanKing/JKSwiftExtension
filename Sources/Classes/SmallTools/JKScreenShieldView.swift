//
//  ScreenShieldView.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2024/3/19.
//

import UIKit

/// 屏蔽 [录屏, 截屏] 的视图（放在其上子视图都会被屏蔽截图）
public class JKScreenShieldView: UIView {
    
    private var safetyZone: UIView?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    public init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func addSubview(_ view: UIView) {
        guard let safe = safetyZone, view != safetyZone else {
            super.addSubview(view)
            return
        }
        safe.addSubview(view)
    }
    
    /// 在指定视图下方插入子视图
    override public func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView) {
        guard let safe = safetyZone, view != safetyZone else {
            super.insertSubview(view, belowSubview: siblingSubview)
            return
        }
        safe.insertSubview(view, belowSubview: siblingSubview)
    }
    
    /// 在指定视图上方插入子视图
    override public func insertSubview(_ view: UIView, aboveSubview siblingSubview: UIView) {
        guard let safe = safetyZone, view != safetyZone else {
            super.insertSubview(view, aboveSubview: siblingSubview)
            return
        }
        safe.insertSubview(view, aboveSubview: siblingSubview)
    }
    
    /// 在指定索引处插入子视图
    override public func insertSubview(_ view: UIView, at index: Int) {
        guard let safe = safetyZone, view != safetyZone else {
            super.insertSubview(view, at: index)
            return
        }
        safe.insertSubview(view, at: index)
    }
    
    /// 交换两个子视图的位置
    override public func exchangeSubview(at index1: Int, withSubviewAt index2: Int) {
        guard let safe = safetyZone else {
            super.exchangeSubview(at: index1, withSubviewAt: index2)
            return
        }
        safe.exchangeSubview(at: index1, withSubviewAt: index2)
    }
    
    /// 将某个子视图移至最前面
    override public func bringSubviewToFront(_ view: UIView) {
        guard let safe = safetyZone, view != safetyZone else {
            super.bringSubviewToFront(view)
            return
        }
        safe.bringSubviewToFront(view)
    }
    
    /// 将某个子视图移至最后面
    override public func sendSubviewToBack(_ view: UIView) {
        guard let safe = safetyZone, view != safetyZone else {
            super.sendSubviewToBack(view)
            return
        }
        safe.sendSubviewToBack(view)
    }
    
    private func setup() {
        
        safetyZone = createSafetyZoneView() ?? UIView()
        
        guard let safetyZone = self.safetyZone else {
            return
        }
        safetyZone.translatesAutoresizingMaskIntoConstraints = false
        addSubview(safetyZone)
        safetyZone.setContentHuggingPriority(.defaultLow, for: .vertical)
        safetyZone.setContentHuggingPriority(.defaultLow, for: .horizontal)
        safetyZone.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        safetyZone.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            safetyZone.topAnchor.constraint(equalTo: self.topAnchor),
            safetyZone.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            safetyZone.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            safetyZone.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    /// 设置安全区域视图
    private func createSafetyZoneView() -> UIView? {
        
        let textField = UITextField()
        textField.isSecureTextEntry = true
        let canvasView = textField.subviews.first
        canvasView?.subviews.forEach { $0.removeFromSuperview() }
        canvasView?.isUserInteractionEnabled = true
        
        return canvasView
    }
}
