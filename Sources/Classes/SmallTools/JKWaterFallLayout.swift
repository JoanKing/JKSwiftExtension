//
//  JKWaterFallLayout.swift
//  JKLive
//
//  Created by 王冲 on 2020/7/22.
//  Copyright © 2020 王冲. All rights reserved.
//

import UIKit

/// 在协议后面写上: AnyObject代表只有类能遵守这个协议
public protocol JKWaterFallLayoutDataSoure: AnyObject {
    func waterfall(_ waterfall: JKWaterFallLayout, item: Int) -> CGFloat
}

public class JKWaterFallLayout: UICollectionViewFlowLayout {
    /// 数据源
    public weak var dataSource: JKWaterFallLayoutDataSoure?
    /// 保存 UICollectionViewLayoutAttributes 的数组
    fileprivate lazy var cellAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    // 几列，默认 2 列
    public lazy var cols: Int = 2
    /// 高度的数组
    fileprivate lazy var totalHeights: [CGFloat] = Array(repeating: sectionInset.top, count: self.cols)
    /// 默认的起始值
    fileprivate var preCount: Int = 0
}

// MARK: - 准备布局
public extension JKWaterFallLayout {
    
    //MARK: 重置布局数据
    /// 重置布局数据
    func restData() {
        preCount = 0
        cellAttributes = []
        totalHeights = Array(repeating: sectionInset.top, count: self.cols)
    }
    
    /// 准备
    override func prepare() {
        super.prepare()
        /*
         totalHeights = Array(repeating: sectionInset.top, count: self.cols)
         cellAttributes.removeAll()
         */
        // cell -> UICollectionViewLayoutAttributes
        // 1.获取cell个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        // 2.给每一个cell创建一个UICollectionViewLayoutAttributes
        let cellW: CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
        for i in preCount..<itemCount {
            // 1.根据i创建IndexPath
            let indexPath = IndexPath(item: i, section: 0)
            // 2.根据indexPath创建对应的UICollectionViewLayoutAttributes
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            guard let cellH: CGFloat = self.dataSource?.waterfall(self, item: i) else {
                fatalError("请实现对应的数据源的方法，并且返回cell的高度")
            }
            // 3.设置attr的frame
            let minH = totalHeights.min()!
            let minIndex = totalHeights.firstIndex(of: minH)!
            
            let cellX: CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            let cellY: CGFloat = minH
            
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            // 4.保存attr
            cellAttributes.append(attr)
            // 5.添加当前高度
            totalHeights[minIndex] = minH + minimumLineSpacing + cellH
        }
        // 6.记录我们之前计算的个数
        preCount = cellAttributes.count
    }
}

// MARK: - 返回准备好的所vVVVVVVVVVVvvvvvvvvvvvv有布局
public extension JKWaterFallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttributes
    }
}

// MARK: - 设置 contentSize
public extension JKWaterFallLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: totalHeights.max()! + sectionInset.bottom - minimumLineSpacing)
    }
}
