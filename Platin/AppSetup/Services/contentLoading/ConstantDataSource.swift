//
//  ConstantDataSource.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/11/2021.
//

import Foundation

struct ConstantDataSource<ContentType>: DataSourceType {

    let result: Result<ContentType, Error>

    init(content: ContentType) {
        self.result = .success(content)
    }

    init(error: Error) {
        self.result = .failure(error)
    }

    init(result: Result<ContentType, Error>) {
        self.result = result
    }

    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        completion(self.result)
    }
}
