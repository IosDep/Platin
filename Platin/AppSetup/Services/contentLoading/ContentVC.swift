//
//  ContentViewController.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/11/2021.
//

import UIKit


class ContentVC<ContentType>: StatefulVC<ContentType> {
    typealias ContentType = ContentType

    enum ContentLoadEvent {
        case viewDidLoad
        case viewWillAppear
    }

    /**
     The entity responsable for getting the content
     */
    var contentRepository: AnyDataSource<ContentType>?

    var contentLoadEvents: [ContentLoadEvent] {
        [.viewDidLoad]
    }

    func initDataSources<DataSource: DataSourceType>(dataSource: DataSource) where DataSource.ContentType == ContentType {
        if let anyRepo = dataSource as? AnyDataSource<ContentType> {
            self.contentRepository = anyRepo
        } else {
            self.contentRepository = AnyDataSource(dataSource)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.contentLoadEvents.contains(.viewDidLoad) {
            performContentRequest()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.contentLoadEvents.contains(.viewWillAppear) {
            performContentRequest()
        }
    }

    override func retry() {
        self.performRetry()
    }

    func performRetry() {
        self.performContentRequest()
    }

    func performContentRequest() {
        guard let contentRepository = self.contentRepository else {
            return
        }
        self.performContentRequest(using: contentRepository)
    }

    func performContentRequest<DataSource: DataSourceType>(using contentRepository:
                                                           DataSource) where DataSource.ContentType == ContentType {
        self.contentRequestWillStart()

        /**
         The view begins by transitioning the context into loading state
         */
        self.transition(to: .loading)

        /**
         Now, perform the request of the content, returning a result
         */
        contentRepository.requestContent { (result) in
            self.contentRequestDidFinish(with: result)
            switch result {
            /**
             In case of failure return value, transition to failure state
             */
            case .failure(let error):
                self.transition(to: .initial)
                self.hideLoading()
//                self.transition(to: .failure(error))
//                self.contentRequestDidFail(with: error)
            case .success(let content):
                if let emptiable = content as? Emptiable {
                    if emptiable.isEmpty {
                        self.transition(to: .empty)
                    } else {
                        self.transition(to: .hasContent(content))
                        self.contentRequestDidSuccess(with: content)
                    }
                } else {
                    self.transition(to: .hasContent(content))
                    self.contentRequestDidSuccess(with: content)
                }
            }
        }
    }

    override func didTransitionToEmptyState() {
        super.didTransitionToEmptyState()
    }

    func contentRequestWillStart() {

    }

    func contentRequestWillRetry() {

    }

    func contentRequestDidFinish(with result: Result<ContentType, Error>) {

    }

    func contentRequestDidFail(with error: Error) {

    }

    func contentRequestDidSuccess(with content: ContentType) {

    }
}
