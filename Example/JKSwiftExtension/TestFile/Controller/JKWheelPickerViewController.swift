//
//  JKWheelPickerViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/3/3.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import JKSwiftExtension
class JKWheelPickerViewController: UIViewController {

    lazy var monthPicker: JKWheelPicker = {
        let picker = JKWheelPicker(frame: CGRect(x: 100, y: 150, width: 100, height: 100))
        picker.backgroundColor = .yellow
        picker.dataSource = self
        picker.delegate = self
        
        picker.interitemSpacing = 7.0
        picker.style = .styleFlat
        picker.isMaskDisabled = true
        picker.scrollDirection = .vertical

        picker.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        picker.highlightedFont = UIFont.systemFont(ofSize: 30, weight: .semibold)
        picker.textColor = UIColor.hexStringColor(hexString: "#7C828C")
        picker.highlightedTextColor = UIColor.red
        return picker
    }()
    
    fileprivate var months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]
    
    lazy var button1: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 300, width: 150, height: 100))
        button.backgroundColor = .brown
        button.tag = 101
        button.addTarget(self, action: #selector(click1), for: .touchUpInside)
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton(frame: CGRect(x: button1.jk.right + 100, y: 300, width: 150, height: 100))
        button.backgroundColor = .brown
        button.tag = 102
        button.addTarget(self, action: #selector(click1), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(monthPicker)
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        
        let weeks = ["1", "6", "3"]
            // .sorted(by: { $0 > $1 })
        let newWeeks = weeks.sorted { $0 < $1 }
        debugPrint("newWeeks：\(newWeeks)")
        
        debugPrint("是否包含2：\(weeks.contains("2"))", "是否包含6：\(weeks.contains("6"))", "是否包含7：\(weeks.contains("7"))")
        
        
        var moons1: [Int] = []
        for index in 1...28 {
            moons1.append(index)
        }
        let currentMoon = Date.jk.currentDate.jk.month
//        if currentMoon {
//
//        }
        debugPrint("当前的月份:\(currentMoon)")
       // monthPicker.select(3, animated: false)
        JKAsyncs.asyncDelay(0) {
        } _: {[weak self] in
            guard let self else {
                return
            }
            // self.monthPicker.select(3, animated: false)
        }
        
    }
    
    @objc func click1(sender: UIButton) {
        if sender.tag == 101 {
            monthPicker.select(3, animated: false)
        } else {
            monthPicker.select(8, animated: false)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        monthPicker.select(5, animated: false)
    }
}

extension JKWheelPickerViewController: JKWheelPickerDataSource {
    
    func numberOfItems(_ wheelPicker: JKWheelPicker) -> Int {
        return months.count
    }
    
    func titleFor(_ wheelPicker: JKWheelPicker, at index: Int) -> String {
        return months[index]
    }
}

extension JKWheelPickerViewController: JKWheelPickerDelegate {
    
    func wheelPicker(_ wheelPicker: JKWheelPicker, didSelectItemAt index: Int) {
        print("\(months[index])")
    }
    
    func wheelPicker(_ wheelPicker: JKWheelPicker, marginForItem index: Int) -> CGSize {
        
        return CGSize(width: 0.0 , height: 0.0)
    }
}

