//
//  ViewController.swift
//  JKSwiftExtension
//
//  Created by JoanKing on 08/31/2020.
//  Copyright (c) 2020 JoanKing. All rights reserved.
//

import UIKit
import JKSwiftExtension

enum DevEnvironType: String {
    case debugDevEnviron   = "开发环境"
    case testDevEnviron    = "测试环境"
    case betaDevEnviron    = "灰度环境"
    case releaseDevEnviron = "正式环境"
}

class ViewController: UIViewController {
    
    var typeValue: DevEnvironType = .debugDevEnviron
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#444444", alpha: 1.0)
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        
        self.edgesForExtendedLayout = []
    }
    
    @objc func click1() {
        print("存的值是：\(typeValue)")
        UserDefaults.standard.set(typeValue.rawValue, forKey: "a")
        UserDefaults.standard.synchronize()
    }

    @objc func click2() {
    
        guard let result = UserDefaults.standard.value(forKey: "a") else {
            return
        }
        let content = DevEnvironType(rawValue: result as! String) ?? .debugDevEnviron
        
        print("取出的值是：\(content)")
    }
    
    @objc func click3() {
        typeValue = .testDevEnviron
    }
    lazy var button1: UIButton = {
        let btn = UIButton(frame: CGRect(x: 16, y: 36, width: 100, height: 50))
        btn.setTitle("存值", for: .normal)
        btn.backgroundColor = .brown
        btn.addTarget(self, action: #selector(click1), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    lazy var button2: UIButton = {
        let btn = UIButton(frame: CGRect(x: 150, y: 36, width: 100, height: 50))
        btn.setTitle("取值", for: .normal)
        btn.backgroundColor = .brown
        btn.addTarget(self, action: #selector(click2), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    lazy var button3: UIButton = {
        let btn = UIButton(frame: CGRect(x: 16, y: 100, width: 100, height: 50))
        btn.setTitle("改变值", for: .normal)
        btn.backgroundColor = .brown
        btn.addTarget(self, action: #selector(click3), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    func test1() {
        let array1 = ["A", "B", "C", "D"]
        let array2 = ["a", "b", "c", "d"]
        array1.forEach { (i, a) in
            print("打印：序列：\(i) 内容：\(a)")
            array2.forEach { (b) in
                print("第二个数组：\(b)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

