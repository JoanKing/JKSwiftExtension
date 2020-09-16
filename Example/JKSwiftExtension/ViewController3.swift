//
//  ViewController3.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class S {
    var foo = "foo"

    func method1() {
        doWork {
            print("method1：\(foo)")
        }
        foo = "bar"
    }

    func method2() {
        doWorkAsync {
            print("method2：\(self.foo)")
        }
        foo = "bar"
    }
    
    func method3() {
        doWorkAsync {
            
        }
        doWorkAsync {
            [weak self] in
            guard let weakSelf = self else { return }
            print("method3：\(weakSelf.foo)")
        }
        foo = "bar"
    }
    
    func doWorkAsync(block: @escaping ()->()) {
        DispatchQueue.main.async {
            block()
        }
    }
    
    func doWork(block: ()->()) {
        print("doWork--begin")
        block()
        print("doWork--end")
    }
}

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        S().method1() // foo
        S().method2() // bar
        S().method3() // nil
        
       
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
