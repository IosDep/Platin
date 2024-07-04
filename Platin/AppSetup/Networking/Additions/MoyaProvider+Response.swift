//
//  MoyaProvider+Response.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 05/04/2023.
//

import Foundation
import Moya

//typealias ContentRequestCompletion<ContentType> = ((Result<ContentType, Error>) -> Void)
typealias CompletionWithContainer<ContentType> = ContentRequestCompletion<ResponseContainer<ContentType>>

extension MoyaProvider {
    func request<ResultType: Codable>(_ endPoint: Target,
                                      _ mappedCompletion: @escaping ContentRequestCompletion<ResultType>) {
        self.requestWithoutContainer(endPoint) { (result: Result<ResponseContainer<ResultType>, Error>) in
            switch result {
            case .failure(let error):
                mappedCompletion(.failure(error))
            case .success(let result):

                // in this case, we need to handle the result as an error.
                if result.status.code < 200 || result.status.code >= 400 {
                    if let resultsAsString = result.results as? String {
                        mappedCompletion(.failure(APIError(message: resultsAsString, statusCode: result.status.code)))
                    } else {
                        let error = APIError(message: result.status.message, statusCode: result.status.code)
                        mappedCompletion(.failure(error))
                    }
                    return
                }

                // results not found, maybe the status code is 200?
                if let results = result.results {
                    mappedCompletion(.success(results))
                } else {
                    mappedCompletion(.failure(APIError(message: result.status.message, statusCode: result.status.code)))
                }
            }
        }
    }

    func requestWithoutContainer<ResultType: Codable>(_ endPoint: Target,
                                                      _ completion: @escaping CompletionWithContainer<ResultType>) {

        self.request(endPoint) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                let decoder = JSONDecoder()

                do {
                    if response.statusCode < 200 || response.statusCode >= 400 {
                        let messageResponse = try decoder.decode(MessageResponse.self, from: response.data)
                        let error = APIError(message: messageResponse.status.message,
                                             statusCode: messageResponse.status.code)
                        completion(.failure(error))
                        return
                    }

                    let result = try decoder.decode(ResponseContainer<ResultType>.self, from: response.data)

                    completion(.success(result))
                } catch {
                    let errorResult = try? decoder.decode(MessageResponse.self, from: response.data)

                    print("Can't decode the result: \(error)")

                    if let result = errorResult {
                        let error = APIError(message: result.status.message,
                                             statusCode: errorResult?.status.code ?? 500)
                        completion(.failure(error))
                    } else {
                        // attempt to decode this as a response container of APIError
                        let responseError =  try? decoder.decode(ResponseContainer<APIError>.self, from: response.data)
                        if let anotherError = responseError {

                            completion(.failure(anotherError.results!))
                        }

                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
