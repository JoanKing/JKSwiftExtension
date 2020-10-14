//
//  String+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation
import UIKit
/*
 1、应用程序包：包含了所有的资源文件和可执行文件
 
 2、Documents：保存应用运行时生成的需要持久化的数据，iTunes同步设备时会备份该目录
 
 3、tmp：保存应用运行时所需要的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行，系统也可能会清除该目录下的文件，iTunes不会同步备份该目录
 
 4、Library/Cache：保存应用运行时生成的需要持久化的数据，iTunes同步设备时不备份该目录。一般存放体积大、不需要备份的非重要数据
 
 5、Library/Preference：保存应用的所有偏好设置，IOS的Settings应用会在该目录中查找应用的设置信息。iTunes
 */

/*
 - 1.Home目录
 - 整个应用程序各文档所在的目录
 - Documents
 - 需要保存由"应用程序本身"产生的文件或者数据，例如: 游戏进度，涂鸦软件的绘图
 - 目录中的文件会被自动保存在 iCloud
 - 注意: 不要保存从网络上下载的文件，否则会无法上架!
 - Caches
 - 保存临时文件,"后续需要使用"，例如: 缓存的图片，离线数据（地图数据）
 - 系统不会清理 cache 目录中的文件
 - 就要求程序开发时, "必须提供 cache 目录的清理解决方案"
 - Prepences
 - 用户偏好，使用 NSUserDefault 直接读写！
 - 如果想要数据及时写入硬盘，还需要调用一个同步方法
 - tmp
 - 保存临时文件，"后续不需要使用"
 - tmp 目录中的文件，系统会自动被清空
 - 重新启动手机, tmp 目录会被清空
 - 系统磁盘空间不足时，系统也会自动清理
 
 */
// MARK:- 沙盒路径的获取
public extension String {
    // MARK: 1.返回Home的完整路径名
    static func homeDir() -> String {
        
        //获取程序的Home目录
        let homeDirectory = NSHomeDirectory()
        return homeDirectory
    }
    
    // MARK: 2.返回Cache的完整路径名
    static func cacheDir() -> String {
        
        //Cache目录－方法1
        /*
         let cachePaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
         //let cachePath = cachePaths.last
         let cachePath = cachePaths[0]
         return cachePath
         */
        
        //Cache目录－方法2
        let cachePath2 = NSHomeDirectory() + "/Library/Caches"
        return cachePath2
    }
    
    // MARK: 3.返回Documnets的完整路径名
    static func DocumnetsDir() -> String {
        
        //获取程序的documentPaths目录
        //方法1
        //        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        //        let documnetPath = documentPaths[0]
        
        //方法2
        let ducumentPath = NSHomeDirectory() + "/Documents"
        return ducumentPath
    }
    
    /// MARK: 4.返回Library的完整路径名
    /**
     这个目录下有两个子目录：Caches 和 Preferences
     Library/Preferences目录，包含应用程序的偏好设置文件。不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好。
     Library/Caches目录，主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会再应用退出时删除
     */
    // MARK: 4.返回Library的完整路径名
    static func LibraryDir() -> String {
        
        //获取程序的documentPaths目录
        //Library目录－方法1
        //        let libraryPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        //        let libraryPath = libraryPaths[0]
        //
        //Library目录－方法2
        let libraryPath = NSHomeDirectory() + "/Library"
        return libraryPath
    }
    
    // MARK: 5.返回Tmp的完整路径名
    /// 返回Tmp的完整路径名，用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空。
    /// - Returns: description
    static func TmpDir() -> String {
        
        //方法1
        //let tmpDir = NSTemporaryDirectory()
        //方法2
        let tmpDir = NSHomeDirectory() + "/tmp"
        
        return tmpDir
    }
}

// MARK:- 字符串的空格和特殊字符的处理
public extension String {
    // MARK: Swift去除字符串前后的换行和空格
    /// Swift去除字符串前后的换行和空格
    /// - Returns: 处理后的字符串
    func trim() -> String {
        var resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }
    
    // MARK: 去除字符串前后的换行和空格
    /// 去除字符串前后的换行和空格
    var removeAllSapceAndLinefeed: String {
        var resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }

    // MARK: 去掉所有空格
    /// 去掉所有空格
    var removeAllSapce: String {
        return replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    // MARK: 去掉所有回车
    /// 去掉所有回车
    var removeLinefeed: String {
        return replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
    }
}

// MARK:- 字符串的包含的判断 和 一些其他的处理
public extension String {
    
    /// Init string with a base64 encoded string
    init ? (base64: String) {
        let pad = String(repeating: "=", count: base64.length % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }

    /// base64 encoded of string
    var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    // MARK: 字符串 转 Float
    /// 字符串 转 Float
    /// - Returns: CGFloat
    func StringToCGFloat() -> (CGFloat) {
        var cgfloat: CGFloat = 0
        if let doubleValue = Double(self) {
            cgfloat = CGFloat(doubleValue)
        }
        return cgfloat
    }
    
    // MARK: 字符串转bool
    /// 字符串转bool
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    
    /// Converts String to Int
    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// Converts String to Double
    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }

    /// Converts String to Float
    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }

    /// Converts String to Bool
    func toBool() -> Bool? {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }

    /// Converts String to NSString
    var toNSString: NSString { return self as NSString }

    ///Returns hight of rendered string
    func height(_ width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?) -> CGFloat {
        var attrib: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
        }
        let size = CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude))

        return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrib, context: nil).height)
    }
    
    // MARK: 判断是否包含某个子串
    /// 判断是否包含某个子串
    /// - Parameter find: 子串
    /// - Returns: Bool
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    // MARK: 判断是否包含某个子串 -- 忽略大小写
    ///  判断是否包含某个子串 -- 忽略大小写
    /// - Parameter find: 子串
    /// - Returns: Bool
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    /// Trims white space and new line characters, returns a new string
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK:- 金钱方面的扩展
public extension String {
    
    // MARK: 将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// 将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// - Returns: description
    func toComma() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .floor
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        if self.contains(".") {
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.minimumIntegerDigits = 1
        }
        var num = NSDecimalNumber(string: self)
        if num.doubleValue.isNaN {
            num = NSDecimalNumber(string: "0")
        }
        let result = formatter.string(from: num)
        return result
    }
    
    // MARK: 精确度的处理
    /// - Important: 字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    func accuraterDouble() -> Double? {
        guard let decimal = Decimal(string: self) else { return nil }
        JKPrint(NSDecimalNumber(decimal: decimal).doubleValue)
        return NSDecimalNumber(decimal: decimal).doubleValue
    }
    
    // MARK:- cut小数点后多余的0
    /// cut小数点后多余的0
    /// - Returns: 返回没有 0 的金额
    func cutLastZeroAfterDot() -> String {
        var rst = self
        var i = 1
        if self.contains(".") {
            while i < self.count {
                if rst.hasSuffix("0") {
                    rst.removeLast()
                    i = i + 1
                } else {
                    break
                }
            }
            if rst.hasSuffix(".") {
                rst.removeLast()
            }
            return rst
        } else {
            return self
        }
    }
}

public enum StringCutType {
    case normal, auto
}

// MARK:- 将数字的字符串处理成2位小数的情况
extension String {
    
    /// 将数字的字符串处理成2位小数的情况
    /// - Parameters:
    ///   - type: normal为固定2位小数，如1 -> 1.00, auto为自动调整， 如 1.00101010 -> 1, 1.10101010 -> 1.1
    ///   - mode: 原有NumberFormatter的的属性，如何取舍，默认是截取
    /// - Returns: 返回的字符，如果是非字符，则根据type 返回0.00 或 0
    public func cut2(type: StringCutType = .normal, mode: NumberFormatter.RoundingMode = .floor) -> String {
        var n = NSDecimalNumber(string: self)
        if n.doubleValue.isNaN {
            n = NSDecimalNumber.zero
        }
        print(n)
        let fmt = NumberFormatter()
        fmt.roundingMode = mode
        fmt.maximumFractionDigits = 2
        fmt.minimumFractionDigits = type == .normal ? 2 : 0
        fmt.minimumIntegerDigits = 1
        if let result = fmt.string(from: n) {
            return result
        }
        if type == .normal {
            return "0.00"
        } else {
            return "0"
        }
    }
    
    public func int(mode: NumberFormatter.RoundingMode = .floor) -> String {
        var n = NSDecimalNumber(string: self)
        if n.doubleValue.isNaN {
            n = NSDecimalNumber.zero
        }
        let fmt = NumberFormatter()
        fmt.roundingMode = mode
        fmt.maximumFractionDigits = 0
        fmt.minimumFractionDigits = 0
        fmt.minimumIntegerDigits = 1
        if let result = fmt.string(from: n) {
            return result
        }
        return "0"
    }
}

// MARK:- 苹果针对浮点类型计算精度问题提供出来的计算类
/// NSDecimalNumberHandler 苹果针对浮点类型计算精度问题提供出来的计算类
/**
 初始化方法
 roundingMode 舍入方式
 scale 小数点后舍入值的位数
 raiseOnExactness 精度错误处理
 raiseOnOverflow 溢出错误处理
 raiseOnUnderflow 下溢错误处理
 raiseOnDivideByZero 除以0的错误处理
 */
/**
 public enum RoundingMode : UInt {
 case plain = 0 是四舍五入
 case down = 1 是向下取整
 case up = 2 是向上取整
 case bankers = 3 是在四舍五入的基础上，加上末尾数为5时，变成偶数的规则
 }
 */
extension String {
    // MARK: ＋
    /// ＋
    /// - Parameter strNumber: strNumber description
    /// - Returns: description
    public func adding(_ strNumber: String?) -> String {
        var ln = NSDecimalNumber(string: self)
        var rn = NSDecimalNumber(string: strNumber)
        if ln.doubleValue.isNaN {
            ln = NSDecimalNumber.zero
        }
        if rn.doubleValue.isNaN {
            rn = NSDecimalNumber.zero
        }
        let final = ln.adding(rn)
        return final.stringValue
    }
    
    // MARK: －
    /// －
    /// - Parameter strNumber: strNumber description
    /// - Returns: description
    public func subtracting(_ strNumber: String?) -> String {
        var ln = NSDecimalNumber(string: self)
        var rn = NSDecimalNumber(string: strNumber)
        if ln.doubleValue.isNaN {
            ln = NSDecimalNumber.zero
        }
        if rn.doubleValue.isNaN {
            rn = NSDecimalNumber.zero
        }
        let final = ln.subtracting(rn)
        return final.stringValue
    }
    
    // MARK: ✖️
    /// ✖️
    /// - Parameter strNumber: strNumber description
    /// - Returns: description
    public func multiplying(_ strNumber: String?) -> String {
        var ln = NSDecimalNumber(string: self)
        var rn = NSDecimalNumber(string: strNumber)
        if ln.doubleValue.isNaN {
            ln = NSDecimalNumber.zero
        }
        if rn.doubleValue.isNaN {
            rn = NSDecimalNumber.zero
        }
        let final = ln.multiplying(by: rn)
        return final.stringValue
    }
    
    // MARK: ➗
    /// ➗
    /// - Parameter strNumber: strNumber description
    /// - Returns: description
    public func dividing(_ strNumber: String?) -> String {
        var ln = NSDecimalNumber(string: self)
        var rn = NSDecimalNumber(string: strNumber)
        if ln.doubleValue.isNaN {
            ln = NSDecimalNumber.zero
        }
        if rn.doubleValue.isNaN {
            rn = NSDecimalNumber.one
        }
        if rn.doubleValue == 0 {
            rn = NSDecimalNumber.one
        }
        let final = ln.dividing(by: rn)
        return final.stringValue
    }
}

// MARK:- 字符串截取的操作
extension String {
    
    // MARK: 截取字符串从开始到 index
    /// 截取字符串从开始到 index
    /// - Parameter index: 截取到的位置
    /// - Returns: 截取后的字符串
    public func sub(to index: Int) -> String {
        let end_Index = validIndex(original: index)
        return String(self[startIndex ..< end_Index])
    }

    /// 截取字符串从index到结束
    /// - Parameter index: 截取结束的位置
    /// - Returns: 截取后的字符串
    public func sub(from index: Int) -> String {
        let start_index = validIndex(original: index)
        return String(self[start_index ..< endIndex])
    }

    // MARK: 获取指定位置和大小的字符串

    public func sub(start: Int, length: Int = -1) -> String {
        var len = length
        if len == -1 {
            len = count - start
        }
        let st = index(startIndex, offsetBy: start)
        let en = index(st, offsetBy: len)
        let range = st ..< en
        return String(self[range]) // .substring(with:range)
    }

    // MARK: 切割字符串(区间范围 前闭后开)

    public func slice(_ range: CountableRange<Int>) -> String { // 如 sliceString(2..<6)
        let startIndex = validIndex(original: range.lowerBound)
        let endIndex = validIndex(original: range.upperBound)
        guard startIndex < endIndex else {
            return ""
        }
        return String(self[startIndex ..< endIndex])
    }

    // MARK: 用整数返回子字符串开始的位置

    public func position(of sub: String) -> Int {
        if sub.isEmpty {
            return 0
        }
        var pos = -1
        if let range = self.range(of: sub) {
            if !range.isEmpty {
                pos = distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
}

extension String {
    // MARK: 判断是否全是空白,包括空白字符和换行符号，长度为0返回true

    public var isBlank: Bool {
        return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == ""
    }

    // MARK: 判断是否全十进制数字，长度为0返回false

    public var isDecimalDigits: Bool {
        if isEmpty {
            return false
        }
        return trimmingCharacters(in: NSCharacterSet.decimalDigits) == ""
    }

    // MARK: 判断是否是整数

    public var isPureInt: Bool {
        let scan: Scanner = Scanner(string: self)
        var n: Int = 0
        return scan.scanInt(&n) && scan.isAtEnd
    }

    // MARK: 判断是否是Float,此处Float是包含Int的，即Int是特殊的Float

    public var isPureFloat: Bool {
        let scan: Scanner = Scanner(string: self)
        var n: Float = 0.0
        return scan.scanFloat(&n) && scan.isAtEnd
    }

    // MARK: 判断是否全是字母，长度为0返回false

    public var isLetters: Bool {
        if isEmpty {
            return false
        }
        return trimmingCharacters(in: NSCharacterSet.letters) == ""
    }

    // MARK: 判断是否是中文, 这里的中文不包括数字及标点符号

    public var isChinese: Bool {
        let mobileRgex = "(^[\u{4e00}-\u{9fef}]+$)"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }
    
    /// 是否是有效昵称，即允许“中文”、“英文”、“数字”
    public var isValidNickName: Bool {
        let rgex = "(^[\u{4e00}-\u{9faf}_a-zA-Z0-9]+$)"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", rgex)
        return checker.evaluate(with: self)    }

    // MARK: 判断是否是有效的手机号码

    public var isValidMobile: Bool {
        let mobileRgex = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199)\\d{8}$"
        //            let mobileRgex = "^((13[0-9])|(15[^4,||D)|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 判断是否是有效的电子邮件地址

    public var isValidEmail: Bool {
        let mobileRgex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 判断是否有效的身份证号码，不是太严格

    public var isValidIDCardNum: Bool {
        //            let mobileRgex = "^(\\d{14}|\\d{17})(\\d|[X])$"
        let mobileRgex = "^(\\d{15})|((\\d{17})(\\d|[X]))$"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码

    public var isValidIDCardNumStrict: Bool {
        let str = trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        let len = str.count
        if !str.isValidIDCardNum {
            return false
        }

        // 省份代码
        let areaArray = ["11", "12", "13", "14", "15", "21", "22", "23", "31", "32", "33", "34", "35", "36", "37", "41", "42", "43", "44", "45", "46", "50", "51", "52", "53", "54", "61", "62", "63", "64", "65", "71", "81", "82", "91"]
        if !areaArray.contains(str.sub(to: 2)) {
            return false
        }
        var regex = NSRegularExpression()
        var numberOfMatch = 0
        var year = 0
        switch len {
        case 15: // 15位身份证
            // 这里年份只有两位，00被处理为闰年了，对2000年是正确的，对1900年是错误的，不过身份证是1900年的应该很少了
            year = Int(str.sub(start: 6, length: 2))!
            if isLeapYear(year: year) { // 闰年
                do {
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: .caseInsensitive) // 检测出生日期的合法性

                } catch {}
            } else {
                do {
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: .caseInsensitive) // 检测出生日期的合法性

                } catch {}
            }
            numberOfMatch = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, len))

            if numberOfMatch > 0 {
                return true
            } else {
                return false
            }
        case 18: // 18位身份证
            year = Int(str.sub(start: 6, length: 4))!
            if isLeapYear(year: year) { // 闰年
                do {
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive) // 检测出生日期的合法性

                } catch {}
            } else {
                do {
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive) // 检测出生日期的合法性

                } catch {}
            }
            numberOfMatch = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, len))

            if numberOfMatch > 0 {
                var s = 0
                let jiaoYan = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3]
                for i in 0 ..< 17 {
                    if let d = Int(str.slice(i ..< (i + 1))) {
                        s += d * jiaoYan[i % 10]
                    } else {
                        return false
                    }
                }

                let Y = s % 11
                let JYM = "10X98765432"
                let M = JYM.sub(start: Y, length: 1)
                if M == str.sub(start: 17, length: 1) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }

        default:
            return false
        }
    }

    private func isLeapYear(year: Int) -> Bool {
        if year % 400 == 0 {
            return true
        } else if year % 100 == 0 {
            return false
        } else if year % 4 == 0 {
            return true
        } else {
            return false
        }
    }

    // MARK: 校验字符串位置是否合理，并返回String.Index

    public func validIndex(original: Int) -> String.Index {
        print(startIndex.utf16Offset(in: self))
        print(endIndex.utf16Offset(in: self))
        switch original {
        case ...startIndex.utf16Offset(in: self):
            return startIndex
        case endIndex.utf16Offset(in: self)...:
            return endIndex
        default:
            return index(startIndex, offsetBy: original)
        }
    }
    
    public func isValidNum() -> Bool {
        let rst: String = self.trimmingCharacters(in: .decimalDigits)
        if rst.count > 0 {
            return false
        }
        return true
    }
}

// MARK:- 字符串UI的处理
extension String {
    // MARK: 对字符串指定字体及宽度，获取Size
    public func rectSize(font: UIFont, width: CGFloat = 320) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let rect: CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size
    }

    // MARK: 对字符串指定字体及宽度，获取高度
    public func rectHeight(font: UIFont, width: CGFloat = 320) -> CGFloat {
        return rectSize(font: font, width: width).height
    }

    // MARK: 对单行字符串指定字体，获取尺寸
    public func sizeWith(font: UIFont) -> CGSize {
        let attrs = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attrs as [NSAttributedString.Key: Any])
    }
    /// label 根据宽度&字体——>高度
    public func heightAccording(width: CGFloat, font: UIFont) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        return label.sizeThatFits(rect.size).height
    }
    /// label 根据宽度&字体&行间距——>高度
    public func heightAccording(width: CGFloat, font: UIFont, lineSpacing: CGFloat) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        let attrStr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, self.count))
        label.attributedText = attrStr
        return label.sizeThatFits(rect.size).height
    }
    /// label 根据高度&字体——>宽度
    public func widthAccording(height: CGFloat, font: UIFont) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: CGFloat(MAXFLOAT), height: height)
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        return label.sizeThatFits(rect.size).width
    }
}

// MARK:- 字符串编码的处理
extension String {
    // MARK: 将16进制字符串转为Int
    public var hexInt: Int {
        return Int(self, radix: 16) ?? 0
    }

    // MARK: 特殊字符编码处理urlEncoded
    /// url编码 默认urlQueryAllowed
    public func urlEncoding(characters: CharacterSet = .urlQueryAllowed) -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            characters)
        return encodeUrlString ?? ""
    }

    /// url编码 Alamofire AFNetworking 处理方式 推荐使用
    public var urlEncoded: String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            allowedCharacterSet)
        return encodeUrlString ?? ""
    }
    /// url编码 会对所有特殊字符做编码  特殊情况下使用
    public var urlAllEncoded: String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;=/?_-.~"
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            allowedCharacterSet)
        return encodeUrlString ?? ""
    }

    // MARK: 特殊字符解码处理urlDecoded

    public var urlDecoded: String {
        let res: NSString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, self as NSString, "" as CFString, CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue))
        return res as String
    }

    // MARK: 字符串时间转化为时间

    // 此处调查了一下，format字符串的类型太多了，暂时不用枚举，由用户传入
    public func date(format str: String = "yyyy-MM-dd HH:mm") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = str
        let date = dateFormatter.date(from: self)
        if let res = date {
            return res
        } else {
            print("String Data or Format Error!!!")
            return Date()
        }
    }
    
    public func hidePhone(combine: String = "****") -> String {
        if self.count >= 11 {
            let pre = self.sub(start: 0, length: 3)
            let post = self.sub(start: 7, length: 4)
            return pre + combine + post
        } else {
            return self
        }
    }
}

// MARK:- 字符串包含表情的处理
extension String {
    
    /// 判断是否包含Emoji
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F,
                 0x1F300...0x1F5FF,
                 0x1F680...0x1F6FF,
                 0x2600...0x26FF,
                 0x2700...0x27BF,
                 0xFE00...0xFE0F:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// 判断是否包含Emoji
    func hasEmoji() -> Bool {
        let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        let pred = NSPredicate(format: "SELF MATCHES %@",pattern)
        return pred.evaluate(with: self)
    }
    
    // MARK: 去除字符串中的表情
    /// 去除字符串中的表情
    /// - Parameter text: 字符串
    /// - Returns: 去除表情后的字符串
    func disableEmoji(text: NSString) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: NSRegularExpression.Options.caseInsensitive)
            
            let modifiedString = regex.stringByReplacingMatches(in: text as String, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.length), withTemplate: "")
            
            return modifiedString
        } catch {
            print(error)
        }
        return ""
    }
    
    /// 判断是不是九宫格键盘
    func isNineKeyBoard() -> Bool {
        let other : NSString = "➋➌➍➎➏➐➑➒"
        let len = self.count
        for _ in 0..<len {
            if !(other.range(of: self).location != NSNotFound) {
                return false
            }
        }
        return true
    }
    
}

public extension String {
    
    /// Character count
    var length: Int {
        return self.count
    }
    
    /// Checks if String contains Emoji
    func includesEmoji() -> Bool {
        for i in 0...length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
}
