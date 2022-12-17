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
    /// 智能换肤的时间区间的key
    private static let JKSmartPeelingTimeIntervalKey = "JKSmartPeelingTimeIntervalKey"
    /// 跟随系统的key
    private static let JKDarkToSystemKey = "JKDarkToSystemKey"
    /// 是否浅色模式的key
    private static let JKLightDarkKey = "JKLightDarkKey"
    /// 智能换肤的key
    private static let JKSmartPeelingKey = "JKSmartPeelingKey"
    /// 是否浅色
    public static var isLight: Bool {
        if isSmartPeeling {
            return isSmartPeelingTime() ? false : true
        }
        if let value = UserDefaults.jk.userDefaultsGetValue(key: JKLightDarkKey) as? Bool {
            return value
        }
        return true
    }
    /// 是否跟随系统
    public static var isFollowSystem: Bool {
        if #available(iOS 13, *) {
            if let value = UserDefaults.jk.userDefaultsGetValue(key: JKDarkToSystemKey) as? Bool {
                return value
            }
            return true
        }
        return false
    }
    /// 默认不是智能换肤
    public static var isSmartPeeling: Bool {
        if let value = UserDefaults.jk.userDefaultsGetValue(key: JKSmartPeelingKey) as? Bool {
            return value
        }
        return false
    }
    /// 智能换肤的时间段：默认是：21:00~8:00
    public static var SmartPeelingTimeIntervalValue: String {
        get {
            if let value = UserDefaults.jk.userDefaultsGetValue(key: JKSmartPeelingTimeIntervalKey) as? String {
                return value
            }
            return "21:00~8:00"
        }
        set {
            UserDefaults.jk.userDefaultsSetValue(value: newValue, key: JKSmartPeelingTimeIntervalKey)
        }
    }
}

// MARK: - 方法的调用
extension JKDarkModeUtil: JKThemeable {
    public func apply() {}
}

public extension JKDarkModeUtil {
    
    // MARK: 初始化的调用
    /// 默认设置
    static func defaultDark() {
        if #available(iOS 13.0, *) {
            // 默认跟随系统暗黑模式开启监听
            if (JKDarkModeUtil.isFollowSystem) {
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
            UserDefaults.jk.userDefaultsSetValue(value: isFollowSystem, key: JKDarkToSystemKey)
            let result = UITraitCollection.current.userInterfaceStyle == .light ? true : false
            UserDefaults.jk.userDefaultsSetValue(value: result, key: JKLightDarkKey)
            UserDefaults.jk.userDefaultsSetValue(value: false, key: JKSmartPeelingKey)
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
            // 1.2、设置跟随系统和智能换肤：否
            UserDefaults.jk.userDefaultsSetValue(value: false, key: JKDarkToSystemKey)
            UserDefaults.jk.userDefaultsSetValue(value: false, key: JKSmartPeelingKey)
            // 1.3、黑白模式的设置
            UserDefaults.jk.userDefaultsSetValue(value: isLight, key: JKLightDarkKey)
        } else {
            UserDefaults.jk.userDefaultsSetValue(value: false, key: JKSmartPeelingKey)
            // 模式存储
            UserDefaults.jk.userDefaultsSetValue(value: isLight, key: JKLightDarkKey)
            // 通知模式更新
            LegacyThemeProvider.shared.updateTheme()
        }
    }
    
    // MARK: 设置：智能换肤
    /// 智能换肤
    /// - Parameter isSmartPeeling: 是否智能换肤
    static func setSmartPeelingDarkMode(isSmartPeeling: Bool) {
        if #available(iOS 13.0, *) {
            // 1.1、设置智能换肤
            UserDefaults.jk.userDefaultsSetValue(value: isSmartPeeling, key: JKSmartPeelingKey)
            // 1.2、智能换肤根据时间段来设置：黑或者白
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = isLight ? .light : .dark
            // 1.3、设置跟随系统：否
            UserDefaults.jk.userDefaultsSetValue(value: false, key: JKDarkToSystemKey)
            UserDefaults.jk.userDefaultsSetValue(value: isLight, key: JKLightDarkKey)
        } else {
            // 模式存储
            // 1.1、设置智能换肤
            UserDefaults.jk.userDefaultsSetValue(value: isSmartPeeling, key: JKSmartPeelingKey)
            // 1.2、设置跟随系统：否
            UserDefaults.jk.userDefaultsSetValue(value: isLight, key: JKLightDarkKey)
            // 1.3、通知模式更新
            LegacyThemeProvider.shared.updateTheme()
        }
    }
    
    // MARK: 智能换肤时间选择后
    /// 智能换肤时间选择后
    static func setSmartPeelingTimeChange(startTime: String, endTime: String) {
        /// 是否是浅色
        var light: Bool = false
        if JKDarkModeUtil.isSmartPeelingTime(startTime: startTime, endTime: endTime), JKDarkModeUtil.isLight {
            light = false
        } else {
            if !JKDarkModeUtil.isLight {
                light = true
            } else {
                JKDarkModeUtil.SmartPeelingTimeIntervalValue = startTime + "~" + endTime
                return
            }
        }
        JKDarkModeUtil.SmartPeelingTimeIntervalValue = startTime + "~" + endTime
        
        if #available(iOS 13.0, *) {
            // 1.1、只要设置了模式：就是黑或者白
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = light ? .light : .dark
            // 1.2、黑白模式的设置
            UserDefaults.jk.userDefaultsSetValue(value: light, key: JKLightDarkKey)
        } else {
            // 模式存储
            UserDefaults.jk.userDefaultsSetValue(value: light, key: JKLightDarkKey)
            // 通知模式更新
            LegacyThemeProvider.shared.updateTheme()
        }
    }
}

// MARK: - 动态颜色的使用
public extension JKDarkModeUtil {
    static func colorLightDark(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection) -> UIColor in
                if JKDarkModeUtil.isFollowSystem {
                    if traitCollection.userInterfaceStyle == .light {
                        return lightColor
                    } else {
                        return darkColor
                    }
                } else if JKDarkModeUtil.isSmartPeeling {
                    return isSmartPeelingTime() ? darkColor : lightColor
                } else {
                    return JKDarkModeUtil.isLight ? lightColor : darkColor
                }
            }
        } else {
            // iOS 13 以下主题色的使用
            if JKDarkModeUtil.isLight {
                return lightColor
            }
            return darkColor
        }
    }
    
    // MARK: 是否为智能换肤的时间：黑色
    /// 是否为智能换肤的时间：黑色
    /// - Returns: 结果
    static func isSmartPeelingTime(startTime: String? = nil, endTime: String? = nil) -> Bool {
        // 获取暗黑模式时间的区间，转为两个时间戳，取出当前的时间戳，看是否在区间内，在的话：黑色，否则白色
        var timeIntervalValue: [String] = []
        if startTime != nil && endTime != nil {
            timeIntervalValue = [startTime!, endTime!]
        } else {
            timeIntervalValue = JKDarkModeUtil.SmartPeelingTimeIntervalValue.jk.separatedByString(with: "~")
        }
        // 1、时间区间分隔为：开始时间 和 结束时间
        // 2、当前的时间转时间戳
        let currentDate = Date()
        let currentTimeStamp = Int(currentDate.jk.dateToTimeStamp())!
        let dateString = currentDate.jk.toformatterTimeString(formatter: "yyyy-MM-dd")
        let startTimeStamp = Int(Date.jk.formatterTimeStringToTimestamp(timesString: dateString + " " + timeIntervalValue[0], formatter: "yyyy-MM-dd HH:mm", timestampType: .second))!
        var endTimeStamp = Int(Date.jk.formatterTimeStringToTimestamp(timesString: dateString + " " + timeIntervalValue[1], formatter: "yyyy-MM-dd HH:mm", timestampType: .second))!
        if startTimeStamp > endTimeStamp {
            endTimeStamp = endTimeStamp + 884600
        }
        return currentTimeStamp >= startTimeStamp && currentTimeStamp <= endTimeStamp
    }
}

// MARK: - 动态图片的使用
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
            let lightImage = weakLight.withConfiguration(config.withTraitCollection(UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.light)))
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
