//
//  AnyDataSource.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 09/11/2021.
//

import Foundation

struct AnyDataSource<ContentType>: DataSourceType {
    fileprivate var base: Any
    fileprivate var requestContentBlock: ((@escaping ContentRequestCompletion<ContentType>) -> Void)

    init<Repository: DataSourceType>(_ repository: Repository) where Repository.ContentType == ContentType {
        self.base = repository

        self.requestContentBlock = { completion in
            repository.requestContent(completion: completion)
        }
    }

    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        self.requestContentBlock(completion)
    }
}

extension DataSourceType {
    func eraseToAnyContentRepository() -> AnyDataSource<Self.ContentType> {
        AnyDataSource(self)
    }
}
