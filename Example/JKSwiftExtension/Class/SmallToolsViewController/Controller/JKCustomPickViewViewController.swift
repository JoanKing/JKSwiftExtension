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
        let pickerView = JKCustomPickView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), dataSource: ["永久", "30天", "29天", "28天", "27天", "26天", "25天", "24天", "22天", "21天", "20天", "19天", "18天", "17天", "16天", "15天", "14天", "13天", "12天", "11天", "10天", "9天", "8天", "7天", "6天", "5天", "4天", "3天", "2天", "1天"], inComponent: 2)
        pickerView.rowAndComponentCallBack = {(resultStr) in
            debugPrint(resultStr as Any)
        }
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
