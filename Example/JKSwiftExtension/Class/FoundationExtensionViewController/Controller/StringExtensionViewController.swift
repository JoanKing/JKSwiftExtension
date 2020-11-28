//
//  StringExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CommonCrypto

class StringExtensionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["零、字符串基本的扩展","一、沙盒路径的获取", "二、iOS CharacterSet（字符集）", "三、字符串的转换", "四、字符串UI的处理", "五、字符串有关数字方面的扩展", "六、苹果针对浮点类型计算精度问题提供出来的计算类", "七、字符串包含表情的处理", "八、字符串的一些正则校验", "九、字符串截取的操作", "十、字符串编码的处理", "十一、进制之间的转换", "十二、String -> NSMutableAttributedString", "十三、MD5 加密 和 Base64 编解码", "十四、AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密", "十五、SHA1, SHA224, SHA256, SHA384, SHA512"]
        dataArray = [["字符串的长度", "判断是否包含某个子串", "判断是否包含某个子串 -- 忽略大小写", "字符串 Base64 编码", "字符串 Base64 解码", "将16进制字符串转为Int", "判断是不是九宫格键盘", "字符串转 UIViewController", "字符串转 AnyClass", "字符串转数组", "JSON 字符串 -> Dictionary", "JSON 字符串 -> Array"], ["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"],["去除字符串前后的 空格", "去除字符串前后的 换行", "去除字符串前后的 换行和换行", "去掉所有 空格", "去掉所有 换行", "去掉所有空格 和 换行", "是否是 0-9的数字，也不包含小数点", "url进行编码", "某个字符使用某个字符替换掉", "使用正则表达式替换某些子串", "删除指定的字符"], ["字符串 转 CGFloat", "字符串转bool", "字符串转 Int", "字符串转 Double", "字符串转 Float", "字符串转 Bool", "字符串转 NSString", "字符串转 Int64", "字符串转 NSNumber"], ["对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)", "对字符串(多行)指定字体及Size，获取 (高度)", "对字符串(多行)指定字体及Size，获取 (宽度)", "对字符串(单行)指定字体，获取 (Size)", "对字符串(单行)指定字体，获取 (width)", "对字符串(单行)指定字体，获取 (Height)", "字符串通过 label 根据高度&字体—>Size", "字符串通过 label 根据高度&字体—>Width", "字符串通过 label 根据宽度&字体—>height", "字符串根据宽度 & 字体&行间距->Size", "字符串根据宽度 & 字体 & 行间距->width", "字符串根据宽度&字体&行间距->height"], ["将金额字符串转化为带逗号的金额 按照千分位划分，如 1234567 => 1,234,567", "字符串差不多精确转换成Double——之所以差不多，是因为有精度损失", "去掉小数点后多余的 0", "将数字的字符串处理成  几位 位小数的情况"], ["+", "-", "*", "/"], ["检查字符串是否包含 Emoji 表情", "去除字符串中的Emoji表情"], ["判断是否全是空白,包括空白字符和换行符号，长度为0返回true", "判断是否全十进制数字，长度为0返回false", "判断是否是整数", "判断是否是Float,此处Float是包含Int的，即Int是特殊的Float", "判断是否全是字母，长度为0返回false", "判断是否是中文, 这里的中文不包括数字及标点符号", "是否是有效昵称，即允许“中文”、“英文”、“数字”", "判断是否是有效的手机号码", "判断是否是有效的电子邮件地址", "判断是否有效的身份证号码，不是太严格", "严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码", "校验字符串位置是否合理，并返回String.Index"], ["截取字符串从开始到 index", "截取字符串从index到结束", "获取指定位置和长度的字符串", "切割字符串(区间范围 前闭后开)", "用整数返回子字符串开始的位置", "获取某个位置的字符串"], [""], ["二进制 -> 八进制", "二进制 -> 十进制", "二进制 -> 十六进制", "八进制 -> 二进制", "八进制 -> 十进制", "八进制 -> 十六进制", "十进制 -> 二进制", "十进制 -> 八进制", "十进制 -> 十六进制", "十六进制 -> 二进制", "十六进制 -> 八进制", "十六进制 -> 十进制"], ["String 添加颜色后转 NSMutableAttributedString", "String 添加 font 后转 NSMutableAttributedString", "String 添加 font 后转 NSMutableAttributedString", "String 添加 text 后转 NSMutableAttributedString", "String 添加 删除线 后转 NSMutableAttributedString"], ["MD5加密 默认是32位小写加密", "Base64 编解码"], ["字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密"], ["SHA1, SHA224, SHA256, SHA384, SHA512 加密"]]
        initUI()
    }
    
    /// 创建控件
    private func initUI() {
        view.addSubview(tableView)
    }
    
    fileprivate static let StringExtensionViewControllerCellIdentifier = "StringExtensionViewControllerCellIdentifier"
    /// 资源数组
    fileprivate var dataArray = [Any]()
    /// 资源数组
    fileprivate var headDataArray = [Any]()
    lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame:CGRect(x:0, y: 0, width: kScreenW, height: kScreenH - CGFloat(kNavFrameH)), style:.grouped)
        if #available(iOS 11, *) {
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.01))
        // 设置行高为自动适配
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: StringExtensionViewController.StringExtensionViewControllerCellIdentifier)
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 十五、SHA1, SHA224, SHA256, SHA384, SHA512
extension StringExtensionViewController {
    
    // MARK: 15.1、SHA1, SHA224, SHA256, SHA384, SHA512 加密
    @objc func test150() {
        let str = "我是一只小小鸟"
        let key = "123456"
        let newString = str.shaCrypt(cryptType: .SHA1, key: key, lower: true) ?? "加密失败"
        print("原始字符串：\(str)")
        print("key：\(key)")
        print("加密后的字符串：\(newString)")
    }
}
// MARK:- 十四、AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
extension StringExtensionViewController {
    
    // MARK: 14.1、字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
    @objc func test140() {
        let str = "welcome to hangge.com"
        let key = "123456"
        let newString = str.scaCrypt(cryptType: .DES, key: key, encode: true) ?? "加密失败"
        print("原始字符串：\(str)")
        print("key：\(key)")
        print("加密后的字符串：\(newString.scaCrypt(cryptType: .DES, key: key, encode: false) ?? "加密失败")")
    }
    
}
// MARK:- 十三、MD5 加密 和 Base64 编解码
extension StringExtensionViewController {
    
    // MARK: 13.2、Base64 编解码
    @objc func test131() {
        let oldString = "123456"
        let newString = oldString.base64String(encode: true) ?? "转码失败"
        let newString2 = newString.base64String(encode: false) ?? "解码失败"
        JKPrint("原始字符串：\(oldString)", "\(oldString) 编码后的字符串：\(newString)", "\(newString) 解码后为：\(newString2)", "最后：\(oldString.base64Encode!)")
    }
    
    // MARK: 13.1、MD5加密 默认是32位小写加密
    @objc func test130() {
        print("32 位小写：\("123456".md5Encrypt())")
        print("32 位大写：\("123456".md5Encrypt(.uppercase32))")
        print("16 位小写：\("123456".md5Encrypt(.lowercase16))")
        print("16 位大写：\("123456".md5Encrypt(.uppercase16))")
        /*
        32 位小写：e10adc3949ba59abbe56e057f20f883e
        32 位大写：E10ADC3949BA59ABBE56E057F20F883E
        16 位小写：49ba59abbe56e057
        16 位大写：49BA59ABBE56E057
        */
    }
}

// MARK:- 十二、String -> NSMutableAttributedString
extension StringExtensionViewController {
    
    // MARK: 12.1、String 添加颜色后转 NSMutableAttributedString
    @objc func test120() {
        
        let attributedString = "2秒后消失".color(UIColor.red)
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 12.2、String 添加 font 后转 NSMutableAttributedString
    @objc func test121() {
        
        let attributedString = "2秒后消失".font(30)
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 12.3、String 添加 UIFont 后转 NSMutableAttributedString
    @objc func test122() {
        let attributedString = "2秒后消失".font(UIFont.systemFont(ofSize: 28))
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 12.4、String 添加 text 后转 NSMutableAttributedString
    @objc func test123() {
        let attributedString = "2秒后消失".text()
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 12.5、String 添加 删除线 后转 NSMutableAttributedString
    @objc func test124() {
        let attributedString = "2秒后消失".strikethrough()
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
}

// MARK:- 十一、进制之间的转换
extension StringExtensionViewController {
    // MARK: 10.1、二进制 -> 八进制
    @objc func test110() {
        let number = "1010"
        JKPrint("二进制 转 八进制", "二进制：\(number) 转 八进制 为：\(number.binaryToOctal())")
    }
    
    // MARK: 10.2、二进制 -> 十进制
    @objc func test111() {
        let number = "1010"
        JKPrint("二进制 转 十进制", "二进制：\(number) 转 十进制 为：\(number.binaryTodecimal())")
    }
    
    // MARK: 10.3、二进制 -> 十六进制
    @objc func test112() {
        let number = "1010"
        JKPrint("二进制 转 十六进制", "二进制：\(number) 转 十六进制 为：\(number.binaryToHexadecimal())")
    }
    
    // MARK: 10.4、八进制 -> 二进制
    @objc func test113() {
        let number = "12"
        JKPrint("八进制 -> 二进制", "八进制：\(number) 转 二进制 为：\(number.octalTobinary())")
    }
    
    // MARK: 10.5、八进制 -> 十进制
    @objc func test114() {
        let number = "12"
        JKPrint("八进制 -> 十进制", "八进制：\(number) 转 十进制 为：\(number.octalTodecimal())")
    }
    
    // MARK: 10.6、八进制 -> 十六进制
    @objc func test115() {
        let number = "12"
        JKPrint("八进制 -> 十六进制", "八进制：\(number) 转 十六进制 为：\(number.octalToHexadecimal())")
    }
    
    // MARK: 10.7、十进制 -> 二进制
    @objc func test116() {
        let number = "10"
        JKPrint("十进制 转 二进制", "十进制：\(number) 转 二进制 为：\(number.decimalToBinary())")
    }
    
    // MARK: 10.8、十进制 -> 八进制
    @objc func test117() {
        let number = "10"
        JKPrint("十进制转 八进制", "十进制：\(number) 转 八进制 为：\(number.decimalToOctal())")
    }
    
    // MARK: 10.9、十进制 -> 十六进制
    @objc func test118() {
        let number = "10"
        JKPrint("十进制转 十六进制", "十进制：\(number) 转 十六进制 为：\(number.decimalToHexadecimal())")
    }
    
    // MARK: 10.10、十六进制 -> 二进制
    @objc func test119() {
        let number = "a"
        JKPrint("十六进制 转 二进制", "十六进制：\(number) 转 二进制 为：\(number.hexadecimalToBinary())")
    }
    
    // MARK: 10.11、十六进制 -> 八进制
    @objc func test1110() {
        let number = "a"
        JKPrint("十六进制 转 八进制", "十六进制：\(number) 转 八进制 为：\(number.hexadecimalToOctal())")
    }
    
    // MARK: 10.12、十六进制 -> 十进制
    @objc func test1111() {
        let number = "a"
        JKPrint("十六进制 转 十进制", "十六进制：\(number) 转 十进制 为：\(number.hexadecimalToDecimal())")
    }
}

// MARK:- 十、字符串编码的处理
extension StringExtensionViewController {
    // MARK:- 10.1、
    ///
    @objc func test100() {
        
    }
}

// MARK:- 零、字符串基本的扩展
extension StringExtensionViewController {
    // MARK:
    @objc func test00() {
        
    }
    
    // MARK:
    @objc func test01() {
        
    }
    
    // MARK:
    @objc func test02() {
        
    }
    
    // MARK: 字符串 Base64 编码
    @objc func test03() {
        let oldString = "123456"
        JKPrint("字符串 Base64 编码", "\(oldString) 编码后的字符串：\(oldString.base64Encode ?? "编码失败")")
    }
    
    // MARK: 字符串 Base64 解码
    @objc func test04() {
        let oldString = "123456"
        let newString = oldString.base64Encode ?? "编码失败"
        JKPrint("字符串 Base64 编码", "\(oldString) 编码后的字符串：\(newString)", "\(newString) 解码后为：\(newString.base64Decode ?? "解码失败")")
    }
    
    // MARK:
    @objc func test05() {
        
    }
}

// MARK:- 一、沙盒路径的获取
extension StringExtensionViewController {
    // MARK: 获取Home的完整路径名
    @objc func test10() {
        JKPrint("获取 Home 的完整路径名:\(String.homeDirectory())")
    }
    // MARK: 获取Documnets的完整路径名
    @objc func test11() {
        JKPrint("获取 Documnets 的完整路径名:\(String.DocumnetsDirectory())")
    }
    // MARK: "获取Library的完整路径名"
    @objc func test12() {
        JKPrint("获取 Library 的完整路径名:\(String.LibraryDirectory())")
    }
    // MARK: 获取/Library/Cache的完整路径名
    @objc func test13() {
        JKPrint("获取 /Library/Cache 的完整路径名:\(String.CachesDirectory())")
    }
    // MARK: 获取/Library/Preferences的完整路径名
    @objc func test14() {
        JKPrint("获取 /Library/Preferences 的完整路径名:\(String.PreferencesDirectory())")
    }
    // MARK: "获取Tmp的完整路径名"
    @objc func test15() {
        JKPrint("获取 Tmp 的完整路径名:\(String.TmpDirectory())")
    }
}

// MARK:- 二、iOS CharacterSet（字符集）
extension StringExtensionViewController {
    
    // MARK: 2.1、去除字符串前后的 空格
    /// 去除字符串前后的 空格
    @objc func test20() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str) \n处理后的字符串=\(str.removeBeginEndAllSapcefeed)")
    }
    
    // MARK: 2.2、去除字符串前后的 换行
    /// 去除字符串前后的 换行
    @objc func test21() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str) \n处理后的字符串=\(str.removeBeginEndAllLinefeed)")
    }
    
    // MARK: 2.3、去除字符串前后的 换行和换行
    /// 去除字符串前后的 换行和换行
    @objc func test22() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.removeBeginEndAllSapceAndLinefeed)")
    }
    
    // MARK: 2.4、去掉所有 空格
    /// 去掉所有 空格
    @objc func test23() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.removeAllSapce)")
    }
    
    // MARK: 2.5、去掉所有 换行
    /// 去掉所有 换行
    @objc func test24() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.removeAllLinefeed)")
    }
    
    // MARK: 2.6、去掉所有空格 和 换行
    /// 去掉所有空格 和 换行
    @objc func test25() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.removeAllLineAndSapcefeed)")
    }
    
    // MARK: 2.7、是否是 0-9 的数字，也不包含小数点
    /// 是否是 0-9 的数字，也不包含小数点
    @objc func test26() {
        let testString1 = "4114"
        let testString2 = "he"
        let testString3 = "h5677ha"
        let testString4 = "m880"
        JKPrint("是否是 0-9的数字，也不包含小数点", "判断 \(testString1) 是否是 0-9的数字：\(testString1.isValidNumber())", "判断 \(testString2) 是否是 0-9的数字：\(testString2.isValidNumber())", "判断 \(testString3) 是否是 0-9的数字：\(testString3.isValidNumber())", "判断 \(testString4) 是否是 0-9的数字：\(testString4.isValidNumber())")
    }
    
    // MARK: 2.8、url进行编码
    /// 是否是 0-9 的数字，也不包含小数点
    @objc func test27() {
        let testString1 = "https://www.baidu.com"
        JKPrint("url进行编码", "\(testString1) 编码后为：\(testString1.urlValidate())")
    }
    
    // MARK: 2.9、某个字符使用某个字符替换掉
    /// 某个字符使用某个字符替换掉
    @objc func test28() {
        let testString1 = "我爱我的祖国，我爱我的家人"
        let oldString = "爱"
        let replacingString = "1"
        JKPrint("某个字符使用某个字符替换掉", "\(testString1) 中的 \(oldString) 被替换为 \(replacingString) 后为 ：\(testString1.removeSomeStringUseSomeString(removeString: oldString, replacingString: replacingString))")
    }
    
    // MARK: 2.10、使用正则表达式替换某些子串
    /// 使用正则表达式替换某些子串
    @objc func test29() {
        //原始字符串
        let str1:String = "qwer1234"
        //判断的正则表达式
        let pattern = "[a-zA-Z]"
        //打印结果
        JKPrint("原字符串：\(str1)", "封装的新字符串：\(str1.pregReplace(pattern: pattern, with: "😌"))")
    }
    
    // MARK: 2.11、删除指定的字符
    /// 删除指定的字符
    @objc func test210() {
        //原始字符串
        let str1 = "<<骆驼祥子>>"
        print("原字符串：\(str1)")
        print("新字符串：\(str1.removeCharacter(characterString: "<>"))")
        print("原字符串：\(str1)")
    }
}

// MARK:- 三、字符串的转换
extension StringExtensionViewController {
    
    // MARK: 3.1、字符串 转 CGFloat
    /// 字符串 转 CGFloat
    @objc func test30() {
        let str = "3.2"
        guard let value = str.toCGFloat() else {
            return
        }
        JKPrint(value)
    }
    
    // MARK: 3.2、字符串转 bool
    /// 字符串转 bool
    @objc func test31() {
        
    }
    
    // MARK: 3.3、字符串转 Int
    /// 字符串转 Int
    @objc func test32() {
        
    }
    
    // MARK: 3.4、字符串转 Double
    /// 字符串转 Double
    @objc func test33() {
        
    }
    
    // MARK: 3.5、字符串转 Float
    /// 字符串转 Float
    @objc func test34() {
        
    }
    
    // MARK: 3.6、字符串转 Bool
    /// 字符串转 Bool
    @objc func test35() {
        
    }
    
    // MARK: 3.7、字符串转 NSString
    /// 字符串转 NSString
    @objc func test36() {
        
    }
    
    // MARK: "字符串转 Int64"
    @objc func test37() {
        
    }
    
    // MARK: "字符串转 NSNumber"
    @objc func test38() {
        
    }
}

// MARK:- 四、字符串UI的处理
extension StringExtensionViewController {
    // MARK: 4.1、对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    /// 对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    @objc func test40() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let size = testString.rectSize(font: font, size: CGSize(width: 200, height: CGFloat(MAXFLOAT)))
        print("对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)：\(size)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 100, width: size.width, height: size.height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }

    // MARK: 4.2、对字符串(多行)指定字体及Size，获取 (高度)
    /// 对字符串(多行)指定字体及Size，获取 (高度)
    @objc func test41() {
        
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let height = testString.rectHeight(font: font, size: CGSize(width: 100, height: CGFloat(MAXFLOAT)))
        print("对字符串(多行)指定字体及Size，获取 (高度)：\(height)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: 100, height: height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.3、对字符串(多行)指定字体及Size，获取 (宽度)
    /// 对字符串(多行)指定字体及Size，获取 (宽度)
    @objc func test42() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let width = testString.rectWidth(font: font, size: CGSize(width: 100, height: CGFloat(MAXFLOAT)))
        print("对字符串(多行)指定字体及Size，获取 (宽度)：\(width)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: width, height: 100))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.4、对字符串(单行)指定字体，获取 (Size)
    /// 对字符串(单行)指定字体，获取 (Size)
    @objc func test43() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let size = testString.singleLineSize(font: font)
        print("对字符串(单行)指定字体，获取 (Size)：\(size)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: size.width, height: size.height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.5、对字符串(单行)指定字体，获取 (width)
    /// 对字符串(单行)指定字体，获取 (width)
    @objc func test44() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let width = testString.singleLineWidth(font: font)
        print("对字符串(单行)指定字体，获取 (width)：\(width)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: width, height: 100))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.6、对字符串(单行)指定字体，获取 (Height)
    /// 对字符串(单行)指定字体，获取 (Height)
    @objc func test45() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let height = testString.singleLineHeight(font: font)
        print("对字符串(单行)指定字体，获取 (Height)：\(height)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: 100, height: height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.7、字符串通过 label 根据高度&字体——> Size
    /// 对字符串(单行)指定字体，获取 (Height)
    @objc func test46() {
        
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let size = testString.sizeAccording(width: 200, font: font)
        print("字符串通过 label 根据高度&字体——> Size：\(size)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: size.width, height: size.height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.8、字符串通过 label 根据高度&字体 ——> Width
    @objc func test47() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let width = testString.widthAccording(width: 200, font: font)
        print("字符串通过 label 根据高度&字体 ——> Width：\(width)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: width, height: 100))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.9、字符串通过 label 根据宽度&字体 ——> height
    @objc func test48() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let height = testString.heightAccording(width: 200, font: font)
        print("字符串通过 label 根据宽度&字体 ——> height：\(height)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: 200, height: height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.text = testString
        testLabel.backgroundColor = UIColor.randomColor
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.10、字符串根据宽度 & 字体 & 行间距 —> Size
    /// 字符串根据宽度 & 字体 & 行间距 —> Size
    @objc func test49() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        let lineSpacing: CGFloat = 20
        
        let size = testString.sizeAccording(width: 200, font: font, lineSpacing: lineSpacing)
        print("字符串根据宽度 & 字体 & 行间距 —> Size：\(size)")

        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: size.width, height: size.height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.backgroundColor = UIColor.randomColor
        
        let attrStr = NSMutableAttributedString(string: testString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, testString.count))
        testLabel.attributedText = attrStr
        self.view.addSubview(testLabel)
        
        self.view.addSubview(testLabel)

        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.11、字符串根据宽度 & 字体 & 行间距 —> width
    /// 字符串根据宽度 & 字体 & 行间距 —> width
    @objc func test410() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        let size = CGSize(width: 300, height: CGFloat(MAXFLOAT))
        let lineSpacing: CGFloat = 20
        let width = testString.widthAccording(width: size.width, font: font, lineSpacing: 20)
        print("字符串根据宽度 & 字体 & 行间距 —> width：\(width)")

        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: width, height: size.height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.backgroundColor = UIColor.randomColor
        
        let attrStr = NSMutableAttributedString(string: testString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, testString.count))
        testLabel.attributedText = attrStr
        self.view.addSubview(testLabel)

        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 4.12、字符串根据宽度 & 字体 & 行间距 —> height
      /// 字符串根据宽度 & 字体 & 行间距 —> height
    @objc func test411() {
        
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        let size = CGSize(width: 300, height: CGFloat(MAXFLOAT))
        let lineSpacing: CGFloat = 20
        
        let height = testString.heightAccording(width: size.width, font: font, lineSpacing: lineSpacing)
        print("字符串根据宽度 & 字体 & 行间距 —> height：\(height)")
        
        var testLabel = UILabel(frame: CGRect(x: 0, y: 70, width: size.width, height: height))
        testLabel.jk.centerX = self.view.jk.centerX
        testLabel.textAlignment = .left
        testLabel.numberOfLines = 0
        testLabel.font = font
        testLabel.backgroundColor = UIColor.randomColor
        let attrStr = NSMutableAttributedString(string: testString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, testString.count))
        testLabel.attributedText = attrStr
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3, {
            JKPrint("3秒等待中。。。。。。")
        }) {
            testLabel.removeFromSuperview()
        }
    }
}

// MARK:- 五、字符串有关数字方面的扩展
extension StringExtensionViewController {
    // MARK: 5.1、将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// 将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    @objc func test50() {
        JKPrint(" 将金额字符串转化为带逗号的金额 按照千分位划分，如1234567 转化后为：\("1234567".toThousands() ?? "无效")")
    }
    
    // MARK: 5.2、字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    /// 字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    @objc func test51() {
        let testStrinig = "1.3403"
        JKPrint("字符串差不多精确转换成Double——之所以差不多，是因为有精度损失：\(testStrinig.accuraterDouble() ?? 0)")
    }
    
    // MARK: 5.3、去掉小数点后多余的 0
    /// 去掉小数点后多余的0
    @objc func test52() {
        let testStrinig1 = "1.3400"
        let testStrinig2 = "1.00"
        let testStrinig3 = "1.20"
        let testStrinig4 = "1.020"
        let testStrinig5 = "1.0010"
        JKPrint("去掉小数点后多余的 0：\n\(testStrinig1) -> \(testStrinig1.cutLastZeroAfterDot())", "\(testStrinig2) -> \(testStrinig2.cutLastZeroAfterDot())", "\(testStrinig3) -> \(testStrinig3.cutLastZeroAfterDot())", "\(testStrinig4) -> \(testStrinig4.cutLastZeroAfterDot())", "\(testStrinig5) -> \(testStrinig5.cutLastZeroAfterDot())")
    }
    
    // MARK: 5.4、将数字的字符串处理成  几位 位小数的情况
    /// 将数字的字符串处理成  几位 位小数的情况
    @objc func test53() {
        let testStrinig1 = "6.123456789"
        JKPrint("保留 1 位小数 \(testStrinig1.saveNumberDecimal(numberDecimal: 1))", "保留 2 位小数 \(testStrinig1.saveNumberDecimal(numberDecimal: 2))", "保留 3 位小数 \(testStrinig1.saveNumberDecimal(numberDecimal: 3))", "保留 4 位小数 \(testStrinig1.saveNumberDecimal(numberDecimal: 4))", "保留 5 位小数 \(testStrinig1.saveNumberDecimal(numberDecimal: 5))")
    }
}

// MARK:- 五、字符串有关数字方面的扩展
extension StringExtensionViewController {
    // MARK: 加
    @objc func test60() {
        let num1 = "1.21"
        let num2 = "1.35"
        JKPrint("\(num1) + \(num2) = \(num1.adding(num2))")
    }
    
    // MARK: 减
    @objc func test61() {
       let num1 = "1.21"
       let num2 = "1.35"
       JKPrint("\(num1) - \(num2) = \(num1.subtracting(num2))")
    }
    
    // MARK: 乘
    @objc func test62() {
       let num1 = "1.21"
       let num2 = "1.35"
       JKPrint("\(num1) * \(num2) = \(num1.multiplying(num2))")
    }
    
    // MARK: 除
    @objc func test63() {
       let num1 = "1.21"
       let num2 = "1.35"
       JKPrint("\(num1) / \(num2) = \(num1.dividing(num2))")
    }
    
}

// MARK:- 七、字符串包含表情的处理
extension StringExtensionViewController {
    
    // MARK: 7.1、检查字符串是否包含 Emoji 表情
    @objc func test70() {
        let testString = "我是一只小小鸟😝"
        JKPrint("第1种方式：\(testString.containsEmoji())", "第2种方式：\(testString.includesEmoji())")
    }
    
    // MARK: 7.2、去除字符串中的Emoji表情
    @objc func test71() {
        let testString = "我是一只小小鸟😝"
        JKPrint("去除字符串中的Emoji表情, 如：\(testString) 去除后为：\(testString.deleteEmoji())")
    }
}

// MARK:- 八、字符串的一些正则校验
extension StringExtensionViewController {
    
    // MARK: 8.1、判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    /// 判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    @objc func test80() {
        let testString = " \n \n"
        JKPrint("\(testString.isBlank)")
    }
    
    // MARK: 8.2、判断是否全十进制数字，长度为0返回false
    /// 判断是否全十进制数字，长度为0返回false
    @objc func test81() {
        let testString = "f"
        JKPrint("\(testString.isDecimalDigits)")
    }
    
    // MARK: 8.3、判断是否是整数
    /// 判断是否是整数
    @objc func test82() {
        let testString1 = "32"
        let testString2 = "e"
        let testString3 = "1.0"
        JKPrint("判断 \(testString1) 是否是整数：\(testString1.isPureInt)", "判断 \(testString1) 是否是整数：\(testString2.isPureInt)", "判断 \(testString1) 是否是整数：\(testString3.isPureInt)")
    }
    
    // MARK: 8.4、判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    /// 判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    @objc func test83() {
        let testString1 = "32"
        let testString2 = "e"
        let testString3 = "1.0"
        JKPrint("判断是否是Float,此处Float是包含Int的，即Int是特殊的Float", "判断 \(testString1) 是否是Float：\(testString1.isPureFloat)", "判断 \(testString2) 是否是Float：\(testString2.isPureFloat)", "判断 \(testString3) 是否是Float：\(testString3.isPureFloat)")
    }
    
    // MARK: 8.5、判断是否全是字母，长度为0返回false
    /// 判断是否全是字母，长度为0返回false
    @objc func test84() {
        let testString1 = "34fgt"
        let testString2 = "e"
        let testString3 = "ABC"
        JKPrint("判断是否全是字母，长度为0返回false，即Int是特殊的Float", "判断 \(testString1) 是否全是字母：\(testString1.isLetters)", "判断 \(testString2) 是否全是字母：\(testString2.isLetters)", "判断 \(testString3) 是否全是字母：\(testString3.isLetters)")
    }
    
    // MARK: 8.6、判断是否是中文, 这里的中文不包括数字及标点符号
    /// 判断是否是中文, 这里的中文不包括数字及标点符号
    @objc func test85() {
        let testString1 = "我爱中国"
        let testString2 = "e"
        let testString3 = "I am a boy"
        JKPrint("判断是否是中文, 这里的中文不包括数字及标点符号", "判断 \(testString1) 是否是中文：\(testString1.isChinese)", "判断 \(testString2) 是否是中文：\(testString2.isChinese)", "判断 \(testString3) 是否是中文：\(testString3.isChinese)")
    }
    
    // MARK: 8.7、是否是有效昵称，即允许“中文”、“英文”、“数字”
    /// 是否是有效昵称，即允许“中文”、“英文”、“数字”
    @objc func test86() {
        let testString1 = "我爱中国--"
        let testString2 = "12"
        let testString3 = "Iloveyou"
        let testString4 = "I love you"
        JKPrint("是否是有效昵称，即允许 中文 、 英文 、 数字 ", "判断 \(testString1) 是否是有效昵称：\(testString1.isValidNickName)", "判断 \(testString2) 是否是有效昵称：\(testString2.isValidNickName)", "判断 \(testString3) 是否是有效昵称：\(testString3.isValidNickName)", "判断 \(testString4) 是否是有效昵称：\(testString4.isValidNickName)")
    }
    
    // MARK: 8.8、判断是否是有效的手机号码
    /// 判断是否是有效的手机号码
    @objc func test87() {
        let testString1 = "123"
        let testString2 = "18500652880"
        let testString3 = "87689022"
        let testString4 = "12345678912"
        JKPrint("判断是否是有效的手机号码", "判断 \(testString1) 是否是有效的手机号码：\(testString1.isValidMobile)", "判断 \(testString2) 是否是有效的手机号码：\(testString2.isValidMobile)", "判断 \(testString3) 是否是有效的手机号码：\(testString3.isValidMobile)", "判断 \(testString4) 是否是有效的手机号码：\(testString4.isValidMobile)")
    }
    
    // MARK: 8.9、判断是否是有效的电子邮件地址
    /// 判断是否是有效的电子邮件地址
    @objc func test88() {
        let testString1 = "123"
        let testString2 = "jkironman@163.com"
        let testString3 = "29388387@163.com"
        let testString4 = "chongwang"
        JKPrint("判断是否是有效的电子邮件地址", "判断 \(testString1) 是否是有效的电子邮件地址：\(testString1.isValidEmail)", "判断 \(testString2) 是否是有效的电子邮件地址：\(testString2.isValidEmail)", "判断 \(testString3) 是否是有效的电子邮件地址：\(testString3.isValidEmail)", "判断 \(testString4) 是否是有效的电子邮件地址：\(testString4.isValidEmail)")
    }
    
    // MARK: 8.10、判断是否有效的身份证号码，不是太严格
    /// 判断是否有效的身份证号码，不是太严格
    @objc func test89() {
        let testString1 = "411423199202026036"
        let testString2 = "411423199"
        let testString3 = "411423199993993j"
        let testString4 = "18500652880"
        JKPrint("判断是否有效的身份证号码，不是太严格", "判断 \(testString1) 是否是有效的身份证号码：\(testString1.isValidIDCardNumber)", "判断 \(testString2) 是否是有效的身份证号码：\(testString2.isValidIDCardNumber)", "判断 \(testString3) 是否是有效的身份证号码：\(testString3.isValidIDCardNumber)", "判断 \(testString4) 是否是有效的身份证号码：\(testString4.isValidIDCardNumber)")
    }
    
    // MARK: 8.11、严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    /// 严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    @objc func test810() {
        let testString1 = "411423199202026036"
        let testString2 = "411423199"
        let testString3 = "411423199993993j"
        let testString4 = "18500652880"
        JKPrint("严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码", "严格判断 \(testString1) 是否是有效的身份证号码：\(testString1.isValidIDCardNumStrict)", "严格判断 \(testString2) 是否是有效的身份证号码：\(testString2.isValidIDCardNumStrict)", "严格判断 \(testString3) 是否是有效的身份证号码：\(testString3.isValidIDCardNumStrict)", "严格判断 \(testString4) 是否是有效的身份证号码：\(testString4.isValidIDCardNumStrict)")
    }
    
    // MARK: 8.12、校验字符串位置是否合理，并返回String.Index
    /// 校验字符串位置是否合理，并返回String.Index
    @objc func test811() {
        let testString1 = "4114231she02026036"
        let testString2 = "he"
        let testString3 = "h5677ha"
        let testString4 = "18500652m880"
        JKPrint("校验字符串位置是否合理，并返回String.Index", "校验 \(testString1) 是否合理：\(testString1.validIndex(original: 7))", "校验 \(testString2) 是否合理：\(testString2.validIndex(original: 2))", "校验 \(testString3) 是否合理：\(testString3.validIndex(original: 0))", "校验 \(testString4) 是否合理：\(testString4.validIndex(original: 2))")
    }
}

// MARK:- 九、字符串截取的操作
extension StringExtensionViewController {
    // MARK:- 9.1、截取字符串从开始到 index
    ///  截取字符串从开始到 index
    @objc func test90() {
        let testString1 = "0123456789"
        JKPrint("字符串截取的操作x", "\(testString1) 从开头截取到index=4 后为：\(testString1.sub(to: 4))")
    }
    
    // MARK:- 9.2、截取字符串从index到结束
    ///  截取字符串从index到结束
    @objc func test91() {
        let testString1 = "0123456789"
        JKPrint("截取字符串从index到结束", "\(testString1) 截取字符串从index=4到结束后为：\(testString1.sub(from: 4))")
    }
    
    // MARK:- 9.3、获取指定位置和长度的字符串
    ///  获取指定位置和长度的字符串
    @objc func test92() {
        let testString1 = "0123456789"
        JKPrint("获取指定位置和长度的字符串", "\(testString1) 截取字符串从index=2到长度为2后为：\(testString1.sub(start: 2, length: 2))")
    }
    
    // MARK:- 9.4、切割字符串(区间范围 前闭后开)
    ///  切割字符串(区间范围 前闭后开)
    @objc func test93() {
        let testString1 = "0123456789"
        JKPrint("切割字符串(区间范围 前闭后开)", "\(testString1) 截取字符串 2..<4 后为：\(testString1.slice(2..<4))")
    }
    
    // MARK: 9.5、用整数返回子字符串开始的位置
    ///  截取字符串从index到结束
    @objc func test94() {
        let testString1 = "0123456789"
        JKPrint("用整数返回子字符串开始的位置", "\(testString1) 中字符串 position 开始的位置是：\(testString1.position(of: "012"))")
    }
    
    // MARK: 9.6、获取某个位置的字符串
    @objc func test95() {
        let testString1 = "0123456789"
        let index: Int = 5
        
        JKPrint("获取某个位置的字符串", "\(testString1) 中字符串位置为：\(index) 的字符是：\(testString1.indexString(index: index))")
    }
    
}

extension StringExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return headDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let singleDataArray = dataArray[section] as! [String]
        return singleDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StringExtensionViewController.StringExtensionViewControllerCellIdentifier, for: indexPath) as! HomeViewCell
        let singleDataArray = dataArray[indexPath.section] as! [String]
        cell.contentLabel.text = "\(indexPath.row + 1)：\((singleDataArray[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let str = headDataArray[section] as! String
        let size = str.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: kScreenW - 20, height: CGFloat(MAXFLOAT)))
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height:size.height + 20))
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: kScreenW - 20, height: size.height))
        label.text = str
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        sectionView.addSubview(label)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let str = headDataArray[section] as! String
        let size = str.rectSize(font: UIFont.systemFont(ofSize: 18), size: CGSize(width: kScreenW - 20, height: CGFloat(MAXFLOAT)))
        return size.height + 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFootView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.01))
        return sectionFootView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectorName = "test\(indexPath.section)\(indexPath.row)"
        let selector = Selector("\(selectorName)")
        guard self.responds(to: selector) else {
            JKPrint("没有该方法：\(selector)")
            return
        }
        perform(selector)
    }
}

