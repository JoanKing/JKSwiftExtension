//
//  JKCustomPickViewViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2023/2/14.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class JKCustomPickViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pickerView = JKSoundPickView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), dataSource: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29"], inComponent: 2)
//        pickerView.rowAndComponentCallBack = {(resultStr) in
//            debugPrint(resultStr as Any)
//        }
        pickerView.show()
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
