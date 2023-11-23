//
//  UIViewControllerExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIViewControllerExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、Storyboard 的 VC 交互"]
        dataArray = [["pop回上一个界面", "获取push进来的 VC", "获取顶部控制器(类方法)", "获取顶部控制器(实例方法)", "是否正在展示", "关闭当前的控制器", "dismiss到某个vc"], ["push跳转Storyboard(首个初始化的控制器)", "push跳转到Storyboard中指定UIViewController"]]
    }
}

// MARK: - 二、Storyboard 的 VC 交互
extension UIViewControllerExtensionViewController {
    
    // MARK: 2.02、push跳转到Storyboard中指定UIViewController
    @objc func test202() {
        self.jk.pushStoryboard("MyStoryboard", identifier: "456") { (vc) in
        }
    }
    
    // MARK: 2.01、push跳转Storyboard(首个初始化的控制器)
    @objc func test201() {
        self.jk.pushStoryboard("MyStoryboard2") { (vc) in
        }
    }
}

// MARK: - 一、基本的扩展
extension UIViewControllerExtensionViewController {
    
    //MARK: 1.07、dismiss到某个vc
    @objc func test107() {
        JKPrint("dismiss到某个vc")
        let vc = PresentFirstViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    // MARK: 1.06、关闭当前的控制器
    @objc func test106() {
        JKPrint("关闭当前的控制器")
        self.jk.closeCurrentVC()
    }
    
    // MARK: 1.05、是否正在展示
    @objc func test105() {
        JKPrint("是否正在展示：\(self.jk.isCurrentVC)")
    }
    
    // MARK: 1.04、获取顶部控制器(实例方法)
    @objc func test104() {
        guard let vc = self.jk.topViewController() else {
            return
        }
        JKPrint("获取顶部控制器", "\(vc.className)")
    }
    
    // MARK: 1.03、获取顶部控制器(类方法)
    @objc func test103() {
        guard let vc = UIViewController.jk.topViewController() else {
            return
        }
        JKPrint("获取顶部控制器", "\(vc.className)")
    }
    
    // MARK: 1.02、获取push进来的 VC
    @objc func test102() {
        guard let vc = jk.getPreviousNavVC() else {
            return
        }
        JKPrint("pop回上一个界面", "\(vc.className)")
    }
    
    // MARK: 1.01、pop回上一个界面
    @objc func test101() {
        JKPrint("pop回上一个界面", "\(jk.popToPreviousVC())")
    }
}

//MARK: - 模态跳转测试
//MARK: 模态vc1
class PresentFirstViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = .randomColor
        self.view.jk.addSubviews([titleLabel, button, dissButton])
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(jk_kNavFrameH + 40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(60)
        }
        
        dissButton.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(60)
        }
    }
    
    /// 模态跳转
    @objc func presentEvent() {
        let vc = PresentSecondViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    /// 返回上个界面
    @objc func dissEvent() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// 模态跳转
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("模态转转：PresentSecondViewController", for: .normal)
        button.addTarget(self, action: #selector(presentEvent), for: .touchUpInside)
        button.backgroundColor = .randomColor
        return button
    }()

    /// 返回上个界面
    lazy var dissButton: UIButton = {
        let button = UIButton()
        button.setTitle("返回上个界面", for: .normal)
        button.addTarget(self, action: #selector(dissEvent), for: .touchUpInside)
        button.backgroundColor = .randomColor
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "这是First"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.jk.textB(15)
        return label
    }()
}

//MARK: 模态vc2
class PresentSecondViewController: PresentFirstViewController {
    override func viewDidLoad() {
       super.viewDidLoad()
        self.titleLabel.text = "这是Second"
        self.button.setTitle("模态转转：PresentThirdViewController", for: .normal)
    }
    
    override func presentEvent() {
        let vc = PresentThirdViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

//MARK: 模态vc3
class PresentThirdViewController: PresentFirstViewController {
    override func viewDidLoad() {
       super.viewDidLoad()
        self.titleLabel.text = "这是Third"
        self.button.setTitle("diss返回PresentFirstViewController", for: .normal)
    }
    
    override func presentEvent() {
        self.jk.dismiss(vc: PresentFirstViewController.self, animated: true)
    }
}
