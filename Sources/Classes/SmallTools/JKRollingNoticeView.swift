//
//  JKScrollviewLabel.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2022/4/10.
//

import UIKit

//MARK: - JKRollingNoticeViewDataSource 数据代理
@objc public protocol JKRollingNoticeViewDataSource : NSObjectProtocol {
    func numberOfRowsFor(roolingView: JKRollingNoticeView) -> Int
    func rollingNoticeView(roolingView: JKRollingNoticeView, cellAtIndex index: Int) -> JKNoticeViewCell
}

//MARK: - JKRollingNoticeViewDelegate 点击事件的代理
@objc public protocol JKRollingNoticeViewDelegate: NSObjectProtocol {
    @objc optional func rollingNoticeView(_ roolingView: JKRollingNoticeView, didClickAt index: Int)
}

//MARK: - 滚动中的状态
public enum JKRollingNoticeViewStatus: UInt {
    case idle, working, pause
}

//MARK: - JKRollingNoticeView
open class JKRollingNoticeView: UIView {
    /// 数据源
    weak open var dataSource : JKRollingNoticeViewDataSource?
    /// 代理
    weak open var delegate : JKRollingNoticeViewDelegate?
    /// 滚动的时间间隔
    open var stayInterval = 2.0
    /// 当前的状态
    open private(set) var status: JKRollingNoticeViewStatus = .idle
    /// 当前的index
    open var currentIndex: Int {
        guard let count = (self.dataSource?.numberOfRowsFor(roolingView: self)) else { return 0}
        
        if (_cIdx > count - 1) {
            _cIdx = 0
        }
        return _cIdx
    }
    
    private var _cIdx = 0
    private var _needTryRoll = false
    
    // MARK: private properties
    /// 标识符集合
    private lazy var cellClsDict: Dictionary = { () -> [String : Any] in
        var tempDict = Dictionary<String, Any>()
        return tempDict
    }()
    /// cell 数组
    private lazy var reuseCells: Array = { () -> [JKNoticeViewCell] in
        var tempArr = Array<JKNoticeViewCell>()
        return tempArr
    }()
    /// 定时器
    private var timer: Timer?
    /// 当前显示的cell
    private var currentCell: JKNoticeViewCell?
    /// 将要显示的cell
    private var willShowCell: JKNoticeViewCell?
    /// 是否正在执行cell动画
    private var isAnimating = false
    
    // MARK: -
    open func register(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier identifier: String) {
        self.cellClsDict[identifier] = cellClass
    }
    
    open func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        self.cellClsDict[identifier] = nib
    }
    
    open func dequeueReusableCell(withIdentifier identifier: String) -> JKNoticeViewCell? {
        for cell in self.reuseCells {
            guard let reuseIdentifier = cell.reuseIdentifier else { return nil }
            if reuseIdentifier.elementsEqual(identifier) {
                return cell
            }
        }
        
        if let cellCls = self.cellClsDict[identifier] {
            if let nib = cellCls as? UINib {
                let arr = nib.instantiate(withOwner: nil, options: nil)
                if let cell = arr.first as? JKNoticeViewCell {
                    cell.setValue(identifier, forKeyPath: "reuseIdentifier")
                    return cell
                }
                return nil
            }
            
            if let noticeCellCls = cellCls as? JKNoticeViewCell.Type {
                let cell = noticeCellCls.self.init(reuseIdentifier: identifier)
                return cell
            }
        }
        return nil
    }
    
    //MARK: 刷新并滚动数据
    /// 刷新并滚动数据
    open func reloadDataAndStartRoll() {
        stopRoll()
        guard let count = self.dataSource?.numberOfRowsFor(roolingView: self), count > 0 else {
            return
        }
        
        layoutCurrentCellAndWillShowCell()
        
        guard count >= 2 else {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: stayInterval, target: self, selector: #selector(timerHandle), userInfo: nil, repeats: true)
        if let __timer = timer {
            RunLoop.current.add(__timer, forMode: .common)
        }
        resume()
    }
    
    // 如果想要释放，请在合适的地方停止timer。 例如 -viewDidDismiss
    open func stopRoll() {
        
        if let rollTimer = timer {
            rollTimer.invalidate()
            timer = nil
        }
        
        status = .idle
        isAnimating = false
        _cIdx = 0
        currentCell?.removeFromSuperview()
        willShowCell?.removeFromSuperview()
        currentCell = nil
        willShowCell = nil
        self.reuseCells.removeAll()
    }
    
    //MARK: 暂定滚动
    /// 暂定滚动
    open func pause() {
        if let __timer = timer {
            __timer.fireDate = Date.distantFuture
            status = .pause
        }
    }
    
    //MARK: 开启滚动
    /// 开启滚动
    open func resume() {
        if let __timer = timer {
            __timer.fireDate = Date.distantPast
            status = .working
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNoticeViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNoticeViews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if (_needTryRoll) {
            self.reloadDataAndStartRoll()
            _needTryRoll = false
        }
    }
}

// MARK: 私有方法
extension JKRollingNoticeView {
    
    @objc fileprivate func timerHandle() {
        if isAnimating {
            return
        }
        layoutCurrentCellAndWillShowCell()
        
        let w = self.frame.size.width
        let h = self.frame.size.height
        
        isAnimating = true
        UIView.animate(withDuration: 0.5, animations: {
            self.currentCell?.frame = CGRect(x: 0, y: -h, width: w, height: h)
            self.willShowCell?.frame = CGRect(x: 0, y: 0, width: w, height: h)
        }) { (flag) in
            if let cell0 = self.currentCell, let cell1 = self.willShowCell {
                self.reuseCells.append(cell0)
                cell0.removeFromSuperview()
                self.currentCell = cell1
            }
            self.isAnimating = false
            self._cIdx += 1
        }
    }
    
    fileprivate func layoutCurrentCellAndWillShowCell() {
        guard let count = (self.dataSource?.numberOfRowsFor(roolingView: self)) else { return }
        
        if (_cIdx > count - 1) {
            _cIdx = 0
        }
        
        var willShowIndex = _cIdx + 1
        if (willShowIndex > count - 1) {
            willShowIndex = 0
        }
        let w = self.frame.size.width
        let h = self.frame.size.height
        
        if !(w > 0 && h > 0) {
            _needTryRoll = true
            return
        }
        
        if currentCell == nil {
            // 第一次没有currentcell
            // currentcell is null at first time
            if let cell = self.dataSource?.rollingNoticeView(roolingView: self, cellAtIndex: _cIdx) {
                currentCell = cell
                cell.frame  = CGRect(x: 0, y: 0, width: w, height: h)
                self.addSubview(cell)
            }
            return
        }
        
        if let cell = self.dataSource?.rollingNoticeView(roolingView: self, cellAtIndex: willShowIndex) {
            willShowCell = cell
            cell.frame = CGRect(x: 0, y: h, width: w, height: h)
            self.addSubview(cell)
        }
        
        guard let _cCell = currentCell, let _wCell = willShowCell else {
            return
        }
        // debugPrint(String(format: "currentCell  %p", _cCell))
        // debugPrint(String(format: "willShowCell %p", _wCell))
        let currentCellIdx = self.reuseCells.firstIndex(of: _cCell)
        let willShowCellIdx = self.reuseCells.firstIndex(of: _wCell)
        
        if let index = currentCellIdx {
            self.reuseCells.remove(at: index)
        }
        
        if let index = willShowCellIdx {
            self.reuseCells.remove(at: index)
        }
    }
    
    @objc fileprivate func handleCellTapAction(){
        self.delegate?.rollingNoticeView?(self, didClickAt: self.currentIndex)
    }
    
    fileprivate func setupNoticeViews() {
        self.clipsToBounds = true
        self.addGestureRecognizer(self.createTapGesture())
    }
    
    fileprivate func createTapGesture() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(JKRollingNoticeView.handleCellTapAction))
    }
}

//MARK: - JKNoticeViewCell
open class JKNoticeViewCell: UIView {
    
    open private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        self.addSubview(view)
        isAddedContentView = true
        return view
    }()
    
    open private(set) lazy var textLabel: UILabel = {
        let lab = UILabel()
        self.contentView.addSubview(lab)
        return lab
    }()
    
    /// 标识
    @objc open private(set) var reuseIdentifier: String?
    fileprivate var isAddedContentView = false
    
    /// 文字左边的距离
    open var textLabelLeading: CGFloat
    /// 文字右边的距离
    open var textLabelTrailing: CGFloat
    
    public required init(reuseIdentifier: String?, textLabelLeading: CGFloat = 10, textLabelTrailing: CGFloat = 10) {
        self.textLabelLeading = textLabelLeading
        self.textLabelTrailing = textLabelTrailing
        self.reuseIdentifier = reuseIdentifier
        super.init(frame: .zero)
        setupInitialUI()
    }
    
    private func setupInitialUI() {
        self.backgroundColor = UIColor.white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.textLabelLeading = 10
        self.textLabelTrailing = 10
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isAddedContentView {
            self.contentView.frame = self.bounds
            var lead = textLabelLeading
            if lead < 0 {
                lead = 0
            }
            var trai = textLabelTrailing
            if trai < 0 {
                trai = 0
            }
            
            var width = self.frame.size.width - lead - trai
            if width < 0 {
                width = 0
            }
            self.textLabel.frame = CGRect(x: lead, y: 0, width: width, height: self.frame.size.height)
        }
    }
}
