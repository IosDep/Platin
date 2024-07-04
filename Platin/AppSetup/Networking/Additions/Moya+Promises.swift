//
//  Moya+Promises.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 28/07/2022.
//

import Foundation
import Moya
import Promises

extension MoyaProvider {
    func request<R: Codable>(_ target: Target, response: R.Type) -> Promise<R> {
        return Promise { success, failure in
            self.request(target) { (result: Result<R, Error>) in
                switch result {
                case .success(let object):
                    success(object)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }

    func requestWithoutContainer<R: Codable>(_ target: Target, response: R.Type) -> Promise<ResponseContainer<R>> {
        return Promise { success, failure in
            self.requestWithoutContainer(target) { (result: Result<ResponseContainer<R>, Error>) in
                switch result {
                case .success(let object):
                    success(object)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
}

extension TargetType {
    func request<R: Codable>(_ response: R.Type) -> Promise<R> {
        MoyaProvider<Self>.default().request(self, response: response)
    }

    func requestWithOutSendToken<R: Codable>(_ response: R.Type) -> Promise<R> {
        MoyaProvider<Self>.withOutSendToken().request(self, response: response)
    }

    func requestWithoutContainer<R: Codable>(_ response: R.Type) -> Promise<ResponseContainer<R>> {
        MoyaProvider<Self>.default().requestWithoutContainer(self, response: response)
    }
}

