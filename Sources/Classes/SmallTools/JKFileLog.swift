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

// MARK: - 日志的类型
public enum JKFileLogType: Int {
    // 文件夹路径
    var folderPath: String {
        return FileManager.jk.DocumnetsDirectory() + "/JKSwiftExtension.default.logfile"
    }
    
    /// 基本日志
    case appBase
    /// 日志的路径
    var defaultFileName: String {
        switch self {
        case .appBase:
            return "appLog.txt"
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
        queue.async {
            // 1、先判默认文件夹是否存在
            let createFolderResult = FileManager.jk.createFolder(folderPath: type.folderPath)
            guard createFolderResult.isSuccess else { return }
            // 2、在判断下是否自定义了文件名
            let fileName: String = type.defaultFileName
            guard let filePath = URL(string: type.folderPath + "/\(fileName)") else { return }
            let createFileResult = FileManager.jk.createFile(filePath: filePath.absoluteString)
            guard createFileResult.isSuccess else { return }
            // 3.文件内容的写入
            do {
                let currentDate = Date()
                let dateString = currentDate.jk.toformatterTimeString(formatter: "yyyy-MM-dd HH:mm:ss:SSS")
                let fileHandle = try FileHandle(forWritingTo: filePath)
                // 函数信息
                let functionMessage = "file：\(file) line：\(line) column：\(column) function：\(fn)"
                // 写入的内容
                var stringToWrite = ""
                // 追加还是插入开头
                if isSeekToEndOfFile {
                    stringToWrite = "\n" + dateString + "\n" + "\(functionMessage)" + "\n" + "☕️ log：\(content)"
                    // 文件可以追加，找到末尾位置并添加
                    fileHandle.seekToEndOfFile()
                } else {
                    // 插入在开头的话，就需要先读取出来再组合一起写入
                    let oldContent = getFilePathContent(type: type)
                    stringToWrite = dateString + "\n" + "\(functionMessage)" + "\n" + "log：\(content)" + "\n" + oldContent
                    fileHandle.seek(toFileOffset: 0)
                }
                if let contentData = stringToWrite.data(using: .utf8) {
                    // 写入要写入的内容
                    fileHandle.write(contentData)
                }
                // 关闭文件句柄
                fileHandle.closeFile()
            } catch let error as NSError {
                debugPrint("failed to append: \(error)")
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
    ///   - logFileName: 文件的名字
    ///   - file: 文件路径
    ///   - line: 打印内容所在的 行
    ///   - column: 打印内容所在的 列
    ///   - fn: 打印内容的函数名
    public static func writeSimpleLog(_ content: String,
                                isSeekToEndOfFile: Bool = true,
                                      type: JKFileLogType = .appBase) {
        #if DEBUG
        queue.async {
            // 1、先判默认文件夹是否存在
            let createFolderResult = FileManager.jk.createFolder(folderPath: type.folderPath)
            guard createFolderResult.isSuccess else { return }
            // 2、在判断下是否自定义了文件名
            let fileName: String = type.defaultFileName
            guard let filePath = URL(string: type.folderPath + "/\(fileName)") else { return }
            let createFileResult = FileManager.jk.createFile(filePath: filePath.absoluteString)
            guard createFileResult.isSuccess else { return }
            // 3.文件内容的写入
            do {
                let currentDate = Date()
                let dateString = currentDate.jk.toformatterTimeString(formatter: "yyyy-MM-dd HH:mm:ss:SSS")
                let fileHandle = try FileHandle(forWritingTo: filePath)
                // 写入的内容
                var stringToWrite = ""
                // 追加还是插入开头
                if isSeekToEndOfFile {
                    stringToWrite = "\n" + dateString + " ：\(content)"
                    // 文件可以追加，找到末尾位置并添加
                    fileHandle.seekToEndOfFile()
                } else {
                    // 插入在开头的话，就需要先读取出来再组合一起写入
                    let oldContent = getFilePathContent(type: type)
                    stringToWrite = dateString + " ：\(content)" + "\n" + oldContent
                    fileHandle.seek(toFileOffset: 0)
                }
                if let contentData = stringToWrite.data(using: .utf8) {
                    // 写入要写入的内容
                    fileHandle.write(contentData)
                }
                // 关闭文件句柄
                fileHandle.closeFile()
            } catch let error as NSError {
                debugPrint("failed to append: \(error)")
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
        guard let fileURL = URL(string: path) else { return "" }
        guard FileManager.jk.judgeFileOrFolderExists(filePath: fileURL.absoluteString) else { return "" }
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
        // 2、判断文件的路径是否存在
        guard let fileURL = URL(string: path) else { return true }
        guard FileManager.jk.judgeFileOrFolderExists(filePath: fileURL.absoluteString) else { return true }
        // 3、存在的就进行移除
        let result = FileManager.jk.removefile(filePath: fileURL.absoluteString)
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
