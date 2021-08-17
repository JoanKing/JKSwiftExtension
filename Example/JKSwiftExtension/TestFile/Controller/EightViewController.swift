//
//  EightViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2021/8/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class EightViewController: UIViewController {

    var sectionTimeArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        var array1 = ["1", "2", "3"]
        var array2 = [["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"]]
        
        print("array1: \(array1.removeFirst())\n新的array1：\(array1)\narray2:\(array2.removeFirst())\n新的array2:\(array2)")
    }
    
    func test<T>(array: [String], array1: [T]) -> ([String], [[String]]) {
        // 局部数组
        var sectionPartialArray: [String] = []
        var dataArray: [[String]] = []
        var dataArray2: [[T]] = []
        for item in array {
            let dateString = Date.jk.timestampToFormatterTimeString(timestamp: item, format: "yyyy-MM-dd")
            if !sectionTimeArray.contains(dateString) {
                sectionTimeArray.append(dateString)
            }
            if sectionPartialArray.contains(dateString), let index = sectionPartialArray.firstIndex(of: dateString), dataArray.count > index {
                var array = dataArray[index]
                array.append(item)
                dataArray[index] = array
            } else {
                sectionPartialArray.append(dateString)
                dataArray.append([item])
            }
        }
        
        print("section：\(sectionPartialArray)\n 单个数组：\(dataArray)")
        return (sectionPartialArray, dataArray)
    }
}
