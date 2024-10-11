![](https://user-images.githubusercontent.com/19670000/114378430-45129480-9bba-11eb-9051-74d89c3e15f3.png)

<p align="center">
<a href="https://cocoapods.org/pods/JKSwiftExtension"><img src="https://img.shields.io/cocoapods/v/JKSwiftExtension.svg?style=flat"></a>
<a href="https://github.com/JoanKing/JKSwiftExtension/blob/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/JKSwiftExtension.svg?style=flat"></a>
<a href="https://cocoapods.org/pods/JKSwiftExtension"><img src="https://img.shields.io/cocoapods/p/JKSwiftExtension.svg?style=flat"></a>
</p>

## 组成部分  

    FoundationExtension：Foundation 类型的扩展
    UIKitExtension：UIKit类型的扩展
    Protocol：协议工具
    SmallTools：其他小工具
    
## 使用说明

   每一个 `Extension` 都会对应一个测试用例的类，如果没有的说明还没有完善，如： String 的分类 `String+Extension` 的测试用例在 `StringExtensionViewController.swift` 里面
   ![WechatIMG160.jpeg](https://upload-images.jianshu.io/upload_images/1728484-f0bcaccd3f7d26b3.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1024)
   
## 导入方式

#### 方式一：Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/JoanKing/JKSwiftExtension.git`
- Select "Up to Next Major" with "2.0.0"

#### 方式二：CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'MyApp' do
  pod 'JKSwiftExtension'
end
```

## Requirements

    Swift5.0+
    
## JKSwiftExtension基础库的目的：快速开发，不重复再去查找资料，如果觉得此项目对您有帮助，欢迎点赞...

## 讨论
- 微信号: wangc2318151015
- 邮箱: jkironman@163.com
<img src="https://github.com/JoanKing/JKSwiftExtension/assets/19670000/5611a91f-e083-4c77-8ef8-bdc4a91a13c9" alt="微信交流群" width="220">

## 版本说明 
  - 2.7.1、版本(2024.10.11)
    - 去除 override var traitCollection: UITraitCollection {} 重写，建议重写traitCollectionDidChange自己去实现界面的布局
  - 2.7.0、版本(2024.09.12)
    - 最低支持版本调整为13.0
  - 2.6.10、版本(2024.09.12)
    - 1、UserDefaults修复移除包含的key
    - 2、UILabel扩展的属性修改为与系统一致的可选类型
  - 2.6.9、版本(2024.08.28)
    - 修复新旧版本号判断的bug，判断逻辑如下
        - 1.先判断传进来的版本号正则判断：开头是数字，结尾是数字，中间是由数字和小数点组合
        - 2.传进来的版本号使用.分割，分割后的数组不足3个元素的补0
        - 3.获取app的版本号使用.分割，分割后的数组不足3个元素的补0
        - 4.逐位对比
  - 2.6.8、版本(2024.08.13)
    - 修复UIScrollView截屏闪烁
    - 修复UITextField和UITextView输入选中内容不可修改的问题
  - 2.6.7、版本(2024.07.06)
    - import Photos 移到库外
    - 其他扩展新增和优化
  - 2.6.6、版本(2024.05.27)
    - 修复UITextField和UITextView复制超出限制字数无法截取的问题
    - UIImage+Extension对于图片裁剪进行了多种扩展
    - 其他扩展新增和优化
  - 2.6.5、版本(2024.05.09)
    - 新增String+Extension进制扩展，如：字符串转十六进制字符串、十六进制字符串转换回原始字符串、十六进制字符串转Float、十六进制字符串转Double等等
    - 修复并优化部分扩展，比如：取消强制解包
  - 2.6.3、版本(2024.03.19)
    - 新增JKScreenShieldView 屏蔽 [录屏, 截屏] 的视图
    - 修复Date针对12小时制转换失败的问题
  - 2.6.2、版本(2024.01.24)
    - 新增CGPoint+Extension扩展
    - 修复其他问题
  - 2.6.1、版本(2024.01.22)：修复String转Double中NumberFormatter问题
  - 2.6.0、版本(2024.01.18)
    - UIView+Extension渐变色替换旧的CAGradientLayer
        ```swift
        if let sublayers = self.base.layer.sublayers {
            // 替换旧的CAGradientLayer
            for (index, layer) in sublayers.enumerated() {
                if layer is CAGradientLayer {
                    // 替换旧的CAGradientLayer
                    self.base.layer.replaceSublayer(layer, with: gradientLayer)
                }
            }
        } else {
            self.base.layer.insertSublayer(gradientLayer, at: 0)
        }
        ```
    - UIDevice+Extension模拟器判断条件调整
      ```swift
      static func isSimulator() -> Bool {
        ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil
      }
      ```
  - 2.5.9、版本(2024.01.12)
    - UIView+Extension渐变色追加到后面
        ```swift
        if let sublayers = self.base.layer.sublayers {
            // 将后面的渐变层插入到最后面
            self.base.layer.insertSublayer(gradientLayer, at: UInt32(sublayers.count))
        } else {
            self.base.layer.insertSublayer(gradientLayer, at: 0)
        }
        ```
  - 2.5.8、版本(2024.01.08)
    - (1)、新增Optional+Extension
    - (2)、设备的identifier更新，具体的可参考链接：https://theapplewiki.com/wiki/Models#iPhone
  - 2.5.7、版本(2023.12.08)
    - (1)、新增JKOperator：|>>>|无符号运算符
    - (2)、UIGraphicsBeginImageContextWithOptions的size出现0崩溃防护
    - (3)、JKFileLog优化
    - (4)、其他扩展优化和新增部分内容
    - (5)、从2.5.7版本开始最低支持iOS10.0
  - 2.5.6、版本(2023.11.23)：优化代码
  - 2.5.5、版本(2023.11.23)：优化JKFileLog、图片检测支持人脸和二维码
  - 2.5.4、版本(2023.11.23)：新增JKFileLog日志以及UIViewController多次present后dismiss到某个vc 
  - 2.5.3、版本(2023.11.18)：扩展补充，特别是数字金钱转大写人民币金钱，以及反向大写人民币转数字金钱
  - 2.5.2、版本(2023.11.01)：bug修复和代码优化
  - 2.5.1、版本(2023.10.31)：bug修复和代码优化
    - (1)、JKPhotoAlbumUtil保存图片增加权限判断
    - (2)、Int单位转化的优化
  - 2.5.0、版本(2023.10.18)：测试用例调整
  - 2.4.6、版本(2023.10.17)：UITextFiled和UITextView复制粘贴的处理
    如果需要处理粘贴，需要把UITextFiled继承于：JKPastedTextField，UITextView继承于JKPastedTextView，之后设置isRemovePasteboardNewlineCharacters才有效果
  - 2.4.3、版本(2023.10.08)：UITextFiled和UITextView在高亮状态下可以设置属性isMarkedTextRangeCanInput输入(非高亮字数在限制范围内)
  - 2.4.2、版本(2023.09.20)：UITextField+Extension.swift和UITextView+Extension.swift的复制内容输入限制正则判断位置调整
  - 2.4.1、版本(2023.09.17)：String+Extension.swift新增枚举StringTypeLength新增lengthOfBytesUtf8和customCountOfChars
    ```swift
    /// utf8编码通过字节判断长度
    case lengthOfBytesUtf8
    /// 英文 = 1，数字 = 1，汉语 = 2
    case customCountOfChars
    ```
    修复限制文字长度的漏洞
  - 2.4.0、版本(2023.08.12)：修改jk_kScreenW等属性为计算属性
  - 2.3.9、版本(2023.08.12)：iOS13适配
  - 2.3.8、版本(2023.07.22)：JKAlertViewControllerView增加card样式与JKCommonTool增加模型差异对比方法
  - 2.3.5、版本(2023.07.12)：修复Date+Extension取今天一直不杀死app无法更新日期的问题
        ```swift
        static var todayDate: Date {
            return Date()
        }
        ```
  - 2.3.4、版本(2023.06.30)：放在库外部(因为涉及到支付宝等敏感第三方)
      - (1)、String+Extension.swift新增枚举StringTypeLength来获取中字符串的长度方式
        /// 字符串取类型的长度
        ```swift
        public enum StringTypeLength {
            /// Unicode字符个数
            case count
            /// utf8
            case utf8
            /// utf16获取长度对应NSString的.length方法
            case utf16
            /// unicodeScalars
            case unicodeScalars
        }
        func typeLengh(_ type: StringTypeLength) -> Int {}获取类型长度
        ```
      - (2)、UITextField+Extension.swift和UITextView+Extension.swift的输入限制方法inputRestrictions新增lenghType: StringTypeLength = .count参数
  - 2.3.3、版本(2023.06.01)：JKThirdPartyAppType放在库外部(因为涉及到支付宝等敏感第三方)
     UIApplication+Extension.swift中打开第三方的方法之前传类型，改为传第三方的deeplink
  - 2.3.0、版本(2023.05.29) : 新增JKAlertViewController弹框和修复字符串截取有表情崩溃的问题
  - 2.2.9、版本(2023.05.03) : 新增单位转换的类：JKUnitConverter和优化并修复部分问题
      - (1)、新增单位转换的类：JKUnitConverter，支持：距离、质量、温度的基本单位转换
      - (2)、修复部分问题，Date在12小时制问题的修复
  - 2.2.8、版本(2023.03.12) : 更新部分extension
  - 2.2.7、版本(2023.02.14) 
      - (1)、 NSDecimalNumberHandler扩展的优化
         - 1、两个数字之间的计算增加参数：roundingMode(舍入方式)和 scale(保留小数的位数)
         - 2、数字取舍以及位数的处理
      - (2)、新增JKCustomPickView
  - 2.2.6、版本(2023.01.12)
      - (1)、UIFont扩展的优化
         - 1、UIFont系统字体的扩展简化，例如regular的字体原来的UIFont.systemFont(ofSize: 20, weight: .regular)到UIFont.textR(20)
         - 2、UIFont字体支持PingFangSC字体的优化使用，比如：PingFangSC-Regular使用方式为UIFont.pingFangR(20)
         - 3、UIFont字体支持自定义字体，比如第三方字体的使用：UIFont.jk.customFont(26, fontName: "第三方字体的名字")
      - (2)、NSAttributedString扩展增加测试用例
  - 2.2.5、版本(2022.12.17) 代码格式检查
  - 2.2.4、版本(2022.12.11)
      - (1)、新增JKCircleProgressView圆形进度条
      - (2)、UIView+Extension.swift部分bug修复
      - (3)、JKPanView完善
  - 2.2.3、版本
      - (1)、String+Extension.swift
         - 1、replacingCharacters 根据指定range替换内容
         - 2、validIndex校验字符串位置是否合理做超出范围(针对表情)做处理
      - (2)、UITextFiled+Extension.swift
         - 1、限制字数的输入inputRestrictions的bugfix
      - (3)、UITextView+Extension.swift
         - 1、限制字数的输入inputRestrictions的bugfix
  - 2.2.2、版本
       - UIView+Extension.swift的圆角和阴影共存的bugfix
       - 其他扩展的bugfix
  - 2.2.1、版本
      - (1)、String+Extension.swift 扩展
         - 1、增加手机隐藏位数，可设置前后的隐藏位数，方法：hidePhone  
         - 2、增加邮箱隐藏位数，可设置前后的隐藏位数，方法：hideEmail  
         - 3、修复插入任意位置插入字符串的bug，方法：insertString
     - (2)、UIDevice+Extension.swift 
         - 1、修复有关获取sim卡信息强制解包崩溃的问题 
         - 2、增加设备的震动相关方法，SystemSoundID、UINotificationFeedbackGenerator、UIImpactFeedbackGenerator
     - (3)、UITextView+Extension.swift
         - 1、修复方法inputRestrictions中当有字数限制，在复制内容的时候，不可截取的问题
     - (4)、UITextField+Extension.swift
         - 1、修复方法inputRestrictions中当有字数限制，在复制内容的时候，不可截取的问题
   - 2.1.12、版本
      - (1)、UIVisualEffectView+Extension.swift 新增 import UIKit
      - (2)、新增 UITapGestureRecognizer+Extension.swift 扩展
   - 2.1.10、版本
      - (1)、String+Extension.swift 新增 匹配两个字符之间的内容 matchesMiddleContentOfCharacters
      - (2)、CGFloat+Extension.swift、Float+Extension.swift 新增四舍五入方法：rounding(scale: Int16 = 1)
      - (3)、NSDecimalNumberHandler+Extension.swift 新增四舍五入方法：rounding(value: Any, scale: Int16 = 0)
      - (4)、JKEmptyView.swift 空白视图，使用简单，方便去显示空白或者无网络的界面，有待完善
   - 2.1.9、版本：
      - (1)、UIButton扩展里面的扩大点击事件，做了修复，之前把self.base写成了self，导致扩大范围失效，在2.1.9分支做了修复
      - (2)、新增字符串有关子串在父字符串range的范围，返回一个子串的范围数组
   - 2.1.7、版本：新增JKPanView(可拖动的卡片)，新增你一些扩展，修复一些bug
      - (1)、新增可拖动的卡片视图(JKPanView)，只作为容器
      - (2)、UITableView 新增扩展：切Section整体的cell和获取section的cell数量
      - (3)、Date扩展新增Local本地化支持
      - (4)、UserDefaults扩展新增对继承于Codable的模型，支持数组的存储
      - (5)、修复UIImage扩展对图片的等比例缩放（scaleTo(scale: CGFloat) -> UIImage? ）有关新的size大小不对的问题
   - 2.1.6、版本：NSAttributedString+Extension和UIButton+Extension扩展更新
   - 2.1.5、版本：部分扩展的优化
   - 2.1.2、版本：新增SmallTools：JKRollingNoticeView
   - 2.1.1、版本：新增扩展内容，优化部分代码，修复JKWeakTimer的fire()崩溃问题
   - 2.1.0、版本：修复判断13.3上UI_USER_INTERFACE_IDIOM的archive的bug，使用UIDevice.current.userInterfaceIdiom代替
   - 2.0.9、版本：修复DateFormatter问题
   - 2.0.8、版本：WKWebView 在Xcode13.3的bug修复
   - 2.0.6、版本：修复Array+Extension 添加数组和 Int转CountableRange的问题
   - 2.0.5、版本：修复JKWeakTimer在未开启下的崩溃
   - 2.0.2、版本：新增JKMems辅助查看内存的小工具类和JKPlaceHolderTextView设置PlaceHolder
   - 2.0.0、版本：开始支持 SPM(Swift Package Manager)
   - 1.9.5、版本：DateFormatter耗时优化
   - 1.9.2、版本：常量增加前缀`jk_`
   - 1.9.1、版本：mark注释更新
   - 1.9.0、版本：1.9.0之后的版本去除JKEKEvent.swift和JKContactsKit.swift，原因是：对于日历和通讯录的API使用，苹果机审需要在：info.plist中添加对用的key和value
   - 1.8.9、版本：去除依赖库
   - 1.8.8、版本：kTabbatBottom 改为 kTabbarBottom
   - 1.8.7、版本：CALayer+Extension.swift中baseBasicAnimation动画repeatNumber: 重复的次数的使用
   - 1.8.6、版本：去除Kingfisher依赖
   - 1.8.5、版本：UIView+Extension新增内阴影
   - 1.8.2、版本：扩展更新
   - 1.8.0、版本：新增智能换肤
       用户可以设置时间来定义：浅色和深色的切换时间，到时间自动切换模式，需要开发者自己去找触发机制，具体的测试用例在：JKDarkModeUtilViewController
       
       ![智能换肤](https://upload-images.jianshu.io/upload_images/1728484-2d6b41fd7cc6c0cc.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
   - 1.7.8、版本：部分扩展的新增
   - 1.7.7、版本：暗黑模式的完善
   - 1.7.6、版本：暗黑模式适配iOS 13以上和iOS 13以下的：浅色和深色
     - iOS 13以上使用系统的暗黑模式：`JKDarkModeUtil`，默认跟随系统
        使用方式：在设置 `window` 的 `rootViewController` 后需要调用 `JKDarkModeUtil.defaultDark()`，颜色调用如下：
        
           self.view.backgroundColor = JKDarkModeUtil.colorLightDark(light: UIColor.yellow, dark: UIColor.green)
     - iOS 13以下使用主题色：`JKThemeProvider`，默认是浅色
       使用方式：
          - 1.1、遵守协议 `JKThemeable` （遵守UITraitEnvironment协议的均可使用）
            
                extension lViewController: JKThemeable {
                   func apply() {
                      self.view.backgroundColor = JKDarkModeUtil.colorLightDark(light: UIColor.yellow, dark: UIColor.green)
                   }
                }
          - 1.2、注册监听模式变化
         
                themeProvider.register(observer: self)
          - 1.3、模式变化通知
          
                JKDarkModeUtil.setDarkModeCustom(isLight: true) 
     - 建议使用业务色

           extension UIColor {
              /// 背景色
              private(set) static var cA1 = JKDarkModeUtil.colorLightDark(light: UIColor.yellow, dark: UIColor.green)
           }
   - 1.7.2、暗黑模式的添加：`JKDarkModeUtil`
    
       - 在设置 `window` 的 `rootViewController` 后需要调用 `JKDarkModeUtil.defaultDark()`
       - 主要方法是：
         - 开启跟随模式：`setDarkModeFollowSystem` 
         - 自定义模式：`setDarkModeCustom`
         - 是否是跟随模式：`JKDarkModeUtil.isFloorSystem`
         - 是否是浅色模式：`JKDarkModeUtil.isLight`
   - 1.7.1、版本
   
     `WKWebView+Extension.swift` 扩展内容的补充
     
     - `WKWebViewConfiguration`默认配置
     - `js`注入
     - `js`交互
     - 调整字体的比例
     - 加载网页
     - 获取WKWebView视图(长截图)
   - 1.7.0、版本

     `DispatchQueue+Extension.swift` 扩展内容的补充
    
     - 函数只被执行一次
     - 异步做一些任务
     - 异步做任务后回到主线程做任务
     - 异步延迟(子线程执行任务)
     - 异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
   - 1.6.9、版本
     
     `Date+Extension.swift` 新增两个Date之间的关系，如下
     
         获取两个日期之间的数据
         获取两个日期之间的天数
         获取两个日期之间的小时
         获取两个日期之间的分钟
         获取两个日期之间的秒数
     
   - 1.6.8、版本
   
        获取字体的名字由 `font.fontName` 替换为 `font.fontName == ".SFUI-Regular" ? "TimesNewRomanPSMT" : font.fontName`
   - 1.6.7、版本
       `UIColor+Extension.swift` 增加暗黑模式颜色适配，方法如下
       
         public extension UIColor {
    
           // MARK: 6.1、深色模式和浅色模式颜色设置，非layer颜色设置
           /// 深色模式和浅色模式颜色设置，非layer颜色设置
           /// - Parameters:
           ///   - lightColor: 浅色模式的颜色
           ///   - darkColor: 深色模式的颜色
           /// - Returns: 返回一个颜色（UIColor）
           static func darkModeColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
              if #available(iOS 13.0, *) {
                return UIColor { (traitCollection) -> UIColor in
                   if traitCollection.userInterfaceStyle == .dark {
                      return darkColor
                   } else {
                      return lightColor
                   }
                }
              } else {
                return lightColor
              }
           }
         }
        使用，建议设置一个业务颜色的扩展，在使用的时候调用业务的颜色，如下
        
         // MARK: - 业务颜色的使用
         extension UIColor {
            /// 颜色
            private(set) static var cB1: UIColor = UIColor.darkModeColor(lightColor: UIColor.green, darkColor: UIColor.blue)
         }
        具体的调用
        
          self.view.backgroundColor = .cB1
      
   - 1.6.2、版本
       String+Extension.swift 新增String或者String HTML标签转富文本设置，方法如下
       
         func setHtmlAttributedString(font: UIFont? = UIFont.systemFont(ofSize: 16), lineSpacing: CGFloat? = 10) -> NSMutableAttributedString {
             省略......
         }
   - 1.6.1、版本
       JKContentSize 新增指定宽度的文本：行数和每行的内容（可缩放后的文本）
   - 1.6.0、版本
      修复枚举 `JKViewGradientDirection` 在 `vertical` 为 `return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1))`
   - 1.5.9、版本
     - UITableView+Extension 新增 UITableViewCell的注册和使用的方法
     - UICollectionView+Extension 新增 UICollectionViewCell的注册和使用的方法
   - 1.5.7、版本
     - UIFont+Extension新增PingFangSC-字体
   - 1.5.6、版本
     - 修复UITextView+Extension和UITextFiled+Extension 限制字符正则的bug
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
