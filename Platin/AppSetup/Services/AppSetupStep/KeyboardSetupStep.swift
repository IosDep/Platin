//
//  KeyboardSetupStep.swift
//  Cardizerr Admin
//
//  Created by Osama Abu hdba on 09/08/2023.
//

import UIKit
import IQKeyboardManagerSwift

extension DefaultSetupSteps {
    struct KeyboardSetupStep: AppSetupStepType {
        func setup(for application: UIApplication, delegate: AppDelegate, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {

            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
            IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(UIStackView.self)
            IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
            IQKeyboardManager.shared.enableAutoToolbar = true
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done".localiz()
        }
    }
}

