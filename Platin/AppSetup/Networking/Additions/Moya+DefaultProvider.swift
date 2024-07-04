//
//  Moya+DefaultProvidefr.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 28/07/2022.
//

import Foundation
import Moya

typealias Method = Moya.Method

extension MoyaProvider {
    static func `default`() -> MoyaProvider<Target> {
        return MoyaProvider<Target>(plugins: [
            ServicesHeadersPlugin(),
            RequestLoggerPlugin()
        ])
    }

    static func withOutSendToken() -> MoyaProvider<Target> {
        return MoyaProvider<Target>(plugins: [
            RequestLoggerPlugin(),
            ServicesHeadersPluginWithOutToken()
        ])
    }
}

extension TargetType {
    var baseURL: URL {
        NetworkConfiguration.current.baseURL
    }

    var sampleData: Data {
        Data()
    }

    var headers: [String : String]? {
        [:]
    }
}
