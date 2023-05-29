//
//  JKAlertViewControllerViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/5/25.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

//MARK: - 弹框
import Foundation

class JKAlertViewControllerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、弹框(描述信息是：基本文本)", "二、弹框(描述信息是：富文本)"]
        dataArray = [["标题/描述/确定/取消", "标题/确定/取消", "确定/取消"], ["标题/描述/确定/取消", "标题/确定/取消", "确定/取消"]]
    }
}

//MARK: - 二、弹框(描述信息是：富文本)
extension JKAlertViewControllerViewController {
    
    //MARK: 2.3、确定/取消
    @objc func test23() {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributedString = NSMutableAttributedString(string: "予观夫巴陵胜状注，在洞庭一湖。衔远山，吞长江，浩浩汤汤，横无际涯注，朝晖夕阴注，气象万千，此则岳阳楼之大观也注，前人之述备矣注。").color(.brown).font(UIFont.systemFont(ofSize: 22)).kern(10).paragraphStyle(style)
        let alert = JKAlertViewController(title: "标题", attributedMessage: attributedString, preferredStyle: .alert)
        let cancelAction = JKAlertAction(title: "取消", style: .blue)
        let sureAction = JKAlertAction(title: "确定", style: .cancel) { (action: JKAlertAction) in
            debugPrint("确定......")
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: 2.2、标题/确定/取消
    @objc func test22() {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributedString = NSMutableAttributedString(string: "予观夫巴陵胜状注，在洞庭一湖。衔远山，吞长江，浩浩汤汤，横无际涯注，朝晖夕阴注，气象万千，此则岳阳楼之大观也注，前人之述备矣注。").color(.red).font(UIFont.systemFont(ofSize: 26)).kern(10).paragraphStyle(style)
        let alert = JKAlertViewController(title: "标题", attributedMessage: attributedString, preferredStyle: .alert)
        let cancelAction = JKAlertAction(title: "取消", style: .blue)
        let sureAction = JKAlertAction(title: "确定", style: .cancel) { (action: JKAlertAction) in
            debugPrint("确定......")
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: 2.1、标题/描述/确定/取消
    @objc func test21() {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributedString = NSMutableAttributedString(string: "予观夫巴陵胜状注，在洞庭一湖。衔远山，吞长江，浩浩汤汤，横无际涯注，朝晖夕阴注，气象万千，此则岳阳楼之大观也注，前人之述备矣注。").color(.green).font(UIFont.systemFont(ofSize: 22)).kern(20).paragraphStyle(style)
        let alert = JKAlertViewController(title: "标题", attributedMessage: attributedString, preferredStyle: .alert)
        alert.backgroundTouchIsEnabled = true
        let cancelAction = JKAlertAction(title: "取消", style: .blue)
        let sureAction = JKAlertAction(title: "确定", style: .cancel) { (action: JKAlertAction) in
            debugPrint("确定......")
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - 一、弹框(描述信息是：基本文本)
extension JKAlertViewControllerViewController {
    
    //MARK: 1.3、确定/取消
    @objc func test13() {
        let alert = JKAlertViewController()
        let cancelAction = JKAlertAction(title: "取消", style: .blue)
        let sureAction = JKAlertAction(title: "确定", style: .cancel) { (action: JKAlertAction) in
            debugPrint("确定......")
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: 1.2、标题/确定/取消
    @objc func test12() {
        let alert = JKAlertViewController(title: "标题")
        let cancelAction = JKAlertAction(title: "取消", style: .blue)
        let sureAction = JKAlertAction(title: "确定", style: .cancel) { (action: JKAlertAction) in
            debugPrint("确定......")
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: 1.1、标题/描述/确定/取消
    @objc func test11() {
        let alert = JKAlertViewController(title: "标题", message: "描述信息")
        alert.backgroundTouchIsEnabled = true
        let cancelAction = JKAlertAction(title: "取消", style: .blue)
        let sureAction = JKAlertAction(title: "确定", style: .cancel) { (action: JKAlertAction) in
            debugPrint("确定......")
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
