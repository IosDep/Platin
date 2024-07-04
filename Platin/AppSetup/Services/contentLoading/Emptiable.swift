//
//  Emptiable.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/11/2021.
//

import Foundation

protocol Emptiable {
    var isEmpty: Bool { get }
}

extension Array: Emptiable {
}
