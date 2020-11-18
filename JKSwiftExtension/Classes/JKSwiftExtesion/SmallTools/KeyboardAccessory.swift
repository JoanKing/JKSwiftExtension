//
//  KeyboardAccessory.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/25.
//

import UIKit

public protocol KeyboardAccessoryDelegate: class {
    func keyboardAccessoryDone()
}

public extension KeyboardAccessoryDelegate {
    func keyboardAccessoryDone() {}
}

public class KeyboardAccessory: UIView {
    public weak var delegate: KeyboardAccessoryDelegate?
    public var doneBtn: UIButton = {
        let doneBtn = UIButton(type: .system).title("完成").font(UIFont.systemFont(ofSize: 13))
        doneBtn.addTarget(self, action: #selector(done), for: .touchUpInside)
        return doneBtn
    }()
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 36))
        doneBtn.addTo(self)
        doneBtn.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        backgroundColor = .white
        let line = UIView().backgroundColor(UIColor.hexStringColor(hexString: "#E6E6E6")).addTo(self)
        line.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @objc func done() {
        if let _delegate = delegate {
            _delegate.keyboardAccessoryDone()
        } else {
            UIApplication.shared.keyWindow?.endEditing(true)
        }
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

