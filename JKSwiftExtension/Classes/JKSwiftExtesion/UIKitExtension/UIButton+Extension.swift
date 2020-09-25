//
//  UIButton+Extension.swift
//  nuannuan
//
//  Created by 王冲 on 2019/11/20.
//  Copyright © 2019 王冲. All rights reserved.
//

import UIKit

public extension UIButton {
    @discardableResult
    func title(_ text: String, _ state: UIControl.State = .normal) -> Self {
        setTitle(text, for: state)
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func font(_ fontSize: Float) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func font(_ fontSize: Int) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func boldFont(_ fontSize: Float) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func boldFont(_ fontSize: Int) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(in bundle: Bundle? = nil, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(in bundle: Bundle, name imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(for aClass: AnyClass, name imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: Bundle(for: aClass), compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(forParent aClass: AnyClass, bundleName: String, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        guard let path = Bundle(for: aClass).path(forResource: bundleName, ofType: "bundle") else {
            return self
        }
        let image = UIImage(named: imageName, in: Bundle(path: path), compatibleWith: nil)
        setImage(image, for: state)
        return self
    }
    
    
    @discardableResult
    func image(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage.imageWithColor(color)
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(forParent aClass: AnyClass, bundleName: String, _ imageName: String, _: UIControl.State = .normal) -> Self {
        guard let path = Bundle(for: aClass).path(forResource: bundleName, ofType: "bundle") else {
            return self
        }
        let image = UIImage(named: imageName, in: Bundle(path: path), compatibleWith: nil)
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(in bundle: Bundle? = nil, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(for aClass: AnyClass, _ imageName: String, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage(named: imageName, in: Bundle(for: aClass), compatibleWith: nil)
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func bgImage(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        let image = UIImage.imageWithColor(color)
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func confirmButton() -> Self {
        let normalImage = UIImage.image(color: UIColor.hexColor(hex: "#E54749"), size: CGSize(width: 10, height: 10), round: 4)?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        let disableImg = UIImage.image(color: UIColor.hexColor(hex: "#E6E6E6"), size: CGSize(width: 10, height: 10), round: 4)?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        setBackgroundImage(normalImage, for: .normal)
        setBackgroundImage(disableImg, for: .disabled)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor?, state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
}

