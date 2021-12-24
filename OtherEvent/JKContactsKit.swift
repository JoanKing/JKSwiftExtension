//
//  JKContactsKit.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/3/23.
//
// MARK:- 通讯录相关的组件
import Foundation
import Contacts

/**
 在 iOS9.0 之前, 我们只能通过 AddressBook 框架来获取通讯录联系人信息。但 AddressBook framework 语法很奇怪，同时也十分难用。所以苹果从 iOS9.0 开始推出的全新的联系人框架 Contacts FrameWork 作为替代，同时将原来的 AddressBook 给废弃掉。
 
 Contacts FrameWork 同样包含两种访问通讯录的方式：
 ContactsUI.framework 框架 ： 通过系统提供的通讯录交互界面来访问（替代原先的 AddressBookUI.framework）
 Contacts.framework 框架 ： 没有界面，通过代码来获取所有联系人信息（替代原先的 AddressBook.framework）
 
 由于苹果安全策略更新，在使用 Xcode8 开发时，需要在 Info.plist 配置请求通讯录的相关描述字段（Privacy - Contacts Usage Description）
 
 //  标识符
 @available(iOS 9.0, *)
 public let CNContactIdentifierKey: String
 // 姓名前缀
 @available(iOS 9.0, *)
 public let CNContactNamePrefixKey: String
 // 姓名
 @available(iOS 9.0, *)
 public let CNContactGivenNameKey: String
 // 中间名
 @available(iOS 9.0, *)
 public let CNContactMiddleNameKey: String
 // 姓氏
 @available(iOS 9.0, *)
 public let CNContactFamilyNameKey: String
 // 之前的姓氏(ex:国外的女士)
 @available(iOS 9.0, *)
 public let CNContactPreviousFamilyNameKey: String
 // 姓名后缀
 @available(iOS 9.0, *)
 public let CNContactNameSuffixKey: String
 // 昵称
 @available(iOS 9.0, *)
 public let CNContactNicknameKey: String
 // 公司(组织)
 @available(iOS 9.0, *)
 public let CNContactOrganizationNameKey: String
 // 部门
 @available(iOS 9.0, *)
 public let CNContactDepartmentNameKey: String
 // 职位
 @available(iOS 9.0, *)
 public let CNContactJobTitleKey: String
 // 名字的拼音或音标
 @available(iOS 9.0, *)
 public let CNContactPhoneticGivenNameKey: String
 // 中间名的拼音或音标
 @available(iOS 9.0, *)
 public let CNContactPhoneticMiddleNameKey: String
 // 形式的拼音或音标
 @available(iOS 9.0, *)
 public let CNContactPhoneticFamilyNameKey: String
 // 公司(组织)的拼音或音标(iOS10 才开始存在的呢)
 @available(iOS 10.0, *)
 public let CNContactPhoneticOrganizationNameKey: String
 // 生日
 @available(iOS 9.0, *)
 public let CNContactBirthdayKey: String
 // 农历
 @available(iOS 9.0, *)
 public let CNContactNonGregorianBirthdayKey: String
 // 备注
 @available(iOS 9.0, *)
 public let CNContactNoteKey: String
 // 头像
 @available(iOS 9.0, *)
 public let CNContactImageDataKey: String
 // 头像的缩略图
 @available(iOS 9.0, *)
 public let CNContactThumbnailImageDataKey: String
 // 头像是否可用
 @available(iOS 9.0, *)
 public let CNContactImageDataAvailableKey: String
 // 类型
 @available(iOS 9.0, *)
 public let CNContactTypeKey: String
 // 电话号码
 @available(iOS 9.0, *)
 public let CNContactPhoneNumbersKey: String
 // 邮箱地址
 @available(iOS 9.0, *)
 public let CNContactEmailAddressesKey: String
 // 住址
 @available(iOS 9.0, *)
 public let CNContactPostalAddressesKey: String
 // 其他日期
 @available(iOS 9.0, *)
 public let CNContactDatesKey: String
 // url地址
 @available(iOS 9.0, *)
 public let CNContactUrlAddressesKey: String
 // 关联人
 @available(iOS 9.0, *)
 public let CNContactRelationsKey: String
 // 社交
 @available(iOS 9.0, *)
 public let CNContactSocialProfilesKey: String
 // 即时通信
 @available(iOS 9.0, *)
 public let CNContactInstantMessageAddressesKey: String
 */
public class JKContactsKit: NSObject {}

// MARK:- 一、通讯录的基本使用
public extension JKContactsKit {
    // MARK: 1.1、获取授权状态
    /// 获取授权状态
    /// - Returns: 授权状态
    static func authorizationStatus() -> CNAuthorizationStatus {
        // 获取授权状态
        return CNContactStore.authorizationStatus(for: .contacts)
    }
    
    // MARK: 1.2、获取通讯录的信息
    /// 获取通讯录的信息
    /// - Parameter keys: 获取Fetch,并且指定之后要获取联系人中的什么属性
    ///   - completion: 结果闭包
    static func selectContactsData(keys: [String] = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactOrganizationNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey], completion: @escaping (([CNContact], Error?) -> Void)) {
        // 创建通讯录对象
        let store = CNContactStore()
        store.requestAccess(for: .contacts) {(granted, error) in
            if (granted) && (error == nil) {
                // 创建请求对象 需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    var contacts: [CNContact] = []
                    // 需要传入一个CNContactFetchRequest
                    try store.enumerateContacts(with: request, usingBlock: {(contact : CNContact, stop : UnsafeMutablePointer) -> Void in
                        contacts.append(contact)
                    })
                    completion(contacts, nil)
                } catch {
                    completion([], nil)
                }
            } else {
                completion([], error)
            }
        }
    }
    
    // MARK: 1.3、添加新联系人
    /// 添加新联系人
    /// - Parameters:
    ///   - contact: 联系人的信息
    ///   - completion: 结果闭包
    static func addContactItem(contact: CNMutableContact, completion: @escaping ((Bool, Error?) -> Void)) {
        // 创建通讯录对象
        let store = CNContactStore()
        store.requestAccess(for: .contacts) {(granted, error) in
            if (granted) && (error == nil) {
                // 添加联系人请求
                let saveRequest = CNSaveRequest()
                saveRequest.add(contact, toContainerWithIdentifier: nil)
                do {
                    // 写入联系人
                    try store.execute(saveRequest)
                    completion(true, nil)
                } catch {
                    completion(true, error)
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: 1.4、更新联系人
    /// 更新联系人
    /// - Parameters:
    ///   - identifier: 唯一标识符
    ///   - familyName: 姓氏
    ///   - givenName: 名字
    ///   - phoneNumbers: 手机号码数组
    ///   - keys: key
    ///   - completion: 结果闭包
    static func updateContactItem(identifier: String, familyName: String, givenName: String, phoneNumbers: [CNLabeledValue<CNPhoneNumber>], keys: [String] = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactOrganizationNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey], completion: @escaping ((Bool, Error?) -> Void)) {
        // 创建通讯录对象
        let store = CNContactStore()
        store.requestAccess(for: .contacts) {(granted, error) in
            if (granted) && (error == nil) {
                guard let itemContact = try? store.unifiedContact(withIdentifier: identifier, keysToFetch: keys as [CNKeyDescriptor]) else {
                    return
                }
                let mutableContact = itemContact.mutableCopy() as! CNMutableContact
                mutableContact.familyName = familyName
                mutableContact.givenName = givenName
                mutableContact.phoneNumbers = phoneNumbers
                // 修改联系人请求
                let request = CNSaveRequest()
                request.update(mutableContact)
                do {
                    // 修改联系人
                    try store.execute(request)
                    completion(true, error)
                } catch {
                    completion(false, error)
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: 1.5、删除联系人
    /// 删除联系人
    /// - Parameters:
    ///   - identifier: 唯一标识符
    ///   - keys: key
    ///   - completion: 结果闭包
    static func deleteContactItem(identifier: String, keys: [String] = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactOrganizationNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey], completion: @escaping ((Bool, Error?) -> Void)) {
        // 创建通讯录对象
        let store = CNContactStore()
        store.requestAccess(for: .contacts) {(granted, error) in
            if (granted) && (error == nil) {
                guard let itemContact = try? store.unifiedContact(withIdentifier: identifier, keysToFetch: keys as [CNKeyDescriptor]) else {
                    return
                }
                let mutableContact = itemContact.mutableCopy() as! CNMutableContact
                // 删除联系人请求
                let request = CNSaveRequest()
                request.delete(mutableContact)
                do {
                    // 执行操作
                    try store.execute(request)
                    completion(true, error)
                } catch {
                    completion(false, error)
                }
            } else {
                completion(false, error)
            }
        }
    }
}
