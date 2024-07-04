//
//  MoyaDataSource.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/11/2021.
//

import Foundation
import Moya

struct MoyaDataSource<APITarget: TargetType, ContentType: Codable>: DataSourceType {

    let provider: MoyaProvider<APITarget>
    let target: APITarget

    init(_ target: APITarget) {
        self.target = target
        self.provider = .default()
    }

    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        self.provider.request(target, completion)
    }
}

extension DataSourceType {
    static func moya<T: TargetType, C: Codable>(_ target: T, contentType: C.Type) -> MoyaDataSource<T, C> {
        MoyaDataSource(target)
    }
}

extension TargetType {
    func dataSource<C: Codable>(_ contentType: C.Type) -> MoyaDataSource<Self, C> {
        MoyaDataSource(self)
    }
}
