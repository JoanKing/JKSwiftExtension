//
//  UIFont+Extensin.swift
//  JKLive
//
//  Created by 王冲 on 2020/7/24.
//  Copyright © 2020 王冲. All rights reserved.
//

import Foundation

extension UIFont {
    // MARK:- 42号字体
    /// 42号字体 -- 加粗
    public private(set) static var f42Bold: UIFont = UIFont.boldSystemFont(ofSize: 42)
    // MARK:- 40号字体
    public private(set) static var f40: UIFont = UIFont.systemFont(ofSize: 40)
    // MARK:- 36号字体
    public private(set) static var f36Bold: UIFont = UIFont.boldSystemFont(ofSize: 36)
    public private(set) static var f36: UIFont = UIFont.systemFont(ofSize: 36)
    // MARK:- 32号字体
    public private(set) static var f32Bold: UIFont = UIFont.boldSystemFont(ofSize: 32)
    // MARK:- 28号字体
    public private(set) static var f28Bold: UIFont = UIFont.boldSystemFont(ofSize: 28)
    // MARK:- 24号字体
    public private(set) static var f24Bold: UIFont = UIFont.boldSystemFont(ofSize: 24)
    public private(set) static var f24Medium: UIFont = UIFont.systemFont(ofSize: 24, weight: .medium)
    public private(set) static var f24: UIFont = UIFont.systemFont(ofSize: 24)
    // MARK:- 22号字体
    public private(set) static var f22: UIFont = UIFont.systemFont(ofSize: 22)
    public private(set) static var f22Bold: UIFont = UIFont.boldSystemFont(ofSize: 22)
    public private(set) static var f21: UIFont = UIFont.systemFont(ofSize: 21)
    // MARK:- 20号字体
    public private(set) static var f20Bold: UIFont = UIFont.boldSystemFont(ofSize: 20)
    public private(set) static var f20Medium: UIFont = UIFont.systemFont(ofSize: 20, weight: .medium)
    public private(set) static var f20: UIFont = UIFont.systemFont(ofSize: 20)
    // MARK:- 18号字体
    public private(set) static var f18Bold: UIFont = iPhone4 || iPhone5 ? UIFont.boldSystemFont(ofSize: 17) : UIFont.boldSystemFont(ofSize: 18)
    public private(set) static var f18Medium: UIFont = UIFont.systemFont(ofSize: 18, weight: .medium)
    public private(set) static var f18: UIFont = UIFont.systemFont(ofSize: 18)
    // MARK:- 17号字体
    public private(set) static var f17Bold: UIFont = iPhone4 || iPhone5 ? UIFont.boldSystemFont(ofSize: 16) : UIFont.boldSystemFont(ofSize: 17)
    public private(set) static var f17: UIFont = UIFont.systemFont(ofSize: 17)
    // MARK:- 15号字体
    public private(set) static var f16Bold: UIFont = iPhone4 || iPhone5 ? UIFont.boldSystemFont(ofSize: 15) : UIFont.boldSystemFont(ofSize: 16)
    public private(set) static var f16Light: UIFont = iPhone4 || iPhone5 ? UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light) : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
    public private(set) static var f16Medium: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    public private(set) static var f16: UIFont = UIFont.systemFont(ofSize: 16)
    // MARK:- 15号字体
    public private(set) static var f15Bold: UIFont = iPhone4 || iPhone5 ? UIFont.boldSystemFont(ofSize: 14) : UIFont.boldSystemFont(ofSize: 15)
    public private(set) static var f15Medium: UIFont = iPhone4 || iPhone5 ? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium) : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
    public private(set) static var f15Light: UIFont = iPhone4 || iPhone5 ? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light) : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
    public private(set) static var f15: UIFont = UIFont.systemFont(ofSize: 15)
    // MARK:- 14号字体
    public private(set) static var f14Bold: UIFont = iPhone4 || iPhone5 ? UIFont.boldSystemFont(ofSize: 13) : UIFont.boldSystemFont(ofSize: 14)
    public private(set) static var f14: UIFont = UIFont.systemFont(ofSize: 14)
    // MARK:- 13号字体
    public private(set) static var f13: UIFont = UIFont.systemFont(ofSize: 13)
    public private(set) static var f13Bold: UIFont = iPhone4 || iPhone5 ? UIFont.boldSystemFont(ofSize: 12) : UIFont.boldSystemFont(ofSize: 13)
    public private(set) static var f13Light: UIFont = iPhone4 || iPhone5 ? UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light) : UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.light)
    // MARK:- 12号字体
    public private(set) static var f12: UIFont = UIFont.systemFont(ofSize: 12)
    public private(set) static var f12Bold: UIFont = UIFont.boldSystemFont(ofSize: 12)
    public private(set) static var f12Light: UIFont = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
    // MARK:- 10号字体
    public private(set) static var f10: UIFont = UIFont.systemFont(ofSize: 10)
    // MARK:- 8号字体
    public private(set) static var f8: UIFont = UIFont.systemFont(ofSize: 8)
}

