//
//  FourViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Four"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
        
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: kScreenW - 40, height: 60))
        label.backgroundColor = .brown
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.text = "凭窗站了一会儿，微微的觉得凉意侵人。转过身来，忽然眼花缭乱，屋子里的别的东西都隐在光云里；一片幽辉，只浸着墙上画中的安琪儿。──这白衣的安琪儿，抱着花儿，扬着翅儿，向着我微微的笑。      "
        self.view.addSubview(label)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(FiveViewController(), animated: true)
    }
}
