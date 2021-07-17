//
//  NSNumber+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/5.
//

import Foundation

extension NSNumber: JKPOPCompatible { }

//MARK: -  基本的扩展
public extension JKPOP where Base == NSNumber {
    
    // MARK: 1.1、保留位数的设置
    /// minDigits: 最小四舍五入应保留多少小数位
    /// maxDigits: 最大保留几个小数位
    func numberFormatter(with mode: NumberFormatter.RoundingMode = .halfEven, minDigits: Int = 0, maxDigits:Int = 0) -> String? {
        return base.numberFormatter(with: mode, minDigits: minDigits, maxDigits: maxDigits)
    }
    
    // MARK: 1.2、保留两位小数
    /// 保留两位小数
    func numberFormatter() -> String? {
        return base.numberFormatter(with: .halfEven, minDigits: 0, maxDigits: 2)
    }
}

//MARK:- 扩展NSNumber的内部方法
public extension NSNumber {
    
    // MARK: 通用方法
    /// minDigits: 最小四舍五入应保留多少小数位
    /// maxDigits:最大保留几个小数位
    func numberFormatter(with mode: NumberFormatter.RoundingMode = .halfEven, minDigits: Int = 0, maxDigits:Int = 0, numberStyle: NumberFormatter.Style = .none) -> String? {
        let formate = NumberFormatter()
        /*
         NumberFormatter.Style.decimal 格式的意思是：整数部分从右往左每三位添加一个逗号，数据最多保留三位小数，和上述@"#,###.##;"和效果相似，没有小数的话会直接显示成整数，但是默认小数最多三位
         */
        formate.numberStyle = numberStyle
        formate.groupingSeparator = ","
        formate.minimumFractionDigits = minDigits
        formate.maximumFractionDigits = maxDigits
        formate.roundingMode = mode
        return formate.string(from: self)
    }
}
