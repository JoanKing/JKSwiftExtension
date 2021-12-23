//
//  JKPOP+String.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/23.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit

extension String: JKPOPCompatible {}
extension NSString: JKPOPCompatible {}

extension JKPOP where Base: ExpressibleByStringLiteral {
    
    func numberCount() -> Int {
        let string = base as! String
        var count = 0
        for c in string where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
}
