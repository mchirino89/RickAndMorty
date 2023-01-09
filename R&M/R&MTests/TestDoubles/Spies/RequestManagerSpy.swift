//
//  RequestManagerSpy.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 9/1/23.
//

import Foundation
import MauriNet

final class RequestManagerSpy: RequestableManager {
    var invokedRequest: Bool = false
    var invokedRequestCount: Int = 0
    var invokedRequestURL: URLRequest?
    var stubbedCompletion: NetworkResult?

    func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        invokedRequest = true
        invokedRequestCount += 1
        invokedRequestURL = request
        stubbedCompletion = completion
    }
}
