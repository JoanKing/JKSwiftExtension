//
//  PresetntFourViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/9/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

fileprivate let gridview_margin: CGFloat = 18
fileprivate let gridview_spacingBetweenGrid: CGFloat = 3
fileprivate let gridview_screenWidth = UIScreen.main.bounds.size.width

fileprivate var gridview_bigWidth: CGFloat {
    return gridview_screenWidth - 2 * gridview_margin
}
/// 三等分
fileprivate var gridview_trisection: CGFloat {
    return (gridview_screenWidth - 2 * gridview_margin - 2 * gridview_spacingBetweenGrid) / 3.0
}
/// 二等分
fileprivate var gridview_halving: CGFloat {
    return (gridview_screenWidth - 2 * gridview_margin -  gridview_spacingBetweenGrid) / 2.0
}

class NiunineGridsImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 4
        clipsToBounds = true
        backgroundColor = .randomColor
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 1张/2张图片
class FeedPostImageGridOneOrTwoView: UIStackView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 3
        
        addArrangedSubview(horizontalRow1)
        horizontalRow1.addArrangedSubview(nineGridsImageView0)
        nineGridsImageView0.snp.remakeConstraints { make in
            make.size.equalTo(CGSize(width: gridview_bigWidth, height: gridview_bigWidth)).priority(.high)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(imageList: [String]) {
        
    }
    
    private lazy var horizontalRow1 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    lazy var nineGridsImageView0: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
}

//MARK: - 3张图片
class FeedPostImageGridThreeView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 3
        
        addArrangedSubview(horizontalRow1)
        for index in 0...2 {
            if index == 0 {
                let imageView = nineGridsImageView0
                horizontalRow1.addArrangedSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: gridview_trisection * 2 + gridview_spacingBetweenGrid, height: gridview_trisection * 2 + gridview_spacingBetweenGrid)).priority(.high)
                }
                horizontalRow1.addArrangedSubview(verticalRow1)
            } else {
                let imageView = index == 1 ? nineGridsImageView1 : nineGridsImageView2
                verticalRow1.addArrangedSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: gridview_trisection, height: gridview_trisection)).priority(.high)
                }
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(imageList: [String]) {
        
    }
    
    private lazy var horizontalRow1 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    private lazy var verticalRow1 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    lazy var nineGridsImageView0: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView1: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView2: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
}

//MARK: - 4/5张图片
class FeedPostImageGridFourOrFiveView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 3
        
        addArrangedSubview(horizontalRow1)
        addArrangedSubview(horizontalRow2)
        for index in 0...3 {
            let imageView = getNine(index: index)
            if index < 2 {
                horizontalRow1.addArrangedSubview(imageView)
            } else {
                horizontalRow2.addArrangedSubview(imageView)
            }
            imageView.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: gridview_halving, height: gridview_halving)).priority(.high)
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(imageList: [String]) {
       
    }
    
    func getNine(index: Int) -> NiunineGridsImageView {
        if index == 0 {
            return nineGridsImageView0
        } else if index == 1 {
            return nineGridsImageView1
        } else if index == 2 {
            return nineGridsImageView2
        } else {
            return nineGridsImageView3
        }
    }
    
    
    private lazy var horizontalRow1 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    private lazy var horizontalRow2 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    lazy var nineGridsImageView0: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView1: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView2: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView3: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
}

//MARK: - 9张图片
class FeedPostImageGridNineView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 3
        
        addArrangedSubview(horizontalRow1)
        addArrangedSubview(horizontalRow2)
        addArrangedSubview(horizontalRow3)
        for index in 0..<9 {
            let imageView = getNine(index: index)
            if index < 3 {
                horizontalRow1.addArrangedSubview(imageView)
            } else if index < 6 {
                horizontalRow2.addArrangedSubview(imageView)
            } else {
                horizontalRow3.addArrangedSubview(imageView)
            }
            imageView.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: gridview_trisection, height: gridview_trisection)).priority(.high)
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(imageList: [String]) {
        
    }
    
    func getNine(index: Int) -> NiunineGridsImageView {
        if index == 0 {
            return nineGridsImageView0
        } else if index == 1 {
            return nineGridsImageView1
        } else if index == 2 {
            return nineGridsImageView2
        } else if index == 3 {
            return nineGridsImageView3
        } else if index == 4 {
            return nineGridsImageView4
        } else if index == 5 {
            return nineGridsImageView5
        } else if index == 6 {
            return nineGridsImageView6
        } else if index == 7 {
            return nineGridsImageView7
        } else {
            return nineGridsImageView8
        }
    }
    
    private lazy var horizontalRow1 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    private lazy var horizontalRow2 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    private lazy var horizontalRow3 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    lazy var nineGridsImageView0: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView1: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView2: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView3: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView4: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView5: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView6: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView7: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView8: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
}

//MARK: - 6、7、8、10+ 张图片
class FeedPostImageGridOtherView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 3
        
        addArrangedSubview(horizontalRow1)
        addArrangedSubview(horizontalRow2)
        // 6、7、8、10+
        for index in 0...5 {
            let imageView = getNine(index: index)
            if index == 0 {
                horizontalRow1.addArrangedSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: gridview_trisection * 2 + gridview_spacingBetweenGrid, height: gridview_trisection * 2 + gridview_spacingBetweenGrid)).priority(.high)
                }
                horizontalRow1.addArrangedSubview(verticalRow1)
            }  else if index > 0 && index < 3 {
                verticalRow1.addArrangedSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: gridview_trisection, height: gridview_trisection)).priority(.high)
                }
            } else {
                horizontalRow2.addArrangedSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: gridview_trisection, height: gridview_trisection)).priority(.high)
                }
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(imageList: [String]) {
        
    }
    
    func getNine(index: Int) -> NiunineGridsImageView {
        if index == 0 {
            return nineGridsImageView0
        } else if index == 1 {
            return nineGridsImageView1
        } else if index == 2 {
            return nineGridsImageView2
        } else if index == 3 {
            return nineGridsImageView3
        } else if index == 4 {
            return nineGridsImageView4
        } else {
            return nineGridsImageView5
        }
    }
    
    private lazy var horizontalRow1 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    private lazy var horizontalRow2 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    private lazy var verticalRow1 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = gridview_spacingBetweenGrid
        return stack
    }()
    
    lazy var nineGridsImageView0: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView1: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView2: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView3: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView4: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
    ///
    lazy var nineGridsImageView5: NiunineGridsImageView = {
        return NiunineGridsImageView(frame: CGRect.zero)
    }()
}

class PresetntFourViewController: UIViewController {
    
    lazy var showlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.jk.textB(25)
        label.textColor = .green
        label.backgroundColor = .brown
        return label
    }()
    ///
    var number: Int = 1
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var feedPostImageGridView0: FeedPostImageGridOneOrTwoView = {
        let view = FeedPostImageGridOneOrTwoView()
        view.backgroundColor = .yellow
        return view
    }()
    
    lazy var feedPostImageGridView1: FeedPostImageGridThreeView = {
        let view = FeedPostImageGridThreeView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var feedPostImageGridView2: FeedPostImageGridFourOrFiveView = {
        let view = FeedPostImageGridFourOrFiveView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var feedPostImageGridView3: FeedPostImageGridNineView = {
        let view = FeedPostImageGridNineView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var feedPostImageGridView4: FeedPostImageGridOtherView = {
        let view = FeedPostImageGridOtherView()
        view.backgroundColor = .blue
        return view
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 3
        return stack
    }()

    lazy var testView3: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Four"
        self.view.backgroundColor = .red
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.right.left.equalToSuperview()
        }
        mainStack.addArrangedSubview(feedPostImageGridView0)
        mainStack.addArrangedSubview(feedPostImageGridView1)
        mainStack.addArrangedSubview(feedPostImageGridView2)
        mainStack.addArrangedSubview(feedPostImageGridView3)
        mainStack.addArrangedSubview(feedPostImageGridView4)
        
        feedPostImageGridView1.isHidden = true
        feedPostImageGridView2.isHidden = true
        feedPostImageGridView3.isHidden = true
        feedPostImageGridView4.isHidden = true
        
        feedPostImageGridView0.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
        }
        
        view.addSubview(showlabel)
        showlabel.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(mainStack.snp.bottom).offset(50)
            make.height.equalTo(100)
        }
        showlabel.text = "\(number)"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeGridViewConstraints(index: number)
        showlabel.text = "\(number)"
        
        if number == 0 {
            feedPostImageGridView0.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
            }
        } else if number == 1 {
            feedPostImageGridView1.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
            }
        } else if number == 2 {
            feedPostImageGridView2.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
            }
        } else if number == 3 {
            feedPostImageGridView3.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
            }
        } else if number == 4 {
            feedPostImageGridView4.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
            }
        }
        number = number + 1
        if number > 4 {
            number = 0
        }
    }
    
    func removeGridViewConstraints(index: Int) {
        feedPostImageGridView0.isHidden = index != 0
        feedPostImageGridView1.isHidden = index != 1
        feedPostImageGridView2.isHidden = index != 2
        feedPostImageGridView3.isHidden = index != 3
        feedPostImageGridView4.isHidden = index != 4
        
        feedPostImageGridView0.snp.removeConstraints()
        feedPostImageGridView1.snp.removeConstraints()
        feedPostImageGridView2.snp.removeConstraints()
        feedPostImageGridView3.snp.removeConstraints()
        feedPostImageGridView4.snp.removeConstraints()
    }
    
    func test1() {
        if #available(iOS 13, *) {
            
            let view1 = UIView(frame: CGRect(x: 20, y: 100, width: jk_kScreenW - 40, height: 100))
            self.view.addSubview(view1)
            //首先创建一个模糊效果
            let blurEffect = UIBlurEffect(style: .light)
            //接着创建一个承载模糊效果的视图
            let blurView = UIVisualEffectView(effect: blurEffect)
            //设置模糊视图的大小（全屏）
            blurView.frame = CGRect(x: 0, y: 0, width: jk_kScreenW - 40, height: 100)
            view1.addSubview(blurView)
            
            //将文本标签添加到vibrancy视图中
            let label = UILabel(frame:CGRectMake(5,10, jk_kScreenW - 40 - 10, 50))
            label.text = "hangge.com-1"
            label.font = UIFont.systemFont(ofSize: 20)
            label.textAlignment = .center
            label.textColor = UIColor.hexStringColor(hexString: "#99A1B2")
            view1.addSubview(label)
            
            let view2 = UIView(frame: CGRect(x: 20, y: view1.jk.bottom + 20, width: jk_kScreenW - 40, height: 100))
            view2.backgroundColor = .blue
            self.view.addSubview(view2)
            //首先创建一个模糊效果
            let blurEffect2 = UIBlurEffect(style: .light)
            //接着创建一个承载模糊效果的视图
            let blurView2 = UIVisualEffectView(effect: blurEffect2)
            //设置模糊视图的大小（全屏）
            blurView2.frame = CGRect(x: 10, y: 0, width: jk_kScreenW - 40 - 20, height: 100)
            view2.addSubview(blurView2)
            
            //将文本标签添加到vibrancy视图中
            let label2 = UILabel(frame:CGRectMake(5, 10, jk_kScreenW - 40 - 20 - 10, 50))
            label2.text = "hangge.com-2"
            label2.font = UIFont.systemFont(ofSize: 20)
            label2.textAlignment = .center
            label2.textColor = UIColor.hexStringColor(hexString: "#99A1B2")
            blurView2.contentView.addSubview(label2)
            
            let view3 = UIView(frame: CGRect(x: 20, y: view2.jk.bottom + 20, width: jk_kScreenW - 40, height: 100))
            view3.backgroundColor = UIColor.hexStringColor(hexString: "#2A2E3D")
            self.view.addSubview(view3)
            //首先创建一个模糊效果
            let blurEffect3 = UIBlurEffect(style: .dark)
            //接着创建一个承载模糊效果的视图
            let blurView3 = UIVisualEffectView(effect: blurEffect3)
            //设置模糊视图的大小（全屏）
            blurView3.frame = CGRect(x: 10, y: 0, width: jk_kScreenW - 40 - 20, height: 100)
            view3.addSubview(blurView3)
            
            //将文本标签添加到vibrancy视图中
            let label3 = UILabel(frame:CGRectMake(5, 10, jk_kScreenW - 40 - 20 - 10, 50))
            label3.text = "hangge.com-3"
            label3.font = UIFont.systemFont(ofSize: 20)
            label3.textAlignment = .center
            label3.textColor = UIColor.hexStringColor(hexString: "#99A1B2")
            blurView3.contentView.addSubview(label3)
            
            let view4 = UIView(frame: CGRect(x: 20, y: view3.jk.bottom + 20, width: jk_kScreenW - 40, height: 100))
            view4.backgroundColor = .blue
            self.view.addSubview(view4)
            let view41 = UIView(frame: CGRect(x: 0, y: 0, width: (jk_kScreenW - 40) / 2.0, height: 100))
            view41.backgroundColor = .blue
            view4.addSubview(view41)
            let view42 = UIView(frame: CGRect(x: view41.jk.right, y: 0, width: (jk_kScreenW - 40) / 2.0, height: 100))
            view42.backgroundColor = .red
            view4.addSubview(view42)
            //首先创建一个模糊效果
            let blurEffect4 = UIBlurEffect(style: .dark)
            //接着创建一个承载模糊效果的视图
            let blurView4 = UIVisualEffectView(effect: blurEffect4)
            //设置模糊视图的大小（全屏）
            blurView4.frame = CGRect(x: 10, y: 0, width: jk_kScreenW - 40 - 20, height: 100)
            view4.addSubview(blurView4)
            
            let vibrancyEffect4 = UIVibrancyEffect(blurEffect: blurEffect4)
            let vibrancyView4 = UIVisualEffectView(effect: vibrancyEffect4)
            vibrancyView4.frame = CGRect(x: 10, y: 0, width: jk_kScreenW - 40 - 20, height: 100)
            blurView4.contentView.addSubview(vibrancyView4)
            
            //将文本标签添加到vibrancy视图中
            let label4 = UILabel(frame:CGRectMake(5, 10, jk_kScreenW - 40 - 20 - 10, 50))
            label4.text = "使用UIVibrancyEffect"
            label4.font = UIFont.systemFont(ofSize: 20)
            label4.textAlignment = .center
            label4.textColor = UIColor.brown
            vibrancyView4.contentView.addSubview(label4)
            
            let view5 = UIView(frame: CGRect(x: 20, y: view4.jk.bottom + 20, width: jk_kScreenW - 40, height: 100))
            view5.backgroundColor = .red
            self.view.addSubview(view5)
            //首先创建一个模糊效果
            let blurEffect5 = UIBlurEffect(style: .dark)
            //接着创建一个承载模糊效果的视图
            let blurView5 = UIVisualEffectView(effect: blurEffect5)
            //设置模糊视图的大小（全屏）
            blurView5.frame = CGRect(x: 10, y: 0, width: jk_kScreenW - 40 - 20, height: 100)
            view5.addSubview(blurView5)
            
            //将文本标签添加到vibrancy视图中
            let label5 = UILabel(frame:CGRectMake(5, 10, jk_kScreenW - 40 - 20 - 10, 50))
            label5.text = "没有使用UIVibrancyEffect-dark"
            label5.font = UIFont.systemFont(ofSize: 20)
            label5.textAlignment = .center
            label5.textColor = UIColor.brown
            blurView5.contentView.addSubview(label5)
            
            let view6 = UIView(frame: CGRect(x: 20, y: view5.jk.bottom + 20, width: jk_kScreenW - 40, height: 100))
            view6.backgroundColor = .red
            self.view.addSubview(view6)
            //首先创建一个模糊效果
            let blurEffect6 = UIBlurEffect(style: .prominent)
            //接着创建一个承载模糊效果的视图
            let blurView6 = UIVisualEffectView(effect: blurEffect6)
            //设置模糊视图的大小（全屏）
            //blurView6.frame = CGRect(x: 10, y: 0, width: jk_kScreenW - 40 - 20, height: 100)
            view6.addSubview(blurView6)
            blurView6.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            let vibrancyEffect6 = UIVibrancyEffect(blurEffect: blurEffect6)
            let vibrancyView6 = UIVisualEffectView(effect: vibrancyEffect6)
            // vibrancyView6.frame = CGRect(x: 10, y: 0, width: jk_kScreenW - 40 - 20, height: 100)
            blurView6.contentView.addSubview(vibrancyView6)
            vibrancyView6.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            //将文本标签添加到vibrancy视图中
            let label6 = UILabel(frame:CGRectMake(5, 10, jk_kScreenW - 40 - 20 - 10, 50))
            label6.text = "使用UIVibrancyEffect-自动"
            label6.font = UIFont.systemFont(ofSize: 20)
            label6.textAlignment = .center
            label6.textColor = UIColor.brown
            vibrancyView6.contentView.addSubview(label6)
            
            let view7 = UIView(frame: CGRect(x: 20, y: view6.jk.bottom + 20, width: jk_kScreenW - 40, height: 100))
            view7.backgroundColor = UIColor.hexStringColor(hexString: "#2C2D2E")
            self.view.addSubview(view7)
            //首先创建一个模糊效果
            //接着创建一个承载模糊效果的视图
            let blurView7 = UIVisualEffectView()
            blurView7.effect = UIBlurEffect(style: .prominent)
            //设置模糊视图的大小（全屏）
            blurView7.frame = CGRect(x: 10, y: 0, width: jk_kScreenW - 40 - 20, height: 100)
            view7.addSubview(blurView7)
            
            //将文本标签添加到vibrancy视图中
            let label7 = UILabel(frame:CGRectMake(5, 10, jk_kScreenW - 40 - 20 - 10, 50))
            label7.text = "没有使用UIVibrancyEffect-自动"
            label7.font = UIFont.systemFont(ofSize: 20)
            label7.textAlignment = .center
            label7.textColor = UIColor.white
            view7.addSubview(label7)
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = self.bottomestPresentedViewController()
        debugPrint("vc：\(vc.className)")
        vc.dismiss(animated: true, completion: nil)
        // dismissViewController(currentVC: self)
    }
    
    /// dismiss到指定的控制器
    ///
    /// - Parameters:
    ///   - index: 指定的控制器序号，如：从vc1 present --> vc2 --> vc3 --> vc4，想从vc4直接dismiss到vc1，只需要传index=4即可
    ///   - vc: 当前控制器
    func dismissViewController(currentVC:UIViewController) {
        var tempVC: UIViewController = currentVC
        while tempVC.presentingViewController != nil {
            debugPrint("\(currentVC.className)")
            if currentVC.isMember(of: PresetntThreeViewController.self) {
                break
            }
            tempVC = tempVC.presentingViewController!
        }
        
        tempVC.dismiss(animated: true, completion: nil)
    }

}

extension UIViewController {
    /// 获取最底层的控制器
    public func bottomestPresentedViewController() -> UIViewController {
        var bottomestVC = self
        while bottomestVC.presentingViewController != nil {
            bottomestVC = bottomestVC.presentingViewController!
        }
        return bottomestVC
    }
    
    /// 获取最顶层的控制器
    public func topestPresentedViewController() -> UIViewController {
        var topestVC = self
        while topestVC.presentedViewController != nil {
            topestVC = topestVC.presentedViewController!
        }
        return topestVC
    }
}
