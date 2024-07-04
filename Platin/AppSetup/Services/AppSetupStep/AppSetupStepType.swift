//
//  AppSetupStepType.swift
//  Cardizerr Admin
//
//  Created by Osama Abu hdba on 09/08/2023.
//
import UIKit

protocol AppSetupStepType {
    func setup(for application: UIApplication, delegate: AppDelegate, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

@resultBuilder
struct AppSetupStepsBuilder {
    static func buildBlock(_ partialResults: AppSetupStepType...) -> [AppSetupStepType] {
        partialResults
    }
}

struct DefaultSetupSteps: AppSetupStepType {

    fileprivate var children: [AppSetupStepType]

    init(@AppSetupStepsBuilder builder: () -> [AppSetupStepType]){
        self.children = builder()
    }

    func setup(for application: UIApplication, delegate: AppDelegate, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        children.forEach {
            $0.setup(for: application, delegate: delegate, launchOptions: launchOptions)
        }
    }
}
