//
//  LaneBackInfoAndTurnIconView.swift
//  JKSwiftExtension_Example
//
//  Created by chongwang on 2025/3/27.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

/**
 导航的车道图，国内同一个方向车道图目前最多10个车道
 */
import UIKit

class LaneBackInfoAndTurnIconView: UIView {
    /// 车道图
    lazy var laneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8 / UIScreen.main.scale
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually // 使用 equalSpacing 实现均匀分布
        return stackView
    }()
    
    // 图片控件数组
    lazy var imageViews: [UIImageView] = {
        return (1...10).map { _ in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            // imageView.backgroundColor = .randomColor
            return imageView
        }
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        commonInit()
        changeTheme()
    }
    
    private func initUI() {
        self.addSubview(laneStackView)

        for imageView in imageViews {
            laneStackView.addArrangedSubview(imageView)
            // 设置每个 imageView 的大小
            // 56x88 56  w = 56 * 56 / 88
            // imageView.heightAnchor.constraint(equalToConstant: 56 * 56 / (88 * UIScreen.main.scale)).isActive = true
            // imageView.widthAnchor.constraint(equalToConstant: 56 / UIScreen.main.scale).isActive = true
        }
    }
    
    private func commonInit() {
        laneStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8 / UIScreen.main.scale, left: 16 / UIScreen.main.scale, bottom: 8 / UIScreen.main.scale, right: 16 / UIScreen.main.scale))
        }
    }
    
    private func changeTheme() {
        self.backgroundColor = UIColor.hexStringColor(hexString: "#426BF2")
        imageViews.forEach { $0.isHidden = true }
//        layer.cornerCurve = .continuous
//        layer.cornerRadius = 9.0 / UIScreen.main.scale
//        self.clipsToBounds = true
        
    }
    
    /// 加载车道图的图片
    /// - Parameter images: 车道图的图片名字数组
    func loadData(images: [String]) {
        guard images.count > 0 else {
            return
        }
        for (index, item) in imageViews.enumerated() {
            // 车道图能转化成功
            if images.count > index, let image = UIImage(named: images[index]) {
                setLandImage(imageView: item, index: index, isShow: true, image: image)
            } else {
                setLandImage(imageView: item, index: index, isShow: false)
            }
        }
        self.layoutIfNeeded()
    }
    
    /// 车道图赋值
    private func setLandImage(imageView: UIImageView, index: Int, isShow: Bool, image: UIImage? = nil) {
        imageView.isHidden = !isShow
        if isShow {
            imageView.image = image
        }
    }
    
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
        // self.niu.addCorner(conrners: .allCorners, radius: 9.0 / UIScreen.main.scale)
        // 获取当前的宽度
        let currentWidth = self.bounds.width
        debugPrint("车道图的宽度：\(currentWidth)")
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        // 获取当前的宽度
        let currentWidth = self.bounds.width
        debugPrint("车道图的宽度：\(currentWidth)")
        self.jk.addCorner(conrners: [.bottomLeft, .bottomRight], radius: 16.0 / UIScreen.main.scale)
        // 计算可用宽度，减去间隔的宽度
        let totalSpacing = laneStackView.spacing * CGFloat(imageViews.count - 1)
        let availableWidth = currentWidth - laneStackView.layoutMargins.left - laneStackView.layoutMargins.right - totalSpacing
        
        // 计算每个控件的理想宽度
        let idealHeight = 56 * 56 / (88 * UIScreen.main.scale)
        let idealWidth = 56 / UIScreen.main.scale
        
        // 如果所有控件以理想宽度显示会超出可用宽度，则缩小控件
        if idealWidth * CGFloat(imageViews.count) > availableWidth {
            let newWidth = availableWidth / CGFloat(imageViews.count)
            let newHeight = newWidth * 88 / 56
            for imageView in imageViews {
                imageView.widthAnchor.constraint(equalToConstant: newWidth).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
            }
        } else {
            for imageView in imageViews {
                imageView.widthAnchor.constraint(equalToConstant: idealWidth).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: idealHeight).isActive = true
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// LaneBackInfoAndTurnIconView的宽高是固定的， 想要的效果是laneStackView内的子控件均匀分布，每个控件之间的间隔相等，如果控件显示的太多就对每个控件进行缩小宽高让其显示在一排，如果可以显示下就不需要再缩小
