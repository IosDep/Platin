//
//  BlockDataSource.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 09/11/2021.
//

import Foundation
import Promises

typealias ContentRequestCompletion<ContentType> = ((Result<ContentType, Error>) -> Void)
struct BlockDataSource<ContentType>: DataSourceType {

    let block: ((@escaping ContentRequestCompletion<ContentType>) -> Void)

    init(_  block: @escaping (@escaping ContentRequestCompletion<ContentType>) -> Void) {
        self.block = block
    }

    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        block(completion)
    }
}
