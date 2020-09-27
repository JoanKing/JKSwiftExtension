//
//  SectorProgressViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/9/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class SectorProgressViewController: UIViewController {

    lazy var sectorProgressView: SectorProgressView = {
        let view = SectorProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.center = self.view.center
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扇形进度"
        self.view.backgroundColor = .yellow
        
        self.view.addSubview(sectorProgressView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sectorProgressView.progress = 0.8
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
