//
//  JKClosure.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/12.
//

import Foundation
import UIKit

/// View的闭包
public typealias ViewClosure = ((UITapGestureRecognizer?, UIView, NSInteger) ->Void)
/// 手势的闭包
public typealias RecognizerClosure = ((UIGestureRecognizer) ->Void)
/// UIControl闭包
public typealias ControlClosure = ((UIControl) ->Void)
