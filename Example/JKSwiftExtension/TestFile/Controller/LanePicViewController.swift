//
//  LanePicViewController.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2025/3/27.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

class LanePicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        view.addSubview(laneBackInfoAndTurnIconView)
        
        laneBackInfoAndTurnIconView.snp.makeConstraints { make in
            make.top.equalTo(jk_kNavFrameH + 20)
            make.centerX.equalToSuperview()
            make.height.equalTo(56 / UIScreen.main.scale)
            make.width.equalTo(280 / UIScreen.main.scale)
        }
    }
    
    lazy var laneBackInfoAndTurnIconView: LaneBackInfoAndTurnIconView = {
        let view = LaneBackInfoAndTurnIconView()
        return view
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let uniqueArray = {
            let shuffledNumbers = (0...9).shuffled()  // 生成 0-9 的乱序数组
            let count = Int.random(in: 1...10)        // 随机决定数组长度
            return Array(shuffledNumbers.prefix(count)).map { "landback_\($0)" }
        }()
        laneBackInfoAndTurnIconView.loadData(images: uniqueArray)
    }
    
    func generateUniqueLandbackArray(count: Int) -> [String] {
        let numbers = Array(0...9).shuffled()
        return Array(numbers.prefix(max(0, min(count, 10)))).map { "landback_\($0)" }
    }
}
