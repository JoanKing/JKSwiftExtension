//
//  JKPOP.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/24.
//

import UIKit
import Foundation
public struct JKPOP<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol JKPOPCompatible {}

public extension JKPOPCompatible {
    
    static var jk: JKPOP<Self>.Type {
        get{ JKPOP<Self>.self }
        set {}
    }
    
    var jk: JKPOP<Self> {
        get { JKPOP(self) }
        set {}
    }
}

/// Define Property protocol
internal protocol JKSwiftPropertyCompatible {
  
    /// Extended type
    associatedtype T
    
    ///Alias for callback function
    typealias SwiftCallBack = ((T?) -> ())
    
    ///Define the calculated properties of the closure type
    var swiftCallBack: SwiftCallBack?  { get set }
}
