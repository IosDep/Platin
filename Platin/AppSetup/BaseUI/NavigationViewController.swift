//
//  NavigationViewController.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 29/12/2022.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {



    override var childForStatusBarStyle: UIViewController? {
        viewControllers.last
    }

    override var shouldAutorotate: Bool {
        return false
    }

    fileprivate var duringPushAnimation = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setNeedsStatusBarAppearanceUpdate()
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true

        delegate = self

        setAppearance()

        navigationBar.tintColor = .TextPrimary
        navigationBar.barTintColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
    }

    func setAppearance(for titleColor: UIColor = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = UIImage()
        appearance.backgroundImage = UIImage()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]

        navigationBar.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]

        appearance.backgroundColor = .clear

        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}


extension NavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        navigationController.view.semanticContentAttribute = _isRTL ? .forceRightToLeft : .forceLeftToRight
        navigationController.navigationBar.semanticContentAttribute = _isRTL ? .forceRightToLeft : .forceLeftToRight

        if let baseVC = viewController as? BaseViewController {
            let preferredMode = baseVC.navigationHidingMode

            if preferredMode == .alwaysHidden {
                self.setNavigationBarHidden(true, animated: animated)
            } else if preferredMode == .alwaysVisible {
                self.setNavigationBarHidden(false, animated: animated)
            }

            let preferredTabBarMode = baseVC.tabBarHidingMode
            
            if preferredTabBarMode == .alwaysHidden {
                self.tabBarController?.tabBar.isHidden = true
            } else if preferredTabBarMode == .alwaysVisible {
                self.tabBarController?.tabBar.isHidden = false
            }
            
            setAppearance()
        }
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        self.duringPushAnimation = false
        
        if self.viewControllers.count > 1 {
            interactivePopGestureRecognizer?.isEnabled = true
        } else {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        setNeedsStatusBarAppearanceUpdate()
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }

        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return viewControllers.count > 1 && duringPushAnimation == false
    }
}

extension UIViewController {
    @discardableResult
    func embededInNavigationController() -> UINavigationController {

        let navigationController = NavigationController(rootViewController: self)
        return navigationController
    }

    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func close() {
        self.navigationController?.popViewController(animated: true)
    }
}
