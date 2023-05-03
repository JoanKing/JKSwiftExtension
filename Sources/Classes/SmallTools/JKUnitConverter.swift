//
//  JKUnitConverter.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2023/4/20.
//

//MARK: - 单位的转换
import UIKit
//MARK: - UnitConverterType
enum JKUnitConverterType: Int {
    /// 长度
    case length
    /// 质量
    case quality
    /// 温度
    case temperature
    /// 速度
    case speed
}

public struct JKUnitConverter {}
//MARK: - 长度
//MARK: - 长度(公制)
extension JKUnitConverter {
    
    //MARK: 1.1、米(m) => 公里(km)
    /// 米(m) <=> 公里(km)
    /// - Parameters:
    ///   - meter: 米(m)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 公里(km)
    public static func meterToKilometer(meter: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: meter, value2: 0.001, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)km" : "\(value)"
    }
    
    //MARK: 1.2、公里(km) => 米(m)
    /// 公里(km) <=> 米(m)
    /// - Parameters:
    ///   - kilometer: 公里(km)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 米(m)
    public static func kilometerToMeter(kilometer: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: kilometer, value2: 1000, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)m" : "\(value)"
    }
}
//MARK: - 长度(英制)
extension JKUnitConverter {
    
    //MARK: 1.3、英尺(ft) => 英里(mi)
    /// 英尺(ft) <=> 英里(mi)
    /// - Parameters:
    ///   - foot: 英尺(ft)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 英里(mi)
    public static func footToMile(foot: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .dividing, value1: foot, value2: 5280, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)mi" : "\(value)"
    }
    
    //MARK: 1.4、英里(mi) => 英尺(ft)
    /// 英里(mi) <=> 英尺(ft)
    /// - Parameters:
    ///   - mile: 英里
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 英尺(ft)
    public static func mileToFoot(mile: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: mile, value2: 5280, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)ft" : "\(value)"
    }
}

//MARK: 公里(km)/米(m) <=> 英里(mi)/英尺(ft)  -- 【英制和公制的转换】
extension JKUnitConverter {
    
    //MARK: 1.5、公里(km) => 英里(mi)
    /// 公里(km) <=> 英里(mi)
    /// - Parameters:
    ///   - kilometer: 公里(km)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 英里(mi)
    public static func kilometerToMile(kilometer: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: kilometer, value2: 0.6213712, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)mi" : "\(value)"
    }
    
    //MARK: 1.6、英里(mi) => 公里(km)
    /// 英里(mi) <=> 公里(km)
    /// - Parameters:
    ///   - kilometer: 英里(mi)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 英里(mi)
    public static func mileTokilometer(mile: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: mile, value2: 1.609344, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)km" : "\(value)"
    }
}

//MARK: - 二、质量
extension JKUnitConverter {
    //MARK: 2.1、千克(kg) => 磅(lb)
    /// 千克(kg) => 磅(lb)
    /// - Parameters:
    ///   - kg: 千克(kg)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 磅(lb)
    public static func kgToLb(kg: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: kg, value2: 2.204622621, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)lb" : "\(value)"
    }
    
    //MARK: 2.2、磅(lb) => 千克(kg)
    /// 磅(lb) => 千克(kg)
    /// - Parameters:
    ///   - lb: 磅(lb)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 千克(kg)
    public static func lbToKg(lb: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: lb, value2: 0.4535924, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)kg" : "\(value)"
    }
}

//MARK: - 温度
/**
 华氏温度与摄氏温度（Fahrenheit temperature and Celsius temperature），是两大国际主流的计量温度的标准。
 中文名：华氏温度与摄氏温度
 外文名：Fahrenheit temperature and Celsius temperature
 类型： 温标
 摄氏单位： °C
 华氏单位： °F
 换算摄氏公式：摄氏度 = (华氏度 - 32°F) ÷ 1.8 或者 1摄氏度 = 33.8华氏度
 换算华氏公式：华氏度 = 32°F+ 摄氏度 × 1.8
 */
extension JKUnitConverter {
    //MARK: 3.1、摄氏度(℃) <=> 华氏度(℉)
    /// 摄氏度(℃) <=> 华氏度(℉)
    /// - Parameters:
    ///   - temperatureC: 摄氏度(℃)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 华氏度(℉)
    public static func temperatureCToF(temperatureC: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String  {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: temperatureC, value2: 33.8, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)℉" : "\(value)"
    }
    
    //MARK: 3.2、华氏度(℉) => 摄氏度(℃)
    /// 华氏度(℉) => 摄氏度(℃)
    /// - Parameters:
    ///   - temperatureF: 华氏度(℉)
    ///   - isNeedUint: 是否需要单位
    ///   - scale: 保留小数的位数
    ///   - roundingMode: RoundingMode模式，默认的四舍五入
    /// - Returns: 摄氏度(℃)
    public static func temperatureFToC(temperatureF: String, isNeedUint: Bool = false, scale: Int16 = 1, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String  {
        let value = NSDecimalNumberHandler.jk.decimalNumberHandlerValue(type: .multiplying, value1: temperatureF, value2: -17.2222222, roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return isNeedUint ? "\(value)℃" : "\(value)"
    }
    
}
