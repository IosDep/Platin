//
//  RequestLoggerPlugin.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 05/04/2023.
//

import Foundation
import Moya

protocol MoyaCacheable {
  typealias MoyaCacheablePolicy = URLRequest.CachePolicy
  var cachePolicy: MoyaCacheablePolicy { get }
}

struct RequestLoggerPlugin: PluginType {
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("Request Response:")
        switch result {
        case .success(let response):
            let request = response.request!
            let requestURL = response.request!.url!

//            if true {
//                self.logout()
//            }
            print("********************")
            print("\(request.method!.rawValue) \(requestURL)")
            print("***")

            if let json = try? response.mapJSON(),
               let asData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {

                print("Received an API Response: \(String(data: asData, encoding: .utf8) ?? "")")
            } else {
                if let string = try? response.mapString() {
                    print("That's's strange, the response doesn't seem like JSON!: \(string)")
                }
            }
        case .failure(let error):
            print("API Error Received ( Internal ): \(error)")
        }
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let moyaCachableProtocol = target as? MoyaCacheable {
            var cachableRequest = request
            cachableRequest.cachePolicy = moyaCachableProtocol.cachePolicy
            return cachableRequest
        }
        return request
    }

//    func logout() {
//
//        if let topViewController = UIApplication.shared.keyWindow?.topViewController() {
//            let coordinator = AuthenticationCoordinator(presenting: topViewController, completion: {
//
//            })
//                 coordinator.start()
//         //         let viewController = UIApplication.topViewController
//        }
//    }
}

