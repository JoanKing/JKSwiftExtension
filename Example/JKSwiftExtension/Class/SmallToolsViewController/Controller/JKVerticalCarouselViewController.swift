//
//  JKVerticalCarouselViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class JKVerticalCarouselViewController: BaseViewController {
    
    var verticalCarousel: JKVerticalCarousel<UIView>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、垂直轮播"]
        dataArray = [["初始化垂直轮播", "开始轮播", "暂停轮播", "移除轮播"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 一、垂直轮播
extension JKVerticalCarouselViewController {
    
    // MARK: 1.1、初始化垂直轮播
    @objc func test11() {
        verticalCarousel = JKVerticalCarousel(frame: CGRect(x: 20, y: 200, width: kScreenW - 40, height: 200)) { () -> UIView in
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
            view.backgroundColor = .randomColor
            return view
        }
        verticalCarousel.itemCount = {
            return 3
        }
        verticalCarousel.configItem = {(index, UIView) in
            print("当前是：\(index)")
        }
        verticalCarousel.addTo(self.view)
    }
    
    // MARK: 1.2、初始化垂直轮播
    @objc func test12() {
        verticalCarousel.start()
    }
    
    // MARK: 1.3、暂停轮播
    @objc func test13() {
        verticalCarousel.stop()
    }
    
    // MARK: 1.4、移除轮播
    @objc func test14() {
        verticalCarousel.removeFromSuperview()
        verticalCarousel = nil
    }
}
