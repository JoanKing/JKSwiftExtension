//
//  String+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation
import UIKit

// MARK:- 0：字符串基本的扩展
public extension String {
    
    // MARK: 0.1、字符串的长度
    /// 字符串的长度
    var length: Int {
        return self.count
    }
    
    // MARK: 0.2、判断是否包含某个子串
    /// 判断是否包含某个子串
    /// - Parameter find: 子串
    /// - Returns: Bool
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    // MARK: 0.3、判断是否包含某个子串 -- 忽略大小写
    ///  判断是否包含某个子串 -- 忽略大小写
    /// - Parameter find: 子串
    /// - Returns: Bool
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    // MARK: 0.4、字符串转 Base64
    /// 字符串转 Base64
    var base64: String? {
        guard let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue) else {
            return nil
        }
        let base64String = plainData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    // MARK: 0.5、将16进制字符串转为Int
    /// 将16进制字符串转为Int
    var hexInt: Int {
        return Int(self, radix: 16) ?? 0
    }
    
    // MARK: 0.6、判断是不是九宫格键盘
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
    
    // MARK: 0.7、字符串转 UIViewController
    /// 字符串转 UIViewController
    /// - Returns: 对应的控制器
    @discardableResult
    func toViewController() -> UIViewController? {
        // 1.动态获取命名空间
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 2.将字符串转换为类
        // 2.1.默认情况下命名空间就是项目的名称，但是命名空间的名称是可以更改的
        guard let Class: AnyClass = NSClassFromString(namespace + "." + self) else {
            return nil
        }
        // 3.通过类创建对象
        // 3.1.将AnyClass 转化为指定的类
        let vcClass = Class as! UIViewController.Type
        // 4.通过class创建对象
        let vc = vcClass.init()
        return vc
    }
    
    // MARK: 0.8、字符串转 AnyClass
    /// 字符串转 AnyClass
    /// - Returns: 对应的 Class
    @discardableResult
    func toClass() -> AnyClass? {
        // 1.动态获取命名空间
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 2.将字符串转换为类
        // 2.1.默认情况下命名空间就是项目的名称，但是命名空间的名称是可以更改的
        guard let Class: AnyClass = NSClassFromString(namespace + "." + self) else {
            return nil
        }
        return Class
    }
    
    // MARK: 0.9、字符串转数组
    /// 字符串转数组
    /// - Returns: 转化后的数组
    func toArray() -> Array<Any> {
        let a = Array(self)
        return a
    }
}

// MARK:- 1、沙盒路径的获取
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
public extension String {
    // MARK: 1.1、获取Home的完整路径名
    /// 获取Home的完整路径名
    /// - Returns: Home的完整路径名
    static func homeDirectory() -> String {
        //获取程序的Home目录
        let homeDirectory = NSHomeDirectory()
        return homeDirectory
    }
    
    // MARK: 1.2、获取Documnets的完整路径名
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
    
    // MARK: 1.3、获取Library的完整路径名
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
    
    // MARK: 1.4、获取/Library/Caches的完整路径名
    /// 获取/Library/Caches的完整路径名
    /// - Returns: /Library/Caches的完整路径名
    static func CachesDirectory() -> String {
        //获取程序的/Library/Caches目录
        let cachesPath = NSHomeDirectory() + "/Library/Caches"
        return cachesPath
    }
    
    // MARK: 1.5、获取Library/Preferences的完整路径名
    /// 获取Library/Preferences的完整路径名
    /// - Returns: Library/Preferences的完整路径名
    static func PreferencesDirectory() -> String {
        //Library/Preferences目录－方法2
        let preferencesPath = NSHomeDirectory() + "/Library/Preferences"
        return preferencesPath
    }
    
    // MARK: 1.6、获取Tmp的完整路径名
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

// MARK:- 二、iOS CharacterSet（字符集）
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
public extension String {
    
    // MARK: 2.1、去除字符串前后的 空格
    /// 去除字符串前后的换行和换行
    var removeBeginEndAllSapcefeed: String {
        let resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return resultString
    }
    
    // MARK: 2.2、去除字符串前后的 换行
    /// 去除字符串前后的 换行
    var removeBeginEndAllLinefeed: String {
        let resultString = self.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }
    
    // MARK: 2.3、去除字符串前后的 换行和空格
    /// 去除字符串前后的 换行和空格
    var removeBeginEndAllSapceAndLinefeed: String {
        var resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }

    // MARK: 2.4、去掉所有空格
    /// 去掉所有空格
    var removeAllSapce: String {
        return replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    // MARK: 2.5、去掉所有换行
    /// 去掉所有换行
    var removeAllLinefeed: String {
        return replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
    }
    
    // MARK: 2.6、去掉所有空格 和 换行
    /// 去掉所有的空格 和 换行
    var removeAllLineAndSapcefeed: String {
        // 去除所有的空格
        var resultString = replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        // 去除所有的换行
        resultString = resultString.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
        return resultString
    }
    
    // MARK: 2.7、是否是 0-9 的数字，也不包含小数点
      /// 是否是 0-9 的数字，也不包含小数点
      /// - Returns: 结果
    func isValidNumber() -> Bool {
          /// 0-9的数字，也不包含小数点
          let rst: String = self.trimmingCharacters(in: .decimalDigits)
          if rst.count > 0 {
              return false
          }
          return true
      }
    
    // MARK: 2.8、url进行编码
    /// url 进行编码
    /// - Returns: 返回对应的URL
     func urlValidate() -> URL {
        return URL(string: self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ?? "")!
    }
    
    // MARK: 2.9、某个字符使用某个字符替换掉
    /// 某个字符使用某个字符替换掉
    /// - Parameters:
    ///   - removeString: 原始字符
    ///   - replacingString: 替换后的字符
    /// - Returns: 替换后的整体字符串
    func removeSomeStringUseSomeString(removeString: String, replacingString: String = "") -> String {
        return replacingOccurrences(of: removeString, with: replacingString)
    }
    
    // MARK: 2.10、使用正则表达式替换某些子串
    /// 使用正则表达式替换
    /// - Parameters:
    ///   - pattern: 正则
    ///   - with: 用来替换的字符串
    ///   - options: 策略
    /// - Returns: 返回替换后的字符串
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    // MARK: 2.11、删除指定的字符
    /// 删除指定的字符
    /// - Parameter characterString: 指定的字符
    /// - Returns: 返回删除后的字符
    func removeCharacter(characterString: String) -> String {
        let characterSet = CharacterSet(charactersIn: characterString)
        return trimmingCharacters(in: characterSet)
    }
}

// MARK:- 三、字符串的转换
public extension String {
    
    // MARK: 3.1、字符串 转 CGFloat
    /// 字符串 转 Float
    /// - Returns: CGFloat
    func toCGFloat() -> CGFloat? {
        if let doubleValue = Double(self) {
           return CGFloat(doubleValue)
        }
        return nil
    }
    
    // MARK: 3.2、字符串转 bool
    /// 字符串转 bool
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
    
    // MARK: 3.3、字符串转 Int
    /// 字符串转 Int
    /// - Returns: Int
    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    // MARK: 3.4、字符串转 Double
    /// 字符串转 Double
    /// - Returns: Double
    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    // MARK: 3.5、字符串转 Float
    /// 字符串转 Float
    /// - Returns: Float
    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    // MARK: 3.6、字符串转 Bool
    /// 字符串转 Bool
    /// - Returns: Bool
    func toBool() -> Bool? {
        let trimmedString = lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    
    // MARK: 3.7、字符串转 NSString
    /// 字符串转 NSString
    var toNSString: NSString {
        return self as NSString
    }
    
    // MARK: 3.8、字符串转 Int64
    /// 字符串转 Int64
    var toInt64Value: Int64 {
        return Int64(self) ?? 0
    }
    
    // MARK: 3.9、字符串转 NSNumber
    /// 字符串转 NSNumber
    var toNumber: NSNumber? {
        return self.toDouble()?.number
    }
}

// MARK:- 四、字符串UI的处理
extension String {
    
    // MARK: 4.1、对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
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
        let rect: CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size
    }
    
    // MARK: 4.2、对字符串(多行)指定字体及Size，获取 (高度)
    /// 对字符串指定字体及Size，获取 (高度)
    /// - Parameters:
    ///   - font: 字体的大小
    ///   - size: 字体的size
    /// - Returns: 返回对应字符串的高度
    public func rectHeight(font: UIFont, size: CGSize) -> CGFloat {
        return rectSize(font: font, size: size).height
    }
    
    // MARK: 4.3、对字符串(多行)指定字体及Size，获取 (宽度)
    /// 对字符串指定字体及Size，获取 (宽度)
    /// - Parameters:
    ///   - font: 字体的大小
    ///   - size: 字体的size
    /// - Returns: 返回对应字符串的宽度
    public func rectWidth(font: UIFont, size: CGSize) -> CGFloat {
        return rectSize(font: font, size: size).width
    }

    // MARK: 4.4、对字符串(单行)指定字体，获取 (Size)
    /// 对字符串(单行)指定字体，获取 (Size)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 size
    public func singleLineSize(font: UIFont) -> CGSize {
        let attrs = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attrs as [NSAttributedString.Key: Any])
    }
    
    // MARK: 4.5、对字符串(单行)指定字体，获取 (width)
    /// 对字符串(单行)指定字体，获取 (width)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 width
    public func singleLineWidth(font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attrs as [NSAttributedString.Key: Any]).width
    }
    
    // MARK: 4.6、对字符串(单行)指定字体，获取 (Height)
    /// 对字符串(单行)指定字体，获取 (height)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 height
    public func singleLineHeight(font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attrs as [NSAttributedString.Key: Any]).height
    }
    
    // MARK: 4.7、字符串通过 label 根据高度&字体 —> Size
    /// 字符串通过 label 根据高度&字体 ——> Size
    /// - Parameters:
    ///   - height: 字符串最大的高度
    ///   - font: 字体大小
    /// - Returns: 返回Size
    public func sizeAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGSize {
        if self.isBlank {return CGSize(width: 0, height: 0)}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        return label.sizeThatFits(rect.size)
    }
    
    // MARK: 4.8、字符串通过 label 根据高度&字体 —> Width
    /// 字符串通过 label 根据高度&字体 ——> Width
    /// - Parameters:
    ///   - height: 字符串最大高度
    ///   - font: 字体大小
    /// - Returns: 返回宽度大小
    public func widthAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        return label.sizeThatFits(rect.size).width
    }
    
    // MARK: 4.9、字符串通过 label 根据宽度&字体 —> height
    /// 字符串通过 label 根据宽度&字体 ——> height
    /// - Parameters:
    ///   - width: 字符串最大宽度
    ///   - font: 字体大小
    /// - Returns: 返回高度大小
    public func heightAccording(width: CGFloat, height: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGFloat {
        if self.isBlank {return 0}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        return label.sizeThatFits(rect.size).height
    }
    
    // MARK: 4.10、字符串根据宽度 & 字体 & 行间距 —> Size
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
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        let attrStr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, self.count))
        label.attributedText = attrStr
        return label.sizeThatFits(rect.size)
    }
    
    // MARK: 4.11、字符串根据宽度 & 字体 & 行间距 —> width
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
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        let attrStr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, self.count))
        label.attributedText = attrStr
        return label.sizeThatFits(rect.size).width
    }

    // MARK: 4.12、字符串根据宽度 & 字体 & 行间距 —> height
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
        let label = UILabel(frame: rect).font(font).text(self).line(0)
        let attrStr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, self.count))
        label.attributedText = attrStr
        return label.sizeThatFits(rect.size).height
    }
}


// MARK:- 五、字符串有关数字方面的扩展
public enum StringCutType {
    case normal, auto
}

public extension String {
    
    // MARK: 5.1、将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// 将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// - Returns: 千分位的字符串
    func toThousands() -> String? {
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
    
    // MARK: 5.2、字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    /// - Important: 字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    func accuraterDouble() -> Double? {
        guard let decimal = Decimal(string: self) else { return nil }
        JKPrint(NSDecimalNumber(decimal: decimal).doubleValue)
        return NSDecimalNumber(decimal: decimal).doubleValue
    }
    
    // MARK:- 5.3、去掉小数点后多余的0
    /// 去掉小数点后多余的0
    /// - Returns: 返回小数点后没有 0 的金额
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
    
    // MARK: 5.4、将数字的字符串处理成  几位 位小数的情况
    /// 将数字的字符串处理成  几位 位小数的情况
    /// - Parameters:
    ///   - numberDecimal: 保留几位小数
    ///   - mode: 模式
    /// - Returns: 返回保留后的小数，如果是非字符，则根据numberDecimal 返回0 或 0.00等等
    func saveNumberDecimal(numberDecimal: Int = 0, mode: NumberFormatter.RoundingMode = .floor) -> String {
        var n = NSDecimalNumber(string: self)
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

// MARK:- 六、苹果针对浮点类型计算精度问题提供出来的计算类
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
    // MARK: 6.1、＋
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
    
    // MARK: 6.2、－
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
    
    // MARK: 6.3、*
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
    
    // MARK: 6.4、/
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

// MARK:- 七、字符串包含表情的处理
extension String {
    
    // MARK: 7.1.1、检查字符串是否包含 Emoji 表情
    /// 检查字符串是否包含 Emoji 表情
    /// - Returns: bool
    public func containsEmoji() -> Bool {
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
    
    // MARK: 7.1.2、检查字符串是否包含 Emoji 表情
    /// 检查字符串是否包含 Emoji 表情
    /// - Returns: bool
    public func includesEmoji() -> Bool {
        for i in 0...length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
    
    // MARK: 7.2、去除字符串中的Emoji表情
    /// 去除字符串中的Emoji表情
    /// - Parameter text: 字符串
    /// - Returns: 去除Emoji表情后的字符串
    public func deleteEmoji() -> String {
        do {
            let regex = try NSRegularExpression(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: NSRegularExpression.Options.caseInsensitive)
            
            let modifiedString = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.length), withTemplate: "")
            
            return modifiedString
        } catch {
            JKPrint(error)
        }
        return ""
    }
}

// MARK:- 八、字符串的一些正则校验
extension String {
    
    // MARK: 8.1、判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    /// 判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    public var isBlank: Bool {
        return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == ""
    }

    // MARK: 8.2、判断是否全十进制数字，长度为0返回false
    /// 判断是否全十进制数字，长度为0返回false
    public var isDecimalDigits: Bool {
        if isEmpty {
            return false
        }
        // 去除什么的操作
        return trimmingCharacters(in: NSCharacterSet.decimalDigits) == ""
    }

    // MARK: 8.3、判断是否是整数
    /// 判断是否是整数
    public var isPureInt: Bool {
        let scan: Scanner = Scanner(string: self)
        var n: Int = 0
        return scan.scanInt(&n) && scan.isAtEnd
    }

    // MARK: 8.4、判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    /// 判断是否是Float，此处Float是包含Int的，即Int是特殊的Float
    public var isPureFloat: Bool {
        let scan: Scanner = Scanner(string: self)
        var n: Float = 0.0
        return scan.scanFloat(&n) && scan.isAtEnd
    }

    // MARK: 8.5、判断是否全是字母，长度为0返回false
    /// 判断是否全是字母，长度为0返回false
    public var isLetters: Bool {
        if isEmpty {
            return false
        }
        return trimmingCharacters(in: NSCharacterSet.letters) == ""
    }

    // MARK: 8.6、判断是否是中文, 这里的中文不包括数字及标点符号
    /// 判断是否是中文, 这里的中文不包括数字及标点符号
    public var isChinese: Bool {
        let mobileRgex = "(^[\u{4e00}-\u{9fef}]+$)"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }
    
    // MARK: 8.7、是否是有效昵称，即允许“中文”、“英文”、“数字”
    /// 是否是有效昵称，即允许“中文”、“英文”、“数字”
    public var isValidNickName: Bool {
        let rgex = "(^[\u{4e00}-\u{9faf}_a-zA-Z0-9]+$)"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", rgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.8、判断是否是有效的手机号码
    /// 判断是否是有效的手机号码
    public var isValidMobile: Bool {
        let mobileRgex = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199)\\d{8}$"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.9、判断是否是有效的电子邮件地址
    /// 判断是否是有效的电子邮件地址
    public var isValidEmail: Bool {
        let mobileRgex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.10、判断是否有效的身份证号码，不是太严格
    /// 判断是否有效的身份证号码，不是太严格
    public var isValidIDCardNumber: Bool {
        let mobileRgex = "^(\\d{15})|((\\d{17})(\\d|[X]))$"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.11、严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    /// 严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    public var isValidIDCardNumStrict: Bool {
        let str = trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        let len = str.count
        if !str.isValidIDCardNumber {
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
        case 15:
            // 15位身份证
            // 这里年份只有两位，00被处理为闰年了，对2000年是正确的，对1900年是错误的，不过身份证是1900年的应该很少了
            year = Int(str.sub(start: 6, length: 2))!
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
            year = Int(str.sub(start: 6, length: 4))!
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
    
    // MARK: 8.12、校验字符串位置是否合理，并返回String.Index
    /// 校验字符串位置是否合理，并返回String.Index
    /// - Parameter original: 位置
    /// - Returns: String.Index
    public func validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.utf16Offset(in: self):
            return startIndex
        case endIndex.utf16Offset(in: self)...:
            return endIndex
        default:
            return index(startIndex, offsetBy: original)
        }
    }
    
    // MARK: 8.13、隐藏手机号中间的几位
    /// 隐藏手机号中间的几位
    /// - Parameter combine: 隐藏的字符串(替换的类型)
    /// - Returns: 返回隐藏的手机号
    public func hidePhone(combine: String = "****") -> String {
        if self.count >= 11 {
            let pre = self.sub(start: 0, length: 3)
            let post = self.sub(start: 7, length: 4)
            return pre + combine + post
        } else {
            return self
        }
    }

    // MARK:- private 方法
    // MARK: 是否是闰年
    /// 是否是闰年
    /// - Parameter year: 年份
    /// - Returns: 返回是否是闰年
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
}

// MARK:- 九、字符串截取的操作
extension String {
    
    // MARK: 9.1、截取字符串从开始到 index
    /// 截取字符串从开始到 index
    /// - Parameter index: 截取到的位置
    /// - Returns: 截取后的字符串
    public func sub(to index: Int) -> String {
        let end_Index = validIndex(original: index)
        return String(self[startIndex ..< end_Index])
    }

    // MARK: 9.2、截取字符串从index到结束
    /// 截取字符串从index到结束
    /// - Parameter index: 截取结束的位置
    /// - Returns: 截取后的字符串
    public func sub(from index: Int) -> String {
        let start_index = validIndex(original: index)
        return String(self[start_index ..< endIndex])
    }

    // MARK: 9.3、获取指定位置和长度的字符串
    /// 获取指定位置和大小的字符串
    /// - Parameters:
    ///   - start: 开始位置
    ///   - length: 长度
    /// - Returns: 截取后的字符串
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

    // MARK: 9.4、切割字符串(区间范围 前闭后开)
    /**
     https://blog.csdn.net/wang631106979/article/details/54098910
     CountableClosedRange：可数的闭区间，如 0...2
     CountableRange：可数的开区间，如 0..<2
     ClosedRange：不可数的闭区间，如 0.1...2.1
     Range：不可数的开居间，如 0.1..<2.1
     */
    /// 切割字符串(区间范围 前闭后开)
    /// - Parameter range: 范围
    /// - Returns: 切割后的字符串
    public func slice(_ range: CountableRange<Int>) -> String { // 如 sliceString(2..<6)
        /**
         upperBound（上界）
         lowerBound（下界）
         */
        let startIndex = validIndex(original: range.lowerBound)
        let endIndex = validIndex(original: range.upperBound)
        guard startIndex < endIndex else {
            return ""
        }
        return String(self[startIndex ..< endIndex])
    }

    // MARK: 9.5、用整数返回子字符串开始的位置
    /// 用整数返回子字符串开始的位置
    /// - Parameter sub: 字符串
    /// - Returns: 返回字符串的位置
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

// MARK:- 十、字符串编码的处理
extension String {

    // MARK: 10.1、特殊字符编码处理urlEncoded
    /// url编码 默认urlQueryAllowed
    public func urlEncoding(characters: CharacterSet = .urlQueryAllowed) -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            characters)
        return encodeUrlString ?? ""
    }

    // MARK:- 10.2、url编码 Alamofire AFNetworking 处理方式 推荐使用
    /// url编码 Alamofire AFNetworking 处理方式 推荐使用
    public var urlEncoded: String {
        // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            allowedCharacterSet)
        return encodeUrlString ?? ""
    }
    
    // MARK: 10.3、url编码 会对所有特殊字符做编码  特殊情况下使用
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
}

// MARK:- 十一、进制之间的转换
/*
 Binary：      二进制
 Octal：       八进制
 Decimal：     十进制
 Hexadecimal： 十六进制
 */
public extension String {
    
    // MARK: 11.1、二进制 -> 十进制
    /// 二进制 -> 十进制
    /// - Returns: 十进制
    func binaryTodecimal() -> String {
        let binary = self
        var sum = 0
        for c in binary {
            if let number = "\(c)".toInt() {
                sum = sum * 2 + number
            }
        }
        return "\(sum)"
    }
    
    // MARK: 11.2、八进制 -> 十进制
    /// 八进制 -> 十进制
    /// - Returns: 十进制
    func octalTodecimal() -> String {
        let binary = self
        var sum: Int = 0
        for c in binary {
            if let number = "\(c)".toInt() {
                sum = sum * 8 + number
            }
        }
        return "\(sum)"
    }
    
    // MARK: 11.3、十六进制 转 十进制
    /// 十六进制  转 十进制
    /// - Returns: 十进制
    func hexadecimalToDecimal() -> String {
        let str = self.uppercased()
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
    
    // MARK: 11.4、十进制 转 二进制
    /// 十进制 转 二进制
    /// - Returns: 二进制
    func decimalToBinary() -> String {
        guard var decimal = self.toInt() else {
            return ""
        }
        var str = ""
        while decimal > 0 {
            str = "\(decimal % 2)" + str
            decimal /= 2
        }
        return str
    }
    // MARK: 11.5、十进制转 八进制
    /// 十进制转 八进制
    /// - Returns: 八进制
    func decimalToOctal() -> String {
       guard var decimal = self.toInt() else {
           return ""
       }
       var str = ""
       while decimal > 0 {
           str = "\(decimal % 8)" + str
           decimal /= 8
       }
       return str
    }
    
    // MARK: 11.6、十进制转 十六进制
    /// 十进制转 十六进制
    /// - Returns: 十六进制
    func decimalToHexadecimal() -> String {
       guard let decimal = self.toInt() else {
           return ""
       }
       return String(format: "%0X", decimal)
    }
}
