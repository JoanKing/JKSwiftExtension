//
//  NiuLogFile.swift
//  manager
//
//  Created by 小冲冲 on 2023/11/21.
//  Copyright © 2023 niu. All rights reserved.
//
//MARK: - 文件日志
/**
 此类的目的是：把一些日志写入文件，便于排查一些内容
 支持：写入自定义路径下，默认写入到 niu.default.fileLoger
 */
import Foundation
import UIKit

// MARK: - 时间戳
/// 获取当前时间戳字符串，格式：`yyyy-MM-dd HH:mm:ss.SSS`
/// 使用 gettimeofday + strftime，比 DateFormatter 快一个数量级
func timestamp() -> String {
    var tv = timeval()
    gettimeofday(&tv, nil)

    var tmValue = tm()
    var seconds = tv.tv_sec
    localtime_r(&seconds, &tmValue)

    var buffer = [CChar](repeating: 0, count: 32)
    strftime(&buffer, buffer.count, "%Y-%m-%d %H:%M:%S", &tmValue)

    let millisecond = Int(tv.tv_usec) / 1000
    let millisecondStr = millisecond < 10 ? "00\(millisecond)" : (millisecond < 100 ? "0\(millisecond)" : "\(millisecond)")
    return String(cString: buffer) + "." + millisecondStr
}

// MARK: - 日志的类型
public enum JKFileLogType {
    /// 基本日志
    case appBase
    /// 自定义日志：可以自定义文件夹路径和文件名字
    /// - Parameters:
    ///   - folderPath: 日志所在的文件夹路径
    ///   - fileName: 日志文件名字
    case custom(folderPath: String, fileName: String)

    /// 文件夹路径
    var folderPath: String {
        switch self {
        case .appBase:
            return FileManager.jk.DocumnetsDirectory() + "/JKSwiftExtension.default.logfile"
        case let .custom(folderPath, _):
            return folderPath
        }
    }

    /// 日志文件名字
    var defaultFileName: String {
        switch self {
        case .appBase:
            return "appLog.txt"
        case let .custom(_, fileName):
            return fileName
        }
    }
}

// MARK: - 日志
public class JKFileLog: NSObject {
    /// 单粒对象
    public static let shared = JKFileLog()
    private override init() {}
    /// 文件夹路径
//    private var folderPath: String = FileManager.niu.DocumnetsDirectory() + "/niu.default.fileLoger"
//    /// 默认文件路径
//    private var defaultFileName: String = "log.txt"
    /// 异步串行写入日志
    private static let queue: DispatchQueue = {
        return DispatchQueue(label: "com.JKSwiftExtension.log")
    }()
    /// 已完成目录/文件创建准备的路径集合，避免每次写入都做磁盘探测（仅在 queue 上访问）
    private static var preparedLogPaths = Set<String>()
}

//MARK: - 一、详细日志的操作
extension JKFileLog {
    
    //MARK: 1.01、写入文件
    /// 写入文件
    /// - Parameters:
    ///   - content: 内容
    ///   - isSeekToEndOfFile: 是否内容追加到尾部，默认尾部追加
    ///   - logFileName: 文件的名字
    ///   - file: 文件路径
    ///   - line: 打印内容所在的 行
    ///   - column: 打印内容所在的 列
    ///   - fn: 打印内容的函数名
    public static func writeLog(_ content: String,
                                isSeekToEndOfFile: Bool = true,
                                type: JKFileLogType = .appBase,
                                file: NSString = #file,
                                line: Int = #line,
                              column: Int = #column,
                                  fn: String = #function) {
        #if DEBUG
        // 时间取调用时刻，避免排队导致时间偏差
        let dateString = timestamp()
        let functionMessage = "file：\(file) line：\(line) column：\(column) function：\(fn)"
        // 控制台打印完整信息（含文件位置），方便定位问题
        print("\(dateString)\n\(functionMessage)\n\(content)")
        queue.async {
            // 1、确保目录和文件已创建（同一路径只处理一次）
            guard prepareLogFile(type: type) else { return }
            // 2、写入文件时只保留时间和内容，不写文件位置信息
            if isSeekToEndOfFile {
                // 追加到尾部：时间 + tab + 内容
                let stringToWrite = "\n" + dateString + "\t" + content
                write(stringToWrite, type: type, toStart: false)
            } else {
                // 插入到开头：先读取旧内容再拼接
                let oldContent = getFilePathContent(type: type)
                let stringToWrite = dateString + "\t" + content + "\n" + oldContent
                write(stringToWrite, type: type, toStart: true)
            }
        }
        #endif
    }
    
    //MARK: 1.02、写入Dictionary数据
    /// 写入Dictionary数据
    /// - Parameters:
    ///   - data: 数据
    ///   - prefix: 前缀
    ///   - isSeekToEndOfFile: 是否内容追加到尾部，默认尾部追加
    ///   - logFileName: 文件的名字
    ///   - file: 文件路径
    ///   - line: 打印内容所在的 行
    ///   - column: 打印内容所在的 列
    ///   - fn: 打印内容的函数名
    public static func writeDictionaryLog(_ data: [String: Any],
                                          prefix: String = "data",
                                          isSeekToEndOfFile: Bool = true,
                                          type: JKFileLogType = .appBase,
                                          file: NSString = #file,
                                          line: Int = #line,
                                          column: Int = #column,
                                          fn: String = #function) {
        #if DEBUG
        if let json = data.toJSON() {
            writeLog("\(prefix)：\(json)",
                     isSeekToEndOfFile: isSeekToEndOfFile,
                     type: type,
                     file: file,
                     line: line,
                     column: column,
                     fn: fn)
        }
        #endif
    }
}

//MARK: - 二、简单日志的操作
extension JKFileLog {
    
    //MARK: 2.01、写入文件
    /// 写入文件
    /// - Parameters:
    ///   - content: 内容
    ///   - isSeekToEndOfFile: 是否内容追加到尾部，默认尾部追加
    ///   - type: 日志类型，可指定写入的文件夹和文件名字，默认 .appBase
    ///   - time: 时间字符串，默认使用 `timestamp()` 生成，也可由调用方传入以复用时间
    public static func writeSimpleLog(_ content: String,
                                isSeekToEndOfFile: Bool = true,
                                      type: JKFileLogType = .appBase,
                                      time: String? = nil) {
        #if DEBUG
        let dateString = time ?? timestamp()
        queue.async {
            // 1、确保目录和文件已创建（同一路径只处理一次）
            guard prepareLogFile(type: type) else { return }
            // 2、文件内容的写入
            if isSeekToEndOfFile {
                write("\n" + dateString + " ：\(content)", type: type, toStart: false)
            } else {
                // 插入到开头：先读取旧内容再拼接
                let oldContent = getFilePathContent(type: type)
                write(dateString + " ：\(content)" + "\n" + oldContent, type: type, toStart: true)
            }
        }
        #endif
    }
    
    //MARK: 2.02、写入Dictionary数据
    /// 写入Dictionary数据
    /// - Parameters:
    ///   - data: 数据
    ///   - prefix: 前缀
    ///   - isSeekToEndOfFile: 是否内容追加到尾部，默认尾部追加
    ///   - logFileName: 文件的名字
    ///   - file: 文件路径
    ///   - line: 打印内容所在的 行
    ///   - column: 打印内容所在的 列
    ///   - fn: 打印内容的函数名
    public static func writeSimpleDictionaryLog(_ data: [String: Any],
                                          prefix: String = "data",
                                          isSeekToEndOfFile: Bool = true,
                                          type: JKFileLogType = .appBase) {
        #if DEBUG
        if let json = data.toJSON() {
            writeSimpleLog("\(prefix)：\(json)",
                     isSeekToEndOfFile: isSeekToEndOfFile,
                     type: type)
        }
        #endif
    }
}

//MARK: - 三、基本的方法
extension JKFileLog {
    //MARK: 3.01、读取日志内容
    /// 获取日志内容
    /// - Parameter logFileName: 日志文件名字
    /// - Returns: 日志内容
    public static func getFilePathContent(type: JKFileLogType = .appBase) -> String {
        // 1、获取文件路径
        let path = getLogFilePath(type)
        let fileURL = URL(fileURLWithPath: path)
        guard FileManager.jk.judgeFileOrFolderExists(filePath: fileURL.path) else { return "" }
        do {
            let fileHandle = try FileHandle(forReadingFrom: fileURL)
            let fileData = fileHandle.readDataToEndOfFile()
            let fileContents = String(data: fileData, encoding: .utf8)
            fileHandle.closeFile()
            return fileContents ?? ""
        } catch {
            debugPrint("Error reading file: \(error.localizedDescription)")
            return ""
        }
    }
    
    //MARK: 3.02、获取日志文件路径
    /// 获取日志文件路径
    /// - Parameter logFileName: 日志名字
    /// - Returns: 日志文件路径
    public static func getLogFilePath(_ type: JKFileLogType = .appBase) -> String {
        return type.folderPath + "/\(type.defaultFileName)"
    }
    
    //MARK: 3.03、移除日志文件
    /// 获取日志文件路径
    /// - Parameter logFileName: 日志名字
    /// - Returns: 日志文件路径
    @discardableResult
    public static func removeLogFile(type: JKFileLogType = .appBase) -> Bool {
        // 1、获取文件路径
        let path = getLogFilePath(type)
        // 2、移除缓存标记，保证下次写入会重新创建文件
        queue.async { preparedLogPaths.remove(path) }
        // 3、判断文件的路径是否存在
        let fileURL = URL(fileURLWithPath: path)
        guard FileManager.jk.judgeFileOrFolderExists(filePath: fileURL.path) else { return true }
        // 4、存在的就进行移除
        let result = FileManager.jk.removefile(filePath: fileURL.path)
        return result.isSuccess
    }
    
    //MARK: 3.04、导出日志
    /// 导出日志
    /// - Parameters:
    ///   - logFileName: 日志名字
    ///   - currntVC: 当前的vc
    /// - Returns: 是否导出成功
    @discardableResult
    public static func exportLog(type: JKFileLogType = .appBase, currentVC: UIViewController? = nil) -> Bool {
        // 1、获取路径
        let path = getLogFilePath(type)
        // 2、判断路径是否存在
        guard FileManager.jk.judgeFileOrFolderExists(filePath: path) else { return false }
        // 3、导出日志
        let fileURL = URL(fileURLWithPath: path)
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        if let vc = currentVC {
            vc.present(activityViewController, animated: true, completion: nil)
        } else {
            UIViewController.jk.topViewController()?.present(activityViewController, animated: true, completion: nil)
        }
        return true
    }
}

//MARK: - 四、内部工具方法
extension JKFileLog {

    /// 确保日志文件及其所在目录存在
    /// 同一路径只处理一次，避免每次写入都做磁盘探测
    /// - Parameter type: 日志类型
    /// - Returns: 是否准备成功
    static func prepareLogFile(type: JKFileLogType) -> Bool {
        let filePath = getLogFilePath(type)
        if preparedLogPaths.contains(filePath) { return true }
        // 1、目录不存在则创建
        guard FileManager.jk.createFolder(folderPath: type.folderPath).isSuccess else { return false }
        // 2、文件不存在则创建
        guard FileManager.jk.createFile(filePath: filePath).isSuccess else { return false }
        // 3、给日志文件打上“请勿备份到 iCloud”的标签
        var url = URL(fileURLWithPath: filePath)
        var resourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = true
        try? url.setResourceValues(resourceValues)
        // 4、记录已准备，后续写入直接复用
        preparedLogPaths.insert(filePath)
        return true
    }

    /// 把字符串写入日志文件
    /// - Parameters:
    ///   - string: 要写入的内容
    ///   - type: 日志类型
    ///   - toStart: true 写到文件开头，false 追加到文件末尾
    static func write(_ string: String, type: JKFileLogType, toStart: Bool) {
        guard let data = string.data(using: .utf8) else { return }
        let fileURL = URL(fileURLWithPath: getLogFilePath(type))
        do {
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            // 适配新旧版本 API 并安全写入
            if #available(iOS 13.4, macOS 10.15.4, *) {
                if toStart {
                    try fileHandle.seek(toOffset: 0)
                } else {
                    try fileHandle.seekToEnd()
                }
                try fileHandle.write(contentsOf: data)
                try fileHandle.close()
            } else {
                if toStart {
                    fileHandle.seek(toFileOffset: 0)
                } else {
                    fileHandle.seekToEndOfFile()
                }
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        } catch let error as NSError {
            debugPrint("failed to append: \(error)")
        }
    }
}
