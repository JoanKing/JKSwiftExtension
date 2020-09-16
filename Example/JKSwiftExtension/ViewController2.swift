//
//  ViewController2.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    
        print(test3(true, false))
        
    }
    
    func test3 (_ a : Bool ,_ b :@autoclosure ()-> Bool) -> Bool {
    
        guard a else {
            return false
        }
        return b()
    }
    
    func test10() {
        test(a: 3) { (a1) -> (Int) in
            return a1 + 2
        }
        
        test(a: 5) { $0 + 2 }
        
        test1(a: 10, 20)
        
        print("HH = \(HH(optional: nil, defaultValue: 3))")
    }
    
    func HH<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
        switch optional {
        case .some(let value):
            return value
        case .none:
            return defaultValue()
        }
    }

    func test(a: Int, fn: (Int) -> (Int)) {
        print("值=\(fn(a))")
    }
    
    func test1(a: Int, _ fn: @autoclosure () -> (Int)) {
        print("值2=\(fn())")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
