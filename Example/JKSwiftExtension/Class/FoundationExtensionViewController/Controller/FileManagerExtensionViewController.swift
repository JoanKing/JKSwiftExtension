//
//  FileManagerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

@objc class FileManagerExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、沙盒路径的获取", "二、文件以及文件夹的操作 扩展", "三、有关视频缩略图获取的扩展"]
        dataArray = [["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"], ["创建文件夹(蓝色的，文件夹和文件是不一样的)", "删除文件夹", "创建文件", "删除文件", "读取文件内容", "把文字，图片，数组，字典写入文件", "从文件 读取 文字，图片，数组，字典", "拷贝(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 拷贝", "移动(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 移动", "判断 (文件夹/文件) 是否存在", "获取 (文件夹/文件) 的前一个路径", "判断目录是否可读", "判断目录是否可写", "判断目录是否可执行", "判断目录是否可删除", "根据文件路径获取文件扩展类型", "根据文件路径获取文件名称，是否需要后缀", "对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表(只寻找一层)", "深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）", "深度遍历，会递归遍历子文件夹（但不会递归符号链接）", "计算单个 (文件夹/文件) 的大小，单位为字节 （没有进行转换的）", "计算 (文件夹/文件) 的大小（转换过的）", "获取(文件夹/文件)属性集合", "文件/文件夹比较 是否一样"], ["通过本地(沙盒)视频文件路径获取截图", "通过本地(沙盒)视频文件路径数组获取截图数组", "通过网络视频文件路径获取截图", "通过网络视频文件路径数组获取截图数组"]]
        
        debugPrint("根目录的路径：\(FileManager.jk.homeDirectory())")
    }
}

// MARK: - 三、有关视频缩略图获取的扩展
extension FileManagerExtensionViewController {
    
    // MARK: 3.04、通过网络视频文件路径数组获取截图数组
    @objc func test304() {
        // 添加录视频的缩略图
        let videoPath1 = "http://play.ciotimes.com/DJT55.mp4"
        let videoPath2 = "http://play.ciotimes.com/DJT58.mp4"
        
        FileManager.jk.getServerVideoImages(videoPaths: [videoPath1, videoPath2]) {[weak self] (images) in
            guard let weakSelf = self else { return }
            if images.count == 2, let image1 = images[0] , let image2 = images[1] {
                var imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                imageView1.image = image1
                imageView1.contentMode = .scaleAspectFit
                imageView1.jk.centerX = weakSelf.view.jk.centerX
                weakSelf.view.addSubview(imageView1)
                
                let imageView2 = UIImageView(frame: CGRect(x: imageView1.jk.x, y: imageView1.jk.bottom + 20, width: 200, height: 200))
                imageView2.image = image2
                imageView2.contentMode = .scaleAspectFit
                weakSelf.view.addSubview(imageView2)
                
                JKAsyncs.asyncDelay(3) {
                } _: {
                    imageView1.removeFromSuperview()
                    imageView2.removeFromSuperview()
                }
            }
            
        }
    }
    
    // MARK: 3.03、通过网络视频文件路径获取截图
    @objc func test303() {
        
        // "获取网路视频缩略图中，请稍等"
        
        // 添加录视频的缩略图
        let videoPath = "http://play.ciotimes.com/DJT55.mp4"
        FileManager.jk.getServerVideoImage(videoPath: videoPath) {[weak self] (image) in
            guard let weakSelf = self, let videoImage = image else { return }
            var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            imageView.image = videoImage
            imageView.contentMode = .scaleAspectFit
            imageView.jk.centerX = weakSelf.view.jk.centerX
            weakSelf.view.addSubview(imageView)
            JKAsyncs.asyncDelay(3) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
       
    }
    
    // MARK: 3.02、通过本地(沙盒)视频文件路径数组获取截图数组
    @objc func test302() {
        // 添加录视频的缩略图
        let videoPath = FileManager.jk.DocumnetsDirectory() + "/video.mp4"
        let playImages = FileManager.jk.getLocalVideoImages(videoPaths: [videoPath])
    
        if !playImages.isEmpty, let image = playImages[0] {
            JKPrint("\(image)")
        }
    }
    
    // MARK: 3.01、通过本地(沙盒)视频文件路径获取截图
    @objc func test301() {
        // 添加录视频的缩略图
        let videoPath = FileManager.jk.DocumnetsDirectory() + "/video.mp4"
        if let image = FileManager.jk.getLocalVideoImage(videoPath: videoPath) {
            print("\(image)")
        }
    }
}

// MARK: - 二、文件以及文件夹的操作 扩展
extension FileManagerExtensionViewController {
    
    // MARK: 2.24、文件/文件夹比较 是否一样
    @objc func test224() {
        let path1 = FileManager.jk.DocumnetsDirectory() + "/华彩业务与客服—吴晓娜.pptx"
        let path2 = FileManager.jk.DocumnetsDirectory() + "/华彩业务与客服—吴晓娜.pptx"
        JKPrint("文件/文件夹比较 是否一样：\(FileManager.jk.isEqual(filePath1: path1, filePath2: path2))")
    }
    
    // MARK: 2.23、获取(文件夹/文件)属性集合
    @objc func test223() {
        let path = FileManager.jk.DocumnetsDirectory() + "/华彩业务与客服—吴晓娜.pptx"
        guard let attributes = FileManager.jk.fileAttributes(path: path) else {
            return
        }
        JKPrint("获取(文件夹/文件)属性集合", "路径：\(path)", "属性：\(attributes)")
    }
    
    // MARK: 2.22、计算 (文件夹/文件) 的大小（转换过的）
    @objc func test222() {
        let path = FileManager.jk.DocumnetsDirectory() + "/华彩业务与客服—吴晓娜.pptx"
        let size = FileManager.jk.fileOrDirectorySize(path: path)
        let size2 = FileManager.jk.fileOrDirectorySingleSize(filePath: path)
        JKPrint("计算 (文件夹/文件) 的大小（转换过的）", "路径：\(path)", "文件大小：\(size)", "计算单个 (文件夹/文件) 的大小：\(size2)")
    }
    
    // MARK: 2.21、计算单个 (文件夹/文件) 的大小，单位为字节 （没有进行转换的）
    @objc func test221() {
        let path = FileManager.jk.LibraryDirectory() + "/1.jpeg"
        let size = FileManager.jk.fileOrDirectorySingleSize(filePath: path)
        JKPrint("路径：\(path)", "文件大小：\(size)")
    }
    
    // MARK: 2.20、深度遍历，会递归遍历子文件夹（但不会递归符号链接）
    @objc func test220() {
        let path = FileManager.jk.LibraryDirectory()
    
        guard let fileNames = FileManager.jk.deepSearchAllFiles(folderPath: path) else {
            return
        }
        JKPrint("路径：\(path)", "数组个数：\(fileNames.count)", "文件名称数组：\(fileNames)")
    }
    
    // MARK: 2.19、深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）
    @objc func test219() {
        let path = FileManager.jk.LibraryDirectory()
    
        guard let fileNames = FileManager.jk.getAllFileNames(folderPath: path) else {
            return
        }
        JKPrint("路径：\(path)", "数组个数：\(fileNames.count)", "文件名称数组：\(fileNames)")
    }
    
    // MARK: 2.18、对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表(只寻找一层)
    @objc func test218() {
        let path = FileManager.jk.PreferencesDirectory()
    
        guard let fileNames = FileManager.jk.shallowSearchAllFiles(folderPath: path) else {
            return
        }
        JKPrint("路径：\(path)", "数组个数：\(fileNames.count)", "文件名称数组：\(fileNames)")
    }
    
    // MARK: 2.17、根据文件路径获取文件名称，是否需要后缀
    @objc func test217() {
        let path = FileManager.jk.DocumnetsDirectory() + "/我是一只小小鸟.text"
        let suffix1 = FileManager.jk.fileName(path: path, suffix: true)
        let suffix2 = FileManager.jk.fileName(path: path, suffix: false)
        JKPrint("路径：\(path)", "文件名称(需要后缀)：\(suffix1)", "文件名称(不需要后缀)：\(suffix2)")
    }
    
    // MARK: 2.16、根据文件路径获取文件扩展类型
    @objc func test216() {
        let path = FileManager.jk.DocumnetsDirectory() + "/我是一只小小鸟.text"
        let suffix = FileManager.jk.fileSuffixAtPath(path: path)
        JKPrint("路径：\(path)", "根据文件路径获取文件扩展类型：\(suffix)")
    }
    
    // MARK: 2.15、判断目录是否可删除
    @objc func test215() {
        let path = FileManager.jk.DocumnetsDirectory() + "/哈哈"
        let result = FileManager.jk.judegeIsDeletableFile(path: path)
        JKPrint("路径：\(path)", "是否可删除：\(result)")
    }
    
    // MARK: 2.14、判断目录是否可执行
    @objc func test214() {
        let path = FileManager.jk.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let result = FileManager.jk.judegeIsExecutableFile(path: path)
        JKPrint("路径：\(path)", "是否可执行：\(result)")
    }
    
    // MARK: 2.13、判断目录是否可写
    @objc func test213() {
        let path = FileManager.jk.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let result = FileManager.jk.judegeIsWritableFile(path: path)
        JKPrint("路径：\(path)", "是否可以写：\(result)")
    }
    
    // MARK: 2.12、判断目录是否可读
    @objc func test212() {
        let path = FileManager.jk.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let result = FileManager.jk.judegeIsReadableFile(path: path)
        JKPrint("路径：\(path)", "是否可以读：\(result)")
    }
    
    // MARK: 2.11、获取 (文件夹/文件) 的前一个路径
    @objc func test211() {
        let path = FileManager.jk.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let newPath = FileManager.jk.directoryAtPath(path: path)
        JKPrint("原来的路径：\(path)", "新的路径：\(newPath)")
    }
    
    // MARK: 2.10、判断 (文件夹/文件) 是否存在
    @objc func test210() {
        let path = FileManager.jk.DocumnetsDirectory() + "/嘿嘿/呵呵"
        let result = FileManager.jk.judgeFileOrFolderExists(filePath: path)
        if result {
            debugPrint("(文件夹/文件) 存在")
        } else {
            debugPrint("(文件夹/文件) 不存在")
        }
    }
    
    // MARK: 2.09、移动(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 移动
    @objc func test209() {
        let result = FileManager.jk.moveFile(type: .directory, fromeFilePath: FileManager.jk.LibraryDirectory() + "/嘿嘿", toFilePath: FileManager.jk.DocumnetsDirectory() + "/动物乐园")
        if result.isSuccess {
            debugPrint("移动文件成功")
        } else {
            debugPrint("移动文件失败")
        }
    }
    
    // MARK: 2.08、拷贝(文件夹/文件)的内容 到另外一个(文件夹/文件)，新的(文件夹/文件)如果存在就先删除再 拷贝
    @objc func test208() {
        // 1、沙盒中的(文件夹/文件)路径
        // let path1 = FileManager.DocumnetsDirectory() + "/动画乐园.text"
        // 2、相中(文件夹/文件)的路径
        guard let path2 = Bundle.main.path(forResource: "testFile", ofType: "text") else {
            return
        }
        let result = FileManager.jk.copyFile(type: .file, fromeFilePath: path2, toFilePath: FileManager.jk.PreferencesDirectory() + "/项目中的testFile.text", isOverwrite: true)
        if result.isSuccess {
            debugPrint("拷贝(文件夹/文件)成功")
        } else {
            debugPrint("复制文件失败")
        }
    }
    
    // MARK: 2.07、从文件 读取 文字，图片，数组，字典
    @objc func test207() {
        guard let contentArray = (FileManager.jk.readFromFile(readType: .ArrayType, readPath:  FileManager.jk.LibraryDirectory() + "/我是一个文件").content) as? [Any] else {
            debugPrint("文件没有内容")
            return
        }
        debugPrint("文件内容：\(contentArray)", "数组个数：\(contentArray.count)")
    }
    
    // MARK: 2.06、把文字，图片，数组，字典写入文件
    @objc func test206() {
        // FileManager.writeToFile(writeType: .TextType, content: "微凉的秋风里，飘着淡淡的桂花香，闭上眼，让那缕缕馨香盈满心间，一瞬间忘了浮世烟火，忘了尘世苍凉，也忘了你离去所带来的伤感。或许，所有的经历，都是岁月的恩赐;所有的遇见，都会留下难忘的痕迹。有些人注定只能陪伴你一程;有些情感注定只是昙花一现!唯有将那些被落花弄疼了的心事，以及那份相遇的温暖，妥帖的收藏于时光的杯盏里。有些缘分，我知道，只能用心铭记，让其伴随一生，直至终老。回首处，即使有遗憾，也是这一程山水必经的风景。你的世界我来过，这就够了!光阴里的故事，我用一颗虔诚的心去描绘。无论深浅，都是生命最美的馈赠。", writePath: FileManager.LibraryDirectory() + "/我是一个文件")
        
        FileManager.jk.writeToFile(writeType: .TextType, content: ["1", "2"], writePath: FileManager.jk.LibraryDirectory() + "/我是一个文件")
    }
    
    // MARK: 2.05、读取文件内容
    @objc func test205() {
        guard let content = FileManager.jk.readfile(filePath: FileManager.jk.LibraryDirectory() + "/我是一个文件") else {
            debugPrint("文件没有内容")
            return
        }
        debugPrint("文件内容：\(content)")
    }
    
    // MARK: 2.04、删除文件
    @objc func test204() {
        FileManager.jk.removefile(filePath: FileManager.jk.LibraryDirectory() + "/我是一个文件")
    }
    
    // MARK: 2.03、根据传件来的路径创建文件
    @objc func test203() {
        FileManager.jk.createFile(filePath: FileManager.jk.DocumnetsDirectory() + "/动画乐园.text")
    }
    
    // MARK: 2.02、删除文件夹
    @objc func test202() {
        FileManager.jk.removefolder(folderPath: FileManager.jk.LibraryDirectory() + "/哈哈")
    }
    
    // MARK: 2.01、创建文件夹(蓝色的，文件夹和文件是不一样的)
    @objc func test201() {
        let path = FileManager.jk.LibraryDirectory() + "/哈哈"
        FileManager.jk.createFolder(folderPath: path)
        JKPrint("根据传件来的路径创建文件夹 创建文件目录(蓝色的，文件夹和文件是不一样的)", "获取文件夹的完整路径名:\(path)")
    }
}

// MARK: - 一、沙盒路径的获取
extension FileManagerExtensionViewController {
    // MARK: 1.06、"获取Tmp的完整路径名"
    @objc func test106() {
        JKPrint("获取 Tmp 的完整路径名:\(FileManager.jk.TmpDirectory())")
    }
    
    // MARK: 1.05、获取/Library/Preferences的完整路径名
    @objc func test105() {
        JKPrint("获取 /Library/Preferences 的完整路径名:\(FileManager.jk.PreferencesDirectory())")
    }
    
    // MARK: 1.04、获取/Library/Cache的完整路径名
    @objc func test104() {
        JKPrint("获取 /Library/Cache 的完整路径名:\(FileManager.jk.CachesDirectory())")
    }
    
    // MARK: 1.03、"获取Library的完整路径名"
    @objc func test103() {
        JKPrint("获取 Library 的完整路径名:\(FileManager.jk.LibraryDirectory())")
    }
    
    // MARK: 1.02、获取Documnets的完整路径名
    @objc func test102() {
        JKPrint("获取 Documnets 的完整路径名:\(FileManager.jk.DocumnetsDirectory())")
    }
    
    // MARK: 1.01、获取Home的完整路径名
    @objc func test101() {
        JKPrint("获取 Home 的完整路径名:\(FileManager.jk.homeDirectory())")
    }
}
