//
//  StringExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CommonCrypto
import JKSwiftExtension

class StringExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、字符串基本的扩展", "二、字符串与其他类型(字符串转 UIViewController、AnyClass、数组、字典等)的转换", "三、沙盒路径的获取", "四、iOS CharacterSet（字符集）", "五、字符串的转换", "六、字符串UI的处理", "七、字符串有关数字方面的扩展", "八、苹果针对浮点类型计算精度问题提供出来的计算类", "九、字符串包含表情的处理", "十、字符串的一些正则校验", "十一、字符串截取的操作", "十二、字符串编码的处理", "十三、进制之间的转换", "十四、String -> NSMutableAttributedString", "十五、MD5 加密 和 Base64 编解码", "十六、AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密", "十七、SHA1, SHA224, SHA256, SHA384, SHA512", "十八、unicode编码和解码", "十九、字符值引用 (numeric character reference, NCR)与普通字符串的转换"]
        dataArray = [["字符串的长度", "判断是否包含某个子串", "判断是否包含某个子串 -- 忽略大小写", "字符串转 base64", "base64转字符串转", "将16进制字符串转为Int", "判断是不是九宫格键盘", "转成拼音", "提取首字母：爱国->AG", "字符串根据某个字符进行分隔成数组", "设备的UUID", "复制", "提取出字符串中所有的URL链接", "String或者String HTML标签转富文本设置", "计算字符个数（英文 = 1，数字 = 1，汉语 = 2）"], ["字符串转 UIViewController", "字符串转 AnyClass", "字符串转数组", "JSON 字符串 -> Dictionary", "JSON 字符串 -> Array", "字符串转成 CGRect"], ["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"],["去除字符串前后的 空格", "去除字符串前后的 换行", "去除字符串前后的 换行和换行", "去掉所有 空格", "去掉所有 换行", "去掉所有空格 和 换行", "是否是 0-9的数字，也不包含小数点", "url进行编码", "url进行解码", "某个字符使用某个字符替换掉", "字符串指定range替换", "使用正则表达式替换某些子串", "删除指定的字符"], ["字符串 转 CGFloat", "字符串转 Bool", "字符串转 Int", "字符串转 Double", "字符串转通过NSDecimalNumberHandler转Double", "字符串转 Float", "字符串转 NSString", "字符串转 Int64", "字符串转 NSNumber", "数字金额转换成大写人民币金额", "大写的金额转数字金额"], ["对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)", "对字符串(多行)指定字体及Size，获取 (高度)", "对字符串(多行)指定字体及Size，获取 (宽度)", "对字符串(单行)指定字体，获取 (Size)", "对字符串(单行)指定字体，获取 (width)", "对字符串(单行)指定字体，获取 (Height)", "字符串通过 label 根据高度&字体—>Size", "字符串通过 label 根据高度&字体—>Width", "字符串通过 label 根据宽度&字体—>height", "字符串根据宽度 & 字体&行间距->Size", "字符串根据宽度 & 字体 & 行间距->width", "字符串根据宽度&字体&行间距->height"], ["将金额字符串转化为带逗号的金额 按照千分位划分，如 1234567 => 1,234,567", "字符串差不多精确转换成Double——之所以差不多，是因为有精度损失", "去掉小数点后多余的 0", "将数字的字符串处理成  几位 位小数的情况"], ["(加) ＋", "(减) -", "(乘) *", "(除) /"], ["检查字符串是否包含 Emoji 表情", "去除字符串中的Emoji表情"], ["判断是否全是空白,包括空白字符和换行符号，长度为0返回true", "判断是否全十进制数字，长度为0返回false", "判断是否是整数", "判断是否是Float,此处Float是包含Int的，即Int是特殊的Float", "判断是否全是字母，长度为0返回false", "判断是否是中文, 这里的中文不包括数字及标点符号", "是否是有效昵称，即允许“中文”、“英文”、“数字”", "判断是否是有效的手机号码", "判断是否是有效的电子邮件地址", "判断是否有效的身份证号码，不是太严格", "严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码", "校验字符串位置是否合理，并返回String.Index", "隐藏手机号中间的几位", "隐藏手机号中间的几位(保留前几位和后几位)", "隐藏邮箱中间的几位(保留前几位和后几位)", "检查字符串是否有特定前缀", "检查字符串是否有特定后缀", "是否为0-9之间的数字(字符串的组成是：0-9之间的数字)", "是否为数字或者小数点(字符串的组成是：0-9之间的数字或者小数点即可)", "验证URL格式是否正确", "是否是一个有效的文件URL", "富文本匹配(某些关键词高亮)", "判断是否是视频链接"], ["截取字符串从开始到 index", "截取字符串从index到结束", "获取指定位置和长度的字符串", "切割字符串(区间范围 前闭后开)", "子字符串第一次出现的位置", "子字符串最后一次出现的位置", "获取某个位置的字符串", "获取某个子串在父串中的范围->Range", "获取某个子串在父串中的范围->NSRange", "在任意位置插入字符串", "匹配两个字符之间的内容", "字符串按照步长拆分为字符串数组", "字符串长度不足前面补0"], [""], ["二进制 -> 八进制", "二进制 -> 十进制", "二进制 -> 十六进制", "八进制 -> 二进制", "八进制 -> 十进制", "八进制 -> 十六进制", "十进制 -> 二进制", "十进制 -> 八进制", "十进制 -> 十六进制", "十六进制 -> 二进制", "十六进制 -> 八进制", "十六进制 -> 十进制"], ["String 添加颜色后转 NSMutableAttributedString", "String 添加 font 后转 NSMutableAttributedString", "String 添加 font 后转 NSMutableAttributedString", "String 添加 text 后转 NSMutableAttributedString", "String 添加 删除线 后转 NSMutableAttributedString"], ["MD5加密 默认是32位小写加密", "Base64 编解码"], ["字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密"], ["SHA1, SHA224, SHA256, SHA384, SHA512 加密"], ["unicode编码", "unicode解码"], ["将普通字符串转为字符值引用", "字符值引用转普通字符串"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 十九、字符值引用 (numeric character reference, NCR)与普通字符串的转换
extension StringExtensionViewController {
    
    // MARK: 19.02、字符值引用转普通字符串
    @objc func test1902() {
        let str = "潘美丽，最美丽"
        let newString = str.jk.toHtmlEncodedString()
        guard let newString2 = newString.jk.htmlEncodedStringToString() else {
            return
        }
        
        JKPrint("字符值引用转普通字符串", "原始字符串：\(str) 转为字符值引用：\(newString)", "字符值引用：\(newString) 转为普通字符串为：\(newString2)")
    }
    
    // MARK: 19.01、将普通字符串转为字符值引用
    @objc func test1901() {
        let str = "潘美丽，最美丽"
        let newString = str.jk.toHtmlEncodedString()
        JKPrint("将普通字符串转为字符值引用", "原始字符串：\(str) 转为字符值引用：\(newString)")
    }
}

// MARK: - 十八、unicode编码和解码
extension StringExtensionViewController {
    
    // MARK: 18.02、unicode解码
    @objc func test1802() {
        let str = "我是一只小小鸟"
        let newString = str.jk.unicodeEncode()
        JKPrint("unicode编码", "原始字符串：\(str)", "unicode编码后的字符串为：\(newString)", "unicode解码后的字符串为：\(newString.jk.unicodeDecode())")
    }
    
    // MARK: 18.01、unicode编码
    @objc func test1801() {
        let str = "我是一只小小鸟"
        let newString = str.jk.unicodeEncode()
        JKPrint("unicode编码", "原始字符串：\(str)", "unicode编码后的字符串为：\(newString)")
    }
}

// MARK: - 十七、SHA1, SHA224, SHA256, SHA384, SHA512
extension StringExtensionViewController {
    
    // MARK: 17.01、SHA1, SHA224, SHA256, SHA384, SHA512 加密
    @objc func test1701() {
        let str = "我是一只小小鸟"
        let key = "123456"
        let newString = str.jk.shaCrypt(cryptType: .SHA1, key: key, lower: true) ?? "加密失败"
        print("原始字符串：\(str)")
        print("key：\(key)")
        print("加密后的字符串：\(newString)")
    }
}
// MARK: - 十六、AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
extension StringExtensionViewController {
    
    // MARK: 16.01、字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密
    @objc func test1601() {
        let str = "welcome to hangge.com"
        let key = "123456"
        let newString = str.jk.scaCrypt(cryptType: .DES, key: key, encode: true) ?? "加密失败"
        print("原始字符串：\(str)")
        print("key：\(key)")
        print("加密后的字符串：\(newString.jk.scaCrypt(cryptType: .DES, key: key, encode: false) ?? "加密失败")")
    }
    
}
// MARK: - 十五、MD5 加密 和 Base64 编解码
extension StringExtensionViewController {
    
    // MARK: 15.02、Base64 编解码
    @objc func test1502() {
        let oldString = "123456"
        let newString = oldString.jk.base64String(encode: true) ?? "转码失败"
        let newString2 = newString.jk.base64String(encode: false) ?? "解码失败"
        JKPrint("原始字符串：\(oldString)", "\(oldString) 编码后的字符串：\(newString)", "\(newString) 解码后为：\(newString2)", "最后：\(oldString.jk.base64Encode!)")
    }
    
    // MARK: 15.01、MD5加密 默认是32位小写加密
    @objc func test1501() {
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

// MARK: - 十四、String -> NSMutableAttributedString
extension StringExtensionViewController {
    
    // MARK: 14.01、String 添加颜色后转 NSMutableAttributedString
    @objc func test1401() {
        
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
    
    // MARK: 14.02、String 添加 font 后转 NSMutableAttributedString
    @objc func test1402() {
        
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
    
    // MARK: 14.03、String 添加 UIFont 后转 NSMutableAttributedString
    @objc func test1403() {
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
    
    // MARK: 14.04、String 添加 text 后转 NSMutableAttributedString
    @objc func test1404() {
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
    
    // MARK: 14.05、String 添加 删除线 后转 NSMutableAttributedString
    @objc func test1405() {
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

// MARK: - 十三、进制之间的转换
extension StringExtensionViewController {
    // MARK: 13.01、二进制 -> 八进制
    @objc func test1301() {
        let number = "1010"
        JKPrint("二进制 转 八进制", "二进制：\(number) 转 八进制 为：\(number.jk.binaryToOctal())")
    }
    
    // MARK: 13.02、二进制 -> 十进制
    @objc func test1302() {
        let number = "1010"
        JKPrint("二进制 转 十进制", "二进制：\(number) 转 十进制 为：\(number.jk.binaryTodecimal())")
    }
    
    // MARK: 13.03、二进制 -> 十六进制
    @objc func test1303() {
        let number = "1010"
        JKPrint("二进制 转 十六进制", "二进制：\(number) 转 十六进制 为：\(number.jk.binaryToHexadecimal())")
    }
    
    // MARK: 13.4、八进制 -> 二进制
    @objc func test134() {
        let number = "12"
        JKPrint("八进制 -> 二进制", "八进制：\(number) 转 二进制 为：\(number.jk.octalTobinary())")
    }
    
    // MARK: 13.05、八进制 -> 十进制
    @objc func test1305() {
        let number = "12"
        JKPrint("八进制 -> 十进制", "八进制：\(number) 转 十进制 为：\(number.jk.octalTodecimal())")
    }
    
    // MARK: 13.06、八进制 -> 十六进制
    @objc func test1306() {
        let number = "12"
        JKPrint("八进制 -> 十六进制", "八进制：\(number) 转 十六进制 为：\(number.jk.octalToHexadecimal())")
    }
    
    // MARK: 13.07、十进制 -> 二进制
    @objc func test1307() {
        let number = "10"
        JKPrint("十进制 转 二进制", "十进制：\(number) 转 二进制 为：\(number.jk.decimalToBinary())")
    }
    
    // MARK: 13.08、十进制 -> 八进制
    @objc func test1308() {
        let number = "10"
        JKPrint("十进制转 八进制", "十进制：\(number) 转 八进制 为：\(number.jk.decimalToOctal())")
    }
    
    // MARK: 13.09、十进制 -> 十六进制
    @objc func test1309() {
        let number = "10"
        JKPrint("十进制转 十六进制", "十进制：\(number) 转 十六进制 为：\(number.jk.decimalToHexadecimal())")
    }
    
    // MARK: 13.10、十六进制 -> 二进制
    @objc func test1310() {
        
        let number = "a"
        JKPrint("十六进制 转 二进制", "十六进制：\(number) 转 二进制 为：\(number.jk.hexadecimalToBinary())")
    }
    
    // MARK: 13.11、十六进制 -> 八进制
    @objc func test1311() {
        let number = "a"
        JKPrint("十六进制 转 八进制", "十六进制：\(number) 转 八进制 为：\(number.jk.hexadecimalToOctal())")
    }
    
    // MARK: 13.12、十六进制 -> 十进制
    @objc func test1312() {
        let number = "01d530d8c930000"
        // 8254091982733312
        JKPrint("十六进制 转 十进制", "十六进制：\(number) 转 十进制 为：\(number.jk.hexadecimalToDecimal())")
    }
}

// MARK: - 十二、字符串编码的处理
extension StringExtensionViewController {
    // MARK: 12.01、
    @objc func test1201() {
        
    }
}

// MARK: - 十一、字符串截取的操作
extension StringExtensionViewController {
    // MARK: 11.01、截取字符串从开始到 index
    ///  截取字符串从开始到 index
    @objc func test1101() {
        let testString1 = "0123456789"
        JKPrint("字符串截取的操作x", "\(testString1) 从开头截取到index=4 后为：\(testString1.jk.sub(to: 4))")
    }
    
    // MARK: 11.02、截取字符串从index到结束
    ///  截取字符串从index到结束
    @objc func test1102() {
        let testString1 = "0😄123456789"
        JKPrint("截取字符串从index到结束", "\(testString1) 截取字符串从index=4到结束后为：\(testString1.jk.sub(from: 4))")
    }
    
    // MARK: 11.03、获取指定位置和长度的字符串
    ///  获取指定位置和长度的字符串
    @objc func test1103() {
        let testString1 = "0123456789"
        JKPrint("获取指定位置和长度的字符串", "\(testString1) 截取字符串从index=2到长度为2后为：\(testString1.jk.sub(start: 2, length: 2))")
    }
    
    // MARK: 11.04、切割字符串(区间范围 前闭后开)
    ///  切割字符串(区间范围 前闭后开)
    @objc func test1104() {
        let testString1 = "0123456789"
        JKPrint("切割字符串(区间范围 前闭后开)", "\(testString1) 截取字符串 2..<4 后为：\(testString1.jk.slice(2..<4))")
    }
    
    // MARK: 11.05、子字符串第一次出现的位置
    /// 子字符串第一次出现的位置
    @objc func test1105() {
        let str = "2"
        let testString1 = "01234567289"
        JKPrint("子字符串第一次出现的位置", "\(testString1) 中字符串 \(str) 第一次出现的位置：\(testString1.jk.positionFirst(of: str))")
    }
    
    // MARK: 11.06、子字符串最后一次出现的位置
    /// 子字符串最后一次出现的位置
    @objc func test1106() {
        let str = "2"
        let testString1 = "01234567289"
        JKPrint("子字符串最后一次出现的位置", "\(testString1) 中字符串 \(str) 最后一次出现的位置：\(testString1.jk.positionLast(of: str))")
    }
    
    // MARK: 11.07、获取某个位置的字符串
    @objc func test1107() {
        let testString1 = "0123456789"
        let index: Int = 5
        JKPrint("获取某个位置的字符串", "\(testString1) 中字符串位置为：\(index) 的字符是：\(testString1.jk.indexString(index: index))")
    }
    
    // MARK: 11.08、获取某个子串在父串中的范围->Range
    @objc func test1108() {
        let testString1 = "01234567892"
        let str = "2"
        guard let range = testString1.jk.range(of: str) else {
            return
        }
        JKPrint("获取某个子串在父串中的范围->Range", "\(testString1) 中子串为：\(str) 在父串中的范围是：\(range)")
    }
    
    // MARK: 11.09、获取某个子串在父串中的范围->NSRange
    @objc func test1109() {
        let testString1 = "01234567829"
        let str = "2"
        let nsRanges = testString1.jk.nsRange(of: str)
        JKPrint("获取某个子串在父串中的范围->NSRange", "\(testString1) 中子串为：\(str) 在父串中的范围是：\(nsRanges)")
    }
    
    // MARK: 11.10、在任意位置插入字符串
    @objc func test1110() {
        let testString = "01234567829"
        let str = "我爱祖国"
        let location = 10
        let newString = testString.jk.insertString(content: str, locat: location)
        JKPrint("在任意位置插入字符串", "父字符串：\(testString)", "子字符串：\(str)", "在\(location)的位置插入字符串：\(str) 后新的字符串为：\(newString)")
    }
    
    //MARK: 11.11、匹配两个字符之间的内容
    /// 匹配两个字符之间的内容
    @objc func test1111() {
        let testString = "晋太元中，武[陵人[捕鱼]为业。缘[溪行]，忘路之远近。忽逢[桃花]林]，夹岸数百步，"
        let leftChar = "["
        let rightChar = "]"
        let resultArray = testString.jk.matchesMiddleContentOfCharacters(leftChar: leftChar, rightChar: rightChar)
        
        let testString2 = "林尽水(源，便得一)山，山有小(口，仿佛(若有光)。便舍船，从口入"
        let leftChar2 = "("
        let rightChar2 = ")"
        let resultArray2 = testString2.jk.matchesMiddleContentOfCharacters(leftChar: leftChar2, rightChar: rightChar2)
        
        let testString3 = "林尽水源，{便得}一山，山有{小{口}，仿佛若{有光}。便舍船，从口入"
        let leftChar3 = "{"
        let rightChar3 = "}"
        let resultArray3 = testString2.jk.matchesMiddleContentOfCharacters(leftChar: leftChar3, rightChar: rightChar3)
        
        JKPrint("匹配两个字符之间的内容", "匹配1--", "原字符串：\(testString)", "匹配左右字符为：\(leftChar)\(rightChar)", "匹配后的结果是：\(resultArray)", "--------", "匹配2--", "原字符串：\(testString2)", "匹配左右字符为：\(leftChar2)\(rightChar2)", "匹配后的结果是：\(resultArray2)", "--------", "匹配3--", "原字符串：\(testString3)", "匹配左右字符为：\(leftChar3)\(rightChar3)", "匹配后的结果是：\(resultArray3)", "--------")
    }
    
    //MARK: 11.12、字符串按照步长拆分为字符串数组
    /// 字符串按照步长拆分为字符串数组
    @objc func test1112() {
        let testString = "晋太元捕鱼为"
        let arrray = testString.jk.splitStringArray(length: 20)
        JKPrint("\(testString)--拆分为：\(arrray)")
    }
    
    //MARK: 11.13、字符串长度不足前面补0
    /// 字符串长度不足前面补0
    @objc func test1113() {
        let testString = "A"
        let length = 2
        let string = testString.jk.prefixAddZero(length)
        JKPrint("\(testString)--字符串长度不足前面补\(length)个0为：\(string)")
    }
}

// MARK: - 十、字符串的一些正则校验
extension StringExtensionViewController {
    
    // MARK: 10.01、判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    /// 判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    @objc func test1001() {
        let testString = " \n \n"
        JKPrint("\(testString.jk.isBlank)")
    }
    
    // MARK: 10.02、判断是否全十进制数字，长度为0返回false
    /// 判断是否全十进制数字，长度为0返回false
    @objc func test1002() {
        let testString = "f"
        JKPrint("\(testString.jk.isDecimalDigits)")
    }
    
    // MARK: 10.03、判断是否是整数
    /// 判断是否是整数
    @objc func test1003() {
        let testString1 = "32"
        let testString2 = "e"
        let testString3 = "1.0"
        JKPrint("判断 \(testString1) 是否是整数：\(testString1.jk.isPureInt)", "判断 \(testString1) 是否是整数：\(testString2.jk.isPureInt)", "判断 \(testString1) 是否是整数：\(testString3.jk.isPureInt)")
    }
    
    // MARK: 10.04、判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    /// 判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    @objc func test1004() {
        let testString1 = "32"
        let testString2 = "e"
        let testString3 = "1.0"
        JKPrint("判断是否是Float,此处Float是包含Int的，即Int是特殊的Float", "判断 \(testString1) 是否是Float：\(testString1.jk.isPureFloat)", "判断 \(testString2) 是否是Float：\(testString2.jk.isPureFloat)", "判断 \(testString3) 是否是Float：\(testString3.jk.isPureFloat)")
    }
    
    // MARK: 10.05、判断是否全是字母，长度为0返回false
    /// 判断是否全是字母，长度为0返回false
    @objc func test1005() {
        let testString1 = "34fgt"
        let testString2 = "e"
        let testString3 = "ABC"
        JKPrint("判断是否全是字母，长度为0返回false，即Int是特殊的Float", "判断 \(testString1) 是否全是字母：\(testString1.jk.isLetters)", "判断 \(testString2) 是否全是字母：\(testString2.jk.isLetters)", "判断 \(testString3) 是否全是字母：\(testString3.jk.isLetters)")
    }
    
    // MARK: 10.06、判断是否是中文, 这里的中文不包括数字及标点符号
    /// 判断是否是中文, 这里的中文不包括数字及标点符号
    @objc func test1006() {
        let testString1 = "我爱中国"
        let testString2 = "e"
        let testString3 = "I am a boy"
        JKPrint("判断是否是中文, 这里的中文不包括数字及标点符号", "判断 \(testString1) 是否是中文：\(testString1.jk.isChinese)", "判断 \(testString2) 是否是中文：\(testString2.jk.isChinese)", "判断 \(testString3) 是否是中文：\(testString3.jk.isChinese)")
    }
    
    // MARK: 10.07、是否是有效昵称，即允许“中文”、“英文”、“数字”
    /// 是否是有效昵称，即允许“中文”、“英文”、“数字”
    @objc func test1007() {
        let testString1 = "我爱中国--"
        let testString2 = "12"
        let testString3 = "Iloveyou"
        let testString4 = "I love you"
        JKPrint("是否是有效昵称，即允许 中文 、 英文 、 数字 ", "判断 \(testString1) 是否是有效昵称：\(testString1.jk.isValidNickName)", "判断 \(testString2) 是否是有效昵称：\(testString2.jk.isValidNickName)", "判断 \(testString3) 是否是有效昵称：\(testString3.jk.isValidNickName)", "判断 \(testString4) 是否是有效昵称：\(testString4.jk.isValidNickName)")
    }
    
    // MARK: 10.08、判断是否是有效的手机号码
    /// 判断是否是有效的手机号码
    @objc func test1008() {
        let testString1 = "123"
        let testString2 = "18500652880"
        let testString3 = "87689022"
        let testString4 = "12345678912"
        JKPrint("判断是否是有效的手机号码", "判断 \(testString1) 是否是有效的手机号码：\(testString1.jk.isValidMobile)", "判断 \(testString2) 是否是有效的手机号码：\(testString2.jk.isValidMobile)", "判断 \(testString3) 是否是有效的手机号码：\(testString3.jk.isValidMobile)", "判断 \(testString4) 是否是有效的手机号码：\(testString4.jk.isValidMobile)")
    }
    
    // MARK: 10.09、判断是否是有效的电子邮件地址
    /// 判断是否是有效的电子邮件地址
    @objc func test1009() {
        let testString1 = "123"
        let testString2 = "jkironman@163.com"
        let testString3 = "29388387@163.com"
        let testString4 = "chongwang"
        JKPrint("判断是否是有效的电子邮件地址", "判断 \(testString1) 是否是有效的电子邮件地址：\(testString1.jk.isValidEmail)", "判断 \(testString2) 是否是有效的电子邮件地址：\(testString2.jk.isValidEmail)", "判断 \(testString3) 是否是有效的电子邮件地址：\(testString3.jk.isValidEmail)", "判断 \(testString4) 是否是有效的电子邮件地址：\(testString4.jk.isValidEmail)")
    }
    
    // MARK: 10.10、判断是否有效的身份证号码，不是太严格
    /// 判断是否有效的身份证号码，不是太严格
    @objc func test1010() {
        let testString1 = "411423199202026036"
        let testString2 = "411423199"
        let testString3 = "411423199993993j"
        let testString4 = "18500652880"
        JKPrint("判断是否有效的身份证号码，不是太严格", "判断 \(testString1) 是否是有效的身份证号码：\(testString1.jk.isValidIDCardNumber)", "判断 \(testString2) 是否是有效的身份证号码：\(testString2.jk.isValidIDCardNumber)", "判断 \(testString3) 是否是有效的身份证号码：\(testString3.jk.isValidIDCardNumber)", "判断 \(testString4) 是否是有效的身份证号码：\(testString4.jk.isValidIDCardNumber)")
    }
    
    // MARK: 10.11、严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    /// 严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    @objc func test1011() {
        let testString1 = "411423199202026036"
        let testString2 = "411423199"
        let testString3 = "411423199993993j"
        let testString4 = "18500652880"
        JKPrint("严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码", "严格判断 \(testString1) 是否是有效的身份证号码：\(testString1.jk.isValidIDCardNumStrict)", "严格判断 \(testString2) 是否是有效的身份证号码：\(testString2.jk.isValidIDCardNumStrict)", "严格判断 \(testString3) 是否是有效的身份证号码：\(testString3.jk.isValidIDCardNumStrict)", "严格判断 \(testString4) 是否是有效的身份证号码：\(testString4.jk.isValidIDCardNumStrict)")
    }
    
    // MARK: 10.12、校验字符串位置是否合理，并返回String.Index
    /// 校验字符串位置是否合理，并返回String.Index
    @objc func test1012() {
        let testString1 = "4114231she02026036"
        let testString2 = "he"
        let testString3 = "h5677ha"
        let testString4 = "18😄"
        JKPrint("校验字符串位置是否合理，并返回String.Index", "校验 \(testString1) 是否合理：\(testString1.jk.validIndex(original: 107))", "校验 \(testString2) 是否合理：\(testString2.jk.validIndex(original: 2))", "校验 \(testString3) 是否合理：\(testString3.jk.validIndex(original: 0))", "校验 \(testString4) 是否合理：\(testString4.jk.validIndex(original: 2))")
    }
    
    // MARK: 10.13、隐藏手机号中间的几位
    @objc func test1013() {
        let phoneNumber = "18500652880"
        JKPrint("隐藏手机号中间的几位", "手机号：\(phoneNumber) 隐藏后为：\(phoneNumber.jk.hide12BitsPhone(combine: "xxxx"))")
    }
    
    // MARK: 10.14、隐藏手机号中间的几位(保留前几位和后几位)
    @objc func test1014() {
        let phoneNumber = "123456"
        JKPrint("隐藏手机号中间的几位", "手机号：\(phoneNumber) 隐藏后为：\(phoneNumber.jk.hidePhone(combine: "*", digitsBefore: 2, digitsAfter: 2))")
    }
    
    // MARK: 10.15、隐藏邮箱中间的几位(保留前几位和后几位)
    @objc func test1015() {
        let email = "123456@qq.com"
        JKPrint("隐藏邮箱中间的几位", "手机号：\(email) 隐藏后为：\(email.jk.hideEmail(combine: "*", digitsBefore: 1, digitsAfter: 1))")
    }
    
    // MARK: 10.16、检查字符串是否有特定前缀：hasPrefix
    @objc func test1016() {
        let testString = "com.ironman"
        JKPrint("检查字符串是否有特定前缀：hasPrefix", "\(testString) 是否有 com 前缀：\(testString.jk.isHasPrefix(prefix: "com"))", "\(testString) 是否有 cm 前缀：\(testString.jk.isHasPrefix(prefix: "cm"))")
    }
    
    // MARK: 10.17、检查字符串是否有特定后缀：hasPrefix
    @objc func test1017() {
        let testString = "ironman.cn"
        JKPrint("检查字符串是否有特定前缀：hasPrefix", "\(testString) 是否有 cn 后缀：\(testString.jk.isHasSuffix(suffix: "cn"))", "\(testString) 是否有 con 后缀：\(testString.jk.isHasSuffix(suffix: "con"))")
    }
    
    // MARK: 10.18、是否为0-9之间的数字(字符串的组成是：0-9之间的数字)
    @objc func test1018() {
        let testString = "123456"
        JKPrint("是否为0-9之间的数字(字符串的组成是：0-9之间的数字)", "\(testString) 是否为0-9之间的数字：\(testString.jk.isValidNumberValue())")
    }
    
    // MARK: 10.19、是否为数字或者小数点(字符串的组成是：0-9之间的数字或者小数点即可)
    @objc func test1019() {
        let testString = "1."
        JKPrint("是否为数字或者小数点(字符串的组成是：0-9之间的数字或者小数点即可)", "\(testString) 是否为数字或者小数点：\(testString.jk.isValidNumberAndDecimalPoint())")
    }
    
    // MARK: 10.20、验证URL格式是否正确
    @objc func test1020() {
        let testString = "http://wwww.baidu"
        JKPrint("验证URL格式是否正确", "\(testString) 验证URL格式是否正确：\(testString.jk.verifyUrl())")
    }
    
    // MARK: 10.21、是否是一个有效的文件URL, "file://Documents/file.txt".isValidFileUrl -> true
    @objc func test1021() {
        let testString = "file://Documents/file"
        JKPrint("是否是一个有效的文件URL", "\(testString) 是否是一个有效的文件URL：\(testString.jk.isValidFileUrl)")
    }
    
    // MARK: 10.22、富文本匹配(某些关键词高亮)
    @objc func test1022() {
        let totalString = "我是一只小小鸟，一直感a觉飞不高， 飞飞，你小鸟要飞的更高"
        let substring = "小鸟"
        let attributedString = totalString.jk.stringWithHighLightSubstring(keyword: substring, font: UIFont.systemFont(ofSize: 20, weight: .medium), normalColor: UIColor.brown, keywordCololor: UIColor.red, isSplit: false, options: [.caseInsensitive])
        let testView1 = UILabel(frame: CGRect(x: 10, y: 100, width: jk_kScreenW - 20, height: 200))
        testView1.numberOfLines = 0
        testView1.backgroundColor = .yellow
        testView1.attributedText = attributedString
        self.view.addSubview(testView1)
        
        JKAsyncs.asyncDelay(5, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    //MARK: 10.23、判断是否是视频链接
    @objc func test1023() {
        let urlString = "https://download.niucache.com/static/upload/20220426/b3068da0-809a-401c-b4f7-a73269ebee78.rm"
        JKPrint("判断是否是视频链接", "\(urlString) 是否是视频链接：\(urlString.jk.isVideoUrl)")
    }
}

// MARK: - 九、字符串包含表情的处理
extension StringExtensionViewController {
    
    // MARK: 9.02、去除字符串中的Emoji表情
    @objc func test902() {
        let testString = "我是一只😝小小鸟"
        JKPrint("去除字符串中的Emoji表情, 如：\(testString) 去除后为：\(testString.jk.deleteEmoji())")
    }
    
    // MARK: 9.01、检查字符串是否包含 Emoji 表情
    @objc func test901() {
        let testString1 = "我是一😝只小小鸟"
        let testString2 = "我是一只小小鸟"
        JKPrint("检查字符串: \(testString1) 是否包含Emoji 表情：\(testString1.jk.includesEmoji())", "检查字符串: \(testString2) 是否包含Emoji 表情：\(testString2.jk.includesEmoji())")
    }
}

// MARK: - 八、苹果针对浮点类型计算精度问题提供出来的计算类
extension StringExtensionViewController {
    
    // MARK: 8.04、(除)/
    @objc func test804() {
        let num1 = "1.21"
        let num2 = "1.35"
        JKPrint("\(num1) / \(num2) = \(num1.jk.dividing(num2))")
    }
    
    // MARK: 8.03、(乘)*
    @objc func test803() {
        let num1 = "1.21"
        let num2 = "1.35"
        JKPrint("\(num1) * \(num2) = \(num1.jk.multiplying(num2))")
    }
    
    // MARK: 8.02、(减-)
    @objc func test802() {
        let num1 = "1.39"
        let num2 = "1.35"
        JKPrint("\(num1) - \(num2) = \(num1.jk.subtracting(num2))")
    }
    
    // MARK: 8.01、(加)＋
    @objc func test801() {
        let num1 = "1.21"
        let num2 = "1.35"
        JKPrint("\(num1) + \(num2) = \(num1.jk.adding(num2))")
    }
}

// MARK: - 七、字符串有关数字方面的扩展
extension StringExtensionViewController {
    
    // MARK: 7.4、将数字的字符串处理成 几位 位小数的情况
    /// 将数字的字符串处理成  几位 位小数的情况
    @objc func test74() {
        let testStrinig1 = "6.123456789"
        JKPrint("保留 1 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 1))", "保留 2 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 2))", "保留 3 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 3))", "保留 4 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 4))", "保留 5 位小数 \(testStrinig1.jk.saveNumberDecimal(numberDecimal: 5))")
    }
    
    // MARK: 7.03、去掉小数点后多余的 0
    /// 去掉小数点后多余的0
    @objc func test703() {
        let testStrinig1 = "1.3400"
        let testStrinig2 = "1.00"
        let testStrinig3 = "1.20"
        let testStrinig4 = "1.020"
        let testStrinig5 = "1.0010"
        JKPrint("去掉小数点后多余的 0：\n\(testStrinig1) -> \(testStrinig1.jk.cutLastZeroAfterDot())", "\(testStrinig2) -> \(testStrinig2.jk.cutLastZeroAfterDot())", "\(testStrinig3) -> \(testStrinig3.jk.cutLastZeroAfterDot())", "\(testStrinig4) -> \(testStrinig4.jk.cutLastZeroAfterDot())", "\(testStrinig5) -> \(testStrinig5.jk.cutLastZeroAfterDot())")
    }
    
    // MARK: 7.02、字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    /// 字符串差不多精确转换成Double——之所以差不多，是因为有精度损失
    @objc func test702() {
        let testStrinig = "1.3403"
        JKPrint("字符串差不多精确转换成Double——之所以差不多，是因为有精度损失：\(testStrinig.jk.accuraterDouble() ?? 0)")
    }
    
    // MARK: 7.01、将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    /// 将金额字符串转化为带逗号的金额 按照千分位划分，如  "1234567" => 1,234,567   1234567.56 => 1,234,567.56
    @objc func test701() {
        JKPrint(" 将金额字符串转化为带逗号的金额 按照千分位划分，如1234567 转化后为：\("1234567".jk.toThousands() ?? "无效")")
    }
}

// MARK: - 六、字符串UI的处理
extension StringExtensionViewController {
    // MARK: 6.01、对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    /// 对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    @objc func test601() {
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
    
    // MARK: 6.02、对字符串(多行)指定字体及Size，获取 (高度)
    /// 对字符串(多行)指定字体及Size，获取 (高度)
    @objc func test602() {
        
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
    
    // MARK: 6.03、对字符串(多行)指定字体及Size，获取 (宽度)
    /// 对字符串(多行)指定字体及Size，获取 (宽度)
    @objc func test603() {
        
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
    
    // MARK: 6.04、对字符串(单行)指定字体，获取 (Size)
    /// 对字符串(单行)指定字体，获取 (Size)
    @objc func test604() {
        
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
    
    // MARK: 6.05、对字符串(单行)指定字体，获取 (width)
    /// 对字符串(单行)指定字体，获取 (width)
    @objc func test605() {
        
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
    
    // MARK: 6.06、对字符串(单行)指定字体，获取 (Height)
    /// 对字符串(单行)指定字体，获取 (Height)
    @objc func test606() {
        
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
    
    // MARK: 6.07、字符串通过 label 根据高度&字体——> Size
    /// 对字符串(单行)指定字体，获取 (Height)
    @objc func test607() {
        
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
    
    // MARK: 6.08、字符串通过 label 根据高度&字体 ——> Width
    @objc func test608() {
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
    
    // MARK: 6.09、字符串通过 label 根据宽度&字体 ——> height
    @objc func test609() {
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
    
    // MARK: 6.10、字符串根据宽度 & 字体 & 行间距 —> Size
    /// 字符串根据宽度 & 字体 & 行间距 —> Size
    @objc func test610() {
        
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
    
    // MARK: 6.11、字符串根据宽度 & 字体 & 行间距 —> width
    /// 字符串根据宽度 & 字体 & 行间距 —> width
    @objc func test611() {
        
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
    
    // MARK: 6.12、字符串根据宽度 & 字体 & 行间距 —> height
    /// 字符串根据宽度 & 字体 & 行间距 —> height
    @objc func test612() {
        
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

// MARK: - 五、字符串的转换
extension StringExtensionViewController {

    // MARK: 5.11、大写的金额转数字金额
    /// 大写的金额转数字金额
    @objc func test511() {
        let money0 = "零元"
        let money1 = "壹角零伍厘"
        let money2 = "壹万零壹佰元壹角零贰毫"
        let money3 = "壹佰贰拾亿零贰佰叁拾万贰仟贰佰叁拾肆元叁毫伍厘"
        let money4 = "壹拾贰兆零叁拾肆亿贰仟叁佰肆拾壹万贰仟贰佰叁拾肆元捌角"
        let money5 = "壹拾贰亿叁仟肆佰零万壹仟贰佰叁拾肆元整"
        let money6 = "壹仟贰佰叁拾亿零贰佰叁拾肆元贰分"

        let value0 = money0.jk.rMBConvertChineseNumber()
        let value1 = money1.jk.rMBConvertChineseNumber()
        let value2 = money2.jk.rMBConvertChineseNumber()
        let value3 = money3.jk.rMBConvertChineseNumber()
        let value4 = money4.jk.rMBConvertChineseNumber()
        let value5 = money5.jk.rMBConvertChineseNumber()
        let value6 = money6.jk.rMBConvertChineseNumber()
        JKPrint("大写的金额转数字金额", "字符串: \(money0) 大写的金额转数字金额 后为：\(value0 ?? "转换失败")", "字符串: \(money1) 大写的金额转数字金额 后为：\(value1 ?? "转换失败")", "字符串: \(money2) 大写的金额转数字金额 后为：\(value2 ?? "转换失败")", "字符串: \(money3) 大写的金额转数字金额 后为：\(value3 ?? "转换失败")", "字符串: \(money4) 大写的金额转数字金额 后为：\(value4 ?? "转换失败")", "字符串: \(money5) 大写的金额转数字金额 后为：\(value5 ?? "转换失败")", "字符串: \(money6) 大写的金额转数字金额 后为：\(value6 ?? "转换失败")")
    }
    
    // MARK: 5.09、数字金额转换成大写人民币金额
    /// 数字金额转换成大写人民币金额
    @objc func test510() {
        let scale0: Int16 = 1
        let money0 = "0.0"
        let price0 = money0.jk.convertToRMB(scale: scale0)
        
        let scale1: Int16 = 4
        let money1 = "0.10045"
        let price1 = money1.jk.convertToRMB(scale: scale1)
        
        let scale2: Int16 = 3
        let money2 = "10100.102"
        let price2 = money2.jk.convertToRMB(scale: scale2)
        
        let scale3: Int16 = 4
        let money3 = "12002302234.00345"
        let price3 = money3.jk.convertToRMB(scale: scale3)
        
        let scale4: Int16 = 1
        let money4 = "12003423412234.8"
        let price4 = money4.jk.convertToRMB(scale: scale4)
        
        let scale5: Int16 = 1
        let money5 = "1234001234"
        let price5 = money5.jk.convertToRMB(scale: scale5)
        
        let scale6: Int16 = 3
        let money6 = "123000000234.02"
        let price6 = money6.jk.convertToRMB(scale: scale6)
        
        JKPrint("数字金额转换成大写人民币金额", "\(money0) 保留\(scale0)位 转换成大写人民币金额 后为：\(price0)", "\(money1) 保留\(scale1)位 转换成大写人民币金额 后为：\(price1)", "\(money2) 保留\(scale2)位 转换成大写人民币金额 后为：\(price2)", "\(money3) 保留\(scale3)位 转换成大写人民币金额 后为：\(price3)", "\(money4) 保留\(scale4)位 转换成大写人民币金额 后为：\(price4)", "\(money5) 保留\(scale5)位 转换成大写人民币金额 后为：\(price5)", "\(money6) 保留\(scale6)位 转换成大写人民币金额 后为：\(price6)")
        
        JKPrint("\(price0) 反向转换为：\(price0.jk.rMBConvertChineseNumber() ?? "")", "\(price1) 反向转换为：\(price1.jk.rMBConvertChineseNumber() ?? "")", "\(price2) 反向转换为：\(price2.jk.rMBConvertChineseNumber() ?? "")", "\(price3) 反向转换为：\(price3.jk.rMBConvertChineseNumber() ?? "")", "\(price4) 反向转换为：\(price4.jk.rMBConvertChineseNumber() ?? "")", "\(price5) 反向转换为：\(price5.jk.rMBConvertChineseNumber() ?? "")", "\(price6) 反向转换为：\(price6.jk.rMBConvertChineseNumber() ?? "")")
    }
    
    // MARK: 5.09、字符串转 NSNumber
    /// 字符串转 NSNumber
    @objc func test509() {
        let str = "19"
        guard let value = str.jk.toNumber else {
            return
        }
        JKPrint("字符串: \(value) 转 NSNumber 后为：\(value)")
    }
    
    // MARK: 5.08、字符串转 Int64
    /// 字符串转 Int64
    @objc func test508() {
        let str = "19"
        guard let value = str.jk.toInt64Value else {
            return
        }
        JKPrint("字符串: \(value) 转 Int64 后为：\(value)")
    }
    
    // MARK: 5.07、字符串转 NSString
    /// 字符串转 NSString
    @objc func test507() {
        let str = "您好"
        let value = str.jk.toNSString
        JKPrint("字符串: \(value) 转 NSString 后为：\(value)")
    }
    
    // MARK: 5.06、字符串转 Float
    /// 字符串转 Float
    @objc func test506() {
        let str = "5.89"
        guard let value = str.jk.toFloat() else {
            return
        }
        JKPrint("字符串: \(value) 转 Float 后为：\(value)")
    }

    // MARK: 5.05、字符串转通过NSDecimalNumberHandler转Double
    /// 字符串转通过NSDecimalNumberHandler转Double
    @objc func test505() {
        let str1 = "82.389900"
        let value1 = str1.jk.toDecimalDouble() ?? 0
        let str2 = "20.--8"
        let value2 = str2.jk.toDecimalDouble() ?? 0
        let str3 = ""
        let value3 = str3.jk.toDecimalDouble() ?? 0
        
        let value: Double = 3.20
        debugPrint("测试：\(value)")
        JKPrint("字符串: \(str1) 转 Double 后为：\(value1)", "字符串: \(str2) 转 Double 后为：\(value2)", "字符串: \(str3) 转 Double 后为：\(value3)")
    }
    
    // MARK: 5.04、字符串转 Double
    /// 字符串转 Double
    @objc func test504() {
        let str1 = "82.389900"
        let value1 = str1.jk.toDouble() ?? 0
        let str2 = "20.--8"
        let value2 = str2.jk.toDouble() ?? 0
        let str3 = ""
        let value3 = str3.jk.toDouble() ?? 0
        
        let value: Double = 3.20
        debugPrint("测试：\(value)")
        JKPrint("字符串: \(str1) 转 Double 后为：\(value1)", "字符串: \(str2) 转 Double 后为：\(value2)", "字符串: \(str3) 转 Double 后为：\(value3)")
    }
    
    // MARK: 5.03、字符串转 Int
    /// 字符串转 Int
    @objc func test503() {
        let str1 = "123456"
        let value1 = str1.jk.toInt() ?? 0
        let str2 = "123.02"
        let value2 = str2.jk.toInt() ?? 0
        let str3 = "测试"
        let value3 = str3.jk.toInt() ?? 0
        if let value = Int("129.21") {
            
        }
        JKPrint("字符串: \(str1) 转 Int 后为：\(value1)", "字符串: \(str2) 转 Int 后为：\(value2)", "字符串: \(str3) 转 Int 后为：\(value3)")
    }
    
    // MARK: 5.02、字符串转 Bool
    /// 字符串转 Bool
    @objc func test502() {
        let str = "1"
        guard let value = str.jk.toBool() else {
            return
        }
        JKPrint("字符串: \(value) 转 Bool 后为：\(value)")
    }
    
    // MARK: 5.01、字符串 转 CGFloat
    /// 字符串 转 CGFloat
    @objc func test501() {
        let str = "3.2"
        guard let value = str.jk.toCGFloat() else {
            return
        }
        JKPrint(value)
    }
}

// MARK: - 三、iOS CharacterSet（字符集）
extension StringExtensionViewController {
    
    // MARK: 4.01、去除字符串前后的 空格
    /// 去除字符串前后的 空格
    @objc func test401() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str) \n处理后的字符串=\(str.jk.removeBeginEndAllSapcefeed)")
    }
    
    // MARK: 4.02、去除字符串前后的 换行
    /// 去除字符串前后的 换行
    @objc func test402() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str) \n处理后的字符串=\(str.jk.removeBeginEndAllLinefeed)")
    }
    
    // MARK: 4.03、去除字符串前后的 换行和换行
    /// 去除字符串前后的 换行和换行
    @objc func test403() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.jk.removeBeginEndAllSapceAndLinefeed)")
    }
    
    // MARK: 4.04、去掉所有 空格
    /// 去掉所有 空格
    @objc func test404() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.jk.removeAllSapce)")
    }
    
    // MARK: 4.05、去掉所有 换行
    /// 去掉所有 换行
    @objc func test405() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.jk.removeAllLinefeed)")
    }
    
    // MARK: 4.06、去掉所有空格 和 换行
    /// 去掉所有空格 和 换行
    @objc func test406() {
        let str = " 123 456 \n 789 "
        JKPrint("原字符串=\(str)  \n处理后的字符串=\(str.jk.removeAllLineAndSapcefeed)")
    }
    
    // MARK: 4.07、是否是 0-9 的数字，也不包含小数点
    /// 是否是 0-9 的数字，也不包含小数点
    @objc func test407() {
        let testString1 = "4114"
        let testString2 = "he"
        let testString3 = "h5677ha"
        let testString4 = "m880"
        JKPrint("是否是 0-9的数字，也不包含小数点", "判断 \(testString1) 是否是 0-9的数字：\(testString1.jk.isValidNumber())", "判断 \(testString2) 是否是 0-9的数字：\(testString2.jk.isValidNumber())", "判断 \(testString3) 是否是 0-9的数字：\(testString3.jk.isValidNumber())", "判断 \(testString4) 是否是 0-9的数字：\(testString4.jk.isValidNumber())")
    }
    
    // MARK: 4.08、url进行编码
    /// 是否是 0-9 的数字，也不包含小数点
    @objc func test408() {
        let testString1 = "https://www.baidu.com"
        let encode = testString1.jk.urlEncode()
        JKPrint("url进行编码", "\(testString1) 编码后为：\(encode)")
    }
    
    // MARK: 4.09、url进行解码
    @objc func test409() {
        let testString1 = "https://www.baidu.com"
        let encode = testString1.jk.urlEncode()
        JKPrint("url进行编码", "\(testString1) 编码后为：\(encode)", "\(testString1) 解码后后为：\(encode.jk.urlDecode())")
    }
    
    // MARK: 4.10、某个字符使用某个字符替换掉
    /// 某个字符使用某个字符替换掉
    @objc func test410() {
        let testString1 = "我爱我的祖国，我爱我的家人"
        let oldString = "爱"
        let replacingString = "1"
        JKPrint("某个字符使用某个字符替换掉", "\(testString1) 中的 \(oldString) 被替换为 \(replacingString) 后为 ：\(testString1.jk.removeSomeStringUseSomeString(removeString: oldString, replacingString: replacingString))")
    }
    
    // MARK: 4.11、字符串指定range替换
    /// 字符串指定range替换
    @objc func test411() {
        /// 原始字符串
        let str1: String = "qwer1234"
        let range = NSRange(location: 2, length: 2)
        /// 打印结果
        JKPrint("原字符串：\(str1)", "range：\(range)", "替换后的字符串：\(str1.jk.replacingCharacters(range: range, replacingString: "测试"))")
    }
    
    // MARK: 4.12、使用正则表达式替换某些子串
    /// 使用正则表达式替换某些子串
    @objc func test412() {
        /// 原始字符串
        let str1: String = "qwer1234"
        /// 判断的正则表达式
        let pattern = "[a-zA-Z]"
        /// 打印结果
        JKPrint("原字符串：\(str1)", "封装的新字符串：\(str1.jk.pregReplace(pattern: pattern, with: "😌"))")
    }
    
    // MARK: 4.13、删除指定的字符
    /// 删除指定的字符
    @objc func test413() {
        /// 原始字符串
        let str1 = "哈哈:嘿嘿:呵呵"
        print("原字符串：\(str1)")
        print("新字符串：\(str1.jk.removeCharacter(characterString: ":"))")
        print("原字符串：\(str1)")
    }
}

// MARK: - 三、沙盒路径的获取
extension StringExtensionViewController {
    // MARK: 3.06、获取Tmp的完整路径名
    @objc func test306() {
        JKPrint("获取 Tmp 的完整路径名:\(String.jk.TmpDirectory())")
    }
    // MARK: 3.05、获取/Library/Preferences的完整路径名
    @objc func test305() {
        JKPrint("获取 /Library/Preferences 的完整路径名:\(String.jk.PreferencesDirectory())")
    }
    // MARK: 3.04、获取/Library/Cache的完整路径名
    @objc func test304() {
        JKPrint("获取 /Library/Cache 的完整路径名:\(String.jk.CachesDirectory())")
    }
    // MARK: 3.03、获取Library的完整路径名
    @objc func test303() {
        JKPrint("获取 Library 的完整路径名:\(String.jk.LibraryDirectory())")
    }
    // MARK: 3.02、获取Documnets的完整路径名
    @objc func test302() {
        JKPrint("获取 Documnets 的完整路径名:\(String.jk.DocumnetsDirectory())")
    }
    // MARK: 3.01、获取Home的完整路径名
    @objc func test301() {
        JKPrint("获取 Home 的完整路径名:\(String.jk.homeDirectory())")
    }
}

// MARK: - 二、二、字符串与其他类型(字符串转 UIViewController、AnyClass、数组、字典等)的转换
extension StringExtensionViewController {
    
    // MARK: 2.6、字符串转成 CGRect
    @objc func test206() {
        let string1 = "{{0, 0}, 375, 812}}"
        let string2 = "{{0, 0}, {375, 812}}"
        let string3 = "{{0, -}, {375, 812}}"
        let string4 = "{{0, 0}, {375, =}}"
        let string5 = "(0, 20, 30, 40)"
        let string6 = "(0, 20, 30"
        
        if let cgrect1 = string1.jk.toCGRect() {
            debugPrint("\(string1)转成 CGRect：\(cgrect1)")
        } else {
            debugPrint("\(string1): 不符合规则")
        }
        if let cgrect2 = string2.jk.toCGRect() {
            debugPrint("\(string2)转成 CGRect：\(cgrect2)")
        } else {
            debugPrint("\(string2): 不符合规则")
        }
        if let cgrect3 = string3.jk.toCGRect() {
            debugPrint("\(string3)转成 CGRect：\(cgrect3)")
        } else {
            debugPrint("\(string3): 不符合规则")
        }
        if let cgrect4 = string4.jk.toCGRect() {
            debugPrint("\(string4)转成 CGRect：\(cgrect4)")
        } else {
            debugPrint("\(string4): 不符合规则")
        }
        if let cgrect5 = string5.jk.toCGRect() {
            debugPrint("\(string5)转成 CGRect：\(cgrect5)")
        } else {
            debugPrint("\(string5): 不符合规则")
        }
        if let cgrect6 = string6.jk.toCGRect() {
            debugPrint("\(string6)转成 CGRect：\(cgrect6)")
        } else {
            debugPrint("\(string6): 不符合规则")
        }
    }
    
    // MARK: 2.05、JSON 字符串 -> Array
    @objc func test205() {
        
    }
    
    // MARK: 2.04、JSON 字符串 -> Dictionary
    @objc func test204() {
        
    }
    
    // MARK: 2.03、字符串转数组
    @objc func test203() {
        
    }
    
    // MARK: 2.02、字符串转 AnyClass
    @objc func test202() {
        let stringContent = "FileManagerExtensionViewController"
        let stringClass: AnyClass? = stringContent.jk.toClass()
        JKPrint("字符串转 AnyClass：\(stringContent) 转AnyClass为：\(stringClass!)")
    }
    
    // MARK: 2.01、字符串转 UIViewController
    @objc func test201() {
        let stringVC = "DateFormatterExtensionViewController"
        if let vc1 = stringVC.jk.toViewController() {
            JKPrint("字符串：\(stringVC) 转VC为：\(vc1) 转控制器名为：\(vc1.className)")
        } else {
            JKPrint("字符串：\(stringVC) 转VC为：nil，不存在\(stringVC))")
        }
        let testVC = "FalseViewController"
        if let vc2 = testVC.jk.toViewController() {
            JKPrint("字符串：\(testVC) 转VC为：\(vc2) 转控制器名为：\(vc2.className)")
        } else {
            JKPrint("字符串：\(testVC) 转VC为：nil，不存在\(testVC)")
        }
    }
}

// MARK: - 一、字符串基本的扩展
extension StringExtensionViewController {
    
    // MARK: 1.15、计算字符个数（英文 = 1，数字 = 1，汉语 = 2）
    @objc func test115() {
        let name = "我是123hh"
        JKPrint("计算字符个数（英文 = 1，数字 = 1，汉语 = 2）", "\(name) 的字符的个数是：\(name.jk.customCountOfChars())")
    }
    
    // MARK: 1.14、String或者String HTML标签转富文本设置
    @objc func test114() {
        let strHtml = "<font color=\"#666666\">账号或密码错误次数达到10次，您的账号已被冻结</font><font color=\"#FF4600\">30分钟</font><font color=\"#666666\">，忘记密码请尝试找回，如有问题请</font><font color=\"#447EFF\">联系客服</font>"
        let attributedText = strHtml.jk.setHtmlAttributedString(font: UIFont.systemFont(ofSize: 20), lineSpacing: 10)
        let textSize = attributedText.boundingRect(with: CGSize(width: jk_kScreenW - 40, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: jk_kScreenW - 40, height: textSize.height))
        label.backgroundColor = .randomColor
        label.numberOfLines = 0
        
        label.attributedText = attributedText
        self.view.addSubview(label)
        
        JKAsyncs.asyncDelay(2) {
        } _: {
            label.removeFromSuperview()
        }
    }
    
    // MARK: 1.13、提取出字符串中所有的URL链接
    @objc func test113() {
        let str = "欢迎访问https://www.baidu.com，https://www.jianshu.com/u/8fed18ed70c9\n以及https://github.com/JoanKing"
        JKPrint("测试字符串式：\(str)", "匹配到的链接：\(str.jk.getUrls() ?? [])")
    }
    
    // MARK: 1.12、复制
    @objc func test112() {
        JKPrint("复制文字：我是一枚小可爱")
        // "复制：我是一枚小可爱".toast()
        "我是一枚小可爱".jk.copy()
        print("复制的内容是：\(UIPasteboard.general.string ?? "没有内容")")
    }
    
    // MARK: 1.11、设备的UUID
    @objc func test111() {
        guard let uuid = String.jk.stringWithUUID() else {
            return
        }
        JKPrint("设备的UUID：\(uuid)")
    }
    
    // MARK: 1.10、字符串根据某个字符进行分隔成数组
    @objc func test110() {
        let string = "我爱祖国爱你呀"
        JKPrint("\(string) 分隔后为：\(string.jk.separatedByString(with: "爱"))")
    }
    
    // MARK: 1.09、提取首字母, "爱国" --> AG
    @objc func test109() {
        let name1 = "我叫雷锋"
        let name2 = "王冲"
        let name3 = "潘滢"
        JKPrint("\(name1) 转成拼音 后为：\(name1.jk.toPinyin()) 提取首字母为：\(name1.jk.pinyinInitials(false))", "\(name2) 转成拼音 后为：\(name2.jk.toPinyin()) 提取首字母为：\(name2.jk.pinyinInitials(false))", "\(name3) 转成拼音 后为：\(name3.jk.toPinyin(true)) 提取首字母为：\(name3.jk.pinyinInitials(true))")
    }
    
    // MARK: 1.08、转成拼音
    @objc func test108() {
        let name1 = "我叫雷锋"
        let name2 = "王冲"
        let name3 = "潘滢"
        JKPrint("\(name1) 转成拼音 后为：\(name1.jk.toPinyin())", "\(name2) 转成拼音 后为：\(name2.jk.toPinyin())", "\(name3) 转成拼音 后为：\(name3.jk.toPinyin(true))")
    }
    
    // MARK: 1.07、判断是不是九宫格键盘
    @objc func test107() {
        
    }
    
    // MARK: 1.06、将16进制字符串转为Int
    @objc func test106() {
        
    }
    
    // MARK: 1.05、base64转字符串转
    @objc func test105() {
        let oldString = "123456"
        let newString = oldString.jk.base64Encode ?? "编码失败"
        JKPrint("base64转字符串转", "\(oldString) 编码后的字符串：\(newString)", "\(newString) 解码后为：\(newString.jk.base64Decode ?? "解码失败")")
    }
    
    // MARK: 1.04、字符串转 base64
    @objc func test104() {
        let oldString = "123456"
        JKPrint("字符串转 base64", "\(oldString) 编码后的字符串：\(oldString.jk.base64Encode ?? "编码失败")")
    }
    
    // MARK: 1.03、判断是否包含某个子串 -- 忽略大小写
    @objc func test103() {
        let string = "abcdefg"
        JKPrint("字符串：\(string) 是否包含：A ：\(string.jk.containsIgnoringCase(find: "A"))", "字符串：\(string) 是否包含：p ：\(string.jk.containsIgnoringCase(find: "p"))")
    }
    
    // MARK: 1.02、判断是否包含某个子串
    @objc func test102() {
        let string = "123哈哈567"
        JKPrint("字符串：\(string) 是否包含：哈哈 ：\(string.jk.contains(find: "哈哈"))", "字符串：\(string) 是否包含：嘿嘿 ：\(string.jk.contains(find: "嘿嘿"))")
    }
    
    // MARK: 1.01、字符串的长度
    @objc func test101() {
        /*
        let string = "abc"
        JKPrint("字符串：\(string) 的长度是：\(string.jk.typeLengh(.utf16))")
         */
        let string = "我 试"
        debugPrint("字符串：\(string) 的字节长度为：\(string.lengthOfBytes(using: .utf8))")
    }
}
