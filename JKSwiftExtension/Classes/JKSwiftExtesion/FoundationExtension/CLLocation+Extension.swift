//
//  CLLocation+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/2/18.
//

import Foundation
import CoreLocation

extension CLLocation: JKPOPCompatible {}

// MARK:- 一、基本的扩展
public extension JKPOP where Base == CLLocation {
 
    // MARK: 1.1、地理信息反编码
    /// 地理信息反编码
    /// - Parameters:
    ///   - latitude: 精度
    ///   - longitude: 纬度
    ///   - completionHandler: 回调函数
    static func reverseGeocode(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completionHandler: @escaping CLGeocodeCompletionHandler) {
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: completionHandler)
    }
    
    // MARK: 1.2、地理信息编码
    /// 地理信息编码
    /// - Parameters:
    ///   - address: 地址信息
    ///   - completionHandler: 回调函数
    static func locationEncode(address: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: completionHandler)
    }
}
