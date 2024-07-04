//
//  PaginatedContentViewController.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/11/2021.
//

import UIKit


class PaginatedContentVC<ContentType: PaginatedContentType>:
    ContentVC<ContentType> {

    fileprivate(set) var hasMoreContent: Bool = true
    fileprivate(set) var isLoadingContent: Bool = false

    var canLoadMore: Bool {
        hasMoreContent && !isLoadingContent
    }

    func performLoadMore() {
        isLoadingContent = true

        self.contentRequest(for: self.content?.count ?? 0).requestContent {
            self.isLoadingContent = false

            switch $0 {
            case .success(let content):
                self.didReceiveMoreContent(content.items)
            case .failure(let error):
                self.didFailToLoadMoreContent(error)
            }
        }
    }

    func contentRequest(for offset: Int) -> AnyDataSource<ContentType> {
        contentRepository!
    }

    func didReceiveMoreContent(_ content: [ContentType.Element]) {
        if var alreadyExistingContent = self.content {
            alreadyExistingContent.append(contentsOf: content)

            hasMoreContent = !content.isEmpty

            self.transition(to: .hasContent(alreadyExistingContent))
            self.contentRequestDidSuccess(with: alreadyExistingContent)
        }
    }

    func didFailToLoadMoreContent(_ error: Error) {
    }

    override func didTransitionToLoadingState() {
        super.didTransitionToLoadingState()
        self.isLoadingContent = true
    }

    override func didTransitionToContentState(with result: ContentType) {
        super.didTransitionToContentState(with: result)
        isLoadingContent = false
    }

    override func didTransitionToFailureState(with error: Error) {
        super.didTransitionToFailureState(with: error)
        isLoadingContent = false
    }

    override func didTransitionToEmptyState() {
        super.didTransitionToEmptyState()
        isLoadingContent = false
    }
}
