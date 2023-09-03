//
//  SegmentViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2023/8/28.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SegmentViewController: UIViewController {
    
    var segmented: UISegmentedControl!
    
    lazy var drivingSpecialConfigurationSegmentView: DrivingSpecialConfigurationSegmentView = {
        let segment = DrivingSpecialConfigurationSegmentView(frame: CGRect.zero, titles: ["跟随车机", "强制关闭"], imageNames: ["special_configuration_off_selected", "special_configuration_on"], selectedIndex: 1)
        return segment
    }()
    
    lazy var drivingSpecialConfigurationSegmentView2: DrivingSpecialConfigurationSegmentView = {
        let segment = DrivingSpecialConfigurationSegmentView(frame: CGRect.zero, titles: ["跟随车机", "强制关闭", "强制开启"], imageNames: ["special_configuration_on_selected", "special_configuration_on", "special_configuration_off"], selectedIndex: 1)
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        /*
        let tags = ["理财", "转让"]
        segmented = UISegmentedControl(items: tags)
        segmented.backgroundColor = .brown
        segmented.layer.cornerRadius = 50
        segmented.clipsToBounds = true
        segmented.selectedSegmentIndex = 1 //默认第一个被选中
        segmented.selectedSegmentTintColor = UIColor.yellow
        segmented.addTarget(self, action: #selector(segmentDidchange), for: .valueChanged)
        self.view.addSubview(segmented)
        
        segmented.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(100)
        }
        */
        
        self.view.jk.addSubviews([drivingSpecialConfigurationSegmentView, drivingSpecialConfigurationSegmentView2])
        drivingSpecialConfigurationSegmentView.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(100)
        }
        
        drivingSpecialConfigurationSegmentView2.snp.makeConstraints { make in
            make.top.equalTo(drivingSpecialConfigurationSegmentView.snp.bottom).offset(100)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(100)
        }
    }
    
    @objc func segmentDidchange(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        debugPrint("选择的第几个：\(index)")
        
        if index == 0 {
            
        } else {
            
        }
    }
}
