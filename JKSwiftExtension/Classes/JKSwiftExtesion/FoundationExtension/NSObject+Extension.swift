//
//  NSObject+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/18.
//

import UIKit

public extension NSObject {
    
    /// 类名
    var className: String {
        return type(of: self).className
    }
    
    /// 类名
    static var className: String {
        return String(describing: self)
    }
}

