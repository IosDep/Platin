//
//  ServicesHeadersPlugin.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 05/04/2023.
//

import Foundation
import Moya

struct ServicesHeadersPlugin: PluginType {

    @Injected var authenticationManager: AuthenticationManagerType
    @Injected var preferenceManager: PreferencesManager

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        var defaultHeaders: [String: String] = [
            "Accepts": "application/json",
            "system_type": "",
            "hash": GeneralAppConstants.getHashKey(),
            "device_type": "ios"
        ]


//        defaultHeaders["App-Version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"

//        defaultHeaders["country_id"] = "\(preferenceManager.selectedCountry?.id ?? 1)"
//        defaultHeaders["api-version"] = String(1)

        if let token = authenticationManager.authorizationToken {
            print("Token :- \(token)")
            defaultHeaders["Authorization"] = token
        }

        defaultHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}

struct ServicesHeadersPluginWithOutToken: PluginType {

    @Injected var authenticationManager: AuthenticationManagerType

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        var defaultHeaders: [String: String] = [
            "Accepts": "application/json"
        ]

//        defaultHeaders["lang"] = AppConstants.languageIdentifier

        defaultHeaders["App-Version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"

        defaultHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}
