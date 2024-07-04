//
//  PreferencesManager.swift
//  CARDIZERR
//
//  Created by Osama AbuHdba on 09/11/2021.
//

import Foundation

final class PreferencesManager {

    static let shared = PreferencesManager()
//
//    @ObjectStorage(key: .deviceToken)
//    var deviceToken: Data?
//
    @ObjectStorage(key: .currentUser)
    var currentUser: User?

    @ObjectStorage(key: .isEnterOnBordingScreenForFirstTime)
    var isEnterOnBordingScreenForFirstTime: Bool?

    @ObjectStorage(key: .getAdIdToFeatureIt)
    var adIdToFeatureIt: Int?

    @ObjectStorage(key: .getTypeIdToFeatureAd)
    var typeIdFeatureIt: Int?

//
//    @ObjectStorage(key: .applicationSettings)
//    var applicationSettings: ApplicationSettings?
//
//    @ObjectStorage(key: .localCart)
//    var localCart: LocalCart?
//
//    @ObjectStorage(key: .physicalLocalCart)
//    var physicalLocalCart: PhysicalLocalCart?
//
//    @PreferenceStorage(key: .apnToken)
//    var apnToken: String?
//
//    @PreferenceStorage(key: .isBiometricsAvailable)
//    var isBiometricsAvailable: Bool?
//
//    @PreferenceStorage(key: .systemType)
//    var systemType: Int?
//
//    @PreferenceStorage(key: .token)
//    var token: String?
//
//    @PreferenceStorage(key: .currentLanguageIndex)
//    var currentLanguageIndex: String?
//
//    @PreferenceStorage(key: .currency)
//    var currency: String?
//
//    @PreferenceStorage(key: .country)
//    var country: String?
}

extension PreferencesManager {
    func set<T>(value: T, for key: PreferenceKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func value<T>(for key: PreferenceKey) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
}
