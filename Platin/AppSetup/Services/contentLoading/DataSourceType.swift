//
//  DataSourceType.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/11/2021.
//

import Foundation

protocol DataSourceType {
    associatedtype ContentType

    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>)
}
