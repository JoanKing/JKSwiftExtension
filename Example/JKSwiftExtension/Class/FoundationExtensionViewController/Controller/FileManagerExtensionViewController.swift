//
//  FileManagerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FileManagerExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、沙盒路径的获取", "二、文件以及文件夹的操作 扩展"]
        dataArray = [["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"], ["创建文件夹(蓝色的，文件夹和文件是不一样的)", "删除文件夹", "创建文件", "删除文件", "读取文件内容", "把文字，图片，数组，字典写入文件", "从文件 读取 文字，图片，数组，字典", "拷贝(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 拷贝", "移动(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 移动", "判断 (文件夹/文件) 是否存在", "获取 (文件夹/文件) 的前一个路径", "判断目录是否可读", "判断目录是否可写", "根据文件路径获取文件扩展类型", "根据文件路径获取文件名称，是否需要后缀", "对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表(只寻找一层)", "深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）", "深度遍历，会递归遍历子文件夹（但不会递归符号链接）", "计算单个 (文件夹/文件) 的大小，单位为字节 （没有进行转换的）", "计算 (文件夹/文件) 的大小（转换过的）", "获取(文件夹/文件)属性集合"]]
        
        print("根目录的路径：\(FileManager.homeDirectory())")
    }
}

// MARK:- 二、文件以及文件夹的操作 扩展
extension FileManagerExtensionViewController {
    
    // MARK: 2.21、获取(文件夹/文件)属性集合
    @objc func test221() {
        let path = FileManager.DocumnetsDirectory() + "/华彩业务与客服—吴晓娜.pptx"
        guard let attributes = FileManager.fileAttributes(path: path) else {
            return
        }
        JKPrint("获取(文件夹/文件)属性集合", "路径：\(path)", "属性：\(attributes)")
    }
    
    // MARK: 2.20、计算 (文件夹/文件) 的大小（转换过的）
    @objc func test220() {
        let path = FileManager.DocumnetsDirectory() + "/华彩业务与客服—吴晓娜.pptx"
        let size = FileManager.fileOrDirectorySize(path: path)
        let size2 = FileManager.fileOrDirectorySingleSize(filePath: path)
        JKPrint("计算 (文件夹/文件) 的大小（转换过的）", "路径：\(path)", "文件大小：\(size)", "计算单个 (文件夹/文件) 的大小：\(size2)")
    }
    
    // MARK: 2.19、计算单个 (文件夹/文件) 的大小，单位为字节 （没有进行转换的）
    @objc func test219() {
        let path = FileManager.LibraryDirectory() + "/1.jpeg"
        let size = FileManager.fileOrDirectorySingleSize(filePath: path)
        JKPrint("路径：\(path)", "文件大小：\(size)")
    }
    
    // MARK:2.18、深度遍历，会递归遍历子文件夹（但不会递归符号链接）
    @objc func test218() {
        let path = FileManager.LibraryDirectory()
    
        guard let fileNames = FileManager.deepSearchAllFiles(folderPath: path) else {
            return
        }
        JKPrint("路径：\(path)", "数组个数：\(fileNames.count)", "文件名称数组：\(fileNames)")
    }
    
    // MARK: 2.17、深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）
    @objc func test217() {
        let path = FileManager.LibraryDirectory()
    
        guard let fileNames = FileManager.getAllFileNames(folderPath: path) else {
            return
        }
        JKPrint("路径：\(path)", "数组个数：\(fileNames.count)", "文件名称数组：\(fileNames)")
    }
    
    // MARK: 2.16、对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表(只寻找一层)
    @objc func test216() {
        let path = FileManager.PreferencesDirectory()
    
        guard let fileNames = FileManager.shallowSearchAllFiles(folderPath: path) else {
            return
        }
        JKPrint("路径：\(path)", "数组个数：\(fileNames.count)", "文件名称数组：\(fileNames)")
    }
    
    // MARK: 2.15、根据文件路径获取文件名称，是否需要后缀
    @objc func test215() {
        let path = FileManager.DocumnetsDirectory() + "/我是一只小小鸟.text"
        let suffix1 = FileManager.fileName(path: path, suffix: true)
        let suffix2 = FileManager.fileName(path: path, suffix: false)
        JKPrint("路径：\(path)", "文件名称(需要后缀)：\(suffix1)", "文件名称(不需要后缀)：\(suffix2)")
    }
    
    // MARK: 2.14、根据文件路径获取文件扩展类型
    @objc func test214() {
        let path = FileManager.DocumnetsDirectory() + "/我是一只小小鸟.text"
        let suffix = FileManager.fileSuffixAtPath(path: path)
        JKPrint("路径：\(path)", "根据文件路径获取文件扩展类型：\(suffix)")
    }
    
    // MARK: 2.13、判断目录是否可写
    @objc func test213() {
        let path = FileManager.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let result = FileManager.judegeIsWritableFile(path: path)
        JKPrint("路径：\(path)", "是否可以写：\(result)")
    }
    
    // MARK: 2.12、判断目录是否可读
    @objc func test212() {
        let path = FileManager.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let result = FileManager.judegeIsReadableFile(path: path)
        JKPrint("路径：\(path)", "是否可以读：\(result)")
    }
    
    // MARK: 2.11、获取 (文件夹/文件) 的前一个路径
    @objc func test211() {
        let path = FileManager.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let newPath = FileManager.directoryAtPath(path: path)
        JKPrint("原来的路径：\(path)", "新的路径：\(newPath)")
    }
    
    // MARK: 2.10、判断 (文件夹/文件) 是否存在
    @objc func test210() {
        let path = FileManager.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let result = FileManager.judgeFileOrFolderExists(filePath: path)
        if result {
            print("(文件夹/文件) 存在")
        } else {
            print("(文件夹/文件) 不存在")
        }
    }
    
    // MARK: 2.9、移动(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 移动
    @objc func test29() {
        let result = FileManager.moveFile(type: .directory, fromeFilePath: FileManager.LibraryDirectory() + "/嘿嘿", toFilePath: FileManager.DocumnetsDirectory() + "/动物乐园")
        if result.isSuccess {
            print("移动文件成功")
        } else {
            print("移动文件失败")
        }
    }
    
    // MARK: 2.8、拷贝(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 拷贝
    @objc func test28() {
        // 1、沙盒中的(文件夹/文件)路径
        // let path1 = FileManager.DocumnetsDirectory() + "/动画乐园.text"
        // 2、相中(文件夹/文件)的路径
        guard let path2 = Bundle.main.path(forResource: "testFile", ofType: "text") else {
            return
        }
        let result = FileManager.copyFile(type: .file, fromeFilePath: path2, toFilePath: FileManager.PreferencesDirectory() + "/项目中的testFile.text", isOverwrite: true)
        if result.isSuccess {
            print("拷贝(文件夹/文件)成功")
        } else {
            print("复制文件失败")
        }
    }
    
    // MARK: 2.7、从文件 读取 文字，图片，数组，字典
    @objc func test27() {
        guard let contentArray = (FileManager.readFromFile(readType: .ArrayType, readPath:  FileManager.LibraryDirectory() + "/我是一个文件").content) as? Array<Any> else {
            print("文件没有内容")
            return
        }
        print("文件内容：\(contentArray)", "数组个数：\(contentArray.count)")
    }
    
    // MARK: 2.6、把文字，图片，数组，字典写入文件
    @objc func test26() {
        // FileManager.writeToFile(writeType: .TextType, content: "微凉的秋风里，飘着淡淡的桂花香，闭上眼，让那缕缕馨香盈满心间，一瞬间忘了浮世烟火，忘了尘世苍凉，也忘了你离去所带来的伤感。或许，所有的经历，都是岁月的恩赐;所有的遇见，都会留下难忘的痕迹。有些人注定只能陪伴你一程;有些情感注定只是昙花一现!唯有将那些被落花弄疼了的心事，以及那份相遇的温暖，妥帖的收藏于时光的杯盏里。有些缘分，我知道，只能用心铭记，让其伴随一生，直至终老。回首处，即使有遗憾，也是这一程山水必经的风景。你的世界我来过，这就够了!光阴里的故事，我用一颗虔诚的心去描绘。无论深浅，都是生命最美的馈赠。", writePath: FileManager.LibraryDirectory() + "/我是一个文件")
        
        FileManager.writeToFile(writeType: .TextType, content: ["1", "2"], writePath: FileManager.LibraryDirectory() + "/我是一个文件")
    }
    
    // MARK: 2.5、读取文件内容
    @objc func test25() {
        guard let content = FileManager.readfile(filePath: FileManager.LibraryDirectory() + "/我是一个文件") else {
            print("文件没有内容")
            return
        }
        print("文件内容：\(content)")
    }
    
    // MARK: 2.4、删除文件
    @objc func test24() {
        FileManager.removefile(filePath: FileManager.LibraryDirectory() + "/我是一个文件")
    }
    
    // MARK: 2.3、根据传件来的路径创建文件
    @objc func test23() {
        FileManager.createFile(filePath: FileManager.DocumnetsDirectory() + "/动画乐园.text")
    }
    
    // MARK: 2.2、删除文件夹
    @objc func test22() {
        FileManager.removefolder(folderPath: FileManager.LibraryDirectory() + "/哈哈")
    }
    
    // MARK: 2.1、创建文件夹(蓝色的，文件夹和文件是不一样的)
    @objc func test21() {
        let path = FileManager.LibraryDirectory() + "/哈哈/嘿嘿"
        FileManager.createFolder(folderPath: path)
        JKPrint("根据传件来的路径创建文件夹 创建文件目录(蓝色的，文件夹和文件是不一样的)", "获取文件夹的完整路径名:\(path)")
    }
}

// MARK:- 一、沙盒路径的获取
extension FileManagerExtensionViewController {
    
    // MARK: 1.1、获取Home的完整路径名
    @objc func test11() {
        JKPrint("获取 Home 的完整路径名:\(FileManager.homeDirectory())")
    }
    
    // MARK: 1.2、获取Documnets的完整路径名
    @objc func test12() {
        JKPrint("获取 Documnets 的完整路径名:\(FileManager.DocumnetsDirectory())")
    }
    
    // MARK: 1.3、"获取Library的完整路径名"
    @objc func test13() {
        JKPrint("获取 Library 的完整路径名:\(FileManager.LibraryDirectory())")
    }
    
    // MARK: 1.4、获取/Library/Cache的完整路径名
    @objc func test14() {
        JKPrint("获取 /Library/Cache 的完整路径名:\(FileManager.CachesDirectory())")
    }
    
    // MARK: 1.5、获取/Library/Preferences的完整路径名
    @objc func test15() {
        JKPrint("获取 /Library/Preferences 的完整路径名:\(FileManager.PreferencesDirectory())")
    }
    
    // MARK: 1.6、"获取Tmp的完整路径名"
    @objc func test16() {
        JKPrint("获取 Tmp 的完整路径名:\(FileManager.TmpDirectory())")
    }
}
