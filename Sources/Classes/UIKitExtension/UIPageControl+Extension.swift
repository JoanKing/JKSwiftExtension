//
//  UIPageControl+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/13.
//

import Foundation
import UIKit

public extension JKPOP where Base: UIPageControl {

    /// UIPageControl创建
    /// - Parameters:
    ///   - rect: frame
    ///   - numberOfPages: 页码数量
    ///   - currentPage: 当前页码
    ///   - currentPageIndicatorTintColor: 当前选中的颜色
    ///   - pageIndicatorTintColor: 没有选中的颜色
    /// - Returns: UIPageControl
    static func create(_ rect: CGRect = .zero, numberOfPages: Int, currentPage: Int = 0, currentPageIndicatorTintColor: UIColor = .black, pageIndicatorTintColor: UIColor = .lightGray) -> UIPageControl {
        let view = UIPageControl(frame: rect)
        view.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        view.pageIndicatorTintColor = pageIndicatorTintColor
        view.isUserInteractionEnabled = true
        view.hidesForSinglePage = true
        view.currentPage = 0
        view.numberOfPages = numberOfPages
        return view
    }
}
