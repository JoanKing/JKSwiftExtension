//
//  MaskingManager.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit

@objc public class MaskingManager: NSObject {
    @objc public static let shareManager: MaskingManager = MaskingManager()
    
    private let loadingMap: NSMapTable<UIView, NSMutableArray> = NSMapTable.weakToStrongObjects()
    
    private var toastView: UIView?
    
    private override init() {}
    
    // MARK: 是否在当前的视图展示
    /// 是否在当前的视图展示
    /// - Parameter aView: 所在视图
    /// - Returns: result
    @discardableResult
    @objc public func isShow(inView aView: UIView? = UIApplication.shared.keyWindow) -> Bool {
        let view = aView ?? UIApplication.shared.keyWindow
        guard let aAView = view else {
            return false
        }
        if let loadingArr = loadingMap.object(forKey: aAView), loadingArr.count > 0 {
            return true
        }
        return false
    }
}

// MARK:- 菊花 loading
extension MaskingManager {
    // MARK: 展示 loading
    @objc public func showloading(inView aView: UIView? = UIApplication.shared.keyWindow) {
        let view = aView ?? UIApplication.shared.keyWindow
        guard let aAView = view else {
            return
        }
        if let loadingArr = loadingMap.object(forKey: aAView),
            let loading = loadingArr.lastObject {
            loadingArr.add(loading)
        } else {
            let loading = JKLoadingView()
            aAView.addSubview(loading)
            loading.snp.remakeConstraints { make in
                make.edges.equalTo(aAView).inset(UIEdgeInsets.zero)
            }
            loadingMap.setObject(NSMutableArray(object: loading), forKey: aAView)
        }
        if aAView == UIApplication.shared.keyWindow {
            windowLoingiShow(true)
        }
    }
    
    // MARK: 隐藏 loading
    @objc public func dismissloading(inView aView: UIView? = UIApplication.shared.keyWindow) {
        let view = aView ?? UIApplication.shared.keyWindow
        guard let aAView = view else {
            return
        }
        if let loadingArr = loadingMap.object(forKey: aAView),
            let loadingView = loadingMap.object(forKey: aAView)?.lastObject as? UIView {
            loadingArr.removeObject(at: loadingArr.count - 1)
            if loadingArr.count == 0 {
                loadingView.removeFromSuperview()
                loadingMap.removeObject(forKey: aAView)
            }
        } else {
            loadingMap.removeObject(forKey: aAView)
        }
        if aAView == UIApplication.shared.keyWindow,
            loadingMap.object(forKey: aAView)?.lastObject == nil {
            windowLoingiShow(false)
        }
    }
}

// MARK:- 文字的展示
extension MaskingManager {
    /// 文字的展示
    /// - Parameters:
    ///   - text: 文字
    ///   - aDuration: 展示的时间
    ///   - view: 所在的视图
    public func showToast(text: String,
                          duration aDuration: TimeInterval,
                          in view: UIView? = UIApplication.shared.keyWindow) {
        guard let inView = view else { return }
        let toastView = ToastTexView()
        toastView.textLable.text = text
        showToast(customiew: toastView, duration: aDuration, in: inView)
    }
}

// MARK:- 私有方法
extension MaskingManager {
    private func showToast(customiew aCustomView: UIView,
                           duration aDuration: TimeInterval,
                           in view: UIView) {
        toastView?.removeFromSuperview()
        toastView = aCustomView
        guard let toast = toastView else { return }
        view.addSubview(toast)
        toast.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        weak var wToast = toast
        let delay = DispatchTime.now() + aDuration
        DispatchQueue.main.asyncAfter(deadline: delay) {
            wToast?.removeFromSuperview()
        }
    }
    
    private func windowLoingiShow(_ isShow: Bool) {
        let keyEnu = loadingMap.keyEnumerator()
        while let key = keyEnu.nextObject() {
            guard let keyView = key as? UIView else {
                continue
            }
            if keyView == UIApplication.shared.keyWindow { continue }
            (loadingMap.object(forKey: keyView)?.lastObject as? UIView)?.isHidden = isShow
        }
    }
}
