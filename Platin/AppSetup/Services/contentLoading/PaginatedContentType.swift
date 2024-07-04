//
//  PaginatedContentType.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/11/2021.
//

import Foundation

protocol PaginatedContentType {
    associatedtype Element

    var count: Int { get }
    var items: [Element] { get }

    mutating func append(contentsOf elements: [Element])
}

extension PaginatedContentType {
    var count: Int { items.count }
}

extension Array: PaginatedContentType {
    var items: [Element] {
        self
    }
}
