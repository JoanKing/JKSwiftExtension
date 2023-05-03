//
//  JKUnitConverterViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/4/21.
//  Copyright © 2023 CocoaPods. All rights reserved.
//
//MARK: - 单位转换
import UIKit

class JKUnitConverterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、距离", "二、重量", "三、温度"]
        dataArray = [["米(m) => 公里(km)", "公里(km) => 米(m)", "英尺(ft) => 英里(mi)", "英里(mi) => 英尺(ft)", "公里(km) => 英里(mi)", "英里(mi) => 公里(km)"], ["千克(kg) => 磅(lb)", "磅(lb) => 千克(kg)"], ["摄氏度(℃) => 华氏度(℉)", "华氏度(℉) => 摄氏度(℃)"]]
    }
}

//MARK: - 三、温度
extension JKUnitConverterViewController {
    
    //MARK: 3.2、华氏度(℉) => 摄氏度(℃)
    @objc func test32() {
        let fValue = 1
        let cValue = JKUnitConverter.temperatureFToC(temperatureF: "\(fValue)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(cValue)华氏度(℉)转为摄氏度(℃)：\(cValue)")
    }
    
    //MARK: 3.1、摄氏度(℃) <=> 华氏度(℉)
    @objc func test31() {
        let cValue = 1
        let fValue = JKUnitConverter.temperatureCToF(temperatureC: "\(cValue)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(cValue)摄氏度(℃)转为华氏度(℉)：\(fValue)")
    }
}

// MARK: - 二、重量
extension JKUnitConverterViewController {
    //MARK: 2.2、磅(lb) => 千克(kg)
    @objc func test22() {
        let lbValue = 2
        let kgValue = JKUnitConverter.lbToKg(lb: "\(lbValue)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(lbValue)磅(lb)转为千克(kg)：\(kgValue)")
    }
    
    //MARK: 2.1、千克(kg) => 磅(lb)
    @objc func test21() {
        let kgValue = 2
        let lbValue = JKUnitConverter.kgToLb(kg: "\(kgValue)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(kgValue)千克(kg)转磅(lb)为：\(lbValue)")
    }
}

// MARK: - 一、距离
extension JKUnitConverterViewController {
    
    // MARK: 1.6、英里(mi) => 公里(km)
    @objc func test16() {
        let mile = 1
        let kilometer = JKUnitConverter.mileTokilometer(mile: "\(mile)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(mile)英里(mi)转公里(km)为：\(kilometer)")
    }
    
    // MARK: 1.5、公里(km) => 英里(mi)
    @objc func test15() {
        let kilometer = 1
        let mile = JKUnitConverter.kilometerToMile(kilometer: "\(kilometer)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(kilometer)公里(km)转英里(mi)为：\(mile)")
    }
    
    // MARK: 1.4、英里(mi) => 英尺(ft)
    @objc func test14() {
        let mile = 1
        let foot = JKUnitConverter.mileToFoot(mile: "\(mile)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(mile)英里(mi)转英尺(ft)为：\(foot)")
    }
    
    // MARK: 1.3、英尺(ft) => 英里(mi)
    @objc func test13() {
        let foot = 5288
        let mile = JKUnitConverter.footToMile(foot: "\(foot)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(foot)英尺(ft)转英里(mi)为：\(mile)")
    }
    
    // MARK: 1.2、公里(km) => 米(m)
    @objc func test12() {
        let kilometer = 3
        let meter = JKUnitConverter.kilometerToMeter(kilometer: "\(kilometer)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(kilometer)公里(km)转米(m)为：\(meter)")
    }
    
    // MARK: 1.1、米(m) => 公里(km)
    @objc func test11() {
        let meter = 80
        let kilometer = JKUnitConverter.meterToKilometer(meter: "\(meter)", isNeedUint: true, scale: 1, roundingMode: .plain)
        JKPrint("\(meter)米(m)转公里(km)为：\(kilometer)")
    }
}
