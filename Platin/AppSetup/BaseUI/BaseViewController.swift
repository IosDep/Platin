//
//  BaseViewController.swift
//  CARDIZERR
//
//  Created by Yehya Titi on 24/07/2022.
//

import UIKit
import Network


class BaseViewController: UIViewController {

    enum TitleStyle {
        case primary
        case secondary
    }

    enum BarHidingMode: Int {
        case auto
        case alwaysHidden
        case alwaysVisible
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    var navigationHidingMode: BarHidingMode {
        .auto
    }

    var tabBarHidingMode: BarHidingMode {
        .auto
    }

    var navigationTitleStyle: TitleStyle {
        .primary
    }

    var navigationTitle: String? {
        nil
    }
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var greyView = UIView()
    
    @Injected var preferencesManager: PreferencesManager
    @Injected var authenticationManager: AuthenticationManagerType

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarButtons()
        subscribeToNotifications()
        connectActions()
        setupUI()
        animateTheViews()
        overrideUserInterfaceStyle = .light
    }

    func vibratePhone() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }

    func routUserToLoginFlow(){}

    func routUserToTabBarController(index: Int) {
        let tabBarController = TabBarController.loadFromNib()
        let navCtrl = NavigationController(rootViewController: tabBarController)

        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first,
            let rootViewController = window.rootViewController else {
                return
        }

        navCtrl.view.frame = rootViewController.view.frame
        navCtrl.view.layoutIfNeeded()

        if let tabBarController = navCtrl.topViewController as? TabBarController {
            tabBarController.selectedIndex = index
//            tabBarController.updateIndicatorPlatform(forIndex: index)
        }

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navCtrl
        })
    }



    func routUserToHomePage() {
        let tabBarController = TabBarController.loadFromNib()
        
           let navCtrl = NavigationController(rootViewController: tabBarController)

        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first,
               let rootViewController = window.rootViewController

           else {
               return
           }

           navCtrl.view.frame = rootViewController.view.frame
           navCtrl.view.layoutIfNeeded()

           UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
               window.rootViewController = navCtrl
           })
    }
   
    func setupNavigationBarButtons() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            let backImage = UIImage(named: "Back_Button")
            let backButton = UIBarButtonItem(image: backImage!, title: "", target: self, action: #selector(backButtonAction))
            self.navigationItem.leftBarButtonItem = backButton
        } else {
            let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark") ?? UIImage(), title: "", target: self, action: #selector(closeButtonAction))
            closeButton.tintColor = .TextPrimary
            self.navigationItem.leftBarButtonItem = closeButton
        }

        let additionalButton = UIBarButtonItem(image: UIImage(named: "menu") ?? UIImage(), title: "", target: self, action: #selector(additionalButtonAction))
        self.navigationItem.rightBarButtonItem = additionalButton
        
        self.navigationItem.title = navigationTitle
    }

    @objc func additionalButtonAction() {
        // Action for the additional button
        let vc = TestViewController.loadFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func connectActions() {}
    func setupUI() {}
    func animateTheViews() {}
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func closeButtonAction() {
        self.dismiss(animated: true)
    }
    
    @objc func dismissKeyboardWhenTapAround() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeAuthNotification),
                                               name: AppNotifications.didChangeAuthStatusNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeSavedContactsNotification),
                                               name: AppNotifications.didChangeSavedContactsNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceivePaymentNotification),
                                               name: AppNotifications.didReceivePaymentNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeEditContactsNotification),
                                               name: AppNotifications.didChangeEditContactsNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeNotificationStatus),
                                               name: AppNotifications.didChangeNotificationStatus,
                                               object: nil)
       
    }
    
    
    @objc func didChangeAuthNotification() {
        
    }
    
    @objc func didChangeSavedContactsNotification() {
        
    }
    
    @objc func didChangeEditContactsNotification() {
        
    }
    
    /**
     this method called when user receive or send payment
    */
    @objc func didReceivePaymentNotification() {
        
    }
    
    @objc func didChangeNotificationStatus() {
        
    }
}


extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool{
          return true
      }
}

extension UIBarButtonItem {
    
    convenience init(image :UIImage, title :String, target: Any?, action: Selector?) {
        
        var configuration = UIButton.Configuration.borderless()
        configuration.title = title
        configuration.image = image
        configuration.baseBackgroundColor = .Background
        configuration.imagePadding = 10
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        
        configuration.attributedTitle = AttributedString(title, attributes: container)
        
        let button = UIButton(configuration: configuration)
        button.setTitleColor(.TextPrimary, for: .highlighted)

        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }

        self.init(customView: button)
    }
}

extension BaseViewController {
    public func convertImagesToData(images: [UIImage]) -> [Data] {
        var imagesData: [Data] = []
        for image in images {
            if image.getSizeIn(.megabyte) > 3.0 {
                do {
                    try image.compressImage(3000, completion: { (image, compressRatio) in
                        print(image.size)
                        let imageData = image.jpegData(compressionQuality: compressRatio)
                        imagesData.append(imageData ?? Data())
                    })
                } catch {
                    print("Error")
                }
            } else {
                let imageData = image.pngData() ?? Data()
                imagesData.append(imageData)
            }
        }
        return imagesData
    }
}


extension BaseViewController {
    public func convertFilesToData(fileURLs: [URL]) -> [Data] {
        var filesData: [Data] = []

        for fileURL in fileURLs {
            do {
                let fileSize = try fileURL.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
                let maxFileSizeInBytes: Int64 = 3 * 1024 * 1024 // 3 MB

                if fileSize > maxFileSizeInBytes {
                    try compressFile(at: fileURL, toMaxSize: maxFileSizeInBytes) { (compressedImage, newCompressionRatio) in
                        // Handle the compressed image and newCompressionRatio here
                        if let compressedData = compressedImage.jpegData(compressionQuality: 1.0) {
                            filesData.append(compressedData)
                        } else {
                            print("Error converting compressed image to data")
                        }
                    }
                } else {
                    // File is smaller than or equal to 3MB, no need for compression
                    let fileData = try Data(contentsOf: fileURL)
                    filesData.append(fileData)
                }
            } catch {
                print("Error: \(error)")
            }
        }


        return filesData
    }

    private func compressFile(at fileURL: URL, toMaxSize maxSize: Int64, completion: @escaping (UIImage, CGFloat) -> Void) throws {
        let fileData = try Data(contentsOf: fileURL)

        let compressionRatio = CGFloat(maxSize) / CGFloat(fileData.count)

        if let image = UIImage(data: fileData) {
            try image.compressImage(Int(compressionRatio)) { (compressedImage, newCompressionRatio) in
                completion(compressedImage, newCompressionRatio)
            }
        } else {
            throw NSError(domain: "Image Compression Error", code: 0, userInfo: nil)
        }
    }

}

extension BaseViewController{
    class func animateBottomToTop(labels: [UILabel], duration: Double? = 1, delay: Double? = 0) {
        var previousLabel: UILabel?
        for (_, label) in labels.enumerated() {
            label.alpha = 0
            if let previous = previousLabel {
                label.transform = CGAffineTransform(translationX: 0, y: 100 + previous.frame.height)
            } else {
                label.transform = CGAffineTransform(translationX: 0, y: 100)
            }
            previousLabel = label
        }
        UIView.animate(withDuration: duration ?? 1, delay: delay ?? 0 , options: .curveEaseIn, animations: {
            for label in labels {
                label.alpha = 1
                label.transform = CGAffineTransform.identity
            }
        }, completion: nil)
    }
}
