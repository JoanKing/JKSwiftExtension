//
//  FileManager+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit
import Foundation
import AVKit

extension FileManager: JKPOPCompatible {}
// MARK: - 一、沙盒路径的获取
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

public enum BasePath {
    case Directory
    case Documnets
    case Library
    case Caches
    case Preferences
    case Tmp
}

public extension JKPOP where Base: FileManager {
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
    /// 获取Tmp的完整路径名，用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空
    /// - Returns: Tmp的完整路径名
    static func TmpDirectory() -> String {
        //方法1
        //let tmpDir = NSTemporaryDirectory()
        //方法2
        let tmpDir = NSHomeDirectory() + "/tmp"
        return tmpDir
    }
}

// MARK: - 二、文件以及文件夹的操作 扩展
public extension JKPOP where Base: FileManager {
    // MARK: 文件写入的类型
    /// 文件写入的类型
    enum FileWriteType {
        case TextType
        case ImageType
        case ArrayType
        case DictionaryType
    }
    // MARK: 移动或者拷贝的类型
    /// 移动或者拷贝的类型
    enum MoveOrCopyType {
        case file
        case directory
    }
    /// 文件管理器
    static var fileManager: FileManager {
        return FileManager.default
    }

    // MARK: 2.1、创建文件夹(蓝色的，文件夹和文件是不一样的)
    /// 创建文件夹(蓝色的，文件夹和文件是不一样的)
    /// - Parameter folderName: 文件夹的名字
    /// - Returns: 返回创建的 创建文件夹路径
    @discardableResult
    static func createFolder(folderPath: String) -> (isSuccess: Bool, error: String) {
        if judgeFileOrFolderExists(filePath: folderPath) {
            return (true, "")
        }
        // 不存在的路径才会创建
        do {
            // withIntermediateDirectories为ture表示路径中间如果有不存在的文件夹都会创建
            try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            return (true, "")
        } catch _ {
            return (false, "创建失败")
        }
    }
    
    // MARK: 2.2、删除文件夹
    /// 删除文件夹
    /// - Parameter folderPath: 文件的路径
    @discardableResult
    static func removefolder(folderPath: String) -> (isSuccess: Bool, error: String) {
        let filePath = "\(folderPath)"
        guard judgeFileOrFolderExists(filePath: filePath) else {
            // 不存在就不做什么操作了
            return (true, "")
        }
        // 文件存在进行删除
        do {
            try fileManager.removeItem(atPath: filePath)
            return (true, "")
        } catch _ {
            return (false, "删除失败")
        }
    }

    // MARK: 2.3、创建文件
    /// 创建文件
    /// - Parameter filePath: 文件路径
    /// - Returns: 返回创建的结果 和 路径
    @discardableResult
    static func createFile(filePath: String) -> (isSuccess: Bool, error: String) {
        guard judgeFileOrFolderExists(filePath: filePath) else {
            // 不存在的文件路径才会创建
            // withIntermediateDirectories 为 ture 表示路径中间如果有不存在的文件夹都会创建
            let createSuccess = fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
            return (createSuccess, "")
        }
        return (true, "")
    }
    
    // MARK: 2.4、删除文件
    /// 删除文件
    /// - Parameter filePath: 文件路径
    @discardableResult
    static func removefile(filePath: String) -> (isSuccess: Bool, error: String) {
        guard judgeFileOrFolderExists(filePath: filePath) else {
            // 不存在的文件路径就不需要要移除
            return (true, "")
        }
        // 移除文件
        do {
            try fileManager.removeItem(atPath: filePath)
            return (true, "")
        } catch _ {
            return (false, "移除文件失败")
        }
    }
    
    // MARK: 2.5、读取文件内容
    /// 读取文件内容
    /// - Parameter filePath: 文件路径
    /// - Returns: 文件内容
    @discardableResult
    static func readfile(filePath: String) -> String? {
        guard judgeFileOrFolderExists(filePath: filePath) else {
            // 不存在的文件路径就不需要要移除
            return nil
        }
        let data = fileManager.contents(atPath: filePath)
        return String(data: data!, encoding: String.Encoding.utf8)
    }
    
    // MARK: 2.6、把文字，图片，数组，字典写入文件
    /// 把文字，图片，数组，字典写入文件
    /// - Parameters:
    ///   - writeType: 写入类型
    ///   - content: 写入内容
    ///   - writePath: 写入路径
    /// - Returns: 写入的结果
    @discardableResult
    static func writeToFile(writeType: FileWriteType, content: Any, writePath: String) -> (isSuccess: Bool, error: String) {
        guard judgeFileOrFolderExists(filePath: directoryAtPath(path: writePath)) else {
            // 不存在的文件路径
            return (false, "不存在的文件路径")
        }
        // 1、文字，2、图片，3、数组，4、字典写入文件
        switch writeType {
        case .TextType:
            let info = "\(content)"
            do {
                // 文件可以追加
                // let stringToWrite = "\n" + string
                // 找到末尾位置并添加
                // fileHandle.seekToEndOfFile()
                try info.write(toFile: writePath, atomically: true, encoding: String.Encoding.utf8)
                return (true, "")
            } catch _ {
                return (false, "写入失败")
            }
        case .ImageType:
            let data = content as! Data
            do {
                try data.write(to: URL(fileURLWithPath: writePath))
                return (true, "")
            } catch _ {
                return (false, "写入失败")
            }
        case .ArrayType:
            let array = content as! NSArray
            let result = array.write(toFile: writePath, atomically: true)
            if result {
                return (true, "")
            } else {
                return (false, "写入失败")
            }
        case .DictionaryType:
            let result = (content as! NSDictionary).write(toFile: writePath, atomically: true)
            if result {
                return (true, "")
            } else {
                return (false, "写入失败")
            }
        }
    }
    
    // MARK: 2.7、从文件 读取 文字，图片，数组，字典
    /// 从文件 读取 文字，图片，数组，字典
    /// - Parameters:
    ///   - readType: 读取的类型
    ///   - readPath: 读取文件路径
    /// - Returns: 返回读取的内容
    @discardableResult
    static func readFromFile(readType: FileWriteType, readPath: String) -> (isSuccess: Bool, content: Any?, error: String) {
        guard judgeFileOrFolderExists(filePath: readPath),  let readHandler =  FileHandle(forReadingAtPath: readPath) else {
            // 不存在的文件路径
            return (false, nil, "不存在的文件路径")
        }
        let data = readHandler.readDataToEndOfFile()
        // 1、文字，2、图片，3、数组，4、字典
        switch readType {
        case .TextType:
            let readString = String(data: data, encoding: String.Encoding.utf8)
            return (true, readString, "")
        case .ImageType:
            let image = UIImage(data: data)
            return (true, image, "")
        case .ArrayType:
            guard let readString = String(data: data, encoding: String.Encoding.utf8) else {
                return (false, nil, "读取内容失败")
            }
            return (true, readString.jk.jsonStringToArray(), "")
        case .DictionaryType:
            guard let readString = String(data: data, encoding: String.Encoding.utf8) else {
                return (false, nil, "读取内容失败")
            }
            return (true, readString.jk.jsonStringToDictionary(), "")
        }
    }
    
    // MARK: 2.8、拷贝(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 拷贝
    /**
     几个小注意点：
     1、目标路径，要带上文件夹名称，而不能只写父路径
     2、如果是覆盖拷贝，就是说目标路径已存在此文件夹，我们必须先删除，否则提示make directory error（当然这里最好做一个容错处理，比如拷贝前先转移到其他路径，如果失败，再拿回来）
     */
    /// 拷贝(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 拷贝
    /// - Parameters:
    ///   - fromeFile: 拷贝的(文件夹/文件)路径
    ///   - toFile: 拷贝后的(文件夹/文件)路径
    ///   - isOverwrite: 当要拷贝到的(文件夹/文件)路径存在，会拷贝失败，这里传入是否覆盖
    /// - Returns: 拷贝的结果
    @discardableResult
    static func copyFile(type: MoveOrCopyType, fromeFilePath: String, toFilePath: String, isOverwrite: Bool = true) -> (isSuccess: Bool, error: String) {
        // 1、先判断被拷贝路径是否存在
        guard judgeFileOrFolderExists(filePath: fromeFilePath) else {
            return (false, "被拷贝的(文件夹/文件)路径不存在")
        }
        // 2、判断拷贝后的文件路径的前一个文件夹路径是否存在，不存在就进行创建
        let toFileFolderPath = directoryAtPath(path: toFilePath)
        if !judgeFileOrFolderExists(filePath: toFileFolderPath), type == .file ? !createFile(filePath: toFilePath).isSuccess : !createFolder(folderPath: toFileFolderPath).isSuccess {
            return (false, "拷贝后路径前一个文件夹不存在")
        }
        // 3、如果被拷贝的(文件夹/文件)已存在，先删除，否则拷贝不了
        if isOverwrite, judgeFileOrFolderExists(filePath: toFilePath) {
            do {
                try fileManager.removeItem(atPath: toFilePath)
            } catch _ {
                return (false, "拷贝失败")
            }
        }
        // 4、拷贝(文件夹/文件)
        do {
            try fileManager.copyItem(atPath: fromeFilePath, toPath: toFilePath)
        } catch _ {
            return (false, "拷贝失败")
        }
        return (true, "success")
    }
    
    // MARK: 2.9、移动(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 移动
    /// 移动(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 移动
    /// - Parameters:
    ///   - fromeFile: 被移动的文件路径
    ///   - toFile: 移动后的文件路径
    @discardableResult
    static func moveFile(type: MoveOrCopyType, fromeFilePath: String, toFilePath: String, isOverwrite: Bool = true) -> (isSuccess: Bool, error: String) {
        // 1、先判断被拷贝路径是否存在
        guard judgeFileOrFolderExists(filePath: fromeFilePath) else {
            return (false, "被移动的(文件夹/文件)路径不存在")
        }
        // 2、判断拷贝后的文件路径的前一个文件夹路径是否存在，不存在就进行创建
        let toFileFolderPath = directoryAtPath(path: toFilePath)
        if !judgeFileOrFolderExists(filePath: toFileFolderPath), type == .file ? !createFile(filePath: toFilePath).isSuccess : !createFolder(folderPath: toFileFolderPath).isSuccess {
            return (false, "移动后路径前一个文件夹不存在")
        }
        // 3、如果被移动的(文件夹/文件)已存在，先删除，否则拷贝不了
        if isOverwrite, judgeFileOrFolderExists(filePath: toFilePath) {
            do {
                try fileManager.removeItem(atPath: toFilePath)
            } catch _ {
                return (false, "移动失败")
            }
        }
        // 4、移动(文件夹/文件)
        do {
            try fileManager.moveItem(atPath: fromeFilePath, toPath: toFilePath)
        } catch _ {
            return (false, "移动失败")
        }
        return (true, "success")
    }
    
    // MARK: 2.10、判断 (文件夹/文件) 是否存在
    /// 判断文件或文件夹是否存在
    static func judgeFileOrFolderExists(filePath: String) -> Bool {
        let exist = fileManager.fileExists(atPath: filePath)
        // 查看文件夹是否存在，如果存在就直接读取，不存在就直接反空
        guard exist else {
            return false
        }
        return true
    }
    
    // MARK: 2.11、获取 (文件夹/文件) 的前一个路径
    /// 获取 (文件夹/文件) 的前一个路径
    /// - Parameter path: (文件夹/文件) 的路径
    /// - Returns: (文件夹/文件) 的前一个路径
    static func directoryAtPath(path: String) -> String {
        return (path as NSString).deletingLastPathComponent
    }
    
    // MARK: 2.12、判断目录是否可读
    static func judegeIsReadableFile(path: String) -> Bool {
        return fileManager.isReadableFile(atPath: path)
    }
    
    // MARK: 2.13、判断目录是否可写
    static func judegeIsWritableFile(path: String) -> Bool {
        return fileManager.isReadableFile(atPath: path)
    }
    
    // MARK: 2.14、判断目录是否可执行
    static func judegeIsExecutableFile(path: String) -> Bool {
        return fileManager.isExecutableFile(atPath: path)
    }
    
    // MARK: 2.15、判断目录是否可删除
    static func judegeIsDeletableFile(path: String) -> Bool {
        return fileManager.isDeletableFile(atPath: path)
    }
    
    // MARK: 2.16、根据文件路径获取文件扩展类型
    /// 根据文件路径获取文件扩展类型
    /// - Parameter path: 文件路径
    /// - Returns: 文件扩展类型
    static func fileSuffixAtPath(path: String) -> String {
        return (path as NSString).pathExtension
    }
    
    // MARK: 2.17、根据文件路径获取文件名称，是否需要后缀
    /// 根据文件路径获取文件名称，是否需要后缀
    /// - Parameters:
    ///   - path: 文件路径
    ///   - suffix: 是否需要后缀，默认需要
    /// - Returns: 文件名称
    static func fileName(path: String, suffix: Bool = true) -> String {
        let fileName = (path as NSString).lastPathComponent
        guard suffix else {
            // 删除后缀
            return (fileName as NSString).deletingPathExtension
        }
        return fileName
    }
    
    // MARK: 2.18、对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表(只寻找一层)
    /// 对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表(只寻找一层)
    /// - Parameter folderPath: 建搜索的lujing
    /// - Returns: 指定目录路径下的文件、子目录及符号链接的列表
    static func shallowSearchAllFiles(folderPath: String) -> Array<String>? {
        guard let contentsOfDirectoryArray = try? fileManager.contentsOfDirectory(atPath: folderPath) else {
            return nil
        }
        return contentsOfDirectoryArray
    }
    
    // MARK: 2.19、深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）
    /**深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）*/
    static func getAllFileNames(folderPath: String) -> Array<String>? {
        // 查看文件夹是否存在，如果存在就直接读取，不存在就直接反空
        guard judgeFileOrFolderExists(filePath: folderPath), let subPaths = fileManager.subpaths(atPath: folderPath) else {
            return nil
        }
        return subPaths
    }
    
    // MARK: 2.20、深度遍历，会递归遍历子文件夹（但不会递归符号链接）
    /** 对指定路径深度遍历，会递归遍历子文件夹（但不会递归符号链接））*/
    static func deepSearchAllFiles(folderPath: String) -> Array<Any>? {
        // 查看文件夹是否存在，如果存在就直接读取，不存在就直接反空
        guard judgeFileOrFolderExists(filePath: folderPath), let contentsOfPathArray = fileManager.enumerator(atPath: folderPath) else {
            return nil
        }
        return contentsOfPathArray.allObjects
    }
    
    // MARK: 2.21、计算单个 (文件夹/文件) 的大小，单位为字节(bytes) （没有进行转换的）
    /// 计算单个 (文件夹/文件) 的大小，单位为字节 （没有进行转换的）
    /// - Parameter filePath: (文件夹/文件) 路径
    /// - Returns: 单个文件或文件夹的大小
    static func fileOrDirectorySingleSize(filePath: String) -> UInt64 {
        // 1、先判断文件路径是否存在
        guard judgeFileOrFolderExists(filePath: filePath) else {
            return 0
        }
        // 2、读取文件大小
        guard let fileAttributes = try? fileManager.attributesOfItem(atPath: filePath), let fileSizeValue = fileAttributes[FileAttributeKey.size] as? UInt64 else {
            return 0
        }
        return fileSizeValue
    }
    
    //MARK: 2.22、计算 (文件夹/文件) 的大小（转换过的）
    /// 计算 (文件夹/文件) 的大小
    /// - Parameter path: (文件夹/文件) 的路径
    /// - Returns: (文件夹/文件) 的大小
    static func fileOrDirectorySize(path: String) -> String {
        if path.count == 0, !fileManager.fileExists(atPath: path) {
            return "0MB"
        }
        // (文件夹/文件) 的实际大小
        var fileSize: UInt64 = 0
        do {
            let files = try fileManager.contentsOfDirectory(atPath: path)
            for file in files {
                let path = path + "/\(file)"
                fileSize = fileSize + fileOrDirectorySingleSize(filePath: path)
            }
        } catch {
            fileSize = fileSize + fileOrDirectorySingleSize(filePath: path)
        }
        // 转换后的大小 ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        return covertUInt64ToString(with: fileSize)
    }

    // MARK: 2.23、获取(文件夹/文件)属性集合
    ///  获取(文件夹/文件)属性集合
    /// - Parameter path: (文件夹/文件)路径
    /// - Returns: (文件夹/文件)属性集合
    @discardableResult
    static func fileAttributes(path: String) -> ([FileAttributeKey : Any]?) {
        do {
            let attributes = try fileManager.attributesOfItem(atPath: path)
            /*
            print("创建时间：\(attributes[FileAttributeKey.creationDate]!)")
            print("修改时间：\(attributes[FileAttributeKey.modificationDate]!)")
            print("文件大小：\(attributes[FileAttributeKey.size]!)")
            */
            return attributes
        } catch _ {
            return nil
        }
        // key的列表如：
        /*
        public static let type:
        public static let size:
        public static let modificationDate:
        public static let referenceCount:
        public static let deviceIdentifier:
        public static let ownerAccountName:
        public static let groupOwnerAccountName:
        public static let posixPermissions:
        public static let systemNumber:
        public static let systemFileNumber:
        public static let extensionHidden:
        public static let hfsCreatorCode:
        public static let hfsTypeCode:
        public static let immutable:
        public static let appendOnly:
        public static let creationDate:
        public static let ownerAccountID:
        public static let groupOwnerAccountID:
        public static let busy:
        @available(iOS 4.0, *)
        public static let protectionKey:
        public static let systemSize:
        public static let systemFreeSize:
        public static let systemNodes:
        public static let systemFreeNodes:
        */
    }
    
    // MARK: 2.24、文件/文件夹比较 是否一样
    static func isEqual(filePath1: String, filePath2: String) -> Bool {
        // 先判断是否存在路径
        guard judgeFileOrFolderExists(filePath: filePath1), judgeFileOrFolderExists(filePath: filePath2) else {
            return false
        }
        // 下面比较用户文档中前面两个文件是否内容相同（该方法也可以用来比较目录）
        return fileManager.contentsEqual(atPath: filePath1, andPath: filePath2)
    }
}

// MARK: fileprivate
public extension JKPOP where Base: FileManager {
    
    // MARK: 计算文件大小：UInt64 -> String
    /// 计算文件大小：UInt64 -> String
    /// - Parameter size: 文件的大小
    /// - Returns: 转换后的文件大小
    static func covertUInt64ToString(with size: UInt64) -> String {
        var convertedValue: Double = Double(size)
        var multiplyFactor = 0
        let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        while convertedValue > 1024 {
            convertedValue /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
    }
}

// MARK: - 三、有关视频缩略图获取的扩展
// 视频URL的类型
enum JKVideoUrlType {
    // 本地
    case local
    // 服务器
    case server
}
public extension JKPOP where Base: FileManager {
    
    // MARK: 3.1、通过本地(沙盒)视频文件路径获取截图
    /// 通过本地(沙盒)视频文件路径获取截图
    /// - Parameters:
    ///   - videoPath: 视频在沙盒的路径
    ///   - preferredTrackTransform: 缩略图的方向
    /// - Returns: 视频的缩略图
    static func getLocalVideoImage(videoPath: String, preferredTrackTransform: Bool = true) -> UIImage? {
        //  获取截图
        let videoImage = getVideoImage(videoUrlSouceType: .local, path: videoPath, seconds: 1, preferredTimescale: 10, maximumSize: nil, preferredTrackTransform: preferredTrackTransform)
        return videoImage
    }
    
    // MARK: 3.2、通过本地(沙盒)视频文件路径数组获取截图数组
    /// 通过本地(沙盒)视频文件路径数组获取截图数组
    /// - Parameters:
    ///   - videoPaths: 视频在沙盒的路径数组
    ///   - preferredTrackTransform: 缩略图的方向
    /// - Returns: 视频的缩略图数组
    static func getLocalVideoImages(videoPaths: [String], preferredTrackTransform: Bool = true) -> [UIImage?] {
        //  获取截图
        var allImageArray: [UIImage?] = []
        for path in videoPaths {
            let videoImage = getVideoImage(videoUrlSouceType: .local, path: path, seconds: 1, preferredTimescale: 10, maximumSize: nil, preferredTrackTransform: preferredTrackTransform)
            allImageArray.append(videoImage)
        }
        return allImageArray
    }
    
    // MARK: 3.3、通过网络视频文件路径获取截图
    /// 通过网络视频文件路径获取截图
    /// - Parameters:
    ///   - videoPath: 视频在沙盒的路径
    ///   - preferredTrackTransform: 缩略图的方向
    /// - Returns: 视频的缩略图
    static func getServerVideoImage(videoPath: String, videoImage: @escaping (UIImage?) -> Void, preferredTrackTransform: Bool = true) {
        //异步获取网络视频缩略图，由于网络请求比较耗时，所以我们把获取在线视频的相关代码写在异步线程里
        DispatchQueue.global().async {
            //  获取截图
            let image = getVideoImage(videoUrlSouceType: .server, path: videoPath, seconds: 1, preferredTimescale: 10, maximumSize: nil, preferredTrackTransform: preferredTrackTransform)
            DispatchQueue.main.async {
                videoImage(image)
            }
        }
    }
    
    // MARK: 3.4、通过网络视频文件路径数组获取截图数组
    /// 通过网络视频文件路径数组获取截图数组
    /// - Parameters:
    ///   - videoPaths: 视频在沙盒的路径数组
    ///   - preferredTrackTransform: 缩略图的方向
    /// - Returns: 视频的缩略图数组
    static func getServerVideoImages(videoPaths: [String], videoImages: @escaping ([UIImage?]) -> Void, preferredTrackTransform: Bool = true) {
        //异步获取网络视频缩略图，由于网络请求比较耗时，所以我们把获取在线视频的相关代码写在异步线程里
        DispatchQueue.global().async {
            //  获取截图
            var allImageArray: [UIImage?] = []
            for path in videoPaths {
                let videoImage = getVideoImage(videoUrlSouceType: .server, path: path, seconds: 1, preferredTimescale: 10, maximumSize: nil, preferredTrackTransform: preferredTrackTransform)
                allImageArray.append(videoImage)
            }
            DispatchQueue.main.async {
                videoImages(allImageArray)
            }
        }
    }
   
    // MARK: 获取视频缩略图的共有方法
    /// 获取视频缩略图的共有方法
    /// - Parameters:
    ///   - videoUrlSouceType: 视频来源类型
    ///   - path: 本地路径或者网络视频连接
    ///   - seconds: 取第几秒
    ///   - preferredTimescale: 一秒钟几帧
    ///   - maximumSize: 设置图片的最大size(分辨率)
    ///   - preferredTrackTransform: 设定缩略图的方向，如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的
    /// - Returns: 返回获取的图片
    private static func getVideoImage(videoUrlSouceType: JKVideoUrlType = .local, path: String, seconds: Double = 1, preferredTimescale: CMTimeScale = 10, maximumSize: CGSize?, preferredTrackTransform: Bool = true) -> UIImage? {
        var videoURL: URL?
        
        if videoUrlSouceType == .local {
            videoURL = URL(fileURLWithPath: path)
        } else {
            videoURL = URL(string: path)!
        }
        
        guard let weakVideoURL = videoURL else {
            return nil
        }
        let videoAsset = AVURLAsset(url: weakVideoURL)
    
        let imageGenerator = AVAssetImageGenerator(asset: videoAsset)
        // 设定缩略图的方向
        // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的
        imageGenerator.appliesPreferredTrackTransform = preferredTrackTransform
        // 设置图片的最大size(分辨率)
        if let size = maximumSize {
            imageGenerator.maximumSize = size
        }
        // 取第几秒，一秒钟几帧
        let cmTime = CMTime(seconds: seconds, preferredTimescale: preferredTimescale)
        if let cgImg = try? imageGenerator.copyCGImage(at: cmTime, actualTime: nil) {
            let img = UIImage(cgImage: cgImg)
            return img
        } else {
            JKPrint("获取缩略图失败")
            return nil
        }
    }
}

