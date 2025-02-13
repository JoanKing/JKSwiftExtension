//
//  UITextFieldExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


class UITextFieldExtensionViewController: BaseViewController {
    
    var testTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、链式编程", "三、输入内容以及正则的配置"]
        dataArray = [["添加左边的内边距", "添加左边的图片", "是否都是数字", "设置富文本的占位符"], ["设置文字", "设置富文本", "设置占位符", "设置富文本占位符", "设置文本格式", "设置文本颜色", "设置文本颜色（十六进制字符串）", "设置文本字体大小(UIFont)", "设置文本字体大小(CGFloat)", "设置代理","设置键盘样式"], ["限制字数的输入(提示在：- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; 里面调用)"]]
        
        let originalString = "\n\n这是一段带有\n换行符的文本\n\n"
        let trimmedString = originalString.jk.removeBeginEndAllSapceAndLinefeed
        // let newString = trimmedString.replacingOccurrences(of: "\n", with: "替换后的字符")
        debugPrint("newString：\(trimmedString)")
    }
}

// MARK: - 三、输入内容以及正则的配置
extension UITextFieldExtensionViewController {
    
    // MARK: 3.01、限制字数的输入(提示在：- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; 里面调用)
    @objc func test301() {
        self.navigationController?.pushViewController(TextFildViewTestViewController(), animated: true)
    }
}

// MARK: - 二、链式编程
extension UITextFieldExtensionViewController {
    
    // MARK: 2.11、键盘样式设置
    @objc func test211() {
        testTextFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).placeholder("我是一只小小鸟").color("#FF1493").font(22).delegate(self).keyboardType(.decimalPad)
        testTextFiled.backgroundColor = .randomColor
        self.view.addSubview(testTextFiled)
        JKAsyncs.asyncDelay(300) {
        } _: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.testTextFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.10、设置代理
    @objc func test210() {
        testTextFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).placeholder("我是一只小小鸟").color("#FF1493").font(22).delegate(self)
        testTextFiled.backgroundColor = .randomColor
        self.view.addSubview(testTextFiled)
        JKAsyncs.asyncDelay(300) {
        } _: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.testTextFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.09、设置文本字体大小(CGFloat)
    @objc func test209() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).text("我是一只小小鸟").alignment(.right).color("#FF1493").font(22)
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.08、设置文本字体大小(UIFont)
    @objc func test208() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).text("我是一只小小鸟").alignment(.right).color("#FF1493").font(UIFont.systemFont(ofSize: 18))
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.07、设置文本颜色（十六进制字符串）
    @objc func test207() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).text("我是一只小小鸟").alignment(.right).color("#FF1493")
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.06、设置文本颜色
    @objc func test206() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).text("我是一只小小鸟").alignment(.right).color(.brown)
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.05、设置文本格式
    @objc func test205() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).text("我是一只小小鸟").alignment(.right)
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.04、设置占位符
    @objc func test204() {
        let attributedString = NSMutableAttributedString(string: "占位符富文本", attributes: [NSAttributedString.Key.foregroundColor: UIColor.randomColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).attributedPlaceholder(attributedString)
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.03、设置占位符
    @objc func test203() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).placeholder("我是占位符")
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.02、设置富文本
    @objc func test202() {
        let testString = "我是富文本"
        let attributedString = NSMutableAttributedString(string: testString)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: NSRange(location: 0, length: testString.count))
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).attributedText(attributedString)
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 2.01、设置文字
    @objc func test201() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40)).text("我是一只小小鸟")
        textFiled.backgroundColor = .randomColor
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
}

extension UITextFieldExtensionViewController: UITextFieldDelegate {
    // MARK: 将要开始编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        debugPrint("将要开始编辑")
        return true
    }
    // MARK: 已经开始编辑
    func textFieldDidBeginEditing(_ textField: UITextField) {
        debugPrint("已经开始编辑")
    }
    // MARK: 将要结束编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        debugPrint("将要结束编辑")
        return true
    }
    // MARK: 已经结束编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        debugPrint("已经结束编辑")
    }
    // MARK: 文本输入内容将要发生变化（每次输入都会调用）
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        debugPrint("文本输入内容将要发生变化（每次输入都会调用）")
        return true
    }
    // MARK: 将要清除输入内容，返回值是是否要清除掉内容
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        debugPrint("将要清除输入内容，返回值是是否要清除掉内容")
        return true
    }
    // MARK: 将要按下Return按钮，返回值是是否结束输入（是否失去焦点）
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        debugPrint("将要按下Return按钮，返回值是是否结束输入（是否失去焦点）")
        return true
    }
}

// MARK: - 一、基本的扩展
extension UITextFieldExtensionViewController {
    
    // MARK: 1.04、设置富文本的占位符
    @objc func test104() {
        JKPrint("设置富文本的占位符")
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40))
        textFiled.backgroundColor = .randomColor
        textFiled.jk.addLeftIcon(UIImage(named: "ironman"), leftViewFrame: CGRect(x: 20, y: 20, width: 30, height: 30), imageSize: CGSize(width: 20, height: 20))
        textFiled.placeholder = "我是占位符"
        textFiled.jk.setPlaceholderAttribute(font: UIFont.systemFont(ofSize: 16), color: UIColor.randomColor)
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(1000) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 1.03、是否都是数字
    @objc func test103() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40))
        textFiled.backgroundColor = .randomColor
        textFiled.jk.addLeftIcon(UIImage(named: "ironman"), leftViewFrame: CGRect(x: 20, y: 20, width: 30, height: 30), imageSize: CGSize(width: 20, height: 20))
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(5) {
        } _: {
            JKPrint("是否都是数字", "结果是：\(textFiled.jk.validateDigits())")
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 1.02、添加左边的图片
    @objc func test102() {
        // addLeftIcon
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40))
        textFiled.backgroundColor = .randomColor
        textFiled.jk.addLeftIcon(UIImage(named: "ironman"), leftViewFrame: CGRect(x: 20, y: 20, width: 30, height: 30), imageSize: CGSize(width: 20, height: 20))
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(300) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
    
    // MARK: 1.01、添加左边的内边距
    @objc func test101() {
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 40))
        textFiled.backgroundColor = .randomColor
        textFiled.jk.addLeftTextPadding(20)
        self.view.addSubview(textFiled)
        JKAsyncs.asyncDelay(3) {
        } _: {
            textFiled.removeFromSuperview()
        }
    }
}


//MARK: - 测试：输入内容以及正则的一个输入内容的限制
class TextFildViewTestViewController: UIViewController {
    
    lazy var limitTipLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "限制输入10个数字-使用utf16来计算长度"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    /// "限制输入10个数字
    private var textFiledView1: TestTextFiledView = {
        let view = TestTextFiledView(frame: CGRect.zero, placeholderContent: "限制输入10个字符", regex: "^[0-9]*$", maxCharacters: 10, lenghType: .utf16)
        if #available(iOS 10, *) {
            view.infoTextField.textContentType = .telephoneNumber
        }
        return view
    }()
    lazy var limitTipLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "限制输入20个字符-使用count来计算长度"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    /// "限制输入20个字符"
    private var textFiledView2: TestTextFiledView = {
        let view = TestTextFiledView(frame: CGRect.zero, placeholderContent: "限制输入20个字符", regex: "^[A-Za-z0-9]+$", maxCharacters: 20, lenghType: .count)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        view.addSubview(limitTipLabel1)
        limitTipLabel1.snp.makeConstraints { make in
            make.top.equalTo(jk_kNavFrameH + 20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        view.addSubview(textFiledView1)
        textFiledView1.snp.makeConstraints { make in
            make.top.equalTo(limitTipLabel1.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        view.addSubview(limitTipLabel2)
        limitTipLabel2.snp.makeConstraints { make in
            make.top.equalTo(textFiledView1.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        view.addSubview(textFiledView2)
        textFiledView2.snp.makeConstraints { make in
            make.top.equalTo(limitTipLabel2.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
    }
}

// 测试输入
class TestTextFiledView: UIView {
    /// 默认占位符
    private var placeholderContent: String
    /// 正则
    private var regex: String?
    /// 信息最多是40个字
    private var maxCharacters: Int = 40
    /// 长度类型
    private var lenghType: StringTypeLength
    /// 前缀：*
    lazy var prefixLabel: UILabel = {
        let label = UILabel()
        label.text = "*"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.hexStringColor(hexString: "#E0192C")
        return label
    }()
    
    /// 请输入信息
    lazy var infoTextField: JKPastedTextField = {
        let textField = JKPastedTextField()
        textField.textColor = UIColor.hexStringColor(hexString: "#2C2D2E")
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.rightViewMode = .always
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.delegate = self
        let attributedPlaceholder = NSMutableAttributedString(string: placeholderContent, attributes: [.foregroundColor: UIColor.hexStringColor(hexString: "#7C828C"), .font: UIFont.systemFont(ofSize: 16)])
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    
    /// 输入的内容发生变化
    var inputChangeClosure: ((String) -> Void)?
    
    init(frame: CGRect, placeholderContent: String = "", regex: String? = nil, maxCharacters: Int = 100, lenghType: StringTypeLength = .count) {
        self.placeholderContent = placeholderContent
        self.regex = regex
        self.maxCharacters = maxCharacters
        self.lenghType = lenghType
        super.init(frame: frame)
        initUI()
        commonInit()
        changeTheme()
        loadData()
    }
    
    private func initUI() {
        addSubview(prefixLabel)
        addSubview(infoTextField)
    }
    
    private func commonInit() {
        prefixLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(14)
            make.width.equalTo(16)
            make.height.equalTo(26)
        }
        infoTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(prefixLabel.snp.right)
            make.right.equalTo(-14)
            make.height.equalTo(26)
        }
    }
    
    private func changeTheme() {
        self.backgroundColor = UIColor.white
    }
    
    private func loadData() {
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 基本事件
extension TestTextFiledView {
    //MARK: 清除输入内容
    /// 清除输入内容
    @objc func clear() {
        infoTextField.text = ""
        inputChangeClosure?("")
    }
}

//MARK: - UITextFieldDelegate 代理事件
extension TestTextFiledView: UITextFieldDelegate {
    //MARK: 内容发生变化
    /// 内容发生变化
    @objc func textDidChange(textField: UITextField) {
        guard var str = textField.text else { return }
        if str.count > 0, let weakRegex = regex, !JKRegexHelper.match(str, pattern: weakRegex) {
            debugPrint("不能输入：\(str)")
            textField.text = ""
            str = ""
        }
        debugPrint("内容：\(str)")
        inputChangeClosure?(str)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return textField.jk.inputRestrictions(shouldChangeTextIn: range, replacementText: string, maxCharacters: maxCharacters, regex: regex, lenghType: lenghType, isRemovePasteboardNewlineCharacters: true)
    }
    
    /// 获得焦点
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        debugPrint("输入信息获得焦点------")
        return true
    }
    
    /// 失去焦点
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        debugPrint("输入信息失去焦点------")
        return true
    }
}




