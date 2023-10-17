//
//  WKWebView+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/12.
//

import UIKit
import WebKit

extension WKWebView {
    fileprivate struct WKWebViewAssociateKeys {
        static var confiDefault = UnsafeRawPointer("WKWebViewConfiDefault".withCString { $0 })
    }
}

// MARK: - 一、基本的扩展
public extension JKPOP where Base: WKWebView {
    
    // MARK: 1.1、WKWebViewConfiguration默认配置
    /// WKWebViewConfiguration默认配置
    static var confiDefault: WKWebViewConfiguration {
        get {
            if let obj = objc_getAssociatedObject(self, &WKWebView.WKWebViewAssociateKeys.confiDefault) as? WKWebViewConfiguration {
                return obj
            }
            let sender = WKWebViewConfiguration()
            sender.allowsInlineMediaPlayback = true
            sender.selectionGranularity = .dynamic
            sender.preferences = WKPreferences()
            sender.preferences.javaScriptCanOpenWindowsAutomatically = false
            sender.preferences.javaScriptEnabled = true
            
            objc_setAssociatedObject(self, &WKWebView.WKWebViewAssociateKeys.confiDefault, sender, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return sender
        }
        set {
            objc_setAssociatedObject(self, &WKWebView.WKWebViewAssociateKeys.confiDefault, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: 1.2、js注入
    /// js注入
    /// - Parameter jsCode: 注入的js代码
    func addUserScript(_ source: String) {
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        base.configuration.userContentController.addUserScript(userScript)
    }
    
    // MARK: 1.3、js交互
    /// js交互
    /// - Parameter jsCode: 注入的js代码
    func evaluateJsCode(_ jsCode: String, completionHandler: ((Any?, Error?) -> Void)? = nil) {
        base.evaluateJavaScript(jsCode, completionHandler: completionHandler)
    }
    
    // MARK: 1.4、调整字体的比例
    /// 调整字体的比例
    /// - Parameter ratio: 比例
    /// - Returns: 返回结果
    func javaScriptFromTextSizeRatio(_ ratio: CGFloat) {
        let jscode = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(ratio)%'"
        evaluateJsCode(jscode)
    }
    
    // MARK: 1.5、加载网页
    /// 加载网页：此方法解决了: Web 页面包含了 ajax 请求的话，cookie 要重新处理，这个处理需要在 WKWebView 的 WKWebViewConfiguration 中进行配置
    /// - Parameters:
    ///   - urlString: 链接
    ///   - additionalHttpHeaders: additionalHttpHeaders description
    func loadUrl(_ urlString: String?, additionalHttpHeaders: [String: String]? = nil) {
        guard let urlString = urlString,
              let urlStr = urlString.removingPercentEncoding as String?,
              let url = URL(string: urlStr) as URL?
        else {
            JKPrint("链接错误")
            return
        }
        let cookieSource: String = "document.cookie = 'user=\("userValue")';"
        let cookieScript = WKUserScript(source: cookieSource, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        let userContentController = WKUserContentController()
        userContentController.addUserScript(cookieScript)
        base.configuration.userContentController = userContentController
        
        var request = URLRequest(url: url)
        if let headFields: [AnyHashable : Any] = request.allHTTPHeaderFields {
            if headFields["user"] != nil {
            } else {
                request.addValue("user=\("userValue")", forHTTPHeaderField: "Cookie")
            }
        }
        additionalHttpHeaders?.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        base.load(request as URLRequest)
    }
    
    // MARK: 1.6、获取WKWebView视图
    /// 获取WKWebView视图
    /// - Parameter callBack: 回调函数
    /// - Returns: WKWebView视图
    func snapShotContentScroll(callBack: @escaping (UIImage?) -> ()) {
        base.scrollView.jk.snapShotContentScroll { (image) in
            callBack(image)
        }
    }
}

