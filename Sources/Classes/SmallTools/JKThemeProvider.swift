//
//  JKThemeProvider.swift
//  JKSwiftDarkMode
//
//  Created by IronMan on 2021/7/18.
//

import Foundation
import UIKit

// MARK: - JKThemeProvider协议
public protocol JKThemeProvider: AnyObject {
    func register<Observer: JKThemeable>(observer: Observer)
    func updateTheme()
}

// MARK: - JKThemeable协议
public protocol JKThemeable: AnyObject {
    func apply()
}

// MARK: - 设置遵守UITraitEnvironment的可以使用协议JKThemeable
public extension JKThemeable where Self: UITraitEnvironment {
    var themeProvider: JKThemeProvider {
        return LegacyThemeProvider.shared
    }
}

// MARK: - LegacyThemeProvider
public class LegacyThemeProvider: JKThemeProvider {
    
    /// 单粒
    static let shared = LegacyThemeProvider()
    /// 监听对象数组
    private var observers: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    /// 更新主题
    public func updateTheme() {
        notifyObservers()
    }
    
    // MARK: 注册监听
    /// 注册监听
    /// - Parameter observer: 监听对象
    public func register<Observer: JKThemeable>(observer: Observer) {
        if #available(iOS 13.0, *) {
            return
        }
        self.observers.add(observer)
    }
    
    // MARK: 通知监听对象更新theme
    /// 通知监听对象更新theme
    private func notifyObservers() {
        DispatchQueue.main.async {
            self.observers.allObjects
                .compactMap({ $0 as? JKThemeable })
                .forEach({ $0.apply() })
        }
    }
}

