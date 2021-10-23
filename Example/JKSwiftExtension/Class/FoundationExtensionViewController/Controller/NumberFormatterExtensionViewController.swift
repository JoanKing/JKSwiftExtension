//
//  NumberFormatterExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/3/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class NumberFormatterExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的扩展用法", "二、进阶扩展用法"]
        dataArray = [["将Float数字转成格式化后的字符串", "将Double数字转成格式化后的字符串", "字符串转为格式化后的数字"], ["通用数字格式化", "修改分割符、分割位数", "设置格式宽度、填充符、填充位置", "设置最大整数位数、最小整数位数", "设置最大小数位数、最小小数位数", "设置前缀、后缀", "设置格式化字符串"]]
    }
}

// MARK: - 二、进阶扩展用法
extension NumberFormatterExtensionViewController {

    // MARK: 2.6、设置格式化字符串
    @objc func test27() {
        // 原始值
        let numberValue = "5432112345.67890"
        guard let formatValue = NumberFormatter.jk.setPositiveFormat(value: numberValue, positiveFormat: "###,###.######", number: .none) else {
            return
        }
        JKPrint("原始值为：\(numberValue)", "格式化后的值为：\(formatValue)")
    }
    
    // MARK: 2.5、设置前缀、后缀
    @objc func test26() {
        // 原始值
        let numberValue = "12345.6789"
        guard let formatValue = NumberFormatter.jk.setMaximumIntegerDigitsAndMinimumIntegerDigits(value: numberValue, positivePrefix: "$", positiveSuffix: "元", number: .none) else {
            return
        }
        JKPrint("原始值为：\(numberValue)", "格式化后的值为：\(formatValue)")
    }
    
    // MARK: 2.5、设置最大小数位数、最小小数位数
    @objc func test25() {
        // 原始值
        let numberValue = "12345.6789"
        guard let formatValue = NumberFormatter.jk.setmMximumFractionDigitsAndMinimumFractionDigits(value: numberValue, maximumFractionDigits: 3, minimumFractionDigits: 2)  else {
            return
        }
        JKPrint("原始值为：\(numberValue)", "格式化后的值为：\(formatValue)")
    }
    
    // MARK: 2.4、设置最大整数位数、最小整数位数
    @objc func test24() {
        // 原始值
        let numberValue = "12345.6789"
        guard let formatValue = NumberFormatter.jk.setMaximumIntegerDigitsAndMinimumIntegerDigits(value: numberValue, maximumIntegerDigits: 4, minimumIntegerDigits: 3, number: .none) else {
            return
        }
        JKPrint("原始值为：\(numberValue)", "格式化后的值为：\(formatValue)")
    }
    
    // MARK: 2.3、设置格式宽度、填充符、填充位置
    @objc func test23() {
        // 原始值
        let numberValue = "12345.6789"
        guard let formatValue = NumberFormatter.jk.setFormatWidthPaddingCharacterAndPosition(value: numberValue, formatWidth: 10, paddingCharacter: "0", paddingPosition: .beforePrefix, number: .none) else {
            return
        }
        JKPrint("原始值为：\(numberValue)", "格式化后的值为：\(formatValue)")
    }
    
    // MARK: 2.2、修改分割符、分割位数
    @objc func test22() {
        // 原始值
        let numberValue = "12345.6789"
        guard let formatValue = NumberFormatter.jk.setGroupingSeparatorAndSize(value: numberValue, separator: "-", groupingSize: 3, number: .decimal) else {
            return
        }
        JKPrint("原始值为：\(numberValue)", "格式化后的值为：\(formatValue)")
    }
    
    // MARK: 2.1、通用数字格式化
    @objc func test21() {
        // 原始值
        let numberValue = "12345.6789"
         
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式，小数形式
        numberFormatter.numberStyle = .decimal
        // 设置用组分隔
        numberFormatter.usesGroupingSeparator = true
        // 分隔符号
        numberFormatter.groupingSeparator = ","
        // 分隔位数
        numberFormatter.groupingSize = 4
        
        guard let formatValue = NumberFormatter.jk.customFormatter(value: numberValue, numberFormatter: numberFormatter) else {
            return
        }
        
        JKPrint("原始值为：\(numberValue)", "格式化后的值为：\(formatValue)")
    }
}

// MARK: - 一、基本的扩展用法
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
extension NumberFormatterExtensionViewController {
    
    // MARK: 1.3、字符串转为数字
    @objc func test13() {
        // 原始数字（需要先转成NSNumber类型）
        let number: String = "1234.5678"
        JKPrint("最初的值：\(number)", "四舍五入的整数：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .none) ?? "")", "小数形式（以国际化格式输出 保留三位小数,第四位小数四舍五入）：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .decimal) ?? "")", "百分数形式：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .percent) ?? "")", "科学计数：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .scientific) ?? "")", "朗读形式（英文表示）：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .spellOut) ?? "")", "序数形式：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .ordinal) ?? "")", "货币形式（以货币通用格式输出 保留2位小数,第三位小数四舍五入,在前面添加货币符号）：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .currency) ?? "")", "货币形式：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .currencyISOCode) ?? "")", "货币形式：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .currencyPlural) ?? "")", "会计计数：\(NumberFormatter.jk.stringFormattingNumber(value: number, number: .currencyAccounting) ?? "")")
    }
    
    // MARK: 1.2、将Double数字转成字符串
    @objc func test12() {
        //原始数字（需要先转成NSNumber类型）
        let number: Double = 1234.5678
        JKPrint("最初的值：\(number)", "四舍五入的整数：\(NumberFormatter.jk.numberFormatting(value: number, number: .none))", "小数形式（以国际化格式输出 保留三位小数,第四位小数四舍五入）：\(NumberFormatter.jk.numberFormatting(value: number, number: .decimal))", "百分数形式：\(NumberFormatter.jk.numberFormatting(value: number, number: .percent))", "科学计数：\(NumberFormatter.jk.numberFormatting(value: number, number: .scientific))", "朗读形式（英文表示）：\(NumberFormatter.jk.numberFormatting(value: number, number: .spellOut))", "序数形式：\(NumberFormatter.jk.numberFormatting(value: number, number: .ordinal))", "货币形式（以货币通用格式输出 保留2位小数,第三位小数四舍五入,在前面添加货币符号）：\(NumberFormatter.jk.numberFormatting(value: number, number: .currency))", "货币形式：\(NumberFormatter.jk.numberFormatting(value: number, number: .currencyISOCode))", "货币形式：\(NumberFormatter.jk.numberFormatting(value: number, number: .currencyPlural))", "会计计数：\(NumberFormatter.jk.numberFormatting(value: number, number: .currencyAccounting))")
    }
    
    // MARK: 1.1、将Float数字转成字符串
    @objc func test11() {
        //原始数字（需要先转成NSNumber类型）
        let number: Float = 1234.5678
        JKPrint("最初的值：\(number)", "四舍五入的整数：\(NumberFormatter.jk.numberFormatting(value: number, number: .none))", "小数形式（以国际化格式输出 保留三位小数,第四位小数四舍五入）：\(NumberFormatter.jk.numberFormatting(value: number, number: .decimal))", "百分数形式：\(NumberFormatter.jk.numberFormatting(value: number, number: .percent))", "科学计数：\(NumberFormatter.jk.numberFormatting(value: number, number: .scientific))", "朗读形式（英文表示）：\(NumberFormatter.jk.numberFormatting(value: number, number: .spellOut))", "序数形式：\(NumberFormatter.jk.numberFormatting(value: number, number: .ordinal))", "货币形式（以货币通用格式输出 保留2位小数,第三位小数四舍五入,在前面添加货币符号）：\(NumberFormatter.jk.numberFormatting(value: number, number: .currency))", "货币形式：\(NumberFormatter.jk.numberFormatting(value: number, number: .currencyISOCode))", "货币形式：\(NumberFormatter.jk.numberFormatting(value: number, number: .currencyPlural))", "会计计数：\(NumberFormatter.jk.numberFormatting(value: number, number: .currencyAccounting))")
    }
}

