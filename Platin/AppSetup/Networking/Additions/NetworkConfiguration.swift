//
//  NetworkConfiguration.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 28/07/2022.
//

import Foundation

enum NetworkConfiguration {
    case production
    case staging

    var baseURL: URL {
        switch self {
        case .production:
            return  URL(string: "https://caravan-ddedb9092a1f.herokuapp.com/apis/")!
        case .staging:
            return  URL(string: "https://cardizerstagingapi.dominate.dev/api/")!
        }
    }

    static var current: NetworkConfiguration {
        .production
    }
}
