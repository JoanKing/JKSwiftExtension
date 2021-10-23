//
//  NumberFormatter+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/3/10.
//

// MARK: - 数字格式化显示
import Foundation
extension NumberFormatter: JKPOPCompatible {}

// MARK: - 一、基本的扩展用法
extension JKPOP where Base == NumberFormatter {
    
    // MARK: 1.1、将Float数字转成格式化后的字符串
    /// 将数字转成字格式化后的符串
    /// - Parameters:
    ///   - value: 值
    ///   - nstyle: 相应的显示样式
    /// - Returns: 格式化后的字符串
    public static func numberFormatting(value: Float, number nstyle: NumberFormatter.Style = .none) -> String {
        //原始数字（需要先转成NSNumber类型）
        let number = NSNumber(value: value)
        /**
         NumberFormatter.Style
         .none：四舍五入的整数
         .decimal：小数形式（以国际化格式输出 保留三位小数,第四位小数四舍五入）
         .percent：百分数形式
         .scientific：科学计数
         .spellOut：朗读形式（英文表示）
         .ordinal：序数形式
         .currency：货币形式（以货币通用格式输出 保留2位小数,第三位小数四舍五入,在前面添加货币符号）
         .currencyISOCode：货币形式
         .currencyPlural：货币形式
         .currencyAccounting：会计计数
         */
        return NumberFormatter.localizedString(from: number, number: nstyle)
    }
    
    // MARK: 1.2、将Double数字转成格式化后的字符串
    /// 将数字转成格式化后的字符串
    /// - Parameters:
    ///   - value: 值
    ///   - nstyle: 相应的显示样式
    /// - Returns: 格式化后的字符串
    public static func numberFormatting(value: Double, number nstyle: NumberFormatter.Style = .none) -> String {
        //原始数字（需要先转成NSNumber类型）
        let number = NSNumber(value: value)
        return NumberFormatter.localizedString(from: number, number: nstyle)
    }
    
    // MARK: 1.3、字符串转为格式化后的数字
    /// 将数字转成格式化后的字符串
    /// - Parameters:
    ///   - value: 值
    ///   - nstyle: 相应的显示样式
    /// - Returns: 格式化后的字符串
    public static func stringFormattingNumber(value: String, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 从字符串装成数字
        guard let number = NumberFormatter().number(from: value) else {
            // fatalError("数值有问题")
            return nil
        }
        return NumberFormatter.localizedString(from: number, number: nstyle)
    }
}

// MARK: - 二、进阶扩展用法
extension JKPOP where Base == NumberFormatter {
    
    // MARK: 2.1、通用数字格式化
    /// 通用数字格式化
    /// - Parameters:
    ///   - value: 值
    ///   - numberFormatter: 格式化
    /// - Returns: 格式化后的值
    public static func customFormatter(value: String, numberFormatter: NumberFormatter) -> String? {
        // 从字符串装成数字
        guard let number = NumberFormatter().number(from: value) else {
            // fatalError("数值有问题")
            return nil
        }
        // 格式化
        guard let formatValue = numberFormatter.string(from: number) else {
            return nil
        }
        return formatValue
    }
    
    // MARK: 2.2、修改分割符、分割位数
    /// 修改分割符、分割位数
    /// - Parameters:
    ///   - value: 值
    ///   - separator: 分隔符号
    ///   - groupingSize: 分隔位数
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setGroupingSeparatorAndSize(value: String, separator: String, groupingSize: Int, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        // 设置用组分隔
        numberFormatter.usesGroupingSeparator = true
        // 分隔符号
        numberFormatter.groupingSeparator = separator
        // 分隔位数
        numberFormatter.groupingSize = groupingSize
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.3、设置格式宽度、填充符、填充位置
    /// 设置格式宽度、填充符、填充位置
    /// - Parameters:
    ///   - value: 值
    ///   - formatWidth: 补齐位数
    ///   - paddingCharacter: 不足位数补齐符
    ///   - paddingPosition: 补在的位置，默认：补在前面
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setFormatWidthPaddingCharacterAndPosition(value: String, formatWidth: Int, paddingCharacter: String, paddingPosition: NumberFormatter.PadPosition = .beforePrefix, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        numberFormatter.formatWidth = formatWidth
        numberFormatter.paddingCharacter = paddingCharacter
        numberFormatter.paddingPosition = paddingPosition
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.4、设置最大整数位数、最小整数位数
    /// 设置最大整数位数、最小整数位数
    /// - Parameters:
    ///   - value: 值
    ///   - maximumIntegerDigits: 设置最大整数位数（超过的直接截断）
    ///   - minimumIntegerDigits: 设置最小整数位数（不足的前面补0）
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setMaximumIntegerDigitsAndMinimumIntegerDigits(value: String, maximumIntegerDigits: Int, minimumIntegerDigits: Int, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        numberFormatter.maximumIntegerDigits = maximumIntegerDigits
        numberFormatter.minimumIntegerDigits = minimumIntegerDigits
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.5、设置最大小数位数、最小小数位数
    /// 设置最大小数位数、最小小数位数
    /// - Parameters:
    ///   - value: 值
    ///   - maximumIntegerDigits: 设置小数点后最多位数
    ///   - minimumIntegerDigits: 设置小数点后最少位数
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setmMximumFractionDigitsAndMinimumFractionDigits(value: String, maximumFractionDigits: Int, minimumFractionDigits: Int) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        numberFormatter.minimumFractionDigits = minimumFractionDigits
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.6、设置前缀、后缀
    /// 设置前缀、后缀
    /// - Parameters:
    ///   - value: 值
    ///   - positivePrefix: 自定义前缀
    ///   - positiveSuffix: 自定义后缀
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setMaximumIntegerDigitsAndMinimumIntegerDigits(value: String, positivePrefix: String, positiveSuffix: String, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        numberFormatter.positivePrefix = positivePrefix
        numberFormatter.positiveSuffix = positiveSuffix
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.7、设置格式化字符串
    /// 设置格式化字符串
    /// - Parameters:
    ///   - value: 值
    ///   - positiveFormat: 设置格式
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setPositiveFormat(value: String, positiveFormat: String, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        numberFormatter.positiveFormat = positiveFormat
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
}
