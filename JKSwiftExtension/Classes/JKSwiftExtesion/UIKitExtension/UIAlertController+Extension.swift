//
//  UIAlertController+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/9/28.
//

import UIKit

public extension UIAlertController {
    convenience init(title: String?, message: String?) {
        self.init(title: title, message: message, preferredStyle: .alert)
    }

    @discardableResult
    func addAction(_ alertActionTitle: String?, _ alertActionStyle: UIAlertAction.Style = .default, handler: (@escaping () -> Void) = {}) -> Self {
        let action = UIAlertAction(title: alertActionTitle, style: alertActionStyle) { _ in
            handler()
        }
        addAction(action)
        return self
    }

    func show(_ vc: UIViewController? = UIViewController.top(), dismiss deadline: TimeInterval? = nil) {
        guard let inVC = vc else {
            return
        }
        inVC.present(self, animated: true, completion: nil)
        guard let deadline = deadline else {
            return
        }
        dismiss(after: deadline)
    }

    func dismiss(after deadline: TimeInterval = 0) {
        let after = DispatchTime.now() + deadline
        DispatchQueue.main.asyncAfter(deadline: after) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.dismiss(animated: true, completion: nil)
        }
    }
}
