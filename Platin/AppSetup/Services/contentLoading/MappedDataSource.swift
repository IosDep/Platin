//
//  MappedDataSource.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/11/2021.
//

import Foundation

class MappedDataSource<ContentType>: DataSourceType {
    typealias ContentType = ContentType
    typealias MappingBlock<OldDS: DataSourceType> = ((Result<OldDS.ContentType, Error>) -> (Result<ContentType, Error>))

    let oldDataSource: Any
    let dataSource: BlockDataSource<ContentType>

    init<OldDataSource: DataSourceType>(dataSource: OldDataSource,
                                        mappingBlock: @escaping MappingBlock<OldDataSource>) {

        self.oldDataSource = dataSource
        self.dataSource = BlockDataSource { completion in
            dataSource.requestContent { oldResult in
                let newResult = mappingBlock(oldResult)
                completion(newResult)
            }
        }
    }

    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        self.dataSource.requestContent(completion: completion)
    }
}
