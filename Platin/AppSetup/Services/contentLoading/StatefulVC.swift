//
//  StatefulViewController.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 01/11/2021.
//

import UIKit

enum ViewStateType<ContentType> {
    case initial
    case hasContent(ContentType)
    case loading
    case empty
    case failure(Error)

    var content: ContentType? {
        if case .hasContent(let content) = self {
            return content
        }
        return nil
    }
}

//enum CategoryType {
//    case card
//    case offer
//    case service
//    case electronics
//    case `default`
//}

/**
 A ViewController type that manages it's content using state transitions, in which the content of the screen ( aka. Views ) belong to one ( or more ) of the given states ( see above ), this helps transition between loading, content, error and empty states without pain in the **.
 */

class StatefulVC<ContentType>: BaseViewController {

    typealias ViewState = ViewStateType<ContentType>
    typealias Complition = (() -> Void)

    /**
     The current state of the container
     */
    fileprivate(set) var state: ViewState = .initial
    //public fileprivate(set) var categoryType: CategoryType = .default
    /**
     Returns the content if exists, this only happens when the state == .hasContent, otherwise, null
     */
    var content: ContentType? {
        state.content
    }

    var unwrappedContent: ContentType {
        state.content!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        setupStatefulContent()
        setupViewsBeforeTransitioning()
        transition(to: .initial)
    }

    /**
        Override this method to setup the content view, this is preferred more than the viewDidLoad, as the container will make better choice for choosing views to be in the content state.
     */
    func setupViewsBeforeTransitioning() { }

    /**
     Transitions the content from one state to another
     */
    func transition(to state: ViewState) {
        let previousState = state

        self.willTransition(to: state)

        let viewsForGivenState = views(for: state) + viewsForAllStates()

        let baseView = self.view
        baseView?.subviews.forEach {
            self.unhighlight(view: $0)
        }

        viewsForGivenState.forEach {
            self.highlight(view: $0)
        }

        self.state = state

        switch state {
        case .loading:
            didTransitionToLoadingState()
        case .failure(let error):
            didTransitionToFailureState(with: error)
        case .empty:
            didTransitionToEmptyState()
        case .hasContent(let result):
            didTransitionToContentState(with: result)
        case .initial:
            break
        }

        self.didTransition(from: previousState)
    }

    func willTransition(to toState: ViewState) { }
    func didTransition(from fromState: ViewState) { }

    // MARK: Mapping Views for States

    func views(for state: ViewState) -> [UIView] {
        switch state {
        case .initial:
            return viewsForInitialState()
        case .hasContent:
            return viewsForContentState()
        case .empty:
            return viewsForEmptyState()
        case .loading:
            return viewsForLoadingState()
        case .failure:
            return viewsForFailureState()
        }
    }

    /// default returns the empty state view used
    func viewsForEmptyState() -> [UIView] {
//        return [emptyStateView]
        return []
    }

    /// default returns the failure state view
    func viewsForFailureState() -> [UIView] {
//        return [failureStateView]
        return []
    }

    /// default returns the loading state view
    func viewsForLoadingState() -> [UIView] {
        return []
    }

    func viewsForAllStates() -> [UIView] {
        []
    }

    /// default implementation returns the views in the content state, but without filling data
    func viewsForInitialState() -> [UIView] {
        return viewsForContentState()
    }

    /// the default implementation of this method returns all the views except the one's used for other states.
    func viewsForContentState() -> [UIView] {
        let otherViews = viewsForEmptyState() + viewsForFailureState() + viewsForLoadingState()
        let allViews = view.subviews
        let viewsForContentState = allViews.filter { !otherViews.contains($0) }
        return Array(viewsForContentState)
    }

    // MARK: Notify upon changing from state to another

    func didTransitionToContentState(with result: ContentType) {
        self.hideLoading()
        /* called when the receiver transitions to hasContent state, and given the data result <R> */
    }

    func didTransitionToFailureState(with error: Error) {
//        self.failureStateView.subtitleLabel.text = error.localizedDescription
        self.hideLoading()
    }

    func didTransitionToEmptyState() {
        self.hideLoading()
    }

    func didTransitionToLoadingState() {
        self.showLoading()
    }

    func retry() { }
}


extension StatefulVC {
    fileprivate func setupStatefulContent() {
        
        let retryBlock = { [unowned self] in
            self.retry()
        }
    }

    // dimms the view alpha to 1, no, it hides the view
    fileprivate func unhighlight(view: UIView) {
        view.isHidden = true
    }

    // brings the view to front, and set's it's alpha to 1
    fileprivate func highlight(view: UIView) {
        view.isHidden = false
        view.superview?.bringSubviewToFront(view)
    }
}
