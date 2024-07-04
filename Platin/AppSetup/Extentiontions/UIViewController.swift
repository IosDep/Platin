//
//  UIViewController.swift
//  CARDIZERR
//
//  Created by Hala Zyod on 13/06/2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView

enum Storyboard: String {
    case authentication = "Authentication"
}

extension UIViewController: NVActivityIndicatorViewable {
    
    /**
     This method used to initilize the ViewController

     alwyes use tthis function to initilize the ViewController
     - parameter identifier: Your View Controller Name
     - parameter storyboardName: the Target Story Board
     - Example:  let nextVc = self.initViewControllerWith(identifier: AddressVC.className, storyboardName: Storyboard.eKYC.rawValue)
     self.show(nextVc)
     - returns: The ViewController
    */
    public func initViewControllerWith(identifier: String, storyboardName: String = "Authentication", title: String = "") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        vc.navigationItem.title = title
        vc.navigationController?.navigationBar.tintColor = UIColor.white
        vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return vc
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }

    /**
     This method used Hide the navigation
     
     - parameter isHidden: true or false
     - parameter storyboardName: the Target Story Board
     - Example:  let nextVc =  self.hiddenNavigation(isHidden: true)
     */
    func hiddenNavigation(isHidden: Bool) {
        guard let navigationController = navigationController else {
            return
        }
        navigationController.navigationBar.isHidden = isHidden
        navigationController.setNavigationBarHidden(isHidden, animated: false)
    }
    
    /**
     This method used to present the ViewController
     
     - parameter T: Your viewController
     - parameter animated: with animation or not
     - parameter modalPresentationStyle: pick you style
     - parameter configure: call back to customize  your view controller after pushed
     - Example:  let nextVc = self.initViewControllerWith(identifier: AddressVC.className, storyboardName: Storyboard.eKYC.rawValue)
     self.present(nextVc)
     - returns: The ViewController
    */
    public func present<T: UIViewController>(
        _ viewController: T,
        animated: Bool = true,
        modalPresentationStyle: UIModalPresentationStyle? = .fullScreen,
        configure: ((T) -> Void)? = nil,
        completion: ((T) -> Void)? = nil
    ) {
        if let modalPresentationStyle = modalPresentationStyle {
            viewController.modalPresentationStyle = modalPresentationStyle
        }
        
        configure?(viewController)
        present(viewController, animated: animated) {
            completion?(viewController)
        }
    }
    
    /**
     This method used to present the ViewController injectd in his own navigation Controller
     
     - parameter T: Your viewController
     - parameter animated: with animation or not
     - parameter modalPresentationStyle: pick you style
     - parameter configure: call back to customize  your view controller after pushed
     - Example:  let nextVc = self.initViewControllerWith(identifier: AddressVC.className, storyboardName: Storyboard.eKYC.rawValue)
     self.presentWithNavigation(nextVc)
     - returns: The ViewController
    */
    public func presentWithNavigation<T: UIViewController>(
        _ viewController: T,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool = true,
        configure: ((T) -> Void)? = nil,
        completion: ((T) -> Void)? = nil
    ) {
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = modalPresentationStyle
//        configure?(viewController)
        present(navigationController, animated: animated) {
            completion?(viewController)
        }
    }
    
    /**
     This method used to show the ViewController
     
     - parameter T: Your viewController
     - parameter animated: with animation or not
     - parameter configure: call back to customize  your view controller after pushed
     - Example:  let nextVc = self.initViewControllerWith(identifier: AddressVC.className, storyboardName: Storyboard.eKYC.rawValue)
        self.show(nextVc)
     - returns: The ViewController
    */
    public func show<T: UIViewController>(
        _ viewController: T,
        animated: Bool = true,
        configure: ((T) -> Void)? = nil
    ) {
//        viewController.modalPresentationStyle = modalPresentationStyle
        configure?(viewController)
        navigationController?.pushViewController(viewController, animated: animated)
    }


    /**
      Show an alert with a title, subtitle, and action

       - parameter title: The title of the alert
       - parameter subtitle: The subtitle of the alert, optional
       - parameter actionTitle: The title of the action button
       - parameter completion: A closure to be executed when the action is tapped, optional
     */
    func showAlert(title: String, subtitle: String?, actionTitle: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
          completion?()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
      }

    @objc func dissmissView(){
        self.dismiss(animated: true, completion: nil)
    }

    func showLoading() {
        DispatchQueue.main.async {
            self.startAnimating(type: .ballClipRotateMultiple)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
    }
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-115, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
    
}
