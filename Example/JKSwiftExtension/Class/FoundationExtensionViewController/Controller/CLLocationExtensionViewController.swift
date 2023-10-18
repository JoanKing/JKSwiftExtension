//
//  CLLocationExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/2/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import CoreLocation

class CLLocationExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["地理信息反编码", "地理信息编码", "点与点之间的距离"]]
    }
}

// MARK: - 一、基本的扩展
extension CLLocationExtensionViewController {
    
    //MARK: 1.03、点与点之间的距离
    /// 点与点之间的距离
    @objc func test103() {
        let distance = CLLocation.jk.distanePointToPoint(startLocationCoordinate2D: CLLocationCoordinate2D(latitude: 220972926.67721075, longitude: 101545204.78064685), endLocationCoordinate2D: CLLocationCoordinate2D(latitude: 220923262.3887309, longitude: 101626139.60786556))
        JKPrint("点与点之间的距离：\(distance)")
    }
    
    // MARK: 1.02、地理信息编码
    @objc func test102() {
        CLLocation.jk.locationEncode(address: "南京市新街口大洋百货") { (placemarks:[CLPlacemark]?, error:Error?) in
            if error != nil {
                JKPrint("错误：\(error!.localizedDescription))")
                return
            }
            if let p = placemarks?[0]{
                JKPrint("经度：\(p.location!.coordinate.longitude)" + "纬度：\(p.location!.coordinate.latitude)")
            } else {
                JKPrint("No placemarks!")
            }
        }
    }
    
    // MARK: 1.01、地理信息反编码
    @objc func test101() {
        CLLocation.jk.reverseGeocode(latitude: 32.029171, longitude: 118.788231) { (placemarks: [CLPlacemark]?, error: Error?) in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                print("错误：\(error!.localizedDescription))")
                return
            }
            
            if let p = placemarks?[0]{
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                print(address)
            } else {
                print("No placemarks!")
            }
        }
        JKPrint("地理信息反编码")
    }
}

