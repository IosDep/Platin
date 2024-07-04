//
//  APIError.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 05/04/2023.
//

import Foundation

struct APIError: LocalizedError {
    let message: String
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "code"
    }

    init(message: String) {
        self.message = message
        self.statusCode = 400
    }

    init(message: String, statusCode: Int) {
        self.message = message
        self.statusCode = statusCode
    }

    var errorDescription: String? {
        message
    }
}

extension APIError: Codable {

}

extension APIError {
    static var emptyFields = APIError(message: "error.emptyfields".localized)
}
