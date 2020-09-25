//
//  Double+Divisible.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/25.
//

import UIKit

/// 由于String转Double后，会损失精度，故考虑添加修复经验值
public let tolerance = 0.000001
public extension Double {

    // MARK: 自己是否可以被精度位数为 accuracy 的 Double 【整除】
    /// 自己是否可以被精度位数为 accuracy 的 Double 【整除】
    /// - Parameters:
    ///   - by: 除数
    ///   - accuracy: 精度位数
    /// - Returns: 是否能被整除
    func canDivisible(by: Double, accuracy: Int) -> Bool {
        let fixSelf = self + tolerance
        let fixBy = by + tolerance
        /// 最多支持的小数点位数
        let divisor = pow(10.0, Double(accuracy))
        let pown = Int(fixSelf * divisor)
        let powinc = Int(fixBy * divisor)
        
        /// 其实用这个也是可以的
        //                let remainder = Double((pown % powinc)) / Double(Int(divisor))
        /// 由于String转Double会丢失精度，不可直接使用——取巧：先放大至Int，再转Double处理！
        let remainderUncertain = Double(pown).truncatingRemainder(dividingBy: Double(powinc)) / divisor
        // 预留if
        if remainderUncertain == 0.0 {
            JKPrint("\(self) 可以被 \(by)  整除" )
        } else {
            JKPrint("\(self) 不可以被 \(by)  整除" )
        }
        return remainderUncertain == 0.0
    }
    
    // MARK: 自己是否可以被精度位数为 accuracy 的 Double 【整除】，并返回能被整除的[向下最大值]
    /// 自己是否可以被精度位数为 accuracy 的 Double 【整除】，并返回能被整除的[向下最大值]
    /// - Parameters:
    ///   - by: 除数
    ///   - accuracy: 精度位数
    /// - Returns: (Bool, String): (是否能被整除, 能被整除的[向下最大值])
    func divisible(by: Double, accuracy: Int) -> (Bool, String) {
        let fixSelf = self + tolerance
        let fixBy = by + tolerance
        /// 最多支持的小数点位数
        let divisor = pow(10.0, Double(accuracy))
        let pown = Int(fixSelf * divisor)
        let powinc = Int(fixBy * divisor)
        
        /// 其实用这个也是可以的
        //                let remainder = Double((pown % powinc)) / Double(Int(divisor))
        /// 由于String转Double会丢失精度，不可直接使用——取巧：先放大至Int，再转Double处理！
        let remainderUncertain = Double(pown).truncatingRemainder(dividingBy: Double(powinc)) / divisor
        // 预留if
        if remainderUncertain == 0.0 {
            JKPrint("\(self) 可以被 \(by)  整除" )
        } else {
            JKPrint("\(self) 不可以被 \(by)  整除" )
        }
        
        let can = remainderUncertain == 0.0
        var downMaxValue = "0.0"
        let formatStr = "%0.\(accuracy)f"
        if !can {
            let less = String(format: formatStr, fixBy)
            let more = String(format: formatStr, (fixSelf - remainderUncertain))
            // 如果输入 < 递增
            if fixSelf < fixBy {
                downMaxValue = less
            } else { // 也只能是 >
                downMaxValue = more
            }
        } else { // 只能是 =
            let right = String(format: formatStr, fixSelf)
            downMaxValue = right
        }
        return (can, downMaxValue.cutLastZeroAfterDot())
    }
    
    // MARK: 自己是否可以被精度位数为 accuracy 的 String 【整除】
    /// 自己是否可以被精度位数为 accuracy 的 String 【整除】
    /// - Parameters:
    ///   - by: 除数字符串
    ///   - accuracy: 精度位数
    /// - Returns: Bool?: 是否能被整除
    func canDivisible(by: String, accuracy: Int) -> Bool? {
        guard let accDouble = by.accuraterDouble() else { return nil }
        let fixSelf = self + tolerance
        let fixBy = accDouble + tolerance
        /// 最多支持的小数点位数
        let divisor = pow(10.0, Double(accuracy))
        let pown = Int(fixSelf * divisor)
        let powinc = Int(fixBy * divisor)
        
        /// 其实用这个也是可以的
        //                let remainder = Double((pown % powinc)) / Double(Int(divisor))
        /// 由于String转Double会丢失精度，不可直接使用——取巧：先放大至Int，再转Double处理！
        let remainderUncertain = Double(pown).truncatingRemainder(dividingBy: Double(powinc)) / divisor
        // 预留if
        if remainderUncertain == 0.0 {
            JKPrint("\(self) 可以被 \(by)  整除" )
        } else {
            JKPrint("\(self) 不可以被 \(by)  整除" )
        }
        return remainderUncertain == 0.0
    }
    
    // MARK: 自己是否可以被精度位数为 accuracy 的 String 【整除】，并返回能被整除的[向下最大值]
    /// 自己是否可以被精度位数为 accuracy 的 String 【整除】，并返回能被整除的[向下最大值]
    /// - Parameters:
    ///   - by: 除数字符串
    ///   - accuracy: 精度位数
    /// - Returns: (Bool?, String?): (是否能被整除, 能被整除的[向下最大值])
    func divisible(by: String, accuracy: Int) -> (Bool?, String?) {
        guard let accDouble = by.accuraterDouble() else { return(nil, nil) }
        let fixSelf = self + tolerance
        let fixBy = accDouble + tolerance
        /// 最多支持的小数点位数
        let divisor = pow(10.0, Double(accuracy))
        let pown = Int(fixSelf * divisor)
        let powinc = Int(fixBy * divisor)
        
        /// 其实用这个也是可以的
        //                let remainder = Double((pown % powinc)) / Double(Int(divisor))
        /// 由于String转Double会丢失精度，不可直接使用——取巧：先放大至Int，再转Double处理！
        let remainderUncertain = Double(pown).truncatingRemainder(dividingBy: Double(powinc)) / divisor
        // 预留if
        if remainderUncertain == 0.0 {
            JKPrint("\(self) 可以被 \(by)  整除" )
        } else {
            JKPrint("\(self) 不可以被 \(by)  整除" )
        }
        
        let can = remainderUncertain == 0.0
        var downMaxValue = "0.0"
        let formatStr = "%0.\(accuracy)f"
        if !can {
            let less = String(format: formatStr, fixBy)
            let more = String(format: formatStr, (fixSelf - remainderUncertain))
            // 如果输入 < 递增
            if fixSelf < fixBy {
                downMaxValue = less
            } else { // 也只能是 >
                downMaxValue = more
            }
        } else { // 只能是 =
            let right = String(format: formatStr, fixSelf)
            downMaxValue = right
        }
        return (can, downMaxValue.cutLastZeroAfterDot())
    }
    
    // MARK: Double差不多精确转换成String——之所以差不多，是因为会有尾部的0被损失
    /// Double差不多精确转换成String——之所以差不多，是因为会有尾部的0被损失
    /// - Returns: description
    func accurateString() -> String {
        let str = String(format: "%lf", self)
        let dn = NSDecimalNumber(string: str)
        return dn.stringValue
    }
}

