//
//  DarkModePickerView.swift
//  FutureBull
//
//  Created by IronMan on 2021/7/27.
//  Copyright © 2021 wuyanwei. All rights reserved.
//

// MARK: - 暗黑模式时间的设置
import UIKit

class DarkModePickerView: UIView {
    /// 确定时间段的返回
    var sureClosure: ((String, String)->Void)
    /// 开始时间
    private var startTime = "21:00"
    /// 结束时间
    private var endTime = "8:00"
    /// 时间数组
    lazy var timeDataArray: [String] = {
        let array = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "8:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"]
        return array
    }()
    /// 时间选择器
    lazy var leftTimePickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width / 2.0, height: 200))
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.autoresizingMask = .flexibleWidth
        let index = timeDataArray.firstIndex(of: startTime) ?? 0
        pickerView.selectRow(index, inComponent: 0, animated: true)
        return pickerView
    }()
    
    /// 时间选择器
    lazy var rightTimePickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: UIScreen.main.bounds.width / 2.0, y: 44, width: UIScreen.main.bounds.width / 2.0, height: 200))
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.autoresizingMask = .flexibleWidth
        let index = timeDataArray.firstIndex(of: endTime) ?? 0
        pickerView.selectRow(index, inComponent: 0, animated: true)
        return pickerView
    }()
    /// 至
    lazy var middeleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2.0 - 20, y: 44 + 200 / 2.0 - 20, width: 40, height: 40))
        label.text = "至"
        label.textAlignment = .center
        return label
    }()
    /// 视图的父视图
    lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 200 - 44, width:  UIScreen.main.bounds.width, height: 200 + 44))
        view.backgroundColor = .white
        return view
    }()
    /// 取消
    lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 44))
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    /// 确定
    lazy var sureButton: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 88, y: 0, width: 88, height: 44))
        button.setTitle("确定", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(sureButtonClick), for: .touchUpInside)
        return button
    }()
    /// 顶部的横线
    lazy var topLineView: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 44 - (1.0 / UIScreen.main.scale), width: UIScreen.main.bounds.width, height: (1.0 / UIScreen.main.scale)))
        line.backgroundColor = .gray
        return line
    }()
    
    init(startTime: String, endTime: String, complete: @escaping (String, String)->Void) {
        self.startTime = startTime
        self.endTime = endTime
        self.sureClosure = complete
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        initUI()
        commonUI()
        updateTheme()
    }
    
    /// 创建控件
    private func initUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.48)
        // 添加一个点击收回手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.addGestureRecognizer(tap)
        self.addSubview(bgView)
        bgView.addSubview(cancelButton)
        bgView.addSubview(sureButton)
        bgView.addSubview(leftTimePickerView)
        bgView.addSubview(rightTimePickerView)
        bgView.addSubview(middeleLabel)
        bgView.addSubview(topLineView)
    }
    
    /// 添加控件和设置约束
    private func commonUI() {
        
    }
    
    /// 更新控件的颜色，字体，背景色等等
    private func updateTheme() {
        
    }
    
    //MARK: 弹出时间
    func showTime() {
        UIApplication.jk.keyWindow?.addSubview(self)
    }
    
    //MARK: 界面消失
    @objc private func dismissView() {
        self.removeFromSuperview()
    }
    
    // MARK: 确定
    @objc func sureButtonClick() {
        sureClosure(startTime, endTime)
        dismissView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DarkModePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 47
    }
    
    // func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    //    return 100
    // }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // 自定义分隔线属性
        /*
         for v in pickerView.subviews {
         if v.frame.size.height < 1 {
         // v.frame.origin.x = 100
         // v.frame.size.width = ScreenWidth - 200
         // v.frame.size.height = 1
         v.backgroundColor = UIColor.red
         }
         }
         */
        
        // 自定义行属性
        var label = view as? UILabel
        if label == nil {
            label = UILabel()
            label!.font = UIFont.systemFont(ofSize: 18)
        }
        label!.textColor = UIColor.black
        label!.textAlignment = .center
        // label!.backgroundColor = .brown
        label!.text = timeDataArray[row]
        
        return label!
    }
    
    // MARK: 将在滑动停止后触发，并打印出选中列和行索引
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == leftTimePickerView {
            startTime = timeDataArray[row]
            // debugPrint("左边时间：\(timeDataArray[row])， row = \(row) component = \(component)")
        } else {
            endTime = timeDataArray[row]
            // debugPrint("右边时间：\(timeDataArray[row])， row = \(row) component = \(component)")
        }
    }
}
