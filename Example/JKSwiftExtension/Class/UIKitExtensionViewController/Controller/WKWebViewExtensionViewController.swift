//
//  WKWebViewExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/6/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import WebKit
class WKWebViewExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["WKWebViewConfiguration默认配置", "js注入", "js交互", "调整字体的比例", "加载网页", "获取WKWebView视图"]]
    }
}

// MARK: - 一、基本的扩展
extension WKWebViewExtensionViewController {
    
    // MARK: 1.06、获取WKWebView视图
    @objc func test106() {
        
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kScreenH - jk_kNavFrameH))
        wkWebView.navigationDelegate = self
        let rul = URL(string:("https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_9743234139645720408%22%7D&n_type=0&p_from=1"))
        let request = URLRequest(url: rul!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JKAsyncs.asyncDelay(5) {
        } _: {
            wkWebView.jk.snapShotContentScroll { image in
                guard let weakImage = image else {
                    return
                }
                debugPrint("开始保存图片------")
                weakImage.savePhotosImageToAlbum { result, error in
                    if result {
                        debugPrint("保存图片成功------")
                    }
                    JKAsyncs.asyncDelay(2) {
                    } _: {
                        wkWebView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    // MARK: 1.05、加载网页
    @objc func test105() {
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kScreenH - jk_kNavFrameH))
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://www.jianshu.com/p/13b77f3e52bd"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JKAsyncs.asyncDelay(5) {
        } _: {
            debugPrint("JS代码调用------------")
            wkWebView.jk.loadUrl("https://www.baidu.com")
            JKAsyncs.asyncDelay(10) {
            } _: {
                wkWebView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.04、调整字体的比例
    @objc func test104() {
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kScreenH - jk_kNavFrameH))
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://www.jianshu.com/p/13b77f3e52bd"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JKAsyncs.asyncDelay(5) {
        } _: {
            debugPrint("JS代码调用------------")
            wkWebView.jk.javaScriptFromTextSizeRatio(200)
            JKAsyncs.asyncDelay(5) {
            } _: {
                wkWebView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.03、js交互
    @objc func test103() {
        let jsCode = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(200)%'"
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kScreenH - jk_kNavFrameH))
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://www.jianshu.com/p/13b77f3e52bd"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JKAsyncs.asyncDelay(5) {
        } _: {
            debugPrint("JS代码调用------------")
            wkWebView.jk.evaluateJsCode(jsCode) { response, error in
                
            }
            JKAsyncs.asyncDelay(5) {
            } _: {
                wkWebView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.02、js注入
    @objc func test102() {
        
        // 以下代码适配大小
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kScreenH - jk_kNavFrameH))
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://www.jianshu.com/p/13b77f3e52bd"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JKAsyncs.asyncDelay(5) {
        } _: {
            debugPrint("JS代码调用------------")
            wkWebView.jk.addUserScript(jScript)
            JKAsyncs.asyncDelay(5) {
            } _: {
                wkWebView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.01、WKWebViewConfiguration 默认配置
    @objc func test101() {
        
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.selectionGranularity = .dynamic
        configuration.preferences = WKPreferences()
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        configuration.preferences.javaScriptEnabled = true
        
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kScreenH - jk_kNavFrameH), configuration: configuration)
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_9743234139645720408%22%7D&n_type=0&p_from=1"))
        // let request = URLRequest(url: url!)
        // wkWebView.load(request)
        /** 加载本地html文件 */
        //从主Bundle获取 HTML 文件的 url
        let bundleStr = Bundle.main.url(forResource: "herf", withExtension: "html")
        let request = URLRequest(url: bundleStr!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JKAsyncs.asyncDelay(5) {
        } _: {
            // wkWebView.removeFromSuperview()
        }
    }
}

extension WKWebViewExtensionViewController: WKNavigationDelegate {
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("1 页面开始加载时调用")
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("2 当内容开始返回时调用")
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("3 页面加载完成之后调用")
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        debugPrint("4 页面加载失败时调用")
    }
    
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("5 接收到服务器跳转请求之后调用")
    }
    
    // 在收到响应后，决定是否跳转 -> 默认允许
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        debugPrint("6 在收到响应后，决定是否跳转 -> 默认允许")
        // 允许跳转
        decisionHandler(.allow)
        // 不允许跳转
        // decisionHandler(.cancel)
    }
}

extension WKWebViewExtensionViewController: WKScriptMessageHandler {
    //用于与JS交互
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "和web那边一样的方法名") {
            debugPrint("JavaScript is sending a message \(message.body)")
        }
    }
}
