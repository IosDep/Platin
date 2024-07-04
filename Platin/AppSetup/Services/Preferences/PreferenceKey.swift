//
//  PreferenceKey.swift
//  CARDIZERR
//
//  Created by Osama AbuHdba on 09/11/2021.
//

import Foundation

enum PreferenceKey: String {
    case systemType
    case deviceToken
    case token
    case apnToken
    case currentSocialUser
    case applicationSettings
    case currentUser
    case localCart
    case physicalLocalCart
    case address
    case isBiometricsAvailable
    case ogLocalCart
    case cardsCart
    case shouldSaveCredential
    case currentLanguageIndex
    case currentCategory
    case selectedCountry
    case selectedCountryCode
    case phoneNumber
    case appVersion
    case currencyCode
    case currency
    case country
    case generalURLs
    case isEnterOnBordingScreenForFirstTime
    case getAdIdToFeatureIt
    case getTypeIdToFeatureAd
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper
struct PreferenceStorage<T> {
    private let key: PreferenceKey
    private let defaultValue: T
    private let storage = UserDefaults.standard

    init(key: PreferenceKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key.rawValue)
            } else {
                storage.setValue(newValue, forKey: key.rawValue)
            }
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
}

extension PreferenceStorage where T: ExpressibleByNilLiteral {
    init(key: PreferenceKey) {
        self.init(key: key, defaultValue: nil)
    }
}

@propertyWrapper
struct ObjectStorage<T: Codable> {
    private let key: PreferenceKey
    private let defaultValue: T
    private let storage = UserDefaults.standard

    init(key: PreferenceKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key.rawValue)
            } else {
                // Convert newValue to data
                let data = try? JSONEncoder().encode(newValue)

                // Set value to UserDefaults
                UserDefaults.standard.set(data, forKey: key.rawValue)
            }
        }
    }
}

extension ObjectStorage where T: ExpressibleByNilLiteral {
    init(key: PreferenceKey) {
        self.init(key: key, defaultValue: nil)
    }
}
