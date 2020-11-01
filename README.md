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

## Author

JoanKing, jkironman@163.com

## License

JKSwiftExtension is available under the MIT license. See the LICENSE file for more info.
