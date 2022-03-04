//
//  FBGuidePage.swift
//  FutureBull
//
//  Created by wuyanwei on 2019/9/19.
//  Copyright © 2019 wuyanwei. All rights reserved.
//
// MARK: - 引导页
import UIKit

class FBGuidePageVC: UIViewController, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
        let scrollViewS = UIScrollView(frame: CGRect(x: 0, y: 0, width: jk_kScreenW, height: jk_kScreenH))
        scrollViewS.backgroundColor = .randomColor
        scrollViewS.isPagingEnabled = true
        scrollViewS.bounces = false
        scrollViewS.showsVerticalScrollIndicator = false
        scrollViewS.showsHorizontalScrollIndicator = false
        let width = CGFloat(guideImages().count) * jk_kScreenW
        scrollViewS.contentSize = CGSize(width: width, height: 0)
        scrollViewS.delegate = self
        return scrollViewS
    }()
    
    // pageControl
    lazy var pageControl: UIPageControl = {
        let pageView: UIPageControl = UIPageControl(frame: CGRect(x: (jk_kScreenW - 100) / 2, y: scrollView.frame.size.height - 100, width: 100, height: 20))
        pageView.hidesForSinglePage = true
        // 设置不是当前页的小点颜色
        pageView.pageIndicatorTintColor = UIColor.green
        // 设置当前页的小点颜色
        pageView.currentPageIndicatorTintColor = UIColor.red
        pageView.numberOfPages = 3
        pageView.backgroundColor = .gray
        if #available(iOS 14, *) {
            // iOS 14 之后要设置背景样式
            pageView.backgroundStyle = .minimal
            // pageView.preferredIndicatorImage = UIImage.init(systemName: "sun.max.fill")
        }
        // 默认小白点位置
        pageView.currentPage = 0
        pageView.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        return pageView
    }()
    
    let contentView: UIView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.navigationItem.title = ""
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        addImage()
        self.view.addSubview(pageControl)
    }
    
    func addImage() {
        let images = guideImages()
        for index in 0..<images.count {
            let imageName = images[index]
            let imageStr = Bundle.jk.getBundlePathResource(bundName: "CashCow", resourceName: imageName, bundleType: .currentBundle)
            let image = UIImage(named: imageStr)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: jk_kScreenW * CGFloat(index), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
            
            if index == images.count - 1 {
                let skipButton = UIButton(frame: CGRect(x: jk_kScreenW * CGFloat(index), y: 0, width: jk_kScreenW, height: 150)).backgroundColor(.clear)
                skipButton.addTarget(self, action: #selector(skipClick), for: .touchUpInside)
                scrollView.addSubview(skipButton)
            }
        }
    }
    
    @objc func skipClick() {
       
    }
    
    func guideImages() -> [String] {
        var guide = "GuideP"
        // if (jk_kScreenW == 414.0) && (jk_kScreenH == 736.0) {
        //    guide = "GuideP"
        // } else if (jk_kScreenW == 375.0) && (jk_kScreenH == 812.0) {
            guide = "GuideX"
        // } else if (jk_kScreenW == 414.0 ) && (jk_kScreenH == 896.0) {
        //    guide = "GuideXsr"
        // } else if (jk_kScreenW == 320.0 ) {
        //    guide = "GuideM"
        // }
        var ret = [String]()
        for index in 1...3 {
            let str = guide + "_\(index)"
            ret.append(str)
        }
        return ret
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page: NSInteger = Int(scrollView.contentOffset.x / scrollView.frame.width + 0.5)
        self.pageControl.currentPage = page
    }
    
    @objc fileprivate func pageControlValueChanged(_ sender: UIPageControl) {
        let page = sender.currentPage
        self.scrollView.contentOffset = CGPoint(x: CGFloat(page) * self.scrollView.frame.width, y: self.scrollView.contentOffset.y)
    }
}
