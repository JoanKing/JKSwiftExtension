//
//  StringExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CommonCrypto

class StringExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、字符串基本的扩展", "二、沙盒路径的获取", "三、iOS CharacterSet（字符集）", "四、字符串的转换", "五、字符串UI的处理", "六、字符串有关数字方面的扩展", "七、苹果针对浮点类型计算精度问题提供出来的计算类", "八、字符串包含表情的处理", "九、字符串的一些正则校验", "十、字符串截取的操作", "十一、字符串编码的处理", "十二、进制之间的转换", "十三、String -> NSMutableAttributedString", "十四、MD5 加密 和 Base64 编解码", "十五、AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密", "十六、SHA1, SHA224, SHA256, SHA384, SHA512", "十七、unicode编码和解码"]
        dataArray = [["字符串的长度", "判断是否包含某个子串", "判断是否包含某个子串 -- 忽略大小写", "字符串 Base64 编码", "字符串 Base64 解码", "将16进制字符串转为Int", "判断是不是九宫格键盘", "字符串转 UIViewController", "字符串转 AnyClass", "字符串转数组", "JSON 字符串 -> Dictionary", "JSON 字符串 -> Array", "转成拼音", "提取首字母：爱国->AG", "字符串根据某个字符进行分隔成数组", "设备的UUID", "复制"], ["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"],["去除字符串前后的 空格", "去除字符串前后的 换行", "去除字符串前后的 换行和换行", "去掉所有 空格", "去掉所有 换行", "去掉所有空格 和 换行", "是否是 0-9的数字，也不包含小数点", "url进行编码", "url进行解码", "某个字符使用某个字符替换掉", "使用正则表达式替换某些子串", "删除指定的字符"], ["字符串 转 CGFloat", "字符串转bool", "字符串转 Int", "字符串转 Double", "字符串转 Float", "字符串转 Bool", "字符串转 NSString", "字符串转 Int64", "字符串转 NSNumber"], ["对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)", "对字符串(多行)指定字体及Size，获取 (高度)", "对字符串(多行)指定字体及Size，获取 (宽度)", "对字符串(单行)指定字体，获取 (Size)", "对字符串(单行)指定字体，获取 (width)", "对字符串(单行)指定字体，获取 (Height)", "字符串通过 label 根据高度&字体—>Size", "字符串通过 label 根据高度&字体—>Width", "字符串通过 label 根据宽度&字体—>height", "字符串根据宽度 & 字体&行间距->Size", "字符串根据宽度 & 字体 & 行间距->width", "字符串根据宽度&字体&行间距->height"], ["将金额字符串转化为带逗号的金额 按照千分位划分，如 1234567 => 1,234,567", "字符串差不多精确转换成Double——之所以差不多，是因为有精度损失", "去掉小数点后多余的 0", "将数字的字符串处理成  几位 位小数的情况"], ["+", "-", "*", "/"], ["检查字符串是否包含 Emoji 表情", "去除字符串中的Emoji表情"], ["判断是否全是空白,包括空白字符和换行符号，长度为0返回true", "判断是否全十进制数字，长度为0返回false", "判断是否是整数", "判断是否是Float,此处Float是包含Int的，即Int是特殊的Float", "判断是否全是字母，长度为0返回false", "判断是否是中文, 这里的中文不包括数字及标点符号", "是否是有效昵称，即允许“中文”、“英文”、“数字”", "判断是否是有效的手机号码", "判断是否是有效的电子邮件地址", "判断是否有效的身份证号码，不是太严格", "严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码", "校验字符串位置是否合理，并返回String.Index", "隐藏手机号中间的几位", "检查字符串是否有特定前缀", "检查字符串是否有特定后缀"], ["截取字符串从开始到 index", "截取字符串从index到结束", "获取指定位置和长度的字符串", "切割字符串(区间范围 前闭后开)", "用整数返回子字符串开始的位置", "获取某个位置的字符串"], [""], ["二进制 -> 八进制", "二进制 -> 十进制", "二进制 -> 十六进制", "八进制 -> 二进制", "八进制 -> 十进制", "八进制 -> 十六进制", "十进制 -> 二进制", "十进制 -> 八进制", "十进制 -> 十六进制", "十六进制 -> 二进制", "十六进制 -> 八进制", "十六进制 -> 十进制"], ["String 添加颜色后转 NSMutableAttributedString", "String 添加 font 后转 NSMutableAttributedString", "String 添加 font 后转 NSMutableAttributedString", "String 添加 text 后转 NSMutableAttributedString", "String 添加 删除线 后转 NSMutableAttributedString"], ["MD5加密 默认是32位小写加密", "Base64 编解码"], ["字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密"], ["SHA1, SHA224, SHA256, SHA384, SHA512 加密"], ["unicode编码", "unicode解码"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 十七、unicode编码和解码
extension StringExtensionViewController {
    
    // MARK: 17.2、unicode解码
    @objc func test172() {
        let str = "我是一只小小鸟"
        let newString = str.jk.unicodeEncode()
        JKPrint("unicode编码", "原始字符串：\(str)", "unicode编码后的字符串为：\(newString)", "unicode解码后的字符串为：\(newString.jk.unicodeDecode())")
    }
    
    // MARK: 17.1、unicode编码
    @objc func test171() {
        let str = "我是一只小小鸟"
        let newString = str.jk.unicodeEncode()
        JKPrint("unicode编码", "原始字符串：\(str)", "unicode编码后的字符串为：\(newString)")
    }
}

// MARK:- 十六、SHA1, SHA224, SHA256, SHA384, SHA512
extension StringExtensionViewController {
    
    // MARK: 16.1、SHA1, SHA224, SHA256, SHA384, SHA512 加密
    @objc func test161() {
        let str = "我是一只小小鸟"
        let key = "123456"
        let newString = str.jk.shaCrypt(cryptType: .SHA1, key: key, lower: true) ?? "加密失败"
        print("原始字符串：\(str)")
        print("key：\(key)")
        print("加密后的字符串：\(newString)")
    }
}
// MARK:- 十五、AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
extension StringExtensionViewController {
    
    // MARK: 15.1、字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
    @objc func test151() {
        let str = "welcome to hangge.com"
        let key = "123456"
        let newString = str.jk.scaCrypt(cryptType: .DES, key: key, encode: true) ?? "加密失败"
        print("原始字符串：\(str)")
        print("key：\(key)")
        print("加密后的字符串：\(newString.jk.scaCrypt(cryptType: .DES, key: key, encode: false) ?? "加密失败")")
    }
    
}
// MARK:- 十四、MD5 加密 和 Base64 编解码
extension StringExtensionViewController {
    
    // MARK: 14.2、Base64 编解码
    @objc func test142() {
        let oldString = "123456"
        let newString = oldString.jk.base64String(encode: true) ?? "转码失败"
        let newString2 = newString.jk.base64String(encode: false) ?? "解码失败"
        JKPrint("原始字符串：\(oldString)", "\(oldString) 编码后的字符串：\(newString)", "\(newString) 解码后为：\(newString2)", "最后：\(oldString.jk.base64Encode!)")
    }
    
    // MARK: 14.1、MD5加密 默认是32位小写加密
    @objc func test141() {
        print("32 位小写：\("123456".jk.md5Encrypt())")
        print("32 位大写：\("123456".jk.md5Encrypt(.uppercase32))")
        print("16 位小写：\("123456".jk.md5Encrypt(.lowercase16))")
        print("16 位大写：\("123456".jk.md5Encrypt(.uppercase16))")
        /*
        32 位小写：e10adc3949ba59abbe56e057f20f883e
        32 位大写：E10ADC3949BA59ABBE56E057F20F883E
        16 位小写：49ba59abbe56e057
        16 位大写：49BA59ABBE56E057
        */
    }
}

// MARK:- 十三、String -> NSMutableAttributedString
extension StringExtensionViewController {
    
    // MARK: 13.1、String 添加颜色后转 NSMutableAttributedString
    @objc func test131() {
        
        let attributedString = "2秒后消失".jk.color(UIColor.red)
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 13.2、String 添加 font 后转 NSMutableAttributedString
    @objc func test132() {
        
        let attributedString = "2秒后消失".jk.font(30)
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 13.3、String 添加 UIFont 后转 NSMutableAttributedString
    @objc func test133() {
        let attributedString = "2秒后消失".jk.font(UIFont.systemFont(ofSize: 28))
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 13.4、String 添加 text 后转 NSMutableAttributedString
    @objc func test134() {
        let attributedString = "2秒后消失".jk.text()
        
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JKAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 13.5、String 添加 删除线 后转 NSMutableAttributedString
    @objc func test135() {
        let attributedString = "2秒后消失".jk.strikethrough()
        
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

// MARK:- 十二、进制之间的转换
extension StringExtensionViewController {
    // MARK: 12.1、二进制 -> 八进制
    @objc func test121() {
        let number = "1010"
        JKPrint("二进制 转 八进制", "二进制：\(number) 转 八进制 为：\(number.jk.binaryToOctal())")
    }
    
    // MARK: 12.2、二进制 -> 十进制
    @objc func test122() {
        let number = "1010"
        JKPrint("二进制 转 十进制", "二进制：\(number) 转 十进制 为：\(number.jk.binaryTodecimal())")
    }
    
    // MARK: 12.3、二进制 -> 十六进制
    @objc func test123() {
        let number = "1010"
        JKPrint("二进制 转 十六进制", "二进制：\(number) 转 十六进制 为：\(number.jk.binaryToHexadecimal())")
    }
    
    // MARK: 12.4、八进制 -> 二进制
    @objc func test124() {
        let number = "12"
        JKPrint("八进制 -> 二进制", "八进制：\(number) 转 二进制 为：\(number.jk.octalTobinary())")
    }
    
    // MARK: 12.5、八进制 -> 十进制
    @objc func test125() {
        let number = "12"
        JKPrint("八进制 -> 十进制", "八进制：\(number) 转 十进制 为：\(number.jk.octalTodecimal())")
    }
    
    // MARK: 12.6、八进制 -> 十六进制
    @objc func test126() {
        let number = "12"
        JKPrint("八进制 -> 十六进制", "八进制：\(number) 转 十六进制 为：\(number.jk.octalToHexadecimal())")
    }
    
    // MARK: 12.7、十进制 -> 二进制
    @objc func test127() {
        let number = "10"
        JKPrint("十进制 转 二进制", "十进制：\(number) 转 二进制 为：\(number.jk.decimalToBinary())")
    }
    
    // MARK: 12.8、十进制 -> 八进制
    @objc func test128() {
        let number = "10"
        JKPrint("十进制转 八进制", "十进制：\(number) 转 八进制 为：\(number.jk.decimalToOctal())")
    }
    
    // MARK: 12.9、十进制 -> 十六进制
    @objc func test129() {
        let number = "10"
        JKPrint("十进制转 十六进制", "十进制：\(number) 转 十六进制 为：\(number.jk.decimalToHexadecimal())")
    }
    
    // MARK: 12.10、十六进制 -> 二进制
    @objc func test1210() {
        let number = "a"
        JKPrint("十六进制 转 二进制", "十六进制：\(number) 转 二进制 为：\(number.jk.hexadecimalToBinary())")
    }
    
    // MARK: 12.11、十六进制 -> 八进制
    @objc func test1211() {
        let number = "a"
        JKPrint("十六进制 转 八进制", "十六进制：\(number) 转 八进制 为：\(number.jk.hexadecimalToOctal())")
    }
    
    // MARK: 12.12、十六进制 -> 十进制
    @objc func test1212() {
        let number = "a"
        JKPrint("十六进制 转 十进制", "十六进制：\(number) 转 十进制 为：\(number.jk.hexadecimalToDecimal())")
    }
}

// MARK:- 十一、字符串编码的处理
extension StringExtensionViewController {
    // MARK: 11.1、
    @objc func test100() {
        
    }
}

// MARK:- 十、字符串截取的操作
extension StringExtensionViewController {
    // MARK: 10.1、截取字符串从开始到 index
    ///  截取字符串从开始到 index
    @objc func test101() {
        let testString1 = "0123456789"
        JKPrint("字符串截取的操作x", "\(testString1) 从开头截取到index=4 后为：\(testString1.jk.sub(to: 4))")
    }
    
    // MARK: 10.2、截取字符串从index到结束
    ///  截取字符串从index到结束
    @objc func test102() {
        let testString1 = "0123456789"
        JKPrint("截取字符串从index到结束", "\(testString1) 截取字符串从index=4到结束后为：\(testString1.jk.sub(from: 4))")
    }
    
    // MARK: 10.3、获取指定位置和长度的字符串
    ///  获取指定位置和长度的字符串
    @objc func test103() {
        let testString1 = "0123456789"
        JKPrint("获取指定位置和长度的字符串", "\(testString1) 截取字符串从index=2到长度为2后为：\(testString1.jk.sub(start: 2, length: 2))")
    }
    
    // MARK: 10.4、切割字符串(区间范围 前闭后开)
    ///  切割字符串(区间范围 前闭后开)
    @objc func test104() {
        let testString1 = "0123456789"
        JKPrint("切割字符串(区间范围 前闭后开)", "\(testString1) 截取字符串 2..<4 后为：\(testString1.jk.slice(2..<4))")
    }
    
    // MARK: 10.5、用整数返回子字符串开始的位置
    ///  截取字符串从index到结束
    @objc func test105() {
        let testString1 = "0123456789"
        JKPrint("用整数返回子字符串开始的位置", "\(testString1) 中字符串 position 开始的位置是：\(testString1.jk.position(of: "012"))")
    }
    
    // MARK: 10.6、获取某个位置的字符串
    @objc func test106() {
        let testString1 = "0123456789"
        let index: Int = 5
        
        JKPrint("获取某个位置的字符串", "\(testString1) 中字符串位置为：\(index) 的字符是：\(testString1.jk.indexString(index: index))")
    }
}

// MARK:- 九、字符串的一些正则校验
extension StringExtensionViewController {
    
    // MARK: 9.1、判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    /// 判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    @objc func test91() {
        let testString = " \n \n"
        JKPrint("\(testString.jk.isBlank)")
    }
    
    // MARK: 9.2、判断是否全十进制数字，长度为0返回false
    /// 判断是否全十进制数字，长度为0返回false
    @objc func test92() {
        let testString = "f"
        JKPrint("\(testString.jk.isDecimalDigits)")
    }
    
    // MARK: 9.3、判断是否是整数
    /// 判断是否是整数
    @objc func test93() {
        let testString1 = "32"
        let testString2 = "e"
        let testString3 = "1.0"
        JKPrint("判断 \(testString1) 是否是整数：\(testString1.jk.isPureInt)", "判断 \(testString1) 是否是整数：\(testString2.jk.isPureInt)", "判断 \(testString1) 是否是整数：\(testString3.jk.isPureInt)")
    }
    
    // MARK: 9.4、判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    /// 判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    @objc func test94() {
        let testString1 = "32"
        let testString2 = "e"
        let testString3 = "1.0"
        JKPrint("判断是否是Float,此处Float是包含Int的，即Int是特殊的Float", "判断 \(testString1) 是否是Float：\(testString1.jk.isPureFloat)", "判断 \(testString2) 是否是Float：\(testString2.jk.isPureFloat)", "判断 \(testString3) 是否是Float：\(testString3.jk.isPureFloat)")
    }
    
    // MARK: 9.5、判断是否全是字母，长度为0返回false
    /// 判断是否全是字母，长度为0返回false
    @objc func test95() {
        let testString1 = "34fgt"
        let testString2 = "e"
        let testString3 = "ABC"
        JKPrint("判断是否全是字母，长度为0返回false，即Int是特殊的Float", "判断 \(testString1) 是否全是字母：\(testString1.jk.isLetters)", "判断 \(testString2) 是否全是字母：\(testString2.jk.isLetters)", "判断 \(testString3) 是否全是字母：\(testString3.jk.isLetters)")
    }
    
    // MARK: 9.6、判断是否是中文, 这里的中文不包括数字及标点符号
    /// 判断是否是中文, 这里的中文不包括数字及标点符号
    @objc func test96() {
        let testString1 = "我爱中国"
        let testString2 = "e"
        let testString3 = "I am a boy"
        JKPrint("判断是否是中文, 这里的中文不包括数字及标点符号", "判断 \(testString1) 是否是中文：\(testString1.jk.isChinese)", "判断 \(testString2) 是否是中文：\(testString2.jk.isChinese)", "判断 \(testString3) 是否是中文：\(testString3.jk.isChinese)")
    }
    
    // MARK: 9.7、是否是有效昵称，即允许“中文”、“英文”、“数字”
    /// 是否是有效昵称，即允许“中文”、“英文”、“数字”
    @objc func test97() {
        let testString1 = "我爱中国--"
        let testString2 = "12"
        let testString3 = "Iloveyou"
        let testString4 = "I love you"
        JKPrint("是否是有效昵称，即允许 中文 、 英文 、 数字 ", "判断 \(testString1) 是否是有效昵称：\(testString1.jk.isValidNickName)", "判断 \(testString2) 是否是有效昵称：\(testString2.jk.isValidNickName)", "判断 \(testString3) 是否是有效昵称：\(testString3.jk.isValidNickName)", "判断 \(testString4) 是否是有效昵称：\(testString4.jk.isValidNickName)")
    }
    
    // MARK: 9.8、判断是否是有效的手机号码
    /// 判断是否是有效的手机号码
    @objc func test98() {
        let testString1 = "123"
        let testString2 = "18500652880"
        let testString3 = "87689022"
        let testString4 = "12345678912"
        JKPrint("判断是否是有效的手机号码", "判断 \(testString1) 是否是有效的手机号码：\(testString1.jk.isValidMobile)", "判断 \(testString2) 是否是有效的手机号码：\(testString2.jk.isValidMobile)", "判断 \(testString3) 是否是有效的手机号码：\(testString3.jk.isValidMobile)", "判断 \(testString4) 是否是有效的手机号码：\(testString4.jk.isValidMobile)")
    }
    
    // MARK: 9.9、判断是否是有效的电子邮件地址
    /// 判断是否是有效的电子邮件地址
    @objc func test99() {
        let testString1 = "123"
        let testString2 = "jkironman@163.com"
        let testString3 = "29388387@163.com"
        let testString4 = "chongwang"
        JKPrint("判断是否是有效的电子邮件地址", "判断 \(testString1) 是否是有效的电子邮件地址：\(testString1.jk.isValidEmail)", "判断 \(testString2) 是否是有效的电子邮件地址：\(testString2.jk.isValidEmail)", "判断 \(testString3) 是否是有效的电子邮件地址：\(testString3.jk.isValidEmail)", "判断 \(testString4) 是否是有效的电子邮件地址：\(testString4.jk.isValidEmail)")
    }
    
    // MARK: 9.10、判断是否有效的身份证号码，不是太严格
    /// 判断是否有效的身份证号码，不是太严格
    @objc func test910() {
        let testString1 = "411423199202026036"
        let testString2 = "411423199"
        let testString3 = "411423199993993j"
        let testString4 = "18500652880"
        JKPrint("判断是否有效的身份证号码，不是太严格", "判断 \(testString1) 是否是有效的身份证号码：\(testString1.jk.isValidIDCardNumber)", "判断 \(testString2) 是否是有效的身份证号码：\(testString2.jk.isValidIDCardNumber)", "判断 \(testString3) 是否是有效的身份证号码：\(testString3.jk.isValidIDCardNumber)", "判断 \(testString4) 是否是有效的身份证号码：\(testString4.jk.isValidIDCardNumber)")
    }
    
    // MARK: 9.11、严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    /// 严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    @objc func test911() {
        let testString1 = "411423199202026036"
        let testString2 = "411423199"
        let testString3 = "411423199993993j"
        let testString4 = "18500652880"
        JKPrint("严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码", "严格判断 \(testString1) 是否是有效的身份证号码：\(testString1.jk.isValidIDCardNumStrict)", "严格判断 \(testString2) 是否是有效的身份证号码：\(testString2.jk.isValidIDCardNumStrict)", "严格判断 \(testString3) 是否是有效的身份证号码：\(testString3.jk.isValidIDCardNumStrict)", "严格判断 \(testString4) 是否是有效的身份证号码：\(testString4.jk.isValidIDCardNumStrict)")
    }
    
    // MARK: 9.12、校验字符串位置是否合理，并返回String.Index
    /// 校验字符串位置是否合理，并返回String.Index
    @objc func test912() {
        let testString1 = "4114231she02026036"
        let testString2 = "he"
        let testString3 = "h5677ha"
        let testString4 = "18500652m880"
        JKPrint("校验字符串位置是否合理，并返回String.Index", "校验 \(testString1) 是否合理：\(testString1.jk.validIndex(original: 7))", "校验 \(testString2) 是否合理：\(testString2.jk.validIndex(original: 2))", "校验 \(testString3) 是否合理：\(testString3.jk.validIndex(original: 0))", "校验 \(testString4) 是否合理：\(testString4.jk.validIndex(original: 2))")
    }
    
    // MARK: 9.13、隐藏手机号中间的几位
    @objc func test913() {
        let phoneNumber = "18500652880"
        JKPrint("隐藏手机号中间的几位", "手机号：\(phoneNumber) 隐藏后为：\(phoneNumber.jk.hidePhone(combine: "xxxx"))")
    }
    
    // MARK: 9.14、检查字符串是否有特定前缀：hasPrefix
    @objc func test914() {
        let testString = "com.ironman"
        JKPrint("检查字符串是否有特定前缀：hasPrefix", "\(testString) 是否有 com 前缀：\(testString.jk.isHasPrefix(prefix: "com"))", "\(testString) 是否有 cm 前缀：\(testString.jk.isHasPrefix(prefix: "cm"))")
    }
    
    // MARK: 9.15、检查字符串是否有特定后缀：hasPrefix
    @objc func test915() {
        let testString = "ironman.cn"
        JKPrint("检查字符串是否有特定前缀：hasPrefix", "\(testString) 是否有 cn 后缀：\(testString.jk.isHasSuffix(suffix: "cn"))", "\(testString) 是否有 con 后缀：\(testString.jk.isHasSuffix(suffix: "con"))")
    }
}

// MARK:- 八、字符串包含表情的处理
extension StringExtensionViewController {
    
    // MARK: 8.1、检查字符串是否包含 Emoji 表情
    @objc func test81() {
        let testString = "我是一只小小鸟😝"
        JKPrint("第1种方式：\(testString.jk.containsEmoji())", "第2种方式：\(testString.jk.includesEmoji())")
    }
    
    // MARK: 8.2、去除字符串中的Emoji表情
    @objc func test82() {
        let testString = "我是一只小小鸟😝"
        JKPrint("去除字符串中的Emoji表情, 如：\(testString) 去除后为：\(testString.jk.deleteEmoji())")
    }
}

// MARK:- 七、苹果针对浮点类型计算精度问题提供出来的计算类
extension StringExtensionViewController {
    // MARK: 7.1、加
    @objc func test71() {
        let num1 = "1.21"
        let num2 = "1.35"
        JKPrint("\(num1) + \(num2) = \(num1.jk.adding(num2))")
    }
    
    // MARK: 7.2、减
    @objc func test72() {
       let num1 = "1.21"
       let num2 = "1.35"
        JKPrint("\(num1) - \(num2) = \(num1.jk.subtracting(num2))")
    }
    
    // MARK: 7.3、乘
    @objc func test73() {
       let num1 = "1.21"
       let num2 = "1.35"
        JKPrint("\(num1) * \(num2) = \(num1.jk.multiplying(num2))")
    }
    
    // MARK: 7.4、除
    @objc func test74() {
       let num1 = "1.21"
       let num2 = "1.35"
        JKPrint("\(num1) / \(num2) = \(num1.jk.dividing(num2))")
    }
}

// MARK:- 六、字符串有关数字方面的扩展
extension StringExtensionViewController {
    // MARK: 6.1、将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// 将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    @objc func test61() {
        JKPrint(" 将金额字符串转化为带逗号的金额 按照千分位划分，如1234567 转化后为：\("1234567".jk.toThousands() ?? "无效")")
    }
    
    // MARK: 6.2、字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    /// 字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    @objc func test62() {
        let testStrinig = "1.3403"
        JKPrint("字符串差不多精确转换成Double——之所以差不多，是因为有精度损失：\(testStrinig.jk.accuraterDouble() ?? 0)")
    }
    
    // MARK: 6.3、去掉小数点后多余的 0
    /// 去掉小数点后多余的0
    @objc func test63() {
        let testStrinig1 = "1.3400"
        let testStrinig2 = "1.00"
        let testStrinig3 = "1.20"
        let testStrinig4 = "1.020"
        let testStrinig5 = "1.0010"
        JKPrint("去掉小数点后多余的 0：\n\(testStrinig1) -> \(testStrinig1.jk.cutLastZeroAfterDot())", "\(testStrinig2) -> \(testStrinig2.jk.cutLastZeroAfterDot())", "\(testStrinig3) -> \(testStrinig3.jk.cutLastZeroAfterDot())", "\(testStrinig4) -> \(testStrinig4.jk.cutLastZeroAfterDot())", "\(testStrinig5) -> \(testStrinig5.jk.cutLastZeroAfterDot())")
    }
    
    // MARK: 6.4、将数字的字符串处理成  几位 位小数的情况
    /// 将数字的字符串处理成  几位 位小数的情况
    @objc func test64() {
        let testStrinig1 = "6.123456789"
        JKPrint("保留 1 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 1))", "保留 2 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 2))", "保留 3 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 3))", "保留 4 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 4))", "保留 5 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 5))")
    }
}

// MARK:- 五、字符串UI的处理
extension StringExtensionViewController {
    // MARK: 5.1、对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    /// 对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    @objc func test51() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let size = testString.jk.rectSize(font: font, size: CGSize(width: 200, height: CGFloat(MAXFLOAT)))
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

    // MARK: 5.2、对字符串(多行)指定字体及Size，获取 (高度)
    /// 对字符串(多行)指定字体及Size，获取 (高度)
    @objc func test52() {
        
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let height = testString.jk.rectHeight(font: font, size: CGSize(width: 100, height: CGFloat(MAXFLOAT)))
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
    
    // MARK: 5.3、对字符串(多行)指定字体及Size，获取 (宽度)
    /// 对字符串(多行)指定字体及Size，获取 (宽度)
    @objc func test53() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let width = testString.jk.rectWidth(font: font, size: CGSize(width: 100, height: CGFloat(MAXFLOAT)))
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
    
    // MARK: 5.4、对字符串(单行)指定字体，获取 (Size)
    /// 对字符串(单行)指定字体，获取 (Size)
    @objc func test54() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let size = testString.jk.singleLineSize(font: font)
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
    
    // MARK: 5.5、对字符串(单行)指定字体，获取 (width)
    /// 对字符串(单行)指定字体，获取 (width)
    @objc func test55() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let width = testString.jk.singleLineWidth(font: font)
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
    
    // MARK: 5.6、对字符串(单行)指定字体，获取 (Height)
    /// 对字符串(单行)指定字体，获取 (Height)
    @objc func test56() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let height = testString.jk.singleLineHeight(font: font)
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
    
    // MARK: 5.7、字符串通过 label 根据高度&字体——> Size
    /// 对字符串(单行)指定字体，获取 (Height)
    @objc func test57() {
        
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let size = testString.jk.sizeAccording(width: 200, font: font)
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
    
    // MARK: 5.8、字符串通过 label 根据高度&字体 ——> Width
    @objc func test58() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let width = testString.jk.widthAccording(width: 200, font: font)
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
    
    // MARK: 5.9、字符串通过 label 根据宽度&字体 ——> height
    @objc func test59() {
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        
        let height = testString.jk.heightAccording(width: 200, font: font)
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
    
    // MARK: 5.10、字符串根据宽度 & 字体 & 行间距 —> Size
    /// 字符串根据宽度 & 字体 & 行间距 —> Size
    @objc func test510() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        let lineSpacing: CGFloat = 20
        
        let size = testString.jk.sizeAccording(width: 200, font: font, lineSpacing: lineSpacing)
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
    
    // MARK: 5.11、字符串根据宽度 & 字体 & 行间距 —> width
    /// 字符串根据宽度 & 字体 & 行间距 —> width
    @objc func test511() {

        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        let size = CGSize(width: 300, height: CGFloat(MAXFLOAT))
        let lineSpacing: CGFloat = 20
        let width = testString.jk.widthAccording(width: size.width, font: font, lineSpacing: 20)
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
    
    // MARK: 5.12、字符串根据宽度 & 字体 & 行间距 —> height
      /// 字符串根据宽度 & 字体 & 行间距 —> height
    @objc func test512() {
        
        let testString = "无论怎样，都要在生活里，学会看远，心怀鸿鹄之志;学会看细，识遍世间美丑;学会看透，保持对万物的敬畏;学会看淡，让心返璞归真;笑看生活，一生幸福快乐。"
        let font = UIFont.systemFont(ofSize: 22)
        let size = CGSize(width: 300, height: CGFloat(MAXFLOAT))
        let lineSpacing: CGFloat = 20
        
        let height = testString.jk.heightAccording(width: size.width, font: font, lineSpacing: lineSpacing)
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

// MARK:- 四、字符串的转换
extension StringExtensionViewController {
    
    // MARK: 4.1、字符串 转 CGFloat
    /// 字符串 转 CGFloat
    @objc func test41() {
        let str = "3.2"
        guard let value = str.jk.toCGFloat() else {
            return
        }
        JKPrint(value)
    }
    
    // MARK: 4.2、字符串转 bool
    /// 字符串转 bool
    @objc func test42() {
        
    }
    
    // MARK: 4.3、字符串转 Int
    /// 字符串转 Int
    @objc func test43() {
        
    }
    
    // MARK: 4.4、字符串转 Double
    /// 字符串转 Double
    @objc func test44() {
        
    }
    
    // MARK: 4.5、字符串转 Float
    /// 字符串转 Float
    @objc func test45() {
        
    }
    
    // MARK: 4.6、字符串转 Bool
    /// 字符串转 Bool
    @objc func test46() {
        
    }
    
    // MARK: 4.7、字符串转 NSString
    /// 字符串转 NSString
    @objc func test47() {
        
    }
    
    // MARK: 4.8、"字符串转 Int64"
    @objc func test48() {
        
    }
    
    // MARK: 4.9、"字符串转 NSNumber"
    @objc func test49() {
        
    }
}

// MARK:- 三、iOS CharacterSet（字符集）
extension StringExtensionViewController {
    
    // MARK: 3.1、去除字符串前后的 空格
    /// 去除字符串前后的 空格
    @objc func test31() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str) \n处理后的字符串=\(str.jk.removeBeginEndAllSapcefeed)")
    }
    
    // MARK: 3.2、去除字符串前后的 换行
    /// 去除字符串前后的 换行
    @objc func test32() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str) \n处理后的字符串=\(str.jk.removeBeginEndAllLinefeed)")
    }
    
    // MARK: 3.3、去除字符串前后的 换行和换行
    /// 去除字符串前后的 换行和换行
    @objc func test33() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.jk.removeBeginEndAllSapceAndLinefeed)")
    }
    
    // MARK: 3.4、去掉所有 空格
    /// 去掉所有 空格
    @objc func test34() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.jk.removeAllSapce)")
    }
    
    // MARK: 3.5、去掉所有 换行
    /// 去掉所有 换行
    @objc func test35() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.jk.removeAllLinefeed)")
    }
    
    // MARK: 3.6、去掉所有空格 和 换行
    /// 去掉所有空格 和 换行
    @objc func test36() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.jk.removeAllLineAndSapcefeed)")
    }
    
    // MARK: 3.7、是否是 0-9 的数字，也不包含小数点
    /// 是否是 0-9 的数字，也不包含小数点
    @objc func test37() {
        let testString1 = "4114"
        let testString2 = "he"
        let testString3 = "h5677ha"
        let testString4 = "m880"
        JKPrint("是否是 0-9的数字，也不包含小数点", "判断 \(testString1) 是否是 0-9的数字：\(testString1.jk.isValidNumber())", "判断 \(testString2) 是否是 0-9的数字：\(testString2.jk.isValidNumber())", "判断 \(testString3) 是否是 0-9的数字：\(testString3.jk.isValidNumber())", "判断 \(testString4) 是否是 0-9的数字：\(testString4.jk.isValidNumber())")
    }
    
    // MARK: 3.8、url进行编码
    /// 是否是 0-9 的数字，也不包含小数点
    @objc func test38() {
        let testString1 = "https://www.baidu.com"
        let encode = testString1.jk.urlEncode()
        JKPrint("url进行编码", "\(testString1) 编码后为：\(encode)")
    }
    
    // MARK: 3.9、url进行解码
    @objc func test39() {
        let testString1 = "https://www.baidu.com"
        let encode = testString1.jk.urlEncode()
        JKPrint("url进行编码", "\(testString1) 编码后为：\(encode)", "\(testString1) 解码后后为：\(encode.jk.urlDecode())")
    }
    
    // MARK: 3.10、某个字符使用某个字符替换掉
    /// 某个字符使用某个字符替换掉
    @objc func test310() {
        let testString1 = "我爱我的祖国，我爱我的家人"
        let oldString = "爱"
        let replacingString = "1"
        JKPrint("某个字符使用某个字符替换掉", "\(testString1) 中的 \(oldString) 被替换为 \(replacingString) 后为 ：\(testString1.jk.removeSomeStringUseSomeString(removeString: oldString, replacingString: replacingString))")
    }
    
    // MARK: 3.11、使用正则表达式替换某些子串
    /// 使用正则表达式替换某些子串
    @objc func test311() {
        //原始字符串
        let str1:String = "qwer1234"
        //判断的正则表达式
        let pattern = "[a-zA-Z]"
        //打印结果
        JKPrint("原字符串：\(str1)", "封装的新字符串：\(str1.jk.pregReplace(pattern: pattern, with: "😌"))")
    }
    
    // MARK: 3.12、删除指定的字符
    /// 删除指定的字符
    @objc func test312() {
        //原始字符串
        let str1 = "<<骆驼祥子>>"
        print("原字符串：\(str1)")
        print("新字符串：\(str1.jk.removeCharacter(characterString: "<>"))")
        print("原字符串：\(str1)")
    }
}

// MARK:- 二、沙盒路径的获取
extension StringExtensionViewController {
    // MARK: 获取Home的完整路径名
    @objc func test21() {
        JKPrint("获取 Home 的完整路径名:\(String.jk.homeDirectory())")
    }
    // MARK: 获取Documnets的完整路径名
    @objc func test22() {
        JKPrint("获取 Documnets 的完整路径名:\(String.jk.DocumnetsDirectory())")
    }
    // MARK: "获取Library的完整路径名"
    @objc func test23() {
        JKPrint("获取 Library 的完整路径名:\(String.jk.LibraryDirectory())")
    }
    // MARK: 获取/Library/Cache的完整路径名
    @objc func test24() {
        JKPrint("获取 /Library/Cache 的完整路径名:\(String.jk.CachesDirectory())")
    }
    // MARK: 获取/Library/Preferences的完整路径名
    @objc func test25() {
        JKPrint("获取 /Library/Preferences 的完整路径名:\(String.jk.PreferencesDirectory())")
    }
    // MARK: "获取Tmp的完整路径名"
    @objc func test26() {
        JKPrint("获取 Tmp 的完整路径名:\(String.jk.TmpDirectory())")
    }
}

// MARK:- 一、字符串基本的扩展
extension StringExtensionViewController {
    // MARK: 1.1、字符串的长度
    @objc func test11() {
        let string = "1234567"
        JKPrint("字符串：\(string) 的长度是：\(string.jk.length)")
    }
    
    // MARK: 1.2、判断是否包含某个子串
    @objc func test12() {
        let string = "123哈哈567"
        JKPrint("字符串：\(string) 是否包含：哈哈 ：\(string.jk.contains(find: "哈哈"))", "字符串：\(string) 是否包含：嘿嘿 ：\(string.jk.contains(find: "嘿嘿"))")
    }
    
    // MARK: 1.3、判断是否包含某个子串 -- 忽略大小写
    @objc func test13() {
        let string = "abcdefg"
        JKPrint("字符串：\(string) 是否包含：A ：\(string.jk.containsIgnoringCase(find: "A"))", "字符串：\(string) 是否包含：p ：\(string.jk.containsIgnoringCase(find: "p"))")
        
    }
    
    // MARK: 1.4、字符串 Base64 编码
    @objc func test14() {
        let oldString = "123456"
        JKPrint("字符串 Base64 编码", "\(oldString) 编码后的字符串：\(oldString.jk.base64Encode ?? "编码失败")")
    }
    
    // MARK: 1.5、字符串 Base64 解码
    @objc func test15() {
        let oldString = "123456"
        let newString = oldString.jk.base64Encode ?? "编码失败"
        JKPrint("字符串 Base64 编码", "\(oldString) 编码后的字符串：\(newString)", "\(newString) 解码后为：\(newString.jk.base64Decode ?? "解码失败")")
    }
 
    // MARK: 1.6、将16进制字符串转为Int
    @objc func test16() {
        
    }
    
    // MARK: 1.7、判断是不是九宫格键盘
    @objc func test17() {
        
    }
    
    // MARK: 1.8、字符串转 UIViewController
    @objc func test18() {
        
    }
    
    // MARK: 1.9、字符串转 AnyClass
    @objc func test19() {
        
    }
    
    // MARK: 1.10、字符串转数组
    @objc func test110() {
        
    }
    
    // MARK: 1.11、JSON 字符串 -> Dictionary
    @objc func test111() {
        
    }
    
    // MARK: 1.12、JSON 字符串 -> Array
    @objc func test112() {
        
    }
    
    // MARK: 13、转成拼音
    @objc func test113() {
        let name1 = "我叫雷锋"
        let name2 = "王冲"
        let name3 = "潘滢"
        JKPrint("\(name1) 转成拼音 后为：\(name1.jk.toPinyin())", "\(name2) 转成拼音 后为：\(name2.jk.toPinyin())", "\(name3) 转成拼音 后为：\(name3.jk.toPinyin(true))")
    }
    
    // MARK: 14、提取首字母, "爱国" --> AG
    @objc func test114() {
        let name1 = "我叫雷锋"
        let name2 = "王冲"
        let name3 = "潘滢"
        JKPrint("\(name1) 转成拼音 后为：\(name1.jk.toPinyin()) 提取首字母为：\(name1.jk.pinyinInitials(false))", "\(name2) 转成拼音 后为：\(name2.jk.toPinyin()) 提取首字母为：\(name2.jk.pinyinInitials(false))", "\(name3) 转成拼音 后为：\(name3.jk.toPinyin(true)) 提取首字母为：\(name3.jk.pinyinInitials(true))")
    }
    
    // MARK: 1.15、字符串根据某个字符进行分隔成数组
    @objc func test115() {
        let string = "我爱祖国爱你呀"
        JKPrint("\(string) 分隔后为：\(string.jk.separatedByString(with: "爱"))")
    }
    
    // MARK: 1.16、设备的UUID
    @objc func test116() {
        guard let uuid = String.jk.stringWithUUID() else {
            return
        }
        JKPrint("设备的UUID：\(uuid)")
    }
    
    // MARK: 1.17、复制
    @objc func test117() {
        JKPrint("复制文字：我是一枚小可爱")
        // "复制：我是一枚小可爱".toast()
    }
}
