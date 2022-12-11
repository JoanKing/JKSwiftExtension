//
//  ThreeViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Three"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
        test13()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.jk.pop(count: 2, animated: true)
    }

}

extension ThreeViewController {
    
    func test13() {
        let lineHight: CGFloat = 50
        let fontSize: CGFloat = 12
        let baselineOffset = (lineHight - fontSize) / 4.0 - 1
        
        let testView = UIView()
        testView.backgroundColor = .brown
        view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(160)
        }
        
        let testView2 = UIView()
        testView2.backgroundColor = .yellow
        testView.addSubview(testView2)
        testView2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(lineHight)
        }
        let testView21 = UIView()
        testView21.backgroundColor = .blue
        testView2.addSubview(testView21)
        testView21.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        let testView22 = UIView()
        testView22.backgroundColor = .blue
        testView2.addSubview(testView22)
        testView22.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        let testLabel = UILabel()
        testLabel.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        testLabel.backgroundColor = .purple
        testLabel.numberOfLines = 0
        testView.addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为50
        paraph.maximumLineHeight = lineHight
        // 将行间距设置为50
        paraph.minimumLineHeight = lineHight
        // 将行间距设置为20
        paraph.lineSpacing = 20
        // 剧中显示
        paraph.alignment = .left
        // 样式属性集合
        let string1 = "34’"
        let string2 = "56’’"
        let string = string1 + string2
        // 正值上偏，负值下偏
        let attributes = NSMutableAttributedString(string: string)
        let attributes1 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green] as [NSAttributedString.Key : Any]
        attributes.addAttributes(attributes1, range: NSRange(location: string1.count, length: string2.count))
        testLabel.attributedText = attributes
    }
    
    func test12() {
        let testView1 = UIView()
        testView1.backgroundColor = .brown
        view.addSubview(testView1)
        testView1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(160)
        }
        
        let testView2 = UIView()
        testView2.backgroundColor = .blue
        testView1.addSubview(testView2)
        testView2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(30)
        }
        
        
        let testView3 = UIView()
        testView3.backgroundColor = .yellow
        testView1.addSubview(testView3)
        testView3.snp.makeConstraints { make in
            make.top.equalTo(testView2.snp.bottom).offset(0)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(0)
        }
        
        let testView4 = UIView()
        testView4.backgroundColor = .purple
        testView3.addSubview(testView4)
        testView4.snp.makeConstraints { make in
            make.top.equalTo(testView2.snp.bottom).offset(20)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(20)
        }
        
        let testView5 = UILabel()
        testView5.backgroundColor = .yellow
        testView5.numberOfLines = 0
        testView5.text = "参差不齐的荇菜，在船的左右两边摘取。贤良美好的女子，日日夜夜都想追求她。"
        testView3.addSubview(testView5)
        testView5.snp.makeConstraints { make in
            make.top.equalTo(testView2.snp.bottom).offset(60)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        JKAsyncs.asyncDelay(3) {
            
        } _: {
            testView5.snp.updateConstraints { make in
                make.top.equalTo(testView2.snp.bottom).offset(0)
                make.bottom.equalToSuperview().offset(0)
            }
            testView5.text = ""
            testView3.isHidden = true
        }

        
    }
    
    func test11() {
        let lineHight: CGFloat = 60
        let fontSize: CGFloat = 20
        let baselineOffset = (lineHight - fontSize) / 4.0 - 1
        
        let testView = UIView()
        testView.backgroundColor = .brown
        view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(160)
        }
        
        let testView2 = UIView()
        testView2.backgroundColor = .yellow
        testView.addSubview(testView2)
        testView2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(lineHight)
        }
        let testView21 = UIView()
        testView21.backgroundColor = .blue
        testView2.addSubview(testView21)
        testView21.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        let testView22 = UIView()
        testView22.backgroundColor = .blue
        testView2.addSubview(testView22)
        testView22.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        let testView3 = UIView()
        testView3.backgroundColor = .yellow
        testView.addSubview(testView3)
        testView3.snp.makeConstraints { make in
            make.top.equalTo(testView2.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(lineHight)
        }
        
        let testView31 = UIView()
        testView31.backgroundColor = .blue
        testView3.addSubview(testView31)
        testView31.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        let testView32 = UIView()
        testView32.backgroundColor = .blue
        testView3.addSubview(testView32)
        testView32.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        let testLabel = UILabel()
        testLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        testLabel.backgroundColor = .clear
        testLabel.numberOfLines = 0
        testView.addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为50
        paraph.maximumLineHeight = lineHight
        // 将行间距设置为50
        paraph.minimumLineHeight = lineHight
        // 将行间距设置为20
        paraph.lineSpacing = 20
        // 剧中显示
        paraph.alignment = .left
        // 样式属性集合
        // 正值上偏，负值下偏
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.paragraphStyle: paraph, NSAttributedString.Key.baselineOffset: baselineOffset] as [NSAttributedString.Key : Any]
        testLabel.attributedText = NSAttributedString(string: "请向购", attributes: attributes)
    }
}
