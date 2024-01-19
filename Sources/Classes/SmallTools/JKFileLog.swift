//
//  JKFileLog.swift
//  JKSwiftExtension
//
//  Created by 小冲冲 on 2023/11/19.
//
//MARK: - 文件日志
/**
 此类的目的是：把一些日志写入文件，便于排查一些内容
 支持：写入自定义路径下，默认写入到 JKSwiftExtension.default.logfile
 */
import Foundation
import UIKit

public protocol JKFileContentType {
    associatedtype ValueType
}

extension Dictionary: JKFileContentType {
    public typealias ValueType = [Key: Value]

}

extension String: JKFileContentType {
    public typealias ValueType = String
}

public class JKFileLog: NSObject {
    /// 单粒对象
    public static let sharedInstance = JKFileLog()
    private override init() {}
    /// 文件夹路径
    private var folderPath: String = FileManager.jk.DocumnetsDirectory() + "/JKSwiftExtension.default.logfile"
    /// 默认文件名
    private var defaultFileName: String = "log.txt"
    /// 异步串行写入日志
    private static let queue: DispatchQueue = {
        return DispatchQueue(label: "com.JKSwiftExtension.log")
    }()
}

//MARK: - 一、日志的操作
extension JKFileLog {
    
    //MARK: 1.01、写入文件
    /// 写入文件
    /// - Parameters:
    ///   - content: 内容，遵守JKFileContentType协议的类型可以写入
    ///   - isSeekToEndOfFile: 是否内容追加到尾部，默认尾部追加
    ///   - logFileName: 文件的名字
    ///   - file: 文件路径
    ///   - line: 打印内容所在的 行
    ///   - column: 打印内容所在的 列
    ///   - fn: 打印内容的函数名
    public static func writeLog<T: JKFileContentType>(_ content: T,
                                isSeekToEndOfFile: Bool = true,
                                logFileName: String = "",
                                file: NSString = #file,
                                line: Int = #line,
                                column: Int = #column,
                                fn: String = #function) {
        switch content {
        case let weakContent as String:
            writeLogMessage(weakContent, isSeekToEndOfFile: isSeekToEndOfFile, logFileName: logFileName, file: file, line: line, column: column, fn: fn)
        case let dictionaryData as [String: Any]:
            if let dictionaryJson = dictionaryData.jk.dictionaryToJson() {
                writeLogMessage(dictionaryJson, isSeekToEndOfFile: isSeekToEndOfFile, logFileName: logFileName, file: file, line: line, column: column, fn: fn)
            }
        default:
            debugPrint("unknown type")
        }
    }
    
    //MARK: 1.02、读取日志内容
    /// 获取日志内容
    /// - Parameter logFileName: 日志文件名字
    /// - Returns: 日志内容
    public static func getFilePathContent(logFileName: String = "") -> String {
        // 1、获取文件路径
        let path = getLogFilePath(logFileName: logFileName)
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
    
    //MARK: 1.03、获取日志文件路径
    /// 获取日志文件路径
    /// - Parameter logFileName: 日志名字
    /// - Returns: 日志文件路径
    public static func getLogFilePath(logFileName: String = "") -> String {
        let fileName = getLogFileName(logFileName)
        return sharedInstance.folderPath + "/\(fileName)"
    }
    
    //MARK: 1.04、移除日志文件
    /// 获取日志文件路径
    /// - Parameter logFileName: 日志名字
    /// - Returns: 日志文件路径
    @discardableResult
    public static func removeLogFile(logFileName: String = "") -> Bool {
        // 1、获取文件路径
        let path = getLogFilePath(logFileName: logFileName)
        // 2、判断文件的路径是否存在
        guard let fileURL = URL(string: path) else { return true }
        guard FileManager.jk.judgeFileOrFolderExists(filePath: fileURL.absoluteString) else { return true }
        // 3、存在的就进行移除
        let result = FileManager.jk.removefile(filePath: fileURL.absoluteString)
        return result.isSuccess
    }
    
    //MARK: 1.05、导出日志
    /// 导出日志
    /// - Parameters:
    ///   - logFileName: 日志名字
    ///   - currntVC: 当前的vc
    /// - Returns: 是否导出成功
    @discardableResult
    public static func exportLog(logFileName: String = "", currntVC: UIViewController? = nil) -> Bool {
        // 1、获取文件路径
        let path = getLogFilePath(logFileName: logFileName)
        // 2、判断路径是否存在
        guard FileManager.jk.judgeFileOrFolderExists(filePath: path) else { return false }
        // 3、导出日志
        let fileURL = URL(fileURLWithPath: path)
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        if let vc = currntVC {
            vc.present(activityViewController, animated: true, completion: nil)
        } else {
            UIViewController.jk.topViewController()?.present(activityViewController, animated: true, completion: nil)
        }
        return true
    }
}

//MARK: - private
extension JKFileLog {
    //MARK: 获取日志文件名字
    /// 获取日志文件名字
    /// - Parameter logFileName: 日志名字
    /// - Returns: 获取代txt日志的名字
    private static func getLogFileName(_ logFileName: String = "") -> String {
        // 1、看下是否自定义了文件名
        guard logFileName.count > 0 else {
            return sharedInstance.defaultFileName
        }
        // 2、自定义了就返回自定义的文件名，补充后缀.txt
        return logFileName.jk.isHasSuffix(suffix: ".txt") ? logFileName : (logFileName + ".txt")
    }
    
    //MARK: 写入文件信息
    /// 写入文件信息
    /// - Parameters:
    ///   - content: 内容
    ///   - isSeekToEndOfFile: 是否内容追加到尾部，默认尾部追加
    ///   - logFileName: 文件的名字
    ///   - file: 文件路径
    ///   - line: 打印内容所在的 行
    ///   - column: 打印内容所在的 列
    ///   - fn: 打印内容的函数名
    private static func writeLogMessage(_ content: String,
                                isSeekToEndOfFile: Bool = true,
                                logFileName: String = "",
                                file: NSString = #file,
                                line: Int = #line,
                                column: Int = #column,
                                fn: String = #function) {
        queue.async {
            // 1、先判默认文件夹是否存在
            let createFolderResult = FileManager.jk.createFolder(folderPath: sharedInstance.folderPath)
            guard createFolderResult.isSuccess else { return }
            // 2、在判断下是否自定义了文件名
            let fileName: String = getLogFileName(logFileName)
            guard let filePath = URL(string: sharedInstance.folderPath + "/\(fileName)") else { return }
            let createFileResult = FileManager.jk.createFile(filePath: filePath.absoluteString)
            guard createFileResult.isSuccess else { return }
            // 3.文件内容的写入
            do {
                // 当前的日期
                let currentDate = Date.jk.currentDate
                let dateString = currentDate.jk.toformatterTimeString()
                // 句柄对象
                let fileHandle = try FileHandle(forWritingTo: filePath)
                // 函数信息
                let functionMessage = "file：\(file) line：\(line) column：\(column) function：\(fn)"
                // 写入的内容
                var stringToWrite = ""
                // 追加还是插入开头
                if isSeekToEndOfFile {
                    stringToWrite = "\n" + "🚀 " + dateString + "\n" + "\(functionMessage)" + "\n" + "☕️ log：\(content)"
                    // 文件可以追加，找到末尾位置并添加
                    fileHandle.seekToEndOfFile()
                } else {
                    // 插入在开头的话，就需要先读取出来再组合一起写入
                    let oldContent = getFilePathContent()
                    stringToWrite = "🚀 " + dateString + "\n" + "\(functionMessage)" + "\n" + "☕️ log：\(content)" + "\n" + oldContent
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
    }
}
