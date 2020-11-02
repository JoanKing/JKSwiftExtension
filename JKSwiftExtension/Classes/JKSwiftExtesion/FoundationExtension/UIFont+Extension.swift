//
//  UIFont+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/11/2.
//

import Foundation

// MARK:- 一、常用的基本字体扩展
extension UIFont {
    
    // MARK: 42号字体
    public private(set) static var f42Bold: UIFont = UIFont.fontBold(42)
    public private(set) static var f42Medium: UIFont = UIFont.fontMedium(42)
    public private(set) static var f42Light: UIFont = UIFont.fontLight(42)
    public private(set) static var f42: UIFont = UIFont.systemFont(ofSize: 42)
    
    // MARK: 40号字体
    public private(set) static var f40Bold: UIFont = UIFont.fontBold(40)
    public private(set) static var f40Medium: UIFont = UIFont.fontMedium(40)
    public private(set) static var f40Light: UIFont = UIFont.fontLight(40)
    public private(set) static var f40: UIFont = UIFont.systemFont(ofSize: 40)
    
    // MARK: 36号字体
    public private(set) static var f36Bold: UIFont = UIFont.fontBold(36)
    public private(set) static var f36Medium: UIFont = UIFont.fontMedium(36)
    public private(set) static var f36Light: UIFont = UIFont.fontLight(36)
    public private(set) static var f36: UIFont = UIFont.systemFont(ofSize: 36)
    
    // MARK: 32号字体
    public private(set) static var f32Bold: UIFont = UIFont.fontBold(32)
    public private(set) static var f32Medium: UIFont = UIFont.fontMedium(32)
    public private(set) static var f32Light: UIFont = UIFont.fontLight(32)
    public private(set) static var f32: UIFont = UIFont.systemFont(ofSize: 32)
    
    // MARK: 30 号字体
    public private(set) static var f30Bold: UIFont = UIFont.fontBold(30)
    public private(set) static var f30Medium: UIFont = UIFont.fontMedium(30)
    public private(set) static var f30Light: UIFont = UIFont.fontLight(30)
    public private(set) static var f30: UIFont = UIFont.systemFont(ofSize: 30)
    
    // MARK: 29 号字体
    public private(set) static var f29Bold: UIFont = UIFont.fontBold(29)
    public private(set) static var f29Medium: UIFont = UIFont.fontMedium(29)
    public private(set) static var f29Light: UIFont = UIFont.fontLight(29)
    public private(set) static var f29: UIFont = UIFont.systemFont(ofSize: 29)
    
    // MARK: 28 号字体
    public private(set) static var f28Bold: UIFont = UIFont.fontBold(28)
    public private(set) static var f28Medium: UIFont = UIFont.fontMedium(28)
    public private(set) static var f28Light: UIFont = UIFont.fontLight(28)
    public private(set) static var f28: UIFont = UIFont.systemFont(ofSize: 28)
    
    // MARK: 27 号字体
    public private(set) static var f27Bold: UIFont = UIFont.fontBold(27)
    public private(set) static var f27Medium: UIFont = UIFont.fontMedium(27)
    public private(set) static var f27Light: UIFont = UIFont.fontLight(27)
    public private(set) static var f27: UIFont = UIFont.systemFont(ofSize: 27)
    
    // MARK: 26 号字体
    public private(set) static var f26Bold: UIFont = UIFont.fontBold(26)
    public private(set) static var f26Medium: UIFont = UIFont.fontMedium(26)
    public private(set) static var f26Light: UIFont = UIFont.fontLight(26)
    public private(set) static var f26: UIFont = UIFont.systemFont(ofSize: 26)
    
    // MARK: 25 号字体
    public private(set) static var f259Bold: UIFont = UIFont.fontBold(25)
    public private(set) static var f25Medium: UIFont = UIFont.fontMedium(25)
    public private(set) static var f25Light: UIFont = UIFont.fontLight(25)
    public private(set) static var f25: UIFont = UIFont.systemFont(ofSize: 25)
    
    // MARK: 24 号字体
    public private(set) static var f24Bold: UIFont = UIFont.fontBold(24)
    public private(set) static var f24Medium: UIFont = UIFont.fontMedium(24)
    public private(set) static var f24Light: UIFont = UIFont.fontLight(24)
    public private(set) static var f24: UIFont = UIFont.systemFont(ofSize: 24)
    
    // MARK: 23 号字体
    public private(set) static var f23Bold: UIFont = UIFont.fontBold(23)
    public private(set) static var f23Medium: UIFont = UIFont.fontMedium(23)
    public private(set) static var f23Light: UIFont = UIFont.fontLight(23)
    public private(set) static var f23: UIFont = UIFont.systemFont(ofSize: 23)
    
    // MARK: 22 号字体
    public private(set) static var f22Bold: UIFont = UIFont.fontBold(22)
    public private(set) static var f22Medium: UIFont = UIFont.fontMedium(22)
    public private(set) static var f22Light: UIFont = UIFont.fontLight(22)
    public private(set) static var f22: UIFont = UIFont.systemFont(ofSize: 22)
    
    // MARK: 21 号字体
    public private(set) static var f21Bold: UIFont = UIFont.fontBold(21)
    public private(set) static var f21Medium: UIFont = UIFont.fontMedium(21)
    public private(set) static var f21Light: UIFont = UIFont.fontLight(21)
    public private(set) static var f21: UIFont = UIFont.systemFont(ofSize: 21)
    
    // MARK: 20 号字体
    public private(set) static var f20Bold: UIFont = UIFont.fontBold(20)
    public private(set) static var f20Medium: UIFont = UIFont.fontMedium(20)
    public private(set) static var f20Light: UIFont = UIFont.fontLight(20)
    public private(set) static var f20: UIFont = UIFont.systemFont(ofSize: 20)
    
    // MARK: 19 号字体
    public private(set) static var f19Bold: UIFont = UIFont.fontBold(19)
    public private(set) static var f19Medium: UIFont = UIFont.fontMedium(19)
    public private(set) static var f19Light: UIFont = UIFont.fontLight(19)
    public private(set) static var f19: UIFont = UIFont.systemFont(ofSize: 19)
    
    // MARK: 18 号字体
    public private(set) static var f18Bold: UIFont = UIFont.fontBold(18)
    public private(set) static var f18Medium: UIFont = UIFont.fontMedium(18)
    public private(set) static var f18Light: UIFont = UIFont.fontLight(18)
    public private(set) static var f18: UIFont = UIFont.systemFont(ofSize: 18)
    
    // MARK: 17 号字体
    public private(set) static var f17Bold: UIFont = UIFont.fontBold(17)
    public private(set) static var f17Medium: UIFont = UIFont.fontMedium(17)
    public private(set) static var f17Light: UIFont = UIFont.fontLight(17)
    public private(set) static var f17: UIFont = UIFont.systemFont(ofSize: 17)
    
    // MARK: 16 号字体
    public private(set) static var f16Bold: UIFont = UIFont.fontBold(16)
    public private(set) static var f16Medium: UIFont = UIFont.fontMedium(16)
    public private(set) static var f16Light: UIFont = UIFont.fontLight(16)
    public private(set) static var f16: UIFont = UIFont.systemFont(ofSize: 16)
    
    // MARK: 15 号字体
    public private(set) static var f15Bold: UIFont = UIFont.fontBold(15)
    public private(set) static var f15Medium: UIFont = UIFont.fontMedium(15)
    public private(set) static var f15Light: UIFont = UIFont.fontLight(15)
    public private(set) static var f15: UIFont = UIFont.systemFont(ofSize: 15)
    
    // MARK: 14 号字体
    public private(set) static var f14Bold: UIFont = UIFont.fontBold(14)
    public private(set) static var f14Medium: UIFont = UIFont.fontMedium(14)
    public private(set) static var f14Light: UIFont = UIFont.fontLight(14)
    public private(set) static var f14: UIFont = UIFont.systemFont(ofSize: 14)
    
    // MARK:- 13 号字体
    public private(set) static var f13Bold: UIFont = UIFont.fontBold(13)
    public private(set) static var f13Medium: UIFont = UIFont.fontMedium(13)
    public private(set) static var f13Light: UIFont = UIFont.fontLight(13)
    public private(set) static var f13: UIFont = UIFont.systemFont(ofSize: 13)
    
    // MARK: 12 号字体
    public private(set) static var f12Bold: UIFont = UIFont.fontBold(12)
    public private(set) static var f12Medium: UIFont = UIFont.fontMedium(12)
    public private(set) static var f12Light: UIFont = UIFont.fontLight(12)
    public private(set) static var f12: UIFont = UIFont.systemFont(ofSize: 12)
    
    // MARK: 10 号字体
    public private(set) static var f10Bold: UIFont = UIFont.fontBold(10)
    public private(set) static var f10Medium: UIFont = UIFont.fontMedium(10)
    public private(set) static var f10Light: UIFont = UIFont.fontLight(10)
    public private(set) static var f10: UIFont = UIFont.systemFont(ofSize: 10)
    
    // MARK: 8 号字体
    public private(set) static var f8Bold: UIFont = UIFont.fontBold(8)
    public private(set) static var f8Medium: UIFont = UIFont.fontMedium(8)
    public private(set) static var f8Light: UIFont = UIFont.fontLight(8)
    public private(set) static var f8: UIFont = UIFont.systemFont(ofSize: 8)
    
    // MARK: 6 号字体
    public private(set) static var f6Bold: UIFont = UIFont.fontBold(6)
    public private(set) static var f6Medium: UIFont = UIFont.fontMedium(6)
    public private(set) static var f6Light: UIFont = UIFont.fontLight(6)
    public private(set) static var f6: UIFont = UIFont.systemFont(ofSize: 6)
    
    /// light 字体
    /// - Parameter fontSize: 字体大小
    /// - Returns: UIFont
    static func fontLight(_ fontSize: CGFloat) -> UIFont {
        return isIPhone4 || isIPhone5 ? UIFont.systemFont(ofSize: fontSize - 1, weight: UIFont.Weight.light) : UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.light)
    }
    
    /// medium 字体
    /// - Parameter fontSize: 字体大小
    /// - Returns: UIFont
    static func fontMedium(_ fontSize: CGFloat) -> UIFont {
        return isIPhone4 || isIPhone5 ? UIFont.systemFont(ofSize: fontSize - 1, weight: UIFont.Weight.medium) : UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
    }
    
    /// bold 字体
    /// - Parameter fontSize: 字体大小
    /// - Returns: UIFont
    static func fontBold(_ fontSize: CGFloat) -> UIFont {
        return isIPhone4 || isIPhone5 ? UIFont.boldSystemFont(ofSize: 5) : UIFont.boldSystemFont(ofSize: 6)
    }
}


