//
//  CGFloat+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/10.
//

import UIKit

extension CGFloat {
    
    // MARK: 角度转弧度
    /// 角度转弧度
    /// - Returns: 弧度
    public func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
}
