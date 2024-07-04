//
//  UserTaskOperator.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 28/07/2022.
//

import Foundation
import Promises

/**
 A Task operator can simply be defined as an object in which executes a specific task with a managed state changes.

 For Example, let's say we have a login task, the default flow would be:
 - ask to perform the task ( on the receiver )
 - the receiver prepares for this task
 - once the task finishes, the receiver prepares for the completion of this task
 - if result is succesful, handle the success result
 - if not, handle the task failure
 */
protocol UserTaskOperator {

    /**
     Performs the given task async and gets it's result throught default handle task result method :)
     */
    @discardableResult
    func performTask<R>(taskOperation: Promise<R>) -> Promise<R>

    /**
     Performs the given task async and gets it's result throught default handle task result method  :)
     
     /// you need here to handle the errors manually
     */
    @discardableResult
    func performTaskWithManualErrorHandiling<R>(taskOperation: Promise<R>) -> Promise<R>
    
    /**
    Performs the given light task async and gets it's result throught default handle task result method :)
    */
   @discardableResult
   func performLightTask<R>(taskOperation: Promise<R>) -> Promise<R>

    /**
     Prepares the receiver for the given task, this should block the interaction for the receiver.
     */
    func prepareForTask<R>(taskOperation: Promise<R>)

    /**
     Prepares the receiver for the given light task, this will not block the interaction for the receiver.
     */
    func prepareForLightTask<R>(taskOperation: Promise<R>)

    /**
    When Something wents wrong,
    */
    func handleTaskFailure(with error: Error?)

    /**
    When something wents ok!
    */
    func handleTaskSuccess<R>(result: R)
}

extension UserTaskOperator {
    @discardableResult
    func performTask<R>(taskOperation: Promise<R>, withLoading: Bool) -> Promise<R> {
        if !withLoading {
            return taskOperation
        }

        return performTask(taskOperation: taskOperation)
    }
    
    @discardableResult
    func performTaskWithManualErrorHandiling<R>(taskOperation: Promise<R>) -> Promise<R> {
        prepareForTask(taskOperation: taskOperation)
        return taskOperation.then { result in
            self.handleTaskSuccess(result: result)
        }.catch { error in
            self.handleTaskFailure(with: nil)
        }
    }


    @discardableResult
    func performTask<R>(taskOperation: Promise<R>) -> Promise<R> {
        prepareForTask(taskOperation: taskOperation)

        return taskOperation.then { result in
            self.handleTaskSuccess(result: result)
        }.catch { error in
            self.handleTaskFailure(with: error)
        }
    }

    func performLightTask<R>(taskOperation: Promise<R>) -> Promise<R> {
        prepareForLightTask(taskOperation: taskOperation)

        return taskOperation.then { result in
            self.handleTaskSuccess(result: result)
        }.catch { error in
            self.handleTaskFailure(with: error)
        }
    }
}

extension UIViewController: UserTaskOperator {

    func prepareForLightTask<R>(taskOperation: Promise<R>) {
    }

    func prepareForTask<R>(taskOperation: Promise<R>) {
        self.showLoading()
    }

    func handleTaskSuccess<R>(result: R) {
        self.hideLoading()
    }

    func handleTaskFailure(with error: Error?) {
        self.hideLoading()
//        guard let error else {return}
        UIApplication.getTopViewController()?.show(message: error?.localizedDescription, messageType: .failure)
    }
}
