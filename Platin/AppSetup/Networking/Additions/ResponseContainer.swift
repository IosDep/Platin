//
//  ResponseContainer.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 28/07/2022.
//

import Foundation

struct ResponseStatus: Codable {
    let message: String
    let code: Int
}

struct ResponseContainer<C> {
    let results: C?
    let status: ResponseStatus
}

extension ResponseContainer: Codable where C: Codable {}
