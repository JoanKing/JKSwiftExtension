//
//  TestViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    /// 消息的数量
    fileprivate var messageCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "JKSwiftExtension"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        let right1 = UIBarButtonItem(title: "old", style: .plain, target: self, action: #selector(click1))
        let right2 = UIBarButtonItem(title: "new", style: .plain, target: self, action: #selector(click2))
        self.navigationItem.rightBarButtonItems = [right1,right2]
        
        NotificationCenter.default.addObserver(self, selector: #selector(click2), name: NSNotification.Name.FBTradeHomeListDataNotification, object: nil)
    }
    
    @objc func clickk() {
        print("哈哈")
    }
    
    @objc func click1() {
        messageCount = 10
    }
    
    @objc func click2() {
        judegeIsTodayResuestData()
    }
    
}

// MARK:- 导航栏信息的处理
extension TestViewController {
    // MARK: 对消息弹框的判断
    /**
     判断是否是今天第一次请求交易接口（在接口请求结束后调用，判断寸存的时间戳和当前的时间戳是否是同一天， 是的话就不弹框，不是的话就看下消息的数量是不是大于 0 ，大于 0 就弹框，否则不弹框）
     */
    /// 对消息弹框的判断
    fileprivate func judegeIsTodayResuestData() {
        // 1.判断是否有存的时间戳，没有的话进行存储当前的时间戳，并进行消息数量的判断
        guard let timeString = UserDefaults.userDefaultsGetValue(key: "TradeMessageTodayIsFirstShow") as? String else {
            print("存储的时间戳是：\(Date.secondStamp)")
            messageMoreZero()
            return
        }
        print("存在时间戳，时间戳是：\(timeString)")
        guard let timeStringValue = timeString.toDouble() else {
            return
        }
        let date = Date(timeIntervalSince1970: timeStringValue)
        // 2.判断是不是今天
        if date.isToday {
            print("存在时间戳是：当天")
            return
        }
        // 3.不是今天就进行消息是否 大于 0 的判断
        messageMoreZero()
    }
    
    // MARK: 消息大于 0 的处理
    /// 消息大于 0 的处理
    /// - Returns: description
    fileprivate func messageMoreZero() {
        guard messageCount > 0 else {
            print("消息数量是：0")
            return
        }
        
        guard UIViewController.getCurrentVC().isMember(of: ViewController.self) else {
            print("不在当前控制器")
            return
        }
        
        // 存储当天的时间戳
        UserDefaults.userDefaultsSetValue(value: Date.secondStamp, key: "TradeMessageTodayIsFirstShow")
        
        // 消息大于0弹框
        // 有未读的消息就弹框提示
        let alertController = UIAlertController(title: "您当前有未读的交易消息，请前往消息中心确认", message: "", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "确认", style: .destructive) {[weak self] (action) in
            guard let _ = self else { return }
            
        }
        alertController.addAction(actionYes)
        self.present(alertController, animated: true, completion: nil)
    }
}
