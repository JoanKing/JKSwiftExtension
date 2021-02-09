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
  
    我的联系方式：微信：18500652880，您加我后，我把您拉进 JKSwiftExtension 的使用和维护群
    
## 版本说明
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
