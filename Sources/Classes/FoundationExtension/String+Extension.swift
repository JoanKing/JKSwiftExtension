//
//  String+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto
import CryptoKit

/// 字符串取类型的长度
public enum StringTypeLength {
    /// Unicode字符个数
    case count
    /// utf8
    case utf8
    /// utf16获取长度对应NSString的.length方法
    case utf16
    /// unicodeScalars
    case unicodeScalars
    /// utf8编码通过字节判断长度
    case lengthOfBytesUtf8
    /// 英文 = 1，数字 = 1，汉语 = 2
    case customCountOfChars
}

// MARK: - 一：字符串基本的扩展
public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 1.1、字符串的长度
    /// 字符串的长度
    var length: Int {
        let string = base as! String
        return string.count
    }
    
    // MARK: 1.2、字符串取类型的长度
    /// 字符串取类型的长度
    func typeLengh(_ type: StringTypeLength) -> Int {
        let string = base as! String
        if type == .utf8 {
            return string.utf8.count
        } else if type == .utf16 {
            return string.utf16.count
        } else if type == .unicodeScalars {
            return string.unicodeScalars.count
        } else if type == .lengthOfBytesUtf8 {
            return string.lengthOfBytes(using: .utf8)
        }  else if type == .customCountOfChars {
            return string.jk.customCountOfChars()
        }
        return string.count
    }
    
    // MARK: 1.2、判断是否包含某个子串
    /// 判断是否包含某个子串
    /// - Parameter find: 子串
    /// - Returns: Bool
    func contains(find: String) -> Bool {
        return (base as! String).range(of: find) != nil
    }
    
    // MARK: 1.3、判断是否包含某个子串 -- 忽略大小写
    ///  判断是否包含某个子串 -- 忽略大小写
    /// - Parameter find: 子串
    /// - Returns: Bool
    func containsIgnoringCase(find: String) -> Bool {
        return (base as! String).range(of: find, options: .caseInsensitive) != nil
    }
    
    // MARK: 1.4、字符串转 base64
    /// 字符串 Base64 编码
    var base64Encode: String? {
        guard let codingData = (base as! String).data(using: .utf8) else {
            return nil
        }
        return codingData.base64EncodedString()
    }
    // MARK: 1.5、base64转字符串转
    /// 字符串 Base64 编码
    var base64Decode: String? {
        guard let decryptionData = Data(base64Encoded: base as! String, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return String(data: decryptionData, encoding: .utf8)
    }
    
    // MARK: 1.6、将16进制字符串转为Int
    /// 将16进制字符串转为Int
    var hexInt: Int {
        return Int(base as! String, radix: 16) ?? 0
    }
    
    // MARK: 1.7、判断是不是九宫格键盘
    /// 判断是不是九宫格键盘
    func isNineKeyBoard() -> Bool {
        let other: NSString = "➋➌➍➎➏➐➑➒"
        let len = (base as! String).count
        for _ in 0..<len {
            if !(other.range(of: base as! String).location != NSNotFound) {
                return false
            }
        }
        return true
    }
    
    // MARK: 1.8、转成拼音
    /// 转成拼音
    /// - Parameter isLatin: true：带声调，false：不带声调，默认 false
    /// - Returns: 拼音
    func toPinyin(_ isTone: Bool = false) -> String {
        let mutableString = NSMutableString(string: self.base as! String)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        if !isTone {
            // 不带声调
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        }
        return mutableString as String
    }
    
    // MARK: 1.9、提取首字母, "爱国" --> AG
    /// 提取首字母, "爱国" --> AG
    /// - Parameter isUpper:  true：大写首字母，false: 小写首字母，默认 true
    /// - Returns: 字符串的首字母
    func pinyinInitials(_ isUpper: Bool = true) -> String {
        let pinyin = toPinyin(false).components(separatedBy: " ")
        let initials = pinyin.compactMap { String(format: "%c", $0.cString(using:.utf8)![0]) }
        return isUpper ? initials.joined().uppercased() : initials.joined()
    }
    
    // MARK: 1.110、字符串根据某个字符进行分隔成数组
    /// 字符串根据某个字符进行分隔成数组
    /// - Parameter char: 分隔符
    /// - Returns: 分隔后的数组
    func separatedByString(with char: String) -> Array<String> {
        let arraySubstrings = (base as! String).components(separatedBy: char)
        let arrayStrings: [String] = arraySubstrings.compactMap { "\($0)" }
        return arrayStrings
    }
    
    // MARK: 1.11、设备的UUID
    /// 设备的UUID
    static func stringWithUUID() -> String? {
        let uuid = CFUUIDCreate(kCFAllocatorDefault)
        let cfString = CFUUIDCreateString(kCFAllocatorDefault, uuid)
        return cfString as String?
    }
    
    // MARK: 1.12、复制
    /// 复制
    func copy() {
        UIPasteboard.general.string = (self.base as! String)
    }
    
    // MARK: 1.13、提取出字符串中所有的URL链接
    /// 提取出字符串中所有的URL链接
    /// - Returns: URL链接数组
    func getUrls() -> [String]? {
        var urls = [String]()
        // 创建一个正则表达式对象
        guard let dataDetector = try? NSDataDetector(types:  NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue)) else {
            return nil
        }
        // 匹配字符串，返回结果集
        let res = dataDetector.matches(in: self.base as! String, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, (self.base as! String).count))
        // 取出结果
        for checkingRes in res {
            urls.append((self.base as! NSString).substring(with: checkingRes.range))
        }
        return urls
    }
    
    // MARK: 1.14、String或者String HTML标签转富文本设置
    /// String 或者String HTML标签 转 html 富文本设置
    /// - Parameters:
    ///   - font: 设置字体
    ///   - lineSpacing: 设置行高
    /// - Returns: 默认不将 \n替换<br/> 返回处理好的富文本
    func setHtmlAttributedString(font: UIFont? = UIFont.systemFont(ofSize: 16), lineSpacing: CGFloat? = 10) -> NSMutableAttributedString {
        var htmlString: NSMutableAttributedString? = nil
        do {
            if let data = (self.base as! String).replacingOccurrences(of: "\n", with: "<br/>").data(using: .utf8) {
                htmlString = try NSMutableAttributedString(data: data, options: [
                    NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                    NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
                ], documentAttributes: nil)
                let wrapHtmlString = NSMutableAttributedString(string: "\n")
                // 判断尾部是否是换行符
                if let weakHtmlString = htmlString, weakHtmlString.string.hasSuffix("\n") {
                    htmlString?.deleteCharacters(in: NSRange(location: weakHtmlString.length - wrapHtmlString.length, length: wrapHtmlString.length))
                }
            }
        } catch {
        }
        // 设置富文本字的大小
        if let font = font {
            htmlString?.addAttributes([
                NSAttributedString.Key.font: font
            ], range: NSRange(location: 0, length: htmlString?.length ?? 0))
        }
        
        // 设置行间距
        if let weakLineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = weakLineSpacing
            htmlString?.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: htmlString?.length ?? 0))
        }
        return htmlString ?? NSMutableAttributedString(string: self.base as! String)
    }
    
    // MARK: 1.15、计算字符个数（英文 = 1，数字 = 1，汉语 = 2）
    /// 计算字符个数（英文 = 1，数字 = 1，汉语 = 2）
    /// - Returns: 返回字符的个数
    func customCountOfChars() -> Int {
        var count = 0
        guard (self.base as! String).count > 0 else { return 0 }
        for i in 0...(self.base as! String).count - 1 {
            let c: unichar = ((self.base as! String) as NSString).character(at: i)
            if (c >= 0x4E00) {
                count += 2
            } else {
                count += 1
            }
        }
        return count
    }
    
    // MARK: 1.16、本地化字符串
    /// 本地化字符串
    var localized: String {
        return NSLocalizedString((self.base as! String), comment: "")
    }
    
    // MARK: 1.17、每n个字符后插入一些字符或字符串
    /// 每 n 个字符后插入一些字符或字符串
    /// - Parameters:
    ///   - length:  n 个字符
    ///   - separator:  插入的字符或字符串
    /// - Returns: 格式化后的字符
    func splitByLength(length: Int, withSeparator separator: String) -> String {
        let content = (self.base as! String)
        var result: [String] = []
        var startIndex = content.startIndex
        while startIndex < content.endIndex {
            let endIndex = content.index(startIndex, offsetBy: length, limitedBy: content.endIndex) ?? content.endIndex
            result.append(String(content[startIndex..<endIndex]))
            startIndex = endIndex
        }
        return result.joined(separator: separator)
    }
}

// MARK: - 二、字符串与其他类型(字符串转 UIViewController、AnyClass、数组、字典等)的转换
public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 2.1、字符串转 UIViewController
    /// 字符串转 UIViewController
    /// - Returns: 对应的控制器
    @discardableResult
    func toViewController() -> UIViewController? {
        // 1.获取类
        guard let trueClass: AnyClass = self.toClass() else {
            return nil
        }
        // 2.通过类创建对象
        // 2.1、将AnyClass 转化为指定的类
        guard let vcClass = trueClass as? UIViewController.Type else {
            return nil
        }
        // 2.2、通过class创建对象
        let vc = vcClass.init()
        return vc
    }
    
    // MARK: 2.2、字符串转 AnyClass
    /// 字符串转 AnyClass
    /// - Returns: 对应的 Class
    @discardableResult
    func toClass() -> AnyClass? {
        // 1.动态获取命名空间
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 2.将字符串转换为类
        // 2.1.默认情况下命名空间就是项目的名称，但是命名空间的名称是可以更改的
        guard let Class: AnyClass = NSClassFromString(namespace.jk.removeSomeStringUseSomeString(removeString: " ", replacingString: "_") + "." + (base as! String)) else {
            return nil
        }
        return Class
    }
    
    // MARK: 2.3、字符串转数组
    /// 字符串转数组
    /// - Returns: 转化后的数组
    func toArray() -> Array<Any> {
        let a = Array(base as! String)
        return a
    }
    
    // MARK: 2.4、JSON 字符串 ->  Dictionary
    /// JSON 字符串 ->  Dictionary
    /// - Returns: Dictionary
    func jsonStringToDictionary() -> Dictionary<String, Any>? {
        let jsonString = self.base as! String
        guard let jsonData: Data = jsonString.data(using: .utf8) else { return nil }
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return (dict as! Dictionary<String, Any>)
        }
        return nil
    }
    
    // MARK: 2.5、JSON 字符串 -> Array
    /// JSON 字符串 ->  Array
    /// - Returns: Array
    func jsonStringToArray() -> Array<Any>? {
        let jsonString = self.base as! String
        guard let jsonData: Data = jsonString.data(using: .utf8) else { return nil }
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return (array as! Array<Any>)
        }
        return nil
    }
    
    // MARK: 2.6、字符串转成 CGRect
    /// 字符串转成 CGRect
    func toCGRect() -> CGRect? {
        // 1、判断是否为空字符串
        var content = (self.base as! String)
        guard !content.isEmpty else {
            return nil
        }
        // 2、去除所有的空格和换行
        content = (self.base as! String).jk.removeAllLineAndSapcefeed
        // 3.1、正则判断 "{{0,0},{375,812}}"
        let pattern1 = #"^\{\{\d+,\d+\},\{\d+,\d+\}\}$"#
        if content.jk.predicateValue(rgex: pattern1) {
            return NSCoder.cgRect(for: self.base as! String)
        }
        // 3.2、正则判断 "(0,20,30,40)"
        let pattern2 = #"^\((\d+),(\d+),(\d+),(\d+)\)$"#
        if content.jk.predicateValue(rgex: pattern2) {
            let results = JKRegexHelper.matchesResult(content: content, pattern: #"\d+"#)
            let numbers = results.map { match in
                String(content[Range(match.range, in: content)!])
            }
            guard numbers.count == 4 else { return nil }
            content = "{{\(numbers[0]), \(numbers[1])}, {\(numbers[2]), \(numbers[3])}}"
            return NSCoder.cgRect(for: content)
        }
        return nil
    }
}

// MARK: - 三、沙盒路径的获取
/*
 - 1、Home(应用程序包)目录
 - 整个应用程序各文档所在的目录,包含了所有的资源文件和可执行文件
 - 2、Documents
 - 保存应用运行时生成的需要持久化的数据，iTunes同步设备时会备份该目录
 - 需要保存由"应用程序本身"产生的文件或者数据，例如: 游戏进度，涂鸦软件的绘图
 - 目录中的文件会被自动保存在 iCloud
 - 注意: 不要保存从网络上下载的文件，否则会无法上架!
 - 3、Library
 - 3.1、Library/Cache
 - 保存应用运行时生成的需要持久化的数据，iTunes同步设备时不备份该目录。一般存放体积大、不需要备份的非重要数据
 - 保存临时文件,"后续需要使用"，例如: 缓存的图片，离线数据（地图数据）
 - 系统不会清理 cache 目录中的文件
 - 就要求程序开发时, "必须提供 cache 目录的清理解决方案"
 - 3.2、Library/Preference
 - 保存应用的所有偏好设置，IOS的Settings应用会在该目录中查找应用的设置信息。iTunes
 - 用户偏好，使用 NSUserDefault 直接读写！
 - 如果想要数据及时写入硬盘，还需要调用一个同步方法
 - 4、tmp
 - 保存临时文件，"后续不需要使用"
 - tmp 目录中的文件，系统会自动被清空
 - 重新启动手机, tmp 目录会被清空
 - 系统磁盘空间不足时，系统也会自动清理
 - 保存应用运行时所需要的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行，系统也可能会清除该目录下的文件，iTunes不会同步备份该目录
 */
public extension JKPOP where Base: ExpressibleByStringLiteral {
    // MARK: 3.1、获取Home的完整路径名
    /// 获取Home的完整路径名
    /// - Returns: Home的完整路径名
    static func homeDirectory() -> String {
        //获取程序的Home目录
        let homeDirectory = NSHomeDirectory()
        return homeDirectory
    }
    
    // MARK: 3.2、获取Documnets的完整路径名
    /// 获取Documnets的完整路径名
    /// - Returns: Documnets的完整路径名
    static func DocumnetsDirectory() -> String {
        //获取程序的documentPaths目录
        //方法1
        // let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        // let documnetPath = documentPaths[0]
        
        //方法2
        let ducumentPath = NSHomeDirectory() + "/Documents"
        return ducumentPath
    }
    
    // MARK: 3.3、获取Library的完整路径名
    /**
     这个目录下有两个子目录：Caches 和 Preferences
     Library/Preferences目录，包含应用程序的偏好设置文件。不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好。
     Library/Caches目录，主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会再应用退出时删除
     */
    /// 获取Library的完整路径名
    /// - Returns: Library的完整路径名
    static func LibraryDirectory() -> String {
        //获取程序的documentPaths目录
        //Library目录－方法1
        // let libraryPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        // let libraryPath = libraryPaths[0]
        //
        // Library目录－方法2
        let libraryPath = NSHomeDirectory() + "/Library"
        return libraryPath
    }
    
    // MARK: 3.4、获取/Library/Caches的完整路径名
    /// 获取/Library/Caches的完整路径名
    /// - Returns: /Library/Caches的完整路径名
    static func CachesDirectory() -> String {
        //获取程序的/Library/Caches目录
        let cachesPath = NSHomeDirectory() + "/Library/Caches"
        return cachesPath
    }
    
    // MARK: 3.5、获取Library/Preferences的完整路径名
    /// 获取Library/Preferences的完整路径名
    /// - Returns: Library/Preferences的完整路径名
    static func PreferencesDirectory() -> String {
        //Library/Preferences目录－方法2
        let preferencesPath = NSHomeDirectory() + "/Library/Preferences"
        return preferencesPath
    }
    
    // MARK: 3.6、获取Tmp的完整路径名
    /// 获取Tmp的完整路径名，用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空。
    /// - Returns: Tmp的完整路径名
    static func TmpDirectory() -> String {
        //方法1
        //let tmpDir = NSTemporaryDirectory()
        //方法2
        let tmpDir = NSHomeDirectory() + "/tmp"
        return tmpDir
    }
}

// MARK: - 四、iOS CharacterSet（字符集）
/**
 CharacterSet是在Foundation框架下的一个结构体，用于搜索操作的一组Unicode字符值。官方的API地址：https://developer.apple.com/documentation/foundation/characterset
 概述
 字符集表示一组符合unicode的字符。基础类型使用字符集将字符组合在一起进行搜索操作，以便在搜索期间可以找到任何特定的字符集。
 这种类型提供了“写时复制”的行为，并且还连接到Objective-C NSCharacterSet类。
 总之就是将unicode字符，按组分类，便于搜索查找，验证字符串。通常我们在一些场景下会用到一个字符串是否包含某种特定字符，比如判断密码是否只包含数字，检查url是否有不规范字符，删除多余空格等操作
 
 属性                                                              描述
 CharacterSet.alphanumerics
 
 controlCharacters:                  控制符
 whitespaces:                           空格
 whitespacesAndNewlines:      空格和换行
 decimalDigits:                          0-9的数字，也不包含小数点
 letters:                                      所有英文字母，包含大小写 65-90 97-122
 lowercaseLetters:                     小写英文字母 97-122
 uppercaseLetters:                    大写英文字母 65-90
 nonBaseCharacters:                非基础字符 M*
 alphanumerics:                         字母和数字的组合，包含大小写, 不包含小数点
 decomposables:                       可分解
 illegalCharacters:                     不合规字符，没有在Unicode 3.2 标准中定义的字符
 punctuationCharacters:            标点符号，连接线，引号什么的 P*
 capitalizedLetters:                    字母，首字母大写，Lt类别
 symbols:                                   符号，包含S* 所有内容，运算符，货币符号什么的
 newlines:                                  返回一个包含换行符的字符集，U+000A ~ U+000D, U+0085, U+2028, and U+2029
 urlUserAllowed:
 urlPasswordAllowed:
 urlHostAllowed:
 urlPathAllowed:
 urlQueryAllowed:
 urlFragmentAllowed:
 bitmapRepresentation:
 inverted:                                    相反的字符集。例如CharacterSet.whitespaces.inverted 就是没有空格
 */
public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 4.1、去除字符串前后的 空格
    /// 去除字符串前后的 空格
    var removeBeginEndAllSapcefeed: String {
        let resultString = (base as! String).trimmingCharacters(in: CharacterSet.whitespaces)
        return resultString
    }
    
    // MARK: 4.2、去除字符串前后的 换行
    /// 去除字符串前后的 换行
    var removeBeginEndAllLinefeed: String {
        let resultString = (base as! String).trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }
    
    // MARK: 4.3、去除字符串前后的 换行和空格
    /// 去除字符串前后的 换行和空格
    var removeBeginEndAllSapceAndLinefeed: String {
        var resultString = (base as! String).trimmingCharacters(in: CharacterSet.whitespaces)
        resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }
    
    // MARK: 4.4、去掉所有空格
    /// 去掉所有空格
    var removeAllSapce: String {
        return (base as! String).replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    // MARK: 4.5、去掉所有换行
    /// 去掉所有换行
    var removeAllLinefeed: String {
        return (base as! String).replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
    }
    
    // MARK: 4.6、去掉所有空格 和 换行
    /// 去掉所有的空格 和 换行
    var removeAllLineAndSapcefeed: String {
        // 去除所有的空格
        var resultString = (base as! String).replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        // 去除所有的换行
        resultString = resultString.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
        return resultString
    }
    
    // MARK: 4.7、是否是 0-9 的数字，也不包含小数点
    /// 是否是 0-9 的数字，也不包含小数点
    /// - Returns: 结果
    func isValidNumber() -> Bool {
        /// 0-9的数字，也不包含小数点
        let rst: String = (base as! String).trimmingCharacters(in: .decimalDigits)
        if rst.count > 0 {
            return false
        }
        return true
    }
    
    // MARK: 4.8、url进行编码
    /// url 进行编码
    /// - Returns: 返回对应的URL
    func urlEncode() -> String {
        // 为了不把url中一些特殊字符也进行转换(以%为例)，自己添加到字符集中
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "%")
        return (base as! String).addingPercentEncoding(withAllowedCharacters: charSet) ?? ""
    }
    
    // MARK: 4.9、url进行解码
    /// url解码
    func urlDecode() -> String {
        return (base as! String).removingPercentEncoding ?? ""
    }
    
    // MARK: 4.10、某个字符使用某个字符替换掉
    /// 某个字符使用某个字符替换掉
    /// - Parameters:
    ///   - removeString: 原始字符
    ///   - replacingString: 替换后的字符
    /// - Returns: 替换后的整体字符串
    func removeSomeStringUseSomeString(removeString: String, replacingString: String = "") -> String {
        return (base as! String).replacingOccurrences(of: removeString, with: replacingString)
    }
    
    //MARK: 4.11、字符串指定range替换
    /// 字符串指定range替换
    /// - Parameters:
    ///   - range: range
    ///   - replacingString: 指定范围内新的字符串
    /// - Returns: 返回新的字符串
    func replacingCharacters(range: NSRange, replacingString: String = "") -> String {
        return ((base as! String) as NSString).replacingCharacters(in: range, with: replacingString)
    }
    
    // MARK: 4.12、使用正则表达式替换某些子串
    /// 使用正则表达式替换
    /// - Parameters:
    ///   - pattern: 正则
    ///   - with: 用来替换的字符串
    ///   - options: 策略
    /// - Returns: 返回替换后的字符串
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: (base as! String), options: [],
                                              range: NSMakeRange(0, (base as! String).count),
                                              withTemplate: with)
    }
    
    // MARK: 4.13、删除指定的字符
    /// 删除指定的字符
    /// - Parameter characterString: 指定的字符
    /// - Returns: 返回删除后的字符
    func removeCharacter(characterString: String) -> String {
        let characterSet = CharacterSet(charactersIn: characterString)
        return (base as! String).trimmingCharacters(in: characterSet)
    }
}

// MARK: - 五、字符串的转换
public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 5.1、字符串 转 CGFloat
    /// 字符串 转 Float
    /// - Returns: CGFloat
    func toCGFloat() -> CGFloat? {
        if let doubleValue = Double(base as! String) {
            return CGFloat(doubleValue)
        }
        return nil
    }
    
    // MARK: 5.2、字符串转 Bool
    /// 字符串转 Bool
    /// - Returns: Bool
    func toBool() -> Bool? {
        switch (base as! String).lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    
    // MARK: 5.3、字符串转 Int
    /// 字符串转 Int
    /// - Returns: Int
    func toInt() -> Int? {
        guard let doubleValue = Double(base as! String) else { return nil }
        return Int(doubleValue)
    }
    
    // MARK: 5.4、字符串转 Double
    /// 字符串转 Double
    /// - Returns: Double
    func toDouble() -> Double? {
        return Double(base as! String)
    }
    
    // MARK: 5.5、字符串转通过NSDecimalNumberHandler转Double
    /// 字符串转通过NSDecimalNumberHandler转Double
    /// - Returns: Double
    func toDecimalDouble(roundingMode: NSDecimalNumber.RoundingMode = .plain, scale: Int16 = 2) -> Double? {
        if let _ = Double(base as! String) {
            let decimalNumberHandler = NSDecimalNumberHandler.jk.digitalTradeOff(value1: base, roundingMode: roundingMode, scale: scale)
            return decimalNumberHandler.doubleValue.isNaN ? nil : decimalNumberHandler.doubleValue
        } else {
            return nil
        }
    }
    
    // MARK: 5.6、字符串转 Float
    /// 字符串转 Float
    /// - Returns: Float
    func toFloat() -> Float? {
       return Float(base as! String)
    }
    
    // MARK: 5.7、字符串转 NSString
    /// 字符串转 NSString
    var toNSString: NSString {
        return (base as! String) as NSString
    }
    
    // MARK: 5.8、字符串转 Int64
    /// 字符串转 Int64
    var toInt64Value: Int64? {
        return Int64(base as! String)
    }
    
    // MARK: 5.9、字符串转 NSNumber
    /// 字符串转 NSNumber
    var toNumber: NSNumber? {
        return self.toDouble()?.jk.number
    }
    
    //MARK: 5.10、数字金额转换成大写人民币金额
    /// 数字金额转换成大写人民币金额
    /// - Parameters:
    ///   - scale: 保留小数位数
    ///   - roundingMode: 取舍方式
    /// - Returns: 大写人民币金额
    ///
    /// 提示：double 双精度浮点, 64取值范围是-1022 - 1023 有效数位15
    func convertToRMB(scale: Int16 = 2, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        // 1、小数后保留的位数，最高支持4位到厘，具体的分为角、分、毫、厘
        var rMBScale: Int16 = scale
        if scale > 4 || scale < 1 {
            rMBScale = 4
        }
        // 2、单位的设置
        let decimalValue = NSDecimalNumberHandler.jk.calculation(type: .multiplying, value1: self.base, value2: 1, roundingMode: roundingMode, scale: rMBScale)
        let numberString = "\(decimalValue)"
        // 2.1、包含小数部分的处理
        var parts: [String] = [numberString]
        if numberString.jk.contains(find: ".") {
            // 根据点(.)分割字符串
            parts = numberString.split(separator: ".").compactMap({ value in
                return "\(value)"
            })
        }
        // 2.2、汉字的数字
        let chineseNumbers = ["零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"]
        // 2.3、基础金额单位，在此只处理到仟秭(qiān zǐ)
        let chineseUnits = ["", "拾", "佰", "仟"]
        // 2.4、每个阶段单位的划分
        let units = ["", "万", "亿", "兆", "京", "垓", "秭"]
        // 2.5、整数部分
        let integerPart = parts[0]
        guard integerPart.count <= 4 * units.count else {
            #if DEBUG
            assert(false, "金额太大，无法处理")
            #endif
            return "金额太大，无法处理"
        }
        
        // 3、整数部分大写金额
        var integerString = ""
        var count = 0
        if integerPart.count > 0, integerPart != "0" {
            for i in (0..<integerPart.count).reversed() {
                // 取出对用位置的值，转Int，再取出对应的中文数字
                let chIndex = integerPart.jk.sub(start: i, length: 1).jk.toInt() ?? 0
                // 中文数字
                let ch = chineseNumbers[chIndex]
                // 对应的单位
                var unitString: String = ""
                // 此位置仅仅是为了获取大单位和小单位
                if (integerPart.count - i - 1) % 4 == 0 {
                    // 是否往左3位全是0
                    var isAllZero: Bool = true
                    // 再往左3位是不是也是零，是的话就不最低位的单位了，比如100001234就不要万了，直接是亿
                    for zeroIndex in 0...3 where i - zeroIndex >= 0 {
                        let zeroValue = integerPart.jk.sub(start: i - zeroIndex, length: 1)
                        if zeroValue != "0" {
                            isAllZero = false
                            break
                        }
                    }
                    if isAllZero {
                        // 大单位四个全是0，就不要单位了
                    } else {
                        // 不等于0才有单位
                        unitString = units[(integerPart.count - i - 1) / 4]
                    }
                } else {
                    if ch != "零" {
                        // 不等于0才有单位
                        unitString = chineseUnits[(integerPart.count - i - 1) % 4]
                    }
                }
                // debugPrint("i：\(i) unitString: \(unitString)")
                if ch == "零" {
                    // 处在大单位的位置或者如果是零，往右一位也是零，零不加
                    if (integerPart.count - i - 1) % 4 == 0 || integerString.hasPrefix("零") {
                        integerString = unitString + integerString
                    } else {
                        // 前一位不是零
                        integerString = ch + unitString + integerString
                    }
                } else {
                    integerString = ch + unitString + integerString
                }
                count += 1
            }
        }
        // 整数部分如果结尾是零元，移除掉
        if integerString.hasSuffix("零") {
            integerString = (integerString + "元").jk.removeSomeStringUseSomeString(removeString: "零元")
        }
        // 4、小数点后面大写金额
        guard parts.count > 1 else {
            // 没有小数部分
            return integerString.isEmpty ? "零元" : (integerString + "元整")
        }
        // 小数部分
        let fractionalPart = parts[1]
        // 小数单位
        let chineseFractionalUnits = ["角", "分", "毫", "厘"]
        // 小数部分大写金额
        var fractionalString = ""
        count = 0
        for i in 0..<fractionalPart.count {
            let index = fractionalPart.jk.sub(start: i, length: 1).jk.toInt() ?? 0
            let ch = chineseNumbers[index]
            let unit = chineseFractionalUnits[count]
            if ch != "零" {
                fractionalString += ch + unit
            } else if !fractionalString.isEmpty, !fractionalString.hasSuffix("零") {
                // 上一个单位是零，这里就不加零了
                fractionalString = fractionalString + ch
            }
            count += 1
        }
        if fractionalString.isEmpty {
            // 小数部分没有值(这个一般不会走，前面做了只有整数的拦截)
            return integerString + "元整"
        } else {
            if integerString.isEmpty {
                // 整数部分没有值
                return fractionalString
            }
            // 整数和小数部分都有值
            return integerString + "元" + fractionalString
        }
    }
    
    //MARK: 5.11、大写的金额转数字金额
    /// 大写的金额转数字金额
    func rMBConvertChineseNumber() -> String? {
        var content = base as! String
        // 1、长度大于0且包含元
        guard content.count > 0 else { return nil }
        // 2、特殊的零元直接返回
        if content == "零元" {
            return "0"
        }
        // 3、第一个肯定是0-9大写中的一个，如果不是就可以结束这个大写人民币数字有问题或者太大无法解析
        // 汉字的数字
        let chineseNumerals = ["零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"]
        let firstNumber = content.jk.sub(to: 1)
        guard chineseNumerals.contains(firstNumber) else { return nil }
        
        // 4、字符串整数和小数部分的分割
        var parts: [String] = []
        if content.jk.contains(find: "元整") {
            content = content.jk.removeSomeStringUseSomeString(removeString: "元整", replacingString: "")
            parts = [content]
        } else {
            // 有小数部分，根据点(元整)分割字符串
            if content.jk.contains(find: "元") {
                parts = content.jk.separatedByString(with: "元")
            } else {
                // 只有小数部分
                parts = ["", content]
            }
        }
        // 5、整数部分的处理
        // 是否是单位
        var isUint: Bool = false
        // 整数金额单位，在此只处理到仟秭(qiān zǐ)
        // 2.3、基础金额单位，在此只处理到仟秭(qiān zǐ)
        // 2.3、基础金额单位，在此只处理到仟秭(qiān zǐ)
        let chineseUnits = ["", "拾", "佰", "仟"]
        // 2.4、每个阶段单位的划分
        let units = ["", "万", "亿", "兆", "京", "垓", "秭"]
        let integerPart = parts[0]
        // 是否是正确的人民币文字
        var isRightRNB = true
        // 当前的小单位
        var currentSmallUnit = ""
        // 当前的大单位
        var currentBigUnit = ""
        var integerString = ""
        for i in (0..<integerPart.count).reversed() {
            let singleString = integerPart.jk.sub(start: i, length: 1)
            // debugPrint("整数-i：\(i) 内容：\(singleString)")
            if isUint {
                // 判断是否是值，不是值的话就是有问题
                if chineseNumerals.contains(singleString) {
                    // 是值
                    let numberValue = "\(chineseNumerals.indexes(singleString)[0])"
                    if (currentSmallUnit.count > 0 && currentBigUnit.count > 0) || currentSmallUnit.count > 0 {
                        // 小单位的索引
                        let smalUintIndex = chineseUnits.indexes(currentSmallUnit)[0]
                        let currntBigUintIndex = units.indexes(currentBigUnit)[0]
                        integerString = "\(numberValue)" + integerString.jk.prefixAddZero(smalUintIndex + currntBigUintIndex * 4)
                    } else {
                        // 大单位
                        integerString = "\(numberValue)" + integerString
                    }
                    isUint = false
                    currentSmallUnit = ""
                } else {
                    // 如果是单位的话，这里只能是小单位，如果是大单位就说明有问题
                    if chineseUnits.contains(singleString) {
                        // 小单位
                        // let smalUintIndex = chineseUnits.indexes(singleString)[0]
                        currentSmallUnit = singleString
                    } else {
                        // 不是大单位，如果后面是单位，不管是大单位还是小单位，再往左一位不可能是小单位
                        isRightRNB = false
                        // debugPrint("不是值，这个大写人民币值有问题：\(singleString)")
                        break
                    }
                }
            } else {
                if chineseUnits.contains(singleString) || units.contains(singleString) {
                    // 记录单位
                    isUint = true
                    if units.contains(singleString) {
                        // 是大单位：["", "万", "亿", "兆", "京", "垓", "秭"]
                        currentBigUnit = singleString
                    } else {
                        currentSmallUnit = singleString
                        // 是小单位：["", "拾", "佰", "仟"]
                    }
                } else {
                    // 如果当前是0的话，就看下当前的单位
                    if chineseNumerals.contains(singleString) {
                        // 判断是否是值，不是值的话就是有问题。
                        if singleString == "零" {
                            // 查看往左一个是不是大单位
                            let leftSingleString = integerPart.jk.sub(start: i - 1, length: 1)
                            if units.contains(leftSingleString) {
                                // 如果是大单位就进行计算
                                let leftBigUintValue = units.indexes(leftSingleString)[0]
                                integerString = integerString.jk.prefixAddZero(leftBigUintValue * 4)
                                
                            } else if chineseUnits.contains(leftSingleString) {
                                // 看下小单位是几位 + 前面的单位 * 4 是总的长度
                                let leftSmallUintValue = chineseUnits.indexes(leftSingleString)[0]
                                let currntBigUintValue = units.indexes(currentBigUnit)[0]
                                integerString = integerString.jk.prefixAddZero(leftSmallUintValue + currntBigUintValue * 4)
                            } else {
                                // 不是单位，这个大写人民币值有问题
                                isRightRNB = false
                                // debugPrint("不是值，这个大写人民币值有问题：\(singleString)")
                                break
                            }
                        } else {
                            // 不是零
                            integerString = integerString + "\(chineseNumerals.indexes(singleString)[0])"
                        }
                    } else {
                        // 不是单位，这个大写人民币值有问题
                        isRightRNB = false
                        // debugPrint("不是值，这个大写人民币值有问题：\(singleString)")
                        break
                    }
                }
            }
        }
        // 不是正确的RMB字符串就直接返回，解析不了
        guard isRightRNB else {
            return nil
        }
        guard parts.count > 1 else {
            // 没有小数部分或者这个值有问题
            return integerString
        }
        // 5、小数部分的处理
        // 小数金额单位
        let chineseFractionalUnits = ["角", "分", "毫", "厘"] // 1 3
        // 当前的小单位
        var currentFractionalUnit = ""
        let fractionalPart = parts[1]
        var fractionalString = ""
        for i in (0..<fractionalPart.count).reversed() {
            let singleString = fractionalPart.jk.sub(start: i, length: 1)
            // debugPrint("小数-i：\(i) 内容：\(singleString)")
            if isUint {
                // 判断是否是值，不是值的话就是有问题
                if chineseNumerals.contains(singleString) {
                    // 是值
                    let numberValue = "\(chineseNumerals.indexes(singleString)[0])"
                    fractionalString = "\(numberValue)" + fractionalString
                    // 如果左边没有小数了，当前的单位和角差几个就补几个0
                    if i == 0 {
                        let currntBigUintIndex = chineseFractionalUnits.indexes(currentFractionalUnit)[0]
                        fractionalString = "".jk.prefixAddZero(currntBigUintIndex) + fractionalString
                    } else {
                    }
                    isUint = false
                } else {
                    // 不是单位，这个大写人民币值有问题
                    isRightRNB = false
                    // debugPrint("不是值，这个大写人民币值有问题：\(singleString)")
                    break
                }
            } else {
                if chineseFractionalUnits.contains(singleString) {
                    // 是否是小数的单位
                    currentFractionalUnit = singleString
                    isUint = true
                } else {
                    // 如果当前是0的话，就看下当前的单位
                    if chineseNumerals.contains(singleString) && singleString == "零" {
                        // 零的处理
                        let leftSingleString = fractionalPart.jk.sub(start: i - 1, length: 1)
                        if chineseFractionalUnits.contains(leftSingleString) {
                            // 看下小单位是几位 + 前面的单位 * 4 是总的长度
                            let leftSmallUintValue = chineseFractionalUnits.indexes(leftSingleString)[0]
                            let currntBigUintValue = chineseFractionalUnits.indexes(currentFractionalUnit)[0]
                            fractionalString = "".jk.prefixAddZero(currntBigUintValue - leftSmallUintValue - 1) + fractionalString
                        } else {
                            // 不是单位，这个大写人民币值有问题
                            isRightRNB = false
                            // debugPrint("不是值，这个大写人民币值有问题：\(singleString)")
                            break
                        }
                    } else {
                        // 不是单位，这个大写人民币值有问题
                        isRightRNB = false
                        // debugPrint("不是值，这个大写人民币值有问题：\(singleString)")
                        break
                    }
                }
            }
        }
        // 不是正确的RMB字符串就直接返回，解析不了
        guard isRightRNB else {
            return nil
        }
        if integerString.count > 0 {
            // 如果有整数
            return integerString + "." + fractionalString
        }
        // 只有小数
        return "0." + fractionalString
    }
}

// MARK: - 六、字符串UI的处理
extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 6.1、对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    /// 对字符串(多行)指定出字体大小和最大的 Size，获取展示的 Size
    /// - Parameters:
    ///   - font: 字体大小
    ///   - size: 字符串的最大宽和高
    /// - Returns: 按照 font 和 Size 的字符的Size
    public func rectSize(font: UIFont, size: CGSize) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        /**
         usesLineFragmentOrigin: 整个文本将以每行组成的矩形为单位计算整个文本的尺寸
         usesFontLeading:
         usesDeviceMetrics:
         @available(iOS 6.0, *)
         truncatesLastVisibleLine:
         */
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect: CGRect = (base as! String).boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size
    }
    
    // MARK: 6.2、对字符串(多行)指定字体及Size，获取 (高度)
    /// 对字符串指定字体及Size，获取 (高度)
    /// - Parameters:
    ///   - font: 字体的大小
    ///   - size: 字体的size
    /// - Returns: 返回对应字符串的高度
    public func rectHeight(font: UIFont, size: CGSize) -> CGFloat {
        return rectSize(font: font, size: size).height
    }
    
    // MARK: 6.3、对字符串(多行)指定字体及Size，获取 (宽度)
    /// 对字符串指定字体及Size，获取 (宽度)
    /// - Parameters:
    ///   - font: 字体的大小
    ///   - size: 字体的size
    /// - Returns: 返回对应字符串的宽度
    public func rectWidth(font: UIFont, size: CGSize) -> CGFloat {
        return rectSize(font: font, size: size).width
    }
    
    // MARK: 6.4、对字符串(单行)指定字体，获取 (Size)
    /// 对字符串(单行)指定字体，获取 (Size)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 size
    public func singleLineSize(font: UIFont) -> CGSize {
        let attrs = [NSAttributedString.Key.font: font]
        return (base as! String).size(withAttributes: attrs as [NSAttributedString.Key: Any])
    }
    
    // MARK: 6.5、对字符串(单行)指定字体，获取 (width)
    /// 对字符串(单行)指定字体，获取 (width)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 width
    public func singleLineWidth(font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        return (base as! String).size(withAttributes: attrs as [NSAttributedString.Key: Any]).width
    }
    
    // MARK: 6.6、对字符串(单行)指定字体，获取 (Height)
    /// 对字符串(单行)指定字体，获取 (height)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 height
    public func singleLineHeight(font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        return (base as! String).size(withAttributes: attrs as [NSAttributedString.Key: Any]).height
    }
    
    // MARK: 6.7、字符串通过 label 根据高度&字体 —> Size
    /// 字符串通过 label 根据高度&字体 ——> Size
    /// - Parameters:
    ///   - height: 字符串最大的高度
    ///   - font: 字体大小
    /// - Returns: 返回Size
    public func sizeAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGSize {
        if self.isBlank {return CGSize(width: 0, height: 0)}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: rect).font(font).text((base as! String)).line(0)
        return label.sizeThatFits(rect.size)
    }
    
    // MARK: 6.8、字符串通过 label 根据高度&字体 —> Width
    /// 字符串通过 label 根据高度&字体 ——> Width
    /// - Parameters:
    ///   - height: 字符串最大高度
    ///   - font: 字体大小
    /// - Returns: 返回宽度大小
    public func widthAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: rect).font(font).text((base as! String)).line(0)
        return label.sizeThatFits(rect.size).width
    }
    
    // MARK: 6.9、字符串通过 label 根据宽度&字体 —> height
    /// 字符串通过 label 根据宽度&字体 ——> height
    /// - Parameters:
    ///   - width: 字符串最大宽度
    ///   - font: 字体大小
    /// - Returns: 返回高度大小
    public func heightAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: rect).font(font).text((base as! String)).line(0)
        return label.sizeThatFits(rect.size).height
    }
    
    // MARK: 6.10、字符串根据宽度 & 字体 & 行间距 —> Size
    /// 字符串根据宽度 & 字体 & 行间距 ——> Size
    /// - Parameters:
    ///   - width: 字符串最大的宽度
    ///   - heiht: 字符串最大的高度
    ///   - font: 字体的大小
    ///   - lineSpacing: 行间距
    /// - Returns: 返回对应的size
    public func sizeAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont, lineSpacing: CGFloat) -> CGSize {
        if self.isBlank {return CGSize(width: 0, height: 0)}
        let rect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let label = UILabel(frame: rect).font(font).text((base as! String)).line(0)
        let attrStr = NSMutableAttributedString(string: (base as! String))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, (base as! String).count))
        label.attributedText = attrStr
        return label.sizeThatFits(rect.size)
    }
    
    // MARK: 6.11、字符串根据宽度 & 字体 & 行间距 —> width
    /// 字符串根据宽度 & 字体 & 行间距 ——> width
    /// - Parameters:
    ///   - width: 字符串最大的宽度
    ///   - heiht: 字符串最大的高度
    ///   - font: 字体的大小
    ///   - lineSpacing: 行间距
    /// - Returns: 返回对应的 width
    public func widthAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont, lineSpacing: CGFloat) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: rect).font(font).text((base as! String)).line(0)
        let attrStr = NSMutableAttributedString(string: (base as! String))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, (base as! String).count))
        label.attributedText = attrStr
        return label.sizeThatFits(rect.size).width
    }
    
    // MARK: 6.12、字符串根据宽度 & 字体 & 行间距 —> height
    /// 字符串根据宽度 & 字体 & 行间距 ——> height
    /// - Parameters:
    ///   - width: 字符串最大的宽度
    ///   - heiht: 字符串最大的高度
    ///   - font: 字体的大小
    ///   - lineSpacing: 行间距
    /// - Returns: 返回对应的 height
    public func heightAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont, lineSpacing: CGFloat) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: rect).font(font).text((base as! String)).line(0)
        let attrStr = NSMutableAttributedString(string: (base as! String))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, (base as! String).count))
        label.attributedText = attrStr
        return label.sizeThatFits(rect.size).height
    }
}

// MARK: - 七、字符串有关数字方面的扩展
public enum StringCutType {
    case normal, auto
}

public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 7.1、将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// 将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// - Returns: 千分位的字符串
    func toThousands() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .floor
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        if (base as! String).contains(".") {
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.minimumIntegerDigits = 1
        }
        var num = NSDecimalNumber(string: (base as! String))
        if num.doubleValue.isNaN {
            num = NSDecimalNumber(string: "0")
        }
        let result = formatter.string(from: num)
        return result
    }
    
    // MARK: 7.2、字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    /// - Important: 字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    func accuraterDouble() -> Double? {
        guard let decimal = Decimal(string: (base as! String)) else { return nil }
        JKPrint(NSDecimalNumber(decimal: decimal).doubleValue)
        return NSDecimalNumber(decimal: decimal).doubleValue
    }
    
    // MARK: 7.3、去掉小数点后多余的0
    /// 去掉小数点后多余的0
    /// - Returns: 返回小数点后没有 0 的金额
    func cutLastZeroAfterDot() -> String {
        var rst = (base as! String)
        var i = 1
        if (base as! String).contains(".") {
            while i < (base as! String).count {
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
            return (base as! String)
        }
    }
    
    // MARK: 7.4、将数字的字符串处理成  几位 位小数的情况
    /// 将数字的字符串处理成  几位 位小数的情况
    /// - Parameters:
    ///   - numberDecimal: 保留几位小数
    ///   - mode: 模式
    /// - Returns: 返回保留后的小数，如果是非字符，则根据numberDecimal 返回0 或 0.00等等
    func saveNumberDecimal(numberDecimal: Int = 0, mode: NumberFormatter.RoundingMode = .floor) -> String {
        var n = NSDecimalNumber(string: (base as! String))
        if n.doubleValue.isNaN {
            n = NSDecimalNumber.zero
        }
        let formatter = NumberFormatter()
        formatter.roundingMode = mode
        // 小数位最多位数
        formatter.maximumFractionDigits = numberDecimal
        // 小数位最少位数
        formatter.minimumFractionDigits = numberDecimal
        // 整数位最少位数
        formatter.minimumIntegerDigits = 1
        // 整数位最多位数
        formatter.maximumIntegerDigits = 100
        // 获取结果
        guard let result = formatter.string(from: n) else {
            // 异常处理
            if numberDecimal == 0 {
                return "0"
            } else {
                var zero = ""
                for _ in 0..<numberDecimal {
                    zero += zero
                }
                return "0." + zero
            }
        }
        return result
    }
}

// MARK: - 八、苹果针对浮点类型计算精度问题提供出来的计算类
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
extension JKPOP where Base: ExpressibleByStringLiteral {
    // MARK: 8.1、(加：＋)
    /// (加：＋)
    /// - Parameter strNumber: strNumber description
    /// - Returns: description
    public func adding(_ strNumber: String?) -> String {
        var ln = NSDecimalNumber(string: (base as! String))
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
    
    // MARK: 8.2、(减：-)
    /// (减：-)
    /// - Parameter strNumber: strNumber description
    /// - Returns: description
    public func subtracting(_ strNumber: String?) -> String {
        var ln = NSDecimalNumber(string: (base as! String))
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
    
    // MARK: 8.3、(乘：*)
    /// (乘：*)
    /// - Parameter strNumber: strNumber description
    /// - Returns: description
    public func multiplying(_ strNumber: String?) -> String {
        var ln = NSDecimalNumber(string: (base as! String))
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
    
    // MARK: 8.4、(除：/)
    /// (除：/)
    /// - Parameter strNumber: strNumber description
    /// - Returns: description
    public func dividing(_ strNumber: String?) -> String {
        var ln = NSDecimalNumber(string: (base as! String))
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

// MARK: - 九、字符串包含表情的处理
extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 9.1、检查字符串是否包含 Emoji 表情
    /// 检查字符串是否包含 Emoji 表情
    /// - Returns: bool
    public func containsEmoji() -> Bool {
        for scalar in (base as! String).unicodeScalars {
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
    
    // MARK: 9.2、检查字符串是否包含 Emoji 表情
    /// 检查字符串是否包含 Emoji 表情
    /// - Returns: bool
    public func includesEmoji() -> Bool {
        var isInClude: Bool = false
        for i in 0..<length {
            let c: unichar = ((base as! String) as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                isInClude = true
                break
            }
        }
        return isInClude
    }
    
    // MARK: 9.3、去除字符串中的Emoji表情
    /// 去除字符串中的Emoji表情
    /// - Parameter text: 字符串
    /// - Returns: 去除Emoji表情后的字符串
    public func deleteEmoji() -> String {
        do {
            let regex = try NSRegularExpression(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: NSRegularExpression.Options.caseInsensitive)
            
            let modifiedString = regex.stringByReplacingMatches(in: (base as! String), options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.length), withTemplate: "")
            
            return modifiedString
        } catch {
            JKPrint(error)
        }
        return ""
    }
}

// MARK: - 十、字符串的一些正则校验
extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 10.1、判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    /// 判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    public var isBlank: Bool {
        return (base as! String).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == ""
    }
    
    // MARK: 10.2、判断是否全十进制数字，长度为0返回false
    /// 判断是否全十进制数字，长度为0返回false
    public var isDecimalDigits: Bool {
        if (base as! String).isEmpty {
            return false
        }
        // 去除什么的操作
        return (base as! String).trimmingCharacters(in: NSCharacterSet.decimalDigits) == ""
    }
    
    // MARK: 10.3、判断是否是整数
    /// 判断是否是整数
    public var isPureInt: Bool {
        let scan: Scanner = Scanner(string: (base as! String))
        var n: Int = 0
        return scan.scanInt(&n) && scan.isAtEnd
    }
    
    // MARK: 10.4、判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    /// 判断是否是Float，此处Float是包含Int的，即Int是特殊的Float
    public var isPureFloat: Bool {
        let scan: Scanner = Scanner(string: (base as! String))
        var n: Float = 0.0
        return scan.scanFloat(&n) && scan.isAtEnd
    }
    
    // MARK: 10.5、判断是否全是字母，长度为0返回false
    /// 判断是否全是字母，长度为0返回false
    public var isLetters: Bool {
        if (base as! String).isEmpty {
            return false
        }
        return (base as! String).trimmingCharacters(in: NSCharacterSet.letters) == ""
    }
    
    // MARK: 10.6、判断是否是中文, 这里的中文不包括数字及标点符号
    /// 判断是否是中文, 这里的中文不包括数字及标点符号
    public var isChinese: Bool {
        let rgex = "(^[\u{4e00}-\u{9fef}]+$)"
        return predicateValue(rgex: rgex)
    }
    
    // MARK: 10.7、是否是有效昵称，即允许“中文”、“英文”、“数字”
    /// 是否是有效昵称，即允许“中文”、“英文”、“数字”
    public var isValidNickName: Bool {
        let rgex = "(^[\u{4e00}-\u{9faf}_a-zA-Z0-9]+$)"
        return predicateValue(rgex: rgex)
    }
    
    // MARK: 10.8、判断是否是有效的手机号码
    /// 判断是否是有效的手机号码
    public var isValidMobile: Bool {
        let rgex = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199)\\d{8}$"
        return predicateValue(rgex: rgex)
    }
    
    // MARK: 10.9、判断是否是有效的电子邮件地址
    /// 判断是否是有效的电子邮件地址
    public var isValidEmail: Bool {
        let rgex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return predicateValue(rgex: rgex)
    }
    
    // MARK: 10.10、判断是否有效的身份证号码，不是太严格
    /// 判断是否有效的身份证号码，不是太严格
    public var isValidIDCardNumber: Bool {
        let rgex = "^(\\d{15})|((\\d{17})(\\d|[X]))$"
        return predicateValue(rgex: rgex)
    }
    
    // MARK: 10.11、严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    /// 严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    public var isValidIDCardNumStrict: Bool {
        let str = (base as! String).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        let len = str.count
        if !str.jk.isValidIDCardNumber {
            return false
        }
        // 省份代码
        let areaArray = ["11", "12", "13", "14", "15", "21", "22", "23", "31", "32", "33", "34", "35", "36", "37", "41", "42", "43", "44", "45", "46", "50", "51", "52", "53", "54", "61", "62", "63", "64", "65", "71", "81", "82", "91"]
        if !areaArray.contains(str.jk.sub(to: 2)) {
            return false
        }
        var regex = NSRegularExpression()
        var numberOfMatch = 0
        var year = 0
        switch len {
        case 15:
            // 15位身份证
            // 这里年份只有两位，00被处理为闰年了，对2000年是正确的，对1900年是错误的，不过身份证是1900年的应该很少了
            year = Int(str.jk.sub(start: 6, length: 2))!
            if isLeapYear(year: year) { // 闰年
                do {
                    // 检测出生日期的合法性
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: .caseInsensitive)
                } catch {}
            } else {
                do {
                    // 检测出生日期的合法性
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: .caseInsensitive)
                } catch {}
            }
            numberOfMatch = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, len))
            
            if numberOfMatch > 0 {
                return true
            } else {
                return false
            }
        case 18:
            // 18位身份证
            year = Int(str.jk.sub(start: 6, length: 4))!
            if isLeapYear(year: year) {
                // 闰年
                do {
                    // 检测出生日期的合法性
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive)
                } catch {}
            } else {
                do {
                    // 检测出生日期的合法性
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive)
                } catch {}
            }
            numberOfMatch = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, len))
            if numberOfMatch > 0 {
                var s = 0
                let jiaoYan = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3]
                for i in 0 ..< 17 {
                    if let d = Int(str.jk.slice(i ..< (i + 1))) {
                        s += d * jiaoYan[i % 10]
                    } else {
                        return false
                    }
                }
                let Y = s % 11
                let JYM = "10X98765432"
                let M = JYM.jk.sub(start: Y, length: 1)
                if M == str.jk.sub(start: 17, length: 1) {
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
    
    // MARK: 10.12、校验字符串位置是否合理，并返回String.Index
    /// 校验字符串位置是否合理，并返回String.Index
    /// - Parameter original: 位置
    /// - Returns: String.Index
    public func validIndex(original: Int) -> String.Index {
        switch original {
        case ...(base as! String).startIndex.utf16Offset(in: base as! String):
            return (base as! String).startIndex
        case (base as! String).endIndex.utf16Offset(in: base as! String)...:
            return (base as! String).endIndex
        default:
            return (base as! String).index((base as! String).startIndex, offsetBy: original > (base as! String).count ? (base as! String).count : original)
        }
    }
    
    // MARK: 10.13、隐藏手机号中间的几位
    /// 隐藏手机号中间的几位
    /// - Parameter combine: 隐藏的字符串(替换的类型)
    /// - Returns: 返回隐藏的手机号
    public func hide12BitsPhone(combine: String = "****") -> String {
        if (base as! String).count >= 11 {
            let pre = self.sub(start: 0, length: 3)
            let post = self.sub(start: 7, length: 4)
            return pre + combine + post
        } else {
            return (base as! String)
        }
    }
    
    // MARK: 10.14、隐藏手机号中间的几位(保留前几位和后几位)
    /// 隐藏手机号中间的几位(保留前几位和后几位)
    /// - Parameters:
    ///   - combine: 中间加密的符号
    ///   - digitsBefore: 前面保留的位数
    ///   - digitsAfter: 后面保留的位数
    /// - Returns: 返回隐藏的手机号
    public func hidePhone(combine: String = "*", digitsBefore: Int = 2, digitsAfter: Int = 2) -> String {
        let phoneLength: Int = (base as! String).count
        if phoneLength > digitsBefore + digitsAfter {
            let combineCount: Int = phoneLength - digitsBefore - digitsAfter
            var combineContent: String = ""
            for _ in 0..<combineCount {
                combineContent = combineContent + combine
            }
            let pre = self.sub(start: 0, length: digitsBefore)
            let post = self.sub(start: phoneLength - digitsAfter, length: digitsAfter)
            return pre + "\(combineContent)" + post
        } else {
            return (base as! String)
        }
    }
    
    // MARK: 10.15、隐藏邮箱中间的几位(保留前几位和后几位)
    /// 隐藏邮箱中间的几位(保留前几位和后几位)
    /// - Parameters:
    ///   - combine: 加密的符号
    ///   - digitsBefore: 前面保留几位
    ///   - digitsAfter: 后面保留几位
    /// - Returns: 返回加密后的字符串
    public func hideEmail(combine: String = "*", digitsBefore: Int = 1, digitsAfter: Int = 1) -> String {
        let emailArray = (base as! String).jk.separatedByString(with: "@")
        if emailArray.count == 2 {
            let fistContent = emailArray[0]
            let encryptionContent = fistContent.jk.hidePhone(combine: "*", digitsBefore: 1, digitsAfter: 1)
            return encryptionContent + "@" +  emailArray[1]
        }
        return (base as! String)
    }
    
    // MARK: 10.16、检查字符串是否有特定前缀：hasPrefix
    /// 检查字符串是否有特定前缀：hasPrefix
    /// - Parameter prefix: 前缀字符串
    /// - Returns: 结果
    public func isHasPrefix(prefix: String) -> Bool {
        return (base as! String).hasPrefix(prefix)
    }
    
    // MARK: 10.17、检查字符串是否有特定后缀：hasSuffix
    /// 检查字符串是否有特定后缀：hasSuffix
    /// - Parameter suffix: 后缀字符串
    /// - Returns: 结果
    public func isHasSuffix(suffix: String) -> Bool {
        return (base as! String).hasSuffix(suffix)
    }
    
    // MARK: 10.18、是否为0-9之间的数字(字符串的组成是：0-9之间的数字)
    /// 是否为0-9之间的数字(字符串的组成是：0-9之间的数字)
    /// - Returns: 返回结果
    public func isValidNumberValue() -> Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return (base as! String).rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    // MARK: 10.19、是否为数字或者小数点(字符串的组成是：0-9之间的数字或者小数点即可)
    /// 是否为数字或者小数点(字符串的组成是：0-9之间的数字或者小数点即可)
    /// - Returns: 返回结果
    public func isValidNumberAndDecimalPoint() -> Bool {
        guard (base as! String).count > 0 else {
            return false
        }
        let rgex = "^[\\d.]*$"
        return predicateValue(rgex: rgex)
    }
    
    // MARK: 10.20、验证URL格式是否正确
    /// 验证URL格式是否正确
    /// - Returns: 结果
    public func verifyUrl() -> Bool {
        // 创建NSURL实例
        if let url = URL(string: (base as! String)) {
            //检测应用是否能打开这个NSURL实例
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    // MARK: 10.21、是否是一个有效的文件URL, "file://Documents/file.txt".isValidFileUrl -> true
    /// 是否是一个有效的文件URL
    public var isValidFileUrl: Bool {
        return URL(string: base as! String)?.isFileURL ?? false
    }
    
    // MARK: 10.22、富文本匹配(某些关键词高亮)
    /// 富文本匹配(某些关键词高亮)
    /// - Parameters:
    ///   - substring: 匹配的关键字
    ///   - normalColor: 常规的颜色
    ///   - highlightedCololor: 关键字的颜色
    ///   - isSplit: 是否分隔匹配
    ///   - options: 匹配规则
    /// - Returns: 返回匹配后的富文本
    public func stringWithHighLightSubstring(keyword: String, font: UIFont, normalColor: UIColor, keywordCololor: UIColor, isSplit: Bool = false, options: NSRegularExpression.Options = []) -> NSMutableAttributedString {
        let totalString = (base as! String)
        let attributedString = NSMutableAttributedString(string: totalString)
        attributedString.addAttributes([.foregroundColor: normalColor, .font: font], range: NSRange(location: 0, length: totalString.count))
        if isSplit {
            for i in 0..<keyword.count {
                let singleString = keyword.jk.sub(start: i, length: 1)
                let ranges = JKRegexHelper.matchRange(totalString, pattern: singleString)
                for range in ranges {
                    attributedString.addAttributes([.foregroundColor: keywordCololor, .font: font], range: range)
                }
            }
        } else {
            let ranges = JKRegexHelper.matchRange(totalString, pattern: keyword)
            for range in ranges {
                attributedString.addAttributes([.foregroundColor: keywordCololor, .font: font], range: range)
            }
        }
        return attributedString
    }
    
    //MARK: 10.23、判断是否是视频链接
    /// 判断是否是视频链接
    public var isVideoUrl: Bool {
        let videoUrls = ["mp4", "MP4", "MOV", "mov", "mpg", "mpeg", "mpg4", "wm", "wmx", "mkv", "mkv2", "3gp", "3gpp", "wv", "wvx", "avi", "asf", "fiv", "swf", "flv", "f4v", "m4u", "m4v", "mov", "movie", "pvx", "qt", "rv", "vod", "rm", "ram", "rmvb"]
        return videoUrls.contains { (base as! String).hasSuffix($0) }
    }
    
    // MARK: - private 方法
    // MARK: 是否是闰年
    /// 是否是闰年
    /// - Parameter year: 年份
    /// - Returns: 返回是否是闰年
    private func isLeapYear(year: Int) -> Bool {
        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)))
    }
    
    private func predicateValue(rgex: String) -> Bool {
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", rgex)
        return checker.evaluate(with: (base as! String))
    }
}

// MARK: - 十一、字符串截取的操作
extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 11.1、截取字符串从开始到 index
    /// 截取字符串从开始到 index
    /// - Parameter index: 截取到的位置
    /// - Returns: 截取后的字符串
    public func sub(to index: Int) -> String {
        let end_Index = validIndex(original: index)
        return String((base as! String)[(base as! String).startIndex ..< end_Index])
    }
    
    // MARK: 11.2、截取字符串从index到结束
    /// 截取字符串从index到结束
    /// - Parameter index: 截取结束的位置
    /// - Returns: 截取后的字符串
    public func sub(from index: Int) -> String {
        let start_index = validIndex(original: index)
        return String((base as! String)[start_index ..< (base as! String).endIndex])
    }
    
    // MARK: 11.3、获取指定位置和长度的字符串
    /// 获取指定位置和大小的字符串
    /// - Parameters:
    ///   - start: 开始位置
    ///   - length: 长度
    /// - Returns: 截取后的字符串
    public func sub(start: Int, length: Int = -1) -> String {
        var len = length
        if len == -1 || (start + length) > (base as! String).count {
            len = (base as! String).count - start
        }
        let st = (base as! String).index((base as! String).startIndex, offsetBy: start)
        let en = (base as! String).index(st, offsetBy: len)
        let range = st ..< en
        return String((base as! String)[range]) // .substring(with:range)
    }
    
    // MARK: 11.4、切割字符串(区间范围 前闭后开)
    /**
     CountableClosedRange：可数的闭区间，如 0...2
     CountableRange：可数的开区间，如 0..<2
     ClosedRange：不可数的闭区间，如 0.1...2.1
     Range：不可数的开居间，如 0.1..<2.1
     */
    /// 切割字符串(区间范围 前闭后开)
    /// - Parameter range: 范围
    /// - Returns: 切割后的字符串
    public func slice(_ range: CountableRange<Int>) -> String {
        // 如 slice(2..<6)
        /**
         upperBound（上界）
         lowerBound（下界）
         */
        let startIndex = validIndex(original: range.lowerBound)
        let endIndex = validIndex(original: range.upperBound)
        guard startIndex < endIndex else {
            return ""
        }
        return String((base as! String)[startIndex ..< endIndex])
    }
    
    // MARK: 11.5、子字符串第一次出现的位置
    /// 子字符串第一次出现的位置
    /// - Parameter sub: 子字符串
    /// - Returns: 返回字符串的位置（如果内部不存在该字符串则返回 -1）
    public func positionFirst(of sub: String) -> Int {
        return position(of: sub)
    }
    
    // MARK: 11.6、子字符串最后一次出现的位置
    /// 子字符串第一次出现的位置
    /// - Parameter sub: 子字符串
    /// - Returns: 返回字符串的位置（如果内部不存在该字符串则返回 -1）
    public func positionLast(of sub: String) -> Int {
        return position(of: sub, backwards: true)
    }
    
    /// 返回(第一次/最后一次)出现的指定子字符串在此字符串中的索引，如果内部不存在该字符串则返回 -1
    /// - Parameters:
    ///   - sub: 子字符串
    ///   - backwards: 如果backwards参数设置为true，则返回最后出现的位置
    /// - Returns: 位置
    private func position(of sub: String, backwards: Bool = false) -> Int {
        var pos = -1
        if let range = (base as! String).range(of: sub, options: backwards ? .backwards : .literal) {
            if !range.isEmpty {
                pos = (base as! String).distance(from: (base as! String).startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
    
    // MARK: 11.7、获取某个位置的字符串
    /// 获取某个位置的字符串
    /// - Parameter index: 位置
    /// - Returns: 某个位置的字符串
    public func indexString(index: Int) -> String  {
        return slice((index ..< index + 1))
    }
    
    // MARK: 11.8、获取某个子串在父串中的范围->Range
    /// 获取某个子串在父串中的范围->Range
    /// - Parameter str: 子串
    /// - Returns: 某个子串在父串中的范围
    public func range(of subString: String) -> Range<String.Index>? {
        return (base as! String).range(of: subString)
    }
    
    // MARK: 11.9、获取某个子串在父串中的范围->[NSRange]
    /// 获取某个子串在父串中的范围->NSRange
    /// - Parameter str: 子串
    /// - Returns: 某个子串在父串中的范围
    public func nsRange(of subString: String) -> [NSRange] {
        guard (base as! String).jk.contains(find: subString) else {
            return []
        }
        // return text.range(of: subString)
        return JKRegexHelper.matchRange(base as! String, pattern: subString)
    }
    
    // MARK: 11.10、在任意位置后面插入字符串
    /// 在任意位置后面插入字符串
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入的位置
    /// - Returns: 添加后的字符串
    public func insertString(content: String, locat: Int) -> String {
        guard locat < (base as! String).count && locat > 0  else {
            return locat <= 0 ? (content + (base as! String)) : ((base as! String) + content)
        }
        let str1 = (base as! String).jk.sub(to: locat)
        let str2 = (base as! String).jk.sub(from: locat)
        return str1 + content + str2
    }
    
    //MARK: 11.11、匹配两个字符之间的内容
    /// 匹配两个字符之间的内容
    /// - Parameters:
    ///   - leftChar: 左边的字符
    ///   - rightChar: 右边的字符
    /// - Returns: 匹配后的字符串数组
    public func matchesMiddleContentOfCharacters(leftChar: String, rightChar: String) -> [String] {
        do {
            let pattern: String = "(?<=\\\(leftChar)).*?(?=\\\(rightChar))"
            /// 最初的额正则
            // let pattern: ·String = "(?<=\\[).*?(?=\\])"
            // let pattern: String = "(\\\(leftChar)[^\\]]*\\\(rightChar))"
            let regex = try NSRegularExpression(pattern: pattern)
            let nsString = (base as! String).jk.toNSString
            let results = regex.matches(in: base as! String, range: NSRange(location: 0, length: nsString.length))
            return results.map {
                nsString.substring(with: $0.range)
                // (base as! String).jk.sub(start: $0.range.location, length: $0.range.length)
                // String(nsString.substring(with: $0.range(at: 1)).dropFirst().dropLast())
            }
        } catch let error {
            debugPrint("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    //MARK: 11.12、字符串按照步长拆分为字符串数组
    /// 字符串拆分为字符串数组
    /// - Parameter length: 步长
    /// - Returns: description
    public func splitStringArray(length: Int) -> [String] {
        let string = (base as! String)
        var subStrings: [String] = []
        guard string.count > length else {
            return subStrings
        }
        // 当前截取的位置
        var currentLength = 0
        while currentLength < string.count {
            if (currentLength + length) > string.count {
                subStrings.append(string.jk.sub(from: currentLength))
            } else {
                let value = string.jk.sub(start: currentLength, length: length)
                subStrings.append(value)
            }
            currentLength = currentLength + 2
        }
        return subStrings
    }
    
    // MARK: 11.13、字符串长度不足前面补0
    /// 字符串长度不足前面补0
    public func prefixAddZero(_ length: Int) -> String {
        return insufficientLengthAdZero(length)
    }
    
    // MARK: 11.14、字符串长度不足后面补0
    /// 字符串长度不足后面补0
    public func suffixAddZero(_ length: Int) -> String {
        return insufficientLengthAdZero(length, isPrefixAddZer: false)
    }
    
    // MARK: 字符串长度不足补0
    /// 字符串长度不足后面补0
    private func insufficientLengthAdZero(_ length: Int, isPrefixAddZer: Bool = true) -> String {
        let string = base as! String
        guard string.count < length else {
            return string
        }
        let zero = String(repeating: "0", count: length - string.count)
        return isPrefixAddZer ? (zero + string) : (string + zero)
    }
}

// MARK: - 十二、字符串编码的处理
extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 12.1、特殊字符编码处理urlEncoded
    /// url编码 默认urlQueryAllowed
    public func urlEncoding(characters: CharacterSet = .urlQueryAllowed) -> String {
        let encodeUrlString = (base as! String).addingPercentEncoding(withAllowedCharacters: characters)
        return encodeUrlString ?? ""
    }
    
    // MARK: 12.2、url编码 Alamofire AFNetworking 处理方式 推荐使用
    /// url编码 Alamofire AFNetworking 处理方式 推荐使用
    public var urlEncoded: String {
        // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let encodeUrlString = (base as! String).addingPercentEncoding(withAllowedCharacters:
                                                                        allowedCharacterSet)
        return encodeUrlString ?? ""
    }
    
    // MARK: 12.3、url编码 会对所有特殊字符做编码  特殊情况下使用
    /// url编码 会对所有特殊字符做编码  特殊情况下使用
    public var urlAllEncoded: String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;=/?_-.~"
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let encodeUrlString = (base as! String).addingPercentEncoding(withAllowedCharacters:
                                                                        allowedCharacterSet)
        return encodeUrlString ?? ""
    }
}

// MARK: - 十三、进制之间的转换
/*
 Binary：      二进制
 Octal：       八进制
 Decimal：     十进制
 Hexadecimal： 十六进制
 */
public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 13.1、二进制 -> 八进制
    /// 二进制 ->转 八进制
    /// - Returns: 八进制
    func binaryToOctal() -> String {
        // 二进制
        let binary = self
        // 十进制
        let decimal = binary.binaryTodecimal()
        // 八进制
        return decimal.jk.decimalToOctal()
    }
    
    // MARK: 13.2、二进制 -> 十进制
    /// 二进制 -> 十进制
    /// - Returns: 十进制
    func binaryTodecimal() -> String {
        let binary = self.base as! String
        var sum = 0
        for c in binary {
            if let number = "\(c)".jk.toInt() {
                sum = sum * 2 + number
            }
        }
        return "\(sum)"
    }
    
    // MARK: 13.3、二进制 转 十六进制
    /// 二进制  ->  十六进制
    /// - Returns: 十六进制
    func binaryToHexadecimal() -> String {
        // 二进制
        let binary = self
        // 十进制
        let decimal = binary.binaryTodecimal()
        // 十六进制
        return decimal.jk.decimalToHexadecimal()
    }
    
    // MARK: 13.4、八进制 -> 二进制
    /// 八进制 -> 二进制
    /// - Returns: 二进制
    func octalTobinary() -> String {
        // 八进制
        let octal = self
        // 十进制
        let decimal = octal.octalTodecimal()
        // 二进制
        return decimal.jk.decimalToBinary()
    }
    
    // MARK: 13.5、八进制 -> 十进制
    /// 八进制 -> 十进制
    /// - Returns: 十进制
    func octalTodecimal() -> String {
        let binary = self.base as! String
        var sum: Int = 0
        for c in binary {
            if let number = "\(c)".jk.toInt() {
                sum = sum * 8 + number
            }
        }
        return "\(sum)"
    }
    
    // MARK: 13.6、八进制 -> 十六进制
    /// 八进制 -> 十六进制
    /// - Returns: 十六进制
    func octalToHexadecimal() -> String {
        // 八进制
        let octal = self.base as! String
        // 十进制
        let decimal = octal.jk.octalTodecimal()
        // 十六进制
        return decimal.jk.decimalToHexadecimal()
    }
    
    // MARK: 13.7、十进制 -> 二进制
    /// 十进制 -> 二进制
    /// - Returns: 二进制
    func decimalToBinary() -> String {
        guard var decimal = (self.base as! String).jk.toInt() else {
            return ""
        }
        var str = ""
        while decimal > 0 {
            str = "\(decimal % 2)" + str
            decimal /= 2
        }
        return str
    }
    
    // MARK: 13.8、十进制 -> 八进制
    /// 十进制 -> 八进制
    /// - Returns: 八进制
    func decimalToOctal() -> String {
        guard let decimal = (self.base as! String).jk.toInt() else {
            return ""
        }
        /*
         guard var decimal = self.toInt() else {
         return ""
         }
         var str = ""
         while decimal > 0 {
         str = "\(decimal % 8)" + str
         decimal /= 8
         }
         return str
         */
        return String(format: "%0O", decimal)
    }
    
    // MARK: 13.9、十进制 -> 十六进制
    /// 十进制 -> 十六进制
    /// - Returns: 十六进制
    func decimalToHexadecimal() -> String {
        guard let decimal = self.toInt() else {
            return ""
        }
        return String(format: "%0X", decimal)
    }
    
    // MARK: 13.10、十六进制 -> 二进制
    /// 十六进制  -> 二进制
    /// - Returns: 二进制
    func hexadecimalToBinary() -> String {
        // 十六进制
        let hexadecimal = self
        // 十进制
        let decimal = hexadecimal.hexadecimalToDecimal()
        // 二进制
        return decimal.jk.decimalToBinary()
    }
    
    // MARK: 13.11、十六进制 -> 八进制
    /// 十六进制  -> 八进制
    /// - Returns: 八进制
    func hexadecimalToOctal() -> String {
        // 十六进制
        let hexadecimal = self
        // 十进制
        let decimal = hexadecimal.hexadecimalToDecimal()
        // 八进制
        return decimal.jk.decimalToOctal()
    }
    
    // MARK: 13.12、十六进制 -> 十进制
    /// 十六进制  -> 十进制
    /// - Returns: 十进制
    func hexadecimalToDecimal() -> String {
        let str = (self.base as! String).uppercased()
        var sum = 0
        for i in str.utf8 {
            // 0-9 从48开始
            sum = sum * 16 + Int(i) - 48
            // A-Z 从65开始，但有初始值10，所以应该是减去55
            if i >= 65 {
                sum -= 7
            }
        }
        return "\(sum)"
    }
    
    // MARK: 13.13、字符串转十六进制字符串
    /// 字符串转十六进制字符串
    /// - Returns: 十六进制字符串
    func hexString() -> String? {
        guard let data = (self.base as! String).data(using: .utf8) else {
            return nil
        }
        
        let dataBuffer = [UInt8](data)
        let dataLength = data.count
        var hexString = ""
        
        for i in 0..<dataLength {
            hexString += String(format: "%02lx", dataBuffer[i])
        }
        
        return hexString
    }

    // MARK: 13.14、十六进制字符串转换回原始字符串
    /// 十六进制字符串转换回原始字符串
    /// - Returns: 原始字符串
    func stringFromHexString() -> String? {
        var hex = self.base as! String
        var string = ""
        
        while !hex.isEmpty {
            let startIndex = hex.startIndex
            let endIndex = hex.index(startIndex, offsetBy: 2)
            
            if let byte = UInt8(hex[startIndex..<endIndex], radix: 16) {
                string.append(Character(UnicodeScalar(byte)))
            } else {
                return nil
            }
            hex = String(hex[endIndex...])
        }
        
        return string
    }
    
    // MARK: 13.15、十六进制字符串转Float
    /// 十六进制字符串转Float
    /// - Returns: Float
    func hexStringToFloat() -> Float {
        if let intValue = UInt32(self.base as! String, radix: 16) {
            var convertedValue: Float = 0.0
            withUnsafePointer(to: intValue) {
                $0.withMemoryRebound(to: Float.self, capacity: 1) {
                    convertedValue = $0.pointee
                }
            }
            return convertedValue
        }
        // 返回默认值或者进行错误处理
        return 0.0
    }
    
    // MARK: 13.16、十六进制字符串转Double
    /// 十六进制字符串转Double
    /// - Returns: Double
    func hexStringToDouble() -> Double {
        if let intValue = UInt64(self.base as! String, radix: 16) {
            var convertedValue: Double = 0.0
            withUnsafePointer(to: intValue) {
                $0.withMemoryRebound(to: Double.self, capacity: 1) {
                    convertedValue = $0.pointee
                }
            }
            return convertedValue
        }
        // 返回默认值或者进行错误处理
        return 0.0
    }
    
    // MARK: 13.17、十六进制字符串转化为data
    /// 十六进制字符串转化为data
    /// - Parameter string: 十六进制字符串
    /// - Returns: data
    func hexStringToData() -> Data? {
        let string = self.base as! String

        var data = Data()
        var idx = 0
        
        while idx + 2 <= string.count {
            let length = string.count - idx
            let len = min(2, length)
            let range = string.index(string.startIndex, offsetBy: idx)..<string.index(string.startIndex, offsetBy: idx + len)
            let hexStr = String(string[range])
            
            if let intValue = UInt8(hexStr, radix: 16) {
                data.append(intValue)
            }
            
            idx += 2
        }
        
        return data
    }
}

// MARK: - 十四、String -> NSMutableAttributedString
public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 14.1、String 添加颜色后转 NSMutableAttributedString
    /// String 添加颜色后转 NSMutableAttributedString
    /// - Parameter color: 背景色
    /// - Returns: NSMutableAttributedString
    func color(_ color: UIColor) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self.base as! String, attributes: [.foregroundColor: color])
        return attributedText
    }
    
    // MARK: 14.2、String 添加 font 后转 NSMutableAttributedString
    /// String 添加 font 后转 NSMutableAttributedString
    /// - Parameter font: 字体的大小
    /// - Returns: NSMutableAttributedString
    func font(_ font: CGFloat) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self.base as! String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)])
        return attributedText
    }
    
    // MARK: 14.3、String 添加 font 后转 NSMutableAttributedString
    /// String 添加 UIFont 后转 NSMutableAttributedString
    /// - Parameter font: UIFont
    /// - Returns: NSMutableAttributedString
    func font(_ font: UIFont) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self.base as! String, attributes: [NSAttributedString.Key.font: font])
        return attributedText
    }
    
    // MARK: 14.4、String 添加 text 后转 NSMutableAttributedString
    /// String 添加 text 后转 NSMutableAttributedString
    /// - Returns: NSMutableAttributedString
    func text() -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self.base as! String)
        return attributedText
    }
    
    // MARK: 14.5、String 添加 删除线 后转 NSMutableAttributedString
    /// String 添加 删除线 后转 NSMutableAttributedString
    /// - Returns: NSMutableAttributedString
    func strikethrough() -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self.base as! String, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        return attributedText
    }
}

// MARK: - 十五、MD5 加密 和 Base64 编解码
/**
 单向散列函数，又被称为消息摘要函数（message digest function），哈希函数
 输出的散列值，也被称为消息摘要（message digest）、指纹（fingerprint）
 
 常见的几种单向散列函数
 MD4、MD5
 产生128bit的散列值，MD就是Message Digest的缩写，目前已经不安全
 Mac终端上默认可以使用md5命令
 SHA-1
 产生160bit的散列值，目前已经不安全
 SHA-2
 SHA-256、SHA-384、SHA-512，散列值长度分别是256bit、384bit、512bit
 SHA-3 全新标准
 */
public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    /// MD5 加密类型
    enum MD5EncryptType {
        /// 32 位小写
        case lowercase32
        /// 32 位大写
        case uppercase32
        /// 16 位小写
        case lowercase16
        /// 16 位大写
        case uppercase16
    }
    
    // MARK: 15.1、MD5加密 默认是32位小写加密
    /// MD5加密 默认是32位小写加密
    /// - Parameter md5Type: 加密类型
    /// - Returns: MD5加密后的字符串
    func md5Encrypt(_ md5Type: MD5EncryptType = .lowercase32) -> String {
        guard let content = self.base as? String, content.count > 0 else {
            JKPrint("⚠️⚠️⚠️md5加密无效的字符串⚠️⚠️⚠️")
            return ""
        }
        if #available(iOS 13, *) {
            let md5String = Insecure.MD5.hash(data: content.data(using: .utf8)!)
            switch md5Type {
                // 32位小写
            case .lowercase32:
                return md5String.map {String(format: "%02x", $0)}.joined()
                // 32位大写
            case .uppercase32:
                return md5String.map {String(format: "%02X", $0)}.joined()
                // 16位小写
            case .lowercase16:
                let tempStr = md5String.map {String(format: "%02x", $0)}.joined()
                return tempStr.jk.slice(8..<24)
                // 16位大写
            case .uppercase16:
                let tempStr = md5String.map {String(format: "%02X", $0)}.joined()
                return tempStr.jk.slice(8..<24)
            }
        } else {
            // 1.把待加密的字符串转成char类型数据 因为MD5加密是C语言加密
            let cCharArray = content.cString(using: .utf8)
            // 2.创建一个字符串数组接受MD5的值
            var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            // 3.计算MD5的值
            /*
             第一个参数:要加密的字符串
             第二个参数: 获取要加密字符串的长度
             第三个参数: 接收结果的数组
             */
            CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
            
            switch md5Type {
                // 32位小写
            case .lowercase32:
                return uint8Array.reduce("") { $0 + String(format: "%02x", $1)}
                // 32位大写
            case .uppercase32:
                return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
                // 16位小写
            case .lowercase16:
                let tempStr = uint8Array.reduce("") { $0 + String(format: "%02x", $1)}
                return tempStr.jk.slice(8..<24)
                // 16位大写
            case .uppercase16:
                let tempStr = uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
                return tempStr.jk.slice(8..<24)
            }
        }
    }
    
    // MARK: 15.2、Base64 编解码
    /// Base64 编解码
    /// - Parameter encode: true:编码 false:解码
    /// - Returns: 编解码结果
    func base64String(encode: Bool) -> String? {
        guard encode else {
            // 1.解码
            guard let decryptionData = Data(base64Encoded: self.base as! String, options: .ignoreUnknownCharacters) else {
                return nil
            }
            return String(data: decryptionData, encoding: .utf8)
        }
        // 2.编码
        guard let codingData = (self.base as! String).data(using: .utf8) else {
            return nil
        }
        return codingData.base64EncodedString()
    }
}

// MARK: - 十六、AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
/**
 iOS中填充规则PKCS7,加解密模式ECB(无补码,CCCrypt函数中对应的nil),字符集UTF8,输出base64(可以自己改hex)
 */
// MARK: 加密模式
public enum DDYSCAType {
    case AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish
    var infoTuple: (algorithm: CCAlgorithm, digLength: Int, keyLength: Int) {
        switch self {
        case .AES:
            return (CCAlgorithm(kCCAlgorithmAES), Int(kCCKeySizeAES128), Int(kCCKeySizeAES128))
        case .AES128:
            return (CCAlgorithm(kCCAlgorithmAES128), Int(kCCBlockSizeAES128), Int(kCCKeySizeAES256))
        case .DES:
            return (CCAlgorithm(kCCAlgorithmDES), Int(kCCBlockSizeDES), Int(kCCKeySizeDES))
        case .DES3:
            return (CCAlgorithm(kCCAlgorithm3DES), Int(kCCBlockSize3DES), Int(kCCKeySize3DES))
        case .CAST:
            return (CCAlgorithm(kCCAlgorithmCAST), Int(kCCBlockSizeCAST), Int(kCCKeySizeMaxCAST))
        case .RC2:
            return (CCAlgorithm(kCCAlgorithmRC2), Int(kCCBlockSizeRC2), Int(kCCKeySizeMaxRC2))
        case .RC4:
            return (CCAlgorithm(kCCAlgorithmRC4), Int(kCCBlockSizeRC2), Int(kCCKeySizeMaxRC4))
        case .Blowfish:return (CCAlgorithm(kCCAlgorithmBlowfish), Int(kCCBlockSizeBlowfish), Int(kCCKeySizeMaxBlowfish))
        }
    }
}

public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 16.1、字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
    /// 字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
    /// - Parameters:
    ///   - cryptType: 加密类型
    ///   - key: 加密的key
    ///   - encode: 编码还是解码
    ///   - encryptIV: 偏移量
    /// - Returns: 编码或者解码后的字符串
    func scaCrypt(cryptType: DDYSCAType, key: String?, encode: Bool, encryptIV: String = "1") -> String? {
        
        let strData = encode ? (self.base as! String).data(using: .utf8) : Data(base64Encoded: (self.base as! String))
        // 创建数据编码后的指针
        let dataPointer = UnsafeRawPointer((strData! as NSData).bytes)
        // 获取转码后数据的长度
        let dataLength = size_t(strData!.count)
        
        // 2、后台对应的加密key
        // 将加密或解密的密钥转化为Data数据
        guard let keyData = key?.data(using: .utf8) else {
            return nil
        }
        // 创建密钥的指针
        let keyPointer = UnsafeRawPointer((keyData as NSData).bytes)
        // 设置密钥的长度
        let keyLength = cryptType.infoTuple.keyLength
        /// 3、后台对应的加密 IV，这个是跟后台商量的iv偏移量
        let encryptIV = "1"
        let encryptIVData = encryptIV.data(using: .utf8)!
        let encryptIVDataBytes = UnsafeRawPointer((encryptIVData as NSData).bytes)
        // 创建加密或解密后的数据对象
        let cryptData = NSMutableData(length: Int(dataLength) + cryptType.infoTuple.digLength)
        // 获取返回数据(cryptData)的指针
        let cryptPointer = UnsafeMutableRawPointer(mutating: cryptData!.mutableBytes)
        // 获取接收数据的长度
        let cryptDataLength = size_t(cryptData!.length)
        // 加密或则解密后的数据长度
        var cryptBytesLength:size_t = 0
        // 是解密或者加密操作(CCOperation 是32位的)
        let operation = encode ? CCOperation(kCCEncrypt) : CCOperation(kCCDecrypt)
        // 算法类型
        let algoritm: CCAlgorithm = CCAlgorithm(cryptType.infoTuple.algorithm)
        // 设置密码的填充规则（ PKCS7 & ECB 两种填充规则）
        let options: CCOptions = UInt32(kCCOptionPKCS7Padding) | UInt32(kCCOptionECBMode)
        // 执行算法处理
        let cryptStatus = CCCrypt(operation, algoritm, options, keyPointer, keyLength, encryptIVDataBytes, dataPointer, dataLength, cryptPointer, cryptDataLength, &cryptBytesLength)
        // 结果字符串初始化
        var resultString: String?
        // 通过返回状态判断加密或者解密是否成功
        if CCStatus(cryptStatus) == CCStatus(kCCSuccess) {
            cryptData!.length = cryptBytesLength
            if encode {
                resultString = cryptData!.base64EncodedString(options: .lineLength64Characters)
            } else {
                resultString = NSString(data:cryptData! as Data ,encoding:String.Encoding.utf8.rawValue) as String?
            }
        }
        return resultString
    }
}

// MARK: - 十七、SHA1, SHA224, SHA256, SHA384, SHA512
/**
 - 安全哈希算法（Secure Hash Algorithm）主要适用于数字签名标准（Digital Signature Standard DSS）里面定义的数字签名算法（Digital Signature Algorithm DSA）。对于长度小于2^64位的消息，SHA1会产生一个160位的消息摘要。当接收到消息的时候，这个消息摘要可以用来验证数据的完整性。在传输的过程中，数据很可能会发生变化，那么这时候就会产生不同的消息摘要。当让除了SHA1还有SHA256以及SHA512等。
 - SHA1有如下特性：不可以从消息摘要中复原信息；两个不同的消息不会产生同样的消息摘要
 - SHA1 SHA256 SHA512 这4种本质都是摘要函数，不通在于长度 SHA1是160位，SHA256是256位，SHA512是512位
 */
// MARK: 加密类型
public enum DDYSHAType {
    case SHA1, SHA224, SHA256, SHA384, SHA512
    var infoTuple: (algorithm: CCHmacAlgorithm, length: Int) {
        switch self {
        case .SHA1:
            return (algorithm: CCHmacAlgorithm(kCCHmacAlgSHA1), length: Int(CC_SHA1_DIGEST_LENGTH))
        case .SHA224:
            return (algorithm: CCHmacAlgorithm(kCCHmacAlgSHA224), length: Int(CC_SHA224_DIGEST_LENGTH))
        case .SHA256:
            return (algorithm: CCHmacAlgorithm(kCCHmacAlgSHA256), length: Int(CC_SHA256_DIGEST_LENGTH))
        case .SHA384:
            return (algorithm: CCHmacAlgorithm(kCCHmacAlgSHA384), length: Int(CC_SHA384_DIGEST_LENGTH))
        case .SHA512:
            return (algorithm: CCHmacAlgorithm(kCCHmacAlgSHA512), length: Int(CC_SHA512_DIGEST_LENGTH))
        }
    }
}

public extension JKPOP where Base: ExpressibleByStringLiteral {
    
    // MARK: 17.1、SHA1, SHA224, SHA256, SHA384, SHA512 加密
    /// SHA1, SHA224, SHA256, SHA384, SHA512 加密
    /// - Parameters:
    ///   - cryptType: 加密类型，默认是 SHA1 加密
    ///   - key: 加密的key
    ///   - lower: 大写还是小写，默认小写
    /// - Returns: 加密以后的字符串
    func shaCrypt(cryptType: DDYSHAType = .SHA1, key: String?, lower: Bool = true) -> String? {
        guard let cStr = (self.base as! String).cString(using: String.Encoding.utf8) else {
            return nil
        }
        let strLen  = strlen(cStr)
        let digLen = cryptType.infoTuple.length
        let buffer = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digLen)
        let hash = NSMutableString()
        
        if let cKey = key?.cString(using: String.Encoding.utf8), key != "" {
            let keyLen = Int(key!.lengthOfBytes(using: String.Encoding.utf8))
            CCHmac(cryptType.infoTuple.algorithm, cKey, keyLen, cStr, strLen, buffer)
        } else {
            switch cryptType {
            case .SHA1:     CC_SHA1(cStr,   (CC_LONG)(strlen(cStr)), buffer)
            case .SHA224:   CC_SHA224(cStr, (CC_LONG)(strlen(cStr)), buffer)
            case .SHA256:   CC_SHA256(cStr, (CC_LONG)(strlen(cStr)), buffer)
            case .SHA384:   CC_SHA384(cStr, (CC_LONG)(strlen(cStr)), buffer)
            case .SHA512:   CC_SHA512(cStr, (CC_LONG)(strlen(cStr)), buffer)
            }
        }
        for i in 0..<digLen {
            if lower {
                hash.appendFormat("%02x", buffer[i])
            } else {
                hash.appendFormat("%02X", buffer[i])
            }
        }
        free(buffer)
        return hash as String
    }
}

// MARK: - 十八、unicode编码和解码
public extension JKPOP where Base == String {
    
    // MARK: 18.1、unicode编码
    /// unicode编码
    /// - Returns: unicode编码后的字符串
    func unicodeEncode() -> String {
        var tempStr = String()
        for v in self.base.utf16 {
            if v < 128 {
                tempStr.append(Unicode.Scalar(v)!.escaped(asASCII: true))
                continue
            }
            let codeStr = String(v, radix: 16, uppercase: false)
            tempStr.append("\\u" + codeStr)
        }
        return tempStr
    }
    
    // MARK: 18.2、unicode解码
    /// unicode解码
    /// - Returns: unicode解码后的字符串
    func unicodeDecode() -> String {
        let tempStr1 = base.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr: String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
        } catch {
            JKPrint(error)
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
}

// MARK: - 十九、字符值引用 (numeric character reference, NCR)与普通字符串的转换
/**
 1，什么是字符值引用
 （1）字符值引用 (numeric character reference, NCR) 是在标记语言SGML以及派生的如HTML与XML中常见的一种转义序列结构，用来表示Unicode的通用字符集 (UCS)中的单个字符. NCR可以表示在一个特定文档中不能直接编码的字符，而该标记语言阅读器软件把每个NCR当作一个字符来处理。
 （2）我们可以将其理解为HTML、XML 等 SGML 类语言的转义序列（escape sequence）。而不是一种编码或转码。
 
 2，字符值引用的格式
 以「&#x」开头的后接十六进制数字。或者以「&#」开头的后接十进制数字。
 &#x4e2d;&#x56fd;  //中国（16进制格式）
 &#20013;&#22269;  //中国（10进制格式）
 （不管哪种形式写在html页面中都会正常显示出“中国”）
 */
public extension JKPOP where Base == String {
    
    // MARK: 19.1、将普通字符串转为字符值引用
    /// 将普通字符串转为字符值引用
    /// - Returns: 字符值引用
    func toHtmlEncodedString() -> String {
        var result: String = ""
        for scalar in self.base.utf16 {
            // 将十进制转成十六进制，不足4位前面补0
            let tem = String().appendingFormat("%04x",scalar)
            result += "&#x\(tem);"
        }
        return result
    }
    
    // MARK: 19.2、字符值引用转普通字符串
    /// 字符值引用转普通字符串
    /// - Parameter htmlEncodedString: 字符值引用
    /// - Returns: 普通字符串
    func htmlEncodedStringToString() -> String? {
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]
        guard let encodedData = self.base.data(using: String.Encoding.utf8), let attributedString = try? NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil) else {
            return nil
        }
        return attributedString.string
    }
}
