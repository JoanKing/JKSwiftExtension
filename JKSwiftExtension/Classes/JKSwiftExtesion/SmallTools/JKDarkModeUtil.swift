//
//  JKDarkModeUtil.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/7/12.
//

import UIKit
/*
 默认开启：跟随系统模式
 
 1、跟随系统
 1.1、需要设置：
 UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .unspecified
 2、不跟随系统
 2.1、浅色，UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .light
 2.2、深色，UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .dark
 */
public class JKDarkModeUtil {
    
    /// 跟随系统的key
    private static let JKDarkToSystem = "JKDarkToSystem"
    /// 是否浅色模式的key
    private static let JKLightDark = "JKLightDark"
    /// 是否浅色
    public static var isLight: Bool {
        if let value = UserDefaults.jk.userDefaultsGetValue(key: JKLightDark) as? Bool {
            return value
        }
        return true
    }
    /// 是否跟随系统
    public static var isFloorSystem: Bool {
        if #available(iOS 13, *) {
            if let value = UserDefaults.jk.userDefaultsGetValue(key: JKDarkToSystem) as? Bool {
                return value
            }
            return true
        }
        return false
    }
}

// MARK:- 方法的调用
extension JKDarkModeUtil: JKThemeable {
    public func apply() {}
}

public extension JKDarkModeUtil {
    
    // MARK: 初始化的调用
    /// 默认设置
    static func defaultDark() {
        if #available(iOS 13.0, *) {
            // 默认跟随系统暗黑模式开启监听
            if (JKDarkModeUtil.isFloorSystem) {
                JKDarkModeUtil.setDarkModeFollowSystem(isFollowSystem: true)
            } else {
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = JKDarkModeUtil.isLight ? .light : .dark
            }
        }
    }
    
    // MARK: 设置系统是否跟随
    static func setDarkModeFollowSystem(isFollowSystem: Bool) {
        if #available(iOS 13.0, *) {
            // 1.1、设置是否跟随系统
            UserDefaults.jk.userDefaultsSetValue(value: isFollowSystem, key: JKDarkToSystem)
            let result = UITraitCollection.current.userInterfaceStyle == .light ? true : false
            UserDefaults.jk.userDefaultsSetValue(value: result, key: JKLightDark)
            // 1.2、设置模式的保存
            if isFollowSystem {
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .unspecified
            } else {
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle
            }
        }
    }
    
    // MARK: 设置：浅色 / 深色
    static func setDarkModeCustom(isLight: Bool) {
        if #available(iOS 13.0, *) {
            // 1.1、只要设置了模式：就是黑或者白
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = isLight ? .light : .dark
            // 1.2、设置跟随系统：否
            UserDefaults.jk.userDefaultsSetValue(value: false, key: JKDarkToSystem)
            UserDefaults.jk.userDefaultsSetValue(value: isLight, key: JKLightDark)
        } else {
            // 模式存储
            UserDefaults.jk.userDefaultsSetValue(value: isLight, key: JKLightDark)
            // 通知模式更新
            LegacyThemeProvider.shared.updateTheme()
        }
    }
}

// MARK:- 动态颜色的使用
public extension JKDarkModeUtil {
    static func colorLightDark(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection) -> UIColor in
                if JKDarkModeUtil.isFloorSystem {
                    if traitCollection.userInterfaceStyle == .light {
                        return light
                    } else {
                        return dark
                    }
                } else {
                    return JKDarkModeUtil.isLight ? light : dark
                }
            }
        } else {
            // iOS 13 以下主题色的使用
            if JKDarkModeUtil.isLight {
                return light
            }
            return dark
        }
    }
}

// MARK:- 动态图片的使用
public extension JKDarkModeUtil {

    // MARK: 深色图片和浅色图片切换 （深色模式适配）
    /// 深色图片和浅色图片切换 （深色模式适配）
    /// - Parameters:
    ///   - light: 浅色图片
    ///   - dark: 深色图片
    /// - Returns: 最终图片
    static func image(light: UIImage?, dark: UIImage?) -> UIImage? {
        if #available(iOS 13.0, *) {
            guard let weakLight = light, let weakDark = dark, let config = weakLight.configuration else { return light }
            let lightImage = weakLight.withConfiguration(config.withTraitCollection(UITraitCollection.init(userInterfaceStyle: UIUserInterfaceStyle.light)))
            lightImage.imageAsset?.register(weakDark, with: config.withTraitCollection(UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.dark)))
            return lightImage.imageAsset?.image(with: UITraitCollection.current) ?? light
        } else {
            // iOS 13 以下主题色的使用
            if JKDarkModeUtil.isLight {
                return light
            }
            return dark
        }
    }
}
