//
//  NavigationCoordinator.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 25/08/2022.
//

import UIKit

protocol NavigationCoordinator: PresentationCoordinator {
    var navigationController: UINavigationController { get }
}

extension NavigationCoordinator {
    var initialViewController: UIViewController { navigationController }
}
