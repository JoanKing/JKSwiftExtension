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
        
        view.jk.addSubviews([label0, label1, label2])
        label0.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(16)
            make.width.equalTo(100)
        }
        label1.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(label0.snp.right).offset(10)
            make.right.equalTo(-32)
        }
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(20)
            make.left.equalTo(label1.snp.left)
            make.right.equalTo(-32)
        }
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        label1.isHidden = true
    }
    
    lazy var label0: UILabel = {
        let label = UILabel()
        label.text = "晋太元中，武陵人捕鱼为业。"
        label.backgroundColor = .brown
        label.numberOfLines = 0
        return label
    }()
    
    lazy var label1: UILabel = {
        let label = UILabel()
        label.text = "晋太元中，武陵人捕鱼为业。缘溪行，忘路之远近。忽逢桃花林，夹岸数百步，中无杂树，芳草鲜美，落英缤纷。渔人甚异之，复前行，欲穷其林。"
        label.backgroundColor = .brown
        label.numberOfLines = 0
        return label
    }()
    
    lazy var label2: UILabel = {
        let label = UILabel()
        label.text = "南阳刘子骥，高尚士也，闻之，欣然规往。未果，寻病终。后遂无问津者。"
        label.numberOfLines = 0
        label.backgroundColor = .brown
        return label
    }()
}

@available(iOS 13.0, *)
extension SegmentViewController {
    
    func segmentTest() {
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

