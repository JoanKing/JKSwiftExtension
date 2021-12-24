//
//  JKContactsKitViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Contacts

class JKContactsKitViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、通讯录的基本使用"]
        dataArray = [["获取授权状态", "查询出所有通讯录信息", "添加新联系人", "更新联系人", "删除联系人"]]
    }
}

// MARK:- 一、通讯录的基本使用
extension JKContactsKitViewController {
    
    // MARK: 1.5、删除联系人
    @objc func test15() {
        JKContactsKit.deleteContactItem(identifier: "2177B5AE-FBF1-479D-A804-AAFBFFA58996:ABPerson") { (result, error) in
            print("更新联系人的结果：\(result)")
        }
    }
    
    // MARK: 1.4、更新联系人
    @objc func test14() {
        // 设置姓名
        let familyName = "Wang"
        let givenName = "Chong新的"
        // 设置电话
        let mobileNumber = CNPhoneNumber(stringValue: "18510002000")
        let mobileValue = CNLabeledValue(label: CNLabelPhoneNumberMobile,
                                         value: mobileNumber)
        JKContactsKit.updateContactItem(identifier: "177C371E-701D-42F8-A03B-C61CA31627F6", familyName: familyName, givenName: givenName, phoneNumbers: [mobileValue]) { (result, error) in
            print("更新联系人的结果：\(result)")
        }
    }
    
    // MARK: 1.3、添加新联系人
    @objc func test13() {
        
        // 创建CNMutableContact类型的实例
        let contactToAdd = CNMutableContact()
        
        // 设置姓名
        contactToAdd.familyName = "王"
        contactToAdd.givenName = "充"
        
        // 设置昵称
        contactToAdd.nickname = "fly"
        
        // 设置头像
        let image = UIImage(named: "testicon")!
        contactToAdd.imageData = image.pngData()
        
        // 设置电话
        let mobileNumber = CNPhoneNumber(stringValue: "18510002000")
        let mobileValue = CNLabeledValue(label: CNLabelPhoneNumberMobile,
                                         value: mobileNumber)
        contactToAdd.phoneNumbers = [mobileValue]
        
        // 设置email
        let email = CNLabeledValue(label: CNLabelHome, value: "feifei@163.com" as NSString)
        contactToAdd.emailAddresses = [email]
        
        JKContactsKit.addContactItem(contact: contactToAdd) { (result, error) in
            print("添加的结果：\(result)")
        }
    }
    
    // MARK: 1.2、查询出所有通讯录信息
    @objc func test12() {
        JKContactsKit.selectContactsData { (contacts, error) in
            print("联系人的数量：\(contacts.count)")
            for (_, contact) in contacts.enumerated() {
                print("线程：\(Thread.current)-------------------------------")
                print("唯一标识符：\(contact.identifier)")
                // 1.获取姓名
                let lastName = contact.familyName
                let firstName = contact.givenName
                print("姓名 : \(lastName)\(firstName)")
                // 2.获取昵称
                let nikeName = contact.nickname
                print("昵称：\(nikeName)")
                // 3.获取公司（组织）
                let organization = contact.organizationName
                print("公司（组织）：\(organization)")
                // 4.获取电话号码
                let phoneNumbers = contact.phoneNumbers
                for phoneNumber in phoneNumbers {
                    print("手机号：\(phoneNumber.value.stringValue)")
                }
            }
        }
    }
    
    // MARK: 1.1、获取授权状态
    @objc func test11() {
        let status = JKContactsKit.authorizationStatus()
        if status == .authorized {
            print("已经授权")
        } else if status == .notDetermined {
            print("未知，第一次申请权限")
        } else if status == .denied {
            print("拒绝授权")
        } else if status == .restricted {
            print("此应用程序没有被授权访问的联系人数据。可能是家长控制权限")
        }
    }
}
