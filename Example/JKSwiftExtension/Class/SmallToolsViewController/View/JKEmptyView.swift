//
//  JKEmptyView.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2022/7/2.
//

import UIKit

/*
 要实现的功能
 1、类型
 1.1、不显示
 1.2、无数据
 1.3、无网络
 */
//MARK: - 空白界面的视图类型
enum NiuEmptyViewType {
    /// 不显示界面
    case normal
    /// 无数据
    case noData
    /// 无网络
    case noNetWork
}

//MARK: - 空白界面的视图代理
protocol JKEmptyViewDelegate: AnyObject {
    
    /// 获取无数据的图片
    /// - Returns: 无数据的图片
    func emptyViewNoDataImage(_ emptyView: JKEmptyView) -> UIImage?
    /// 获取无数据的内容
    /// - Returns: 无数据的不容
    func emptyViewNoDataContent(_ emptyView: JKEmptyView) -> String?
    /// 获取无网络的图片
    /// - Returns: 无网络的图片
    func emptyViewNoNetWorkImage(_ emptyView: JKEmptyView) -> UIImage?
}

extension JKEmptyViewDelegate {
    /// 获取无数据的图片
    /// - Returns: 无数据的图片
    func emptyViewNoDataImage(_ emptyView: JKEmptyView) -> UIImage? {
        return nil
    }
    /// 获取无数据的内容
    /// - Returns: 无数据的不容
    func emptyViewNoDataContent(_ emptyView: JKEmptyView) -> String? {
        return nil
    }
    /// 获取无网络的图片
    /// - Returns: 无网络的图片
    func emptyViewNoNetWorkImage(_ emptyView: JKEmptyView) -> UIImage? {
        return nil
    }
}

//MARK: - 空白界面的视图
class JKEmptyView: UIView {
    /// 代理
    weak var delegate: JKEmptyViewDelegate?
    /// 无网络刷新的闭包
    var refreshClosure: (() -> Void)?
    /// 空白视图的类型
    var emptyViewType: NiuEmptyViewType = .normal {
        didSet {
            reloadData()
        }
    }
    /// 无数据提示内容
    private var noDataTipContent: String = "暂无内容"
    /// 无网络提示内容
    private var noNetWorkTipContent: String = "网络连接失败"
    /// 无网络刷新按钮文案
    private var rerfreshTipContent: String = "重新加载"
    /// 无数据的图片
    private var noDataImage: UIImage? = UIImage(named: "screen_no_content")
    /// 无网络的图片
    private var noNetWorkImage: UIImage? = UIImage(named: "screen_no_network")

    init(emptyViewType: NiuEmptyViewType = .normal) {
        self.emptyViewType = emptyViewType
        super.init(frame: .zero)
        initUI()
        commonInit()
        changeTheme()
    }
    /// 提示图片
    private lazy var tipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.noDataImage
        return imageView
    }()
    /// 提示文案
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.hexStringColor(hexString: "#7C828C")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    /// 刷新按钮
    private lazy var rerfreshButton: UIButton = {
        let button = UIButton()
        button.setTitle(rerfreshTipContent, for: .normal)
        button.backgroundColor = UIColor.hexStringColor(hexString: "#303133")
        button.setTitleColor(UIColor.hexStringColor(hexString: "#7C828C"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        return button
    }()
    /// 容器
    private lazy var container: UIView = {
        let container = UIView()
        return container
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Event
extension JKEmptyView {
    //MARK: 刷新的闭包
    /// 刷新的闭包
    @objc private func btnAction() {
        emptyViewType = .normal
        refreshClosure?()
    }
}

//MARK: - 界面的更新操作
extension JKEmptyView {
    
    //MARK: 刷新视图显示
    /// 刷新视图显示
    @objc private func reloadData() {
        var isHidden: Bool = true
        if emptyViewType == .noData {
            if let image = delegate?.emptyViewNoDataImage(self) {
                tipImageView.image = image
            } else {
                tipImageView.image = noDataImage
            }
            if let content = delegate?.emptyViewNoDataContent(self) {
                titleLabel.text = content
            } else {
                titleLabel.text = noDataTipContent
            }
            rerfreshButton.isHidden = true
            isHidden = false
        } else if emptyViewType == .noNetWork {
            if let image = delegate?.emptyViewNoNetWorkImage(self) {
                tipImageView.image = image
            } else {
                tipImageView.image = noNetWorkImage
            }
            titleLabel.text = noNetWorkTipContent
            rerfreshButton.isHidden = false
            isHidden = false
        } else {
            rerfreshButton.isHidden = true
            isHidden = true
        }
        self.isHidden = isHidden
    }
}

extension JKEmptyView {
    
    private func initUI() {
        addSubview(container)
        container.addSubview(tipImageView)
        container.addSubview(titleLabel)
        container.addSubview(rerfreshButton)
    }
    
    private func commonInit() {
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        tipImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 48, height: 48))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tipImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        rerfreshButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(52)
            make.right.equalTo(-52)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
    
    private func changeTheme() {
        self.isHidden = true
        rerfreshButton.isHidden = true
    }
}
