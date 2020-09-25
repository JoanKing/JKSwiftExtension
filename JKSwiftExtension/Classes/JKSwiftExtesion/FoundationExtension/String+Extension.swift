//
//  String+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/12/1.
//  Copyright © 2019 王冲. All rights reserved.
//

import Foundation

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
    
    /// MARK: 5.返回Tmp的完整路径名
    /**
     用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空。
     */
    
    // MARK: 5.返回Tmp的完整路径名
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
}

// MARK:- 字符串的包含的判断
public extension String {
    
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
}

// MARK:- 精确度的处理
public extension String {
    /// - Important: 字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    func accuraterDouble() -> Double? {
        guard let decimal = Decimal(string: self) else { return nil }
        print(NSDecimalNumber(decimal: decimal).doubleValue)
        return NSDecimalNumber(decimal: decimal).doubleValue
    }
    /// - Important: cut小数点后多余的0
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
        }
        else {
            return self
        }
    }
}
