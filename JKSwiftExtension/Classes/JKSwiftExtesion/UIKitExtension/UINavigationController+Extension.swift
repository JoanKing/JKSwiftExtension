//
//  UINavigationController+Extension.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2020/10/9.
//

import Foundation

// Consider refactoring the code to use the non-optional operators.
private func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
      case let (l?, r?):
        return l < r
      case (nil, _?):
        return true
      default:
        return false
      }
}

public protocol NavigationControllerBackButtonDelegate {
    func viewControllerShouldPopOnBackButton() -> Bool
}

public extension UINavigationController {

    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        // Prevents from a synchronization issue of popping too many navigation items
        // and not enough view controllers or viceversa from unusual tapping
        if self.viewControllers.count < navigationBar.items?.count {
            return true
        }
        // Check if we have a view controller that wants to respond to being popped
        var shouldPop = true
        if let viewController = self.topViewController as? NavigationControllerBackButtonDelegate {
            shouldPop = viewController.viewControllerShouldPopOnBackButton()
        }
        if (shouldPop) {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        } else {
            // Prevent the back button from staying in an disabled state
            for view in navigationBar.subviews {
                if view.alpha < 1.0 {
                    UIView.animate(withDuration: 0.25, animations: { () -> Void in
                        view.alpha = 1.0
                    })
                }
            }

        }
        return false
    }
}
