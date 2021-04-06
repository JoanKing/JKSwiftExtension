# JKSwiftExtension

[![CI Status](https://img.shields.io/travis/JoanKing/JKSwiftExtension.svg?style=flat)](https://travis-ci.org/JoanKing/JKSwiftExtension)
[![Version](https://img.shields.io/cocoapods/v/JKSwiftExtension.svg?style=flat)](https://cocoapods.org/pods/JKSwiftExtension)
[![License](https://img.shields.io/cocoapods/l/JKSwiftExtension.svg?style=flat)](https://cocoapods.org/pods/JKSwiftExtension)
[![Platform](https://img.shields.io/cocoapods/p/JKSwiftExtension.svg?style=flat)](https://cocoapods.org/pods/JKSwiftExtension)

## 组成部分

    FoundationExtension：Foundation 类型的扩展
    UIKitExtension：UIKit类型的扩展
    Protocol：协议工具
    SmallTools：其他小工具
    
## 使用说明

   每一个 `Extension` 都会对应一个测试用例的类，如果没有的说明还没有完善，如： String 的分类 `String+Extension` 的测试用例在 `StringExtensionViewController.swift` 里面
   ![WechatIMG160.jpeg](https://upload-images.jianshu.io/upload_images/1728484-f0bcaccd3f7d26b3.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 导入方式

     platform :ios, '9.0'
     
     target '项目名字' do
       use_frameworks!
       pod 'JKSwiftExtension'

     end

## Requirements

    Swift5.0+
    
## 这个基础库的目的：快速开发，不重复再去查找资料，我希望感兴趣的朋友和我一起完善它和规范它，如果觉得此项目对您的Swift学习有帮助，欢迎点赞...
  
    我的联系方式：微信：18500652880
    
## 版本说明
   - 1.5.5、版本
     - UITextView 限制行数、限制字符、自动变化高度的去除
   - 1.5.2、版本
     
     - JKValidateHelper内容合并到JKRegexHelper
     - JKRegexHelper：新增JKRegexCharacterType(校验字符的表达式)和JKRegexDigitalType(校验数字的表达式)
     - WeakTimer->改为JKWeakTimer
     - UITextView&UITextField 扩展新增方法(`inputRestrictions`)，限制字数的输入(考虑了九宫格键盘和高亮状态)
   - 1.5.1、版本
      新增 Range+Extension.swift ，Range 转 NSRange，String+Extension 新增任意位置插入字符串
   - 1.5.0、版本
      新增 JKContactsKit 获取通讯录的联系人
        
         在iOS9.0 之前, 我们只能通过 AddressBook 框架来获取通讯录联系人信息。但 AddressBook framework 语法很奇怪，同时也十分难用。所以苹果从 iOS9.0 开始推出的全新的联系人框架 Contacts FrameWork 作为替代，同时将原来的 AddressBook 给废弃掉。
         Contacts FrameWork 同样包含两种访问通讯录的方式：
         ContactsUI.framework 框架 ： 通过系统提供的通讯录交互界面来访问（替代原先的 AddressBookUI.framework）
         Contacts.framework 框架 ： 没有界面，通过代码来获取所有联系人信息（替代原先的 AddressBook.framework）
   - 1.3.9、版本
      修复 UIViewController+Extension.swift 1.3 和 1.4 找不到 rootViewController 的问题
   - 1.3.8、版本
      JKEKEvent.swift 回到主线程优化
      
         /// 事件主线程
         /// - Parameters:
         ///   - parameter: 返回的参数
         ///   - eventsClosure: 闭包
         private static func resultMain<T>(parameter: T, eventsClosure: @escaping ((T) -> Void)) {
            DispatchQueue.main.async {
               eventsClosure(parameter)
            }
         }
   - 1.3.7、版本
       新增JKEKEvent日历和提醒事件的基本使用
   - 1.3.6、版本
       优化JKPhotoAlbumUtil相册管理
   - 1.3.5、版本
       新增小工具JKPhotoAlbumUtil，管理相册
   - 1.3.2、版本
       `UITextView+Extension` 新增：添加链接文本（链接为空时则表示普通文本）、转换特殊符号标签字段
   - 1.3.1、版本
       `String+Extension` 和 `NumberFormatter+Extension` 部分内容代码优化
   - 1.3.0、版本
       新增 NumberFormatter+Extension.swift：NumberFormatter进行数字格式化显示
   - 1.2.9、版本
       UIFont+Extension 字体的调整
   - 1.2.8、版本
       新增具有内边距的label：JKPaddingLabel
   - 1.2.7、版本
       - URL+Extension.swift 增加 检测应用是否能打开这个URL实例
       - JKJSON.swift 小组件的新增：将数据转成可用的JSON模型
       - String+Extension.swift 新增 提取出字符串中所有的URL链接
       - JKDrawSignatureView.swift 签名板
   - 1.2.6、版本   
       UIImage+Extension.swift  
       - 图片中二维码的识别
       - 分析图片中二维码的具体数据
       - 图片打马赛克
       - 识别图片中的人脸位置
       - 图片中的人脸打马赛克
       
       String+Extension.swift 新增 字符值引用 (numeric character reference, NCR)与普通字符串的转换
   - 1.2.5、版本
     CLLocation+Extension.swift 和 NSRange+Extension.swift 扩展的新增
   - 1.2.2、版本
     FileManager+Extension.swift 新增部分扩展
   - 1.2.1、版本
     去除 SmallTools 中的 JKVerticalCarousel、MaskingManager、JKLoadingView 删除，也去除依赖SnapKit
   - 1.1.9、版本
       UIDevice+Extension.swift 扩展新增：有关设备运营商的信息
       - sim卡信息
       - 数据业务对应的通信技术
       - 设备网络制式
       - 运营商名字
       - 移动国家码(MCC)
       - 移动网络码(MNC)
       - ISO国家代码
       - 是否允许VoIP
   - 1.1.8、版本
       调整状态栏的高度
       
         public var kStatusBarFrameH: CGFloat {
            guard isIPhoneX else {
              return 20
            }
            return UIApplication.shared.statusBarFrame.height > 0 ? UIApplication.shared.statusBarFrame.height : 44
         }
   - 1.1.7、版本
   
         gif图片的：本地、asset、网络 的分解

   - 1.1.6、版本
   
         UIView+Extension：新增背景颜色渐变和colors变化渐变动画
         UIButton+Extension：新增点击区域的扩展设置
         CAGradientLayer+Extension：新增渐变扩展
   - 1.1.5、版本
    
         UIApplication+Extension 新增打开系统应用和第三方APP的方法，如打开微信
         UIApplication.jk.openThirdPartyApp(type: .weixin) { (result) in
            JKPrint("结果：\(result)")
         }
   - 1.1.2、版本
     
         UIApplication+Extension 新增判断是否拥有权限，目前支持 照相机、相册、麦克风、定位，提示：这里判断是这些权限有没有被用户手动关闭
         JKGlobalTools 新增打开设置界面
   - 1.1.1、版本
   
         音视频压缩 AVAssetExportSession+Extension.swift 扩展的新增
   - 1.1.0、版本
   
         FileManager+Extension 新增有关网络和本地视频缩略图获取的扩展
         Date+Extension 新增时间条显示的格式，主要是针对播放时间条
   - 1.0.8、版本：UIViewController扩展新增一些内容
   - 1.0.7、版本：UIView有关手势的扩展
   - 1.0.1、版本：新增中间协议，使用绝大部分方法的时候需要先调用 `jk`,然后才可以使用，在 1.0.1 版本之前是没有使用协议的

## Author

JoanKing, jkironman@163.com

## License

JKSwiftExtension is available under the MIT license. See the LICENSE file for more info.
