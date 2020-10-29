//
//  UITextField+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/29.
//

import UIKit

extension UITextField {
    /// Regular exp for email
    static let emailRegex = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

    /// Add left padding to the text in textfield
    public func addLeftTextPadding(_ blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }

    /// Add a image icon on the left side of the textfield
    public func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        imgView.frame = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgView.image = image
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }

    /// Ways to validate by comparison
    enum textFieldValidationOptions: Int {
        case equalTo
        case greaterThan
        case greaterThanOrEqualTo
        case lessThan
        case lessThanOrEqualTo
    }

    /// Validation length of character counts in UITextField
    func validateLength(ofCount count: Int, option: UITextField.textFieldValidationOptions) -> Bool {
        switch option {
        case .equalTo:
            return self.text!.count == count
        case .greaterThan:
            return self.text!.count > count
        case .greaterThanOrEqualTo:
            return self.text!.count >= count
        case .lessThan:
            return self.text!.count < count
        case .lessThanOrEqualTo:
            return self.text!.count <= count
        }
    }

    /// Validation of email format based on https://stackoverflow.com/questions/201323/using-a-regular-expression-to-validate-an-email-address and https://stackoverflow.com/questions/2049502/what-characters-are-allowed-in-an-email-address
    // TODO match String.isEmail method
    func validateEmail() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", UITextField.emailRegex)
        return emailTest.evaluate(with: self.text)
    }

    /// Validation of digits only
    func validateDigits() -> Bool {
        let digitsRegEx = "[0-9]*"
        let digitsTest = NSPredicate(format: "SELF MATCHES %@", digitsRegEx)
        return digitsTest.evaluate(with: self.text)
    }
    
    public func setPlaceholderAttribute(font: UIFont, color: UIColor = .black) {
        let arrStr = NSMutableAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        self.attributedPlaceholder = arrStr
    }
}

public extension UITextField {
    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    @discardableResult
    func attributedText(_ text: NSAttributedString) -> Self {
        self.attributedText = text
        return self
    }
    

    @discardableResult
    func placeholder(_ text: String) -> Self {
        placeholder = text
        return self
    }
    @discardableResult
    func attributedPlaceholder(_ text: NSAttributedString) -> Self {
        attributedPlaceholder = text
        return self
    }

    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }

    @discardableResult
    func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    @discardableResult
    func color(_ hex: String) -> Self {
        textColor = UIColor.hexStringColor(hexString: hex)
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func font(_ fontSize: Float) -> Self {
        font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }

    @discardableResult
    func font(_ fontSize: Int) -> Self {
        font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }

}
