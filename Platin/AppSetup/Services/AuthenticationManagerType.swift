//
//  AuthenticationManagerType.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 05/02/2023.
//

import Foundation
import UIKit

protocol AuthenticationManagerType {

    var isAuthenticated: Bool { get }

    var authorizationToken: String? { get }

    var user: User? { get }

    func logout()

    func login(with user: User)

//    func update(profile: User)

//    func updateProfileIfNeeded()
}

class DefaultAuthenticationManager: AuthenticationManagerType {

    private enum Keys: String {
        case user
    }

    @Injected var preferencesManager: PreferencesManager

    fileprivate(set) var user: User? {
        didSet {
            preferencesManager.currentUser = user
            if let user = user {
                print("[Authorization] Starting with: (\(user.token))")
            }
        }
    }
    var isAuthenticated: Bool {
        user != nil
    }

    var authorizationToken: String? {
        user?.token
    }

    init() {
        self.user = preferencesManager.currentUser
    }

    func logout() {
        self.user = nil
        self.preferencesManager.currentUser = nil
        NotificationCenter.default.post(name: AppNotifications.didChangeAuthStatusNotification,
                                        object: nil,
                                        userInfo: nil)
    }

    func login(with user: User) {
        self.user = user
//        routUserToHomePage()
        NotificationCenter.default.post(name: AppNotifications.didChangeAuthStatusNotification,
                                        object: nil,
                                        userInfo: nil)
    }

    private func routUserToHomePage(){}
//    {
//        let tabBarController = HomeViewController.loadFromNib()
//           let navCtrl = NavigationController(rootViewController: tabBarController)
//
//        let scenes = UIApplication.shared.connectedScenes
//        let windowScene = scenes.first as? UIWindowScene
//        guard let window = windowScene?.windows.first,
//               let rootViewController = window.rootViewController
//
//           else {
//               return
//           }
//
//           navCtrl.view.frame = rootViewController.view.frame
//           navCtrl.view.layoutIfNeeded()
//
//           UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
//               window.rootViewController = navCtrl
//           })
//    }

//    func update(profile: User) {
//        self.user = profile
//        NotificationCenter.default.post(name: AppNotifications.didUpdateProfileNotification,
//                                        object: nil)
//    }

//    func updateProfileIfNeeded() {
//        if isAuthenticated {
//            ProfileRoutes.profile.request(User.self).then {
//                self.update(profile: $0)
//            }
//        }
//    }
}
