//
//  ArrayExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/10/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ArrayExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Array+Extension"
        view.backgroundColor = .randomColor
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        test()
    }
    
    func test() {
        var array = Array(["1","2","1","3"])
        array.removeArr(["1","3"], isRepeat: true)
        print(array,"5")
        JKPrint("1", "3")
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
